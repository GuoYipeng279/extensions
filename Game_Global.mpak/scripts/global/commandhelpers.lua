-- Target pozicio lekerdezese
-- Target.ID / Target.x  .y  .z

--[[
memoriafoglalas miatt kiveve
function luaPeekTarget(target)
	local pos,living
	local dummy
	if target.ID ~= nil then
		local unit = thisTable[target.ID]
		living = not unit.Dead
		if living then
			pos = GetPosition(unit)
		else
			return unit.x, unit.y, unit.z, false
		end
	else
		pos = target
		living = true
	end
	return pos.x,pos.y,pos.z,living
end
]]


--[[AutoDoc
usage: rotation = luaGetRotation(entity)
category: Math
shortdesc: Visszaadja egy entitas rotaciojat
desc: Egy megadott entitas viszonyitott rotaciojat kapjuk meg
entity: table, Entitas, barmely gameentity
rotation: number, rotacio
]]
function luaGetRotation(ent)
	local rot = GetRotation(ent)

	return rot["y"]
end

--[[
memoriafoglalas miatt kiveve
-- egy nev altal megadott entityt berak a masodik paramkent megadott tablaba
function luaInsertObject(name, unittable)
-- RELEASE_LOGOFF  	Assert(type(name) == "string", "ERROR: in function luaInsertObject, first param is not string!\t Type is: "..type(name))
-- RELEASE_LOGOFF  	Assert(type(unittable) == "table", "ERROR: in function luaInsertObject, second param is not table!\t Type is: "..type(unittable))
	local unit = FindEntity(name)
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "ERROR: can't find unit named "..name)
	table.insert(unittable, unit)
end
]]

--[[AutoDoc
usage: distance = luaGetDistance(Obj1, Obj2)
category: Math
shortdesc: Visszaadja ket entitas tavolsagat
desc: Ket entitas tavolsagat kapjuk meg meterben, 2Dben
Obj1: table, Barmely letezo gameentity
Obj2: table, Barmely letezo gameentity
distance: number, A ket entitas kozotti tavolsag 2Dben szamolva, meterben
]]
-- ket ojjektum kozti tavolsagot adja vissza. 2D !!
function luaGetDistance(Obj1, Obj2)
	if type(Obj1) ~= "table" then
		error("***ERROR: luaGetDistance's first param is a non-table parameter.", 2)
	end

	if type(Obj2) ~= "table" then
		error("***ERROR: luaGetDistance's second param is a non-table parameter.", 2)
	end

-- RELEASE_LOGOFF  	Assert(Obj1.ID ~= nil or Obj1.x ~= nil, "***ERROR: luaGetDistance's first param is a table without ID or X index!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Obj2.ID ~= nil or Obj2.x ~= nil, "***ERROR: luaGetDistance's second param is a table without ID or X index!"..debug.traceback())

	if Obj1.ID ~= nil then
-- RELEASE_LOGOFF  		Assert(not thisTable[Obj1.ID].Dead, "***ERROR: luaGetDistance's first param is a dead entity! ("..tostring(thisTable[Obj1.ID].Name)..")\n"..debug.traceback())
--		if thisTable[Obj1.ID].Dead then
-- RELEASE_LOGOFF  --			luaHelperLog("Warning: luaGetDistance got a dead entity! 1st arg: "..thisTable[Obj1.ID].Name)
--		end
	end

	if Obj2.ID ~= nil then
-- RELEASE_LOGOFF  		Assert(not thisTable[Obj2.ID].Dead, "***ERROR: luaGetDistance's second param is a dead entity! ("..tostring(thisTable[Obj2.ID].Name)..")\n"..debug.traceback())
--		if thisTable[Obj2.ID].Dead then
-- RELEASE_LOGOFF  --			luaHelperLog("Warning: luaGetDistance got a dead entity! 2nd arg: "..thisTable[Obj2.ID].Name)
--		end
	end
--[[
	if Obj1 == nil then
		error("***ERROR: luaGetDistance's first parameter is nil.", 2)
	end

	if Obj2 == nil then
		error("***ERROR: luaGetDistance's second parameter is nil.", 2)
	end
]]
	local distance
	local posa
	local posb
	local posc = {}

	if Obj1.ID ~= nil then
		--luaHelperLog("Object: "..Obj1.Name.." ID: "..Obj1.ID.." thist: "..thisTable[Obj1.ID].." Dead? "..tostring(Obj1.Dead))
		posa = GetPosition(thisTable[Obj1.ID])
	else
		posa = Obj1
	end

	if Obj2.ID ~= nil then
		posb = GetPosition(thisTable[Obj2.ID])
	else
		posb = Obj2
	end

	posc.x = posa.x-posb.x
--	posc.y = posa.y-posb.y
	posc.z = posa.z-posb.z
	distance = math.sqrt(math.pow(posc.x, 2)+math.pow(posc.z, 2))
-- RELEASE_LOGOFF  --	luaHelperLog("Distance between "..Obj1.." and "..Obj2.." is "..distance.." m.")
	return distance
end

--[[AutoDoc
usage: direction = luaGetDirFromPosToPos(FromPos, ToPos)
category: Math
shortdesc: Visszaadja ket entitas tavolsagat
desc: ket 3d pozicio egymashoz viszonyitott iranyat adja vissza fokokban (NEM radianban!)
FromPos: table, 3d vektor ({["x"], ["y"], ["z"]})
ToPos: table, 3d vektor ({["x"], ["y"], ["z"]})
direction: number, A ket entitas kozotti iranyultsag 3D-ben
]]
function luaGetDirFromPosToPos(FromPos, ToPos)
	return math.deg(math.atan2(ToPos.z-FromPos.z,ToPos.x-FromPos.x))-90
end

--[[AutoDoc
usage: nearestTable = luaGetNearestUnitFromTable(targetUnit ,targetTable)
category: Mission
shortdesc: a tablabol a legkozelebbi unitot es tavolsagat adja vissza
desc: A tablabol a legkozelebbi unitot es tavolsagat adja vissza
targetUnit: table, barmely gameentity amelyhez kepest a legkozelebbi egyseget keressuk
targetTable: table, az ebben levo unitok kozul keressuk a legkozelebbit
nearestTable: table, indexei: "nearestUnit" - legkozelebbi egyseg, shortestOwnWay - tavolsag a 2 egyseg kozott. Ha a keresesi felteteleknek egy egyseg sem tesz eleget a visszateresi ertek nil lesz
]]
function luaGetNearestUnitFromTable(targetUnit, targetTable)
	local Dist = 0
	local prevDistance = 1000000
	local shortestOwnWay = 1000000
	local nearestUnit
	local target = thisTable[targetUnit.ID]
-- RELEASE_LOGOFF  	luaHelperLog("luaGetNearestUnitFromTable");

	for key, unit in pairs(targetTable) do
		if not unit.Dead then
			Dist = luaGetDistance(unit, targetUnit)
			if Dist < prevDistance and Dist < shortestOwnWay and targetUnit~=unit then
				shortestOwnWay = Dist
				nearestUnit = unit
			end
			prevDistance = Dist
		end
	end

	if nearestUnit == nil then
-- RELEASE_LOGOFF  		luaHelperLog(" No unit found for the criteria")
		return nil
	end

-- RELEASE_LOGOFF  	luaHelperLog(" Nearest unit: "..nearestUnit.Name)
	return nearestUnit, shortestOwnWay
end

--[[AutoDoc
usage: nearestTable = luaGetNearestEnemy(targetUnit [,uType])
category: Mission
shortdesc: a legkozelebbi meghatarozott tipusu enemy unitot es tavolsagat adja vissza
desc: A legkozelebbi meghatarozott tipusu enemy unitot es tavolsagat adja vissza ha nincs meghatarozott tipus, akkor a legkozelebbi enemy unitot, tipusat, tavolsagat adja vissza
targetUnit: table, barmely gameentity amelyhez kepest a legkozelebbi elleneseges egyseget keressuk
uType: string, a keresett ellenseges egyseg tipusa (entity.Type)
nearestTable: table, indexei: "nearestEnemy" - legkozelebbi ellenseges egyseg, [nearestEnemyType] - a legkozelebbi ellenseges egyseg tipusa (ha megadtuk a fv hivasakor), shortestOwnWay - tavolsag a 2 egyseg kozott. Ha a keresesi felteteleknek egy egyseg sem tesz eleget a visszateresi ertek nil lesz
]]
function luaGetNearestEnemy(targetUnit, uType)
	local Dist = 0
	local prevDistance = 1000000
	local shortestOwnWay = 1000000
	local nearestEnemy
	local nearestEnemyType
	local target = thisTable[targetUnit.ID]
-- RELEASE_LOGOFF  	luaHelperLog("luaGetNearestEnemy "..target.Name..","..tostring(uType));
-- RELEASE_LOGOFF  --	luaHelperLog("Looking for uType: "..tostring(uType).."\townunit: "..target)
-- RELEASE_LOGOFF  --	luaHelperLog(target)

	if uType ~= nil then
		for key, unittype in pairs(recon[target.Party]["enemy"]) do
			--luaHelperLog("unittype es searchType\n\t\t***"..key.." and "..tostring(uType))
			if key == uType then
				for key2, unit in pairs(unittype) do
-- RELEASE_LOGOFF  					luaHelperLog(" Unit : "..unit.Name)
-- RELEASE_LOGOFF  					luaHelperLog("  Dead? "..tostring(unit.Dead))
					if not unit.Dead then
-- RELEASE_LOGOFF  						luaHelperLog("  Found unit: "..unit.Name)
						Dist = luaGetDistance(unit, target)
						if Dist < prevDistance and Dist < shortestOwnWay and target~=unit then
							shortestOwnWay = Dist
							nearestEnemy = unit
						end
						prevDistance = Dist
					end
				end
			end
		end

		if nearestEnemy == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" No enemy found for the criteria")
			return nil
		end

-- RELEASE_LOGOFF  		luaHelperLog(" nearest enemy: "..nearestEnemy.Name)
		return nearestEnemy, shortestOwnWay
	else
		for key, unittype in pairs(recon[target.Party]["enemy"]) do
			for key2, unit in pairs(unittype) do
				if not unit.Dead then
					Dist = luaGetDistance(unit, target)
					if Dist < prevDistance and Dist < shortestOwnWay and target~=unit then
						shortestOwnWay = Dist
						nearestEnemy = unit
						nearestEnemyType = key
					end
					prevDistance = Dist
				end
			end
		end

		if nearestEnemy == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" No enemy found")
			return nil
		else
-- RELEASE_LOGOFF  			luaHelperLog(" nearest enemy: "..nearestEnemy.Name)
			return nearestEnemy, nearestEnemyType, shortestOwnWay
		end
	end
end

--[[
memoriafoglalas miatt kiveve
-- az elobbi forditottja, tehat amik target utan meg vannak adva parameterkent, azokat NEM valogatja le
function luaGetNearestEnemyNot(...)

-- RELEASE_LOGOFF  	Assert(arg[1].ID ~= nil, "***ERROR: first arg must be an entity."..debug.traceback())
-- RELEASE_LOGOFF  	Assert(arg[2] ~= nil, "***ERROR: luaGetNearestEnemyNot needs at least 2 params."..debug.traceback())

	local Dist = 0
	local prevDistance = 1000000
	local shortestOwnWay = 1000000
	local nearestEnemy
	local nearestEnemyType
	local argnum = table.getn(arg)
	local target = arg[1]
	local checked

	--luaHelperLog("----FUNCTION----")
	--luaHelperLog("argnum: "..argnum)
	for key, unittype in pairs(recon[target.Party]["enemy"]) do
		local i = 2
		while i <= argnum do
			--luaHelperLog("I value "..i)
			--luaHelperLog("key value: "..key)
			--luaHelperLog("arg[i] value: "..arg[i])
			if key ~= arg[i] then
				checked = true
			else
				checked = false
				break
			end
			i = i+1
		end
		--luaHelperLog("CHECKED "..tostring(checked))
		if checked then
			for key2, unit in pairs(unittype) do
				if not unit.Dead then
					Dist = luaGetDistance(unit, target)
					if Dist < prevDistance and Dist < shortestOwnWay and target.ID ~= unit.ID and not target.Dead then
						shortestOwnWay = Dist
						nearestEnemy = unit
						nearestEnemyType = key
					end
					prevDistance = Dist
				end
			end
		end

	end
	--luaHelperLog("---NEAREST_ENEMY_NOT RETURN VALUES---")
	--luaHelperLog(nearestEnemy)
	--luaHelperLog(nearestEnemyType)
	--luaHelperLog(shortestOwnWay)
	--luaHelperLog("-------------------------------------")
	return nearestEnemy, nearestEnemyType, shortestOwnWay
end
]]
--[[AutoDoc
usage: shipsAroundTable = luaGetShipsAround(target, radius, allegiance [,index] [,all] [,searchedtype] [,noretreaters])
category: Mission
shortdesc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu hajokat valogatja ossze
desc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu hajokat valogatja ossze, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string, elobbi esetben csak a tablat adja vissza, utobbiban a tablat es a tabla elemszamat; visszateresi ertek a unitokat tartalmazo tabla
target: adott egyseg amelyhez kepest keresunk ellenseges hajokat
radius: ilyen messze levo hajok szamitanak, meter
allegriance: a targethez kepest milyen hajokat keresunk: allegiance lehet "enemy", "neutral", "own"
index: ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string
all: ha 'all' nem nil, akkor sajat magat is beleszamolja
searchedtype: 'searchedtype' a keresendo unittipust hatarozza meg, ha nem nil
noretreaters: ha nem nil akkor csak a nem visszavonulo egysegeket keresi
shipsAroundTable: entitasokat tartalmazo tabla, sorszam vagy unit.Type indexxel
]]
function luaGetShipsAround(target, radius, allegiance, index, all, searchedtype, noretreaters)
	if allegiance == nil then
		error("***Script function error: no 'allegiance' parameter at luaGetShipsAround.", 2)
	elseif allegiance ~= "enemy" and allegiance ~= "neutral" and allegiance ~= "own" then
		error("***Script function error: bad 'allegiance' parameter at luaGetShipsAround: "..allegiance, 2)
	end
-- RELEASE_LOGOFF  	Assert(target ~= nil and target.ID ~= nil, "***ERROR: luaGetShipsAround's first param must have an ID key!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaGetShipsAround "..target.Name..","..radius..","..tostring(allegiance)..","..tostring(index)..","..tostring(all)..","..tostring(searchedtype))

	local targetUnit = thisTable[target.ID]
	local shipsAround = {}
	local i = 0
	local uType
	local rad2=radius*radius

	for key, unittype in pairs(recon[targetUnit.Party][allegiance]) do
-- RELEASE_LOGOFF  		luaHelperLog("  Type "..key)
		if (key == "destroyer" or key == "submarine" or key == "mothership" or key == "cargo" or key == "cruiser" or key == "torpedoboat" or key == "battleship" or key == "landingship" ) and (searchedtype == nil or searchedtype == key) then
			for key2, unit in pairs(unittype) do
				if index == nil then
-- RELEASE_LOGOFF  					luaHelperLog("    Unit "..unit.Name)
					if not unit.Dead and (all or unit.ID ~= targetUnit.ID) then
						local posa
						local posb
						local diffx
						local diffz

						posa = GetPosition(thisTable[unit.ID])
						posb = GetPosition(thisTable[targetUnit.ID])
						diffx=posa.x-posb.x
						diffz=posa.z-posb.z

						if diffx*diffx+diffz*diffz<rad2 then
-- RELEASE_LOGOFF  							luaHelperLog("      OK")
							if noretreaters ~= nil and not unit.Retreat then
								table.insert(shipsAround, unit)
							elseif noretreaters == nil then
								table.insert(shipsAround, unit)
							end
						end
					end
				else
-- RELEASE_LOGOFF  					luaHelperLog("    Unit "..unit.Name)
					if not unit.Dead and (all or unit.ID ~= targetUnit.ID) then
						local posa
						local posb
						local diffx
						local diffz

						posa = GetPosition(thisTable[unit.ID])
						posb = GetPosition(thisTable[targetUnit.ID])
						diffx=posa.x-posb.x
						diffz=posa.z-posb.z

						if diffx*diffx+diffz*diffz<rad2 then
							if noretreaters ~= nil and not unit.Retreat then
--								tonumber(i)
								i = i+1
								shipsAround[key..tostring(i)] = unit
							elseif noretreaters == nil then
--								tonumber(i)
								i = i+1
								shipsAround[key..tostring(i)] = unit
							end
						end
					end
				end
			end
		end
	end

	if next(shipsAround) == nil then
		return nil
	else
		return shipsAround
	end
end

--[[AutoDoc
usage: shipsAroundTable = luaGetShipsAroundCoordinate(target, radius, party, allegiance, [index] [,searchedtype] [,noretreaters])
category: Mission
shortdesc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu hajokat valogatja ossze
desc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu hajokat valogatja ossze, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string, elobbi esetben csak a tablat adja vissza, utobbiban a tablat es a tabla elemszamat; visszateresi ertek a unitokat tartalmazo tabla
target: table, adott koordinata amelyhez kepest keresunk ellenseges hajokat
radius: number, ilyen messze levo hajok szamitanak, meter
party: enum, milyen partyra vizsgalunk (PARTY_ALLIED, PARTY_JAPANESE)
allegiance: string, a targethez kepest milyen hajokat keresunk: allegiance lehet "enemy","neutral", "own"
index: bool, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string
all: bool, ha 'all' nem nil, akkor sajat magat is beleszamolja
searchedtype: string, 'searchedtype' a keresendo unittipust hatarozza meg, ha nem nil
noretreaters: bool, ha nem nil akkor csak a nem visszavonulo egysegeket keresi
shipsAroundTable: table, entitasokat tartalmazo tabla, sorszam vagy unit.Type indexxel
]]
function luaGetShipsAroundCoordinate(target, radius, party, allegiance, index, searchedtype, noretreaters)
-- RELEASE_LOGOFF  	LogToFile("luaGetShipsAroundCoordinate is running for point: ", target)

-- RELEASE_LOGOFF  	Assert(target ~= nil and target.x ~= nil and target.y ~= nil and target.z ~= nil, "***ERROR: luaGetShipsAroundCoordinate's first param must be a {x, y, z} coordinate!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(party == PARTY_ALLIED or party == PARTY_JAPANESE, "***ERROR: luaGetShipsAroundCoordinate needs a party (PARTY_ALLIED or PARTY_JAPANESE) as third param!"..debug.traceback())

	if allegiance == nil then
		error("***Script function error: no 'allegiance' parameter at luaGetShipsAround.", 2)
	elseif allegiance ~= "enemy" and allegiance ~= "neutral" and allegiance ~= "own" then
		error("***Script function error: bad 'allegiance' parameter at luaGetShipsAround: "..allegiance, 2)
	end

	local shipsAround = {}
	local i = 0
	local uType

	for key, unittype in pairs(recon[party][allegiance]) do
-- RELEASE_LOGOFF  		luaHelperLog("  Type "..key)
		--if key ~= "fighter" and key ~= "levelbomber" and key ~= "divebomber" and key ~= "torpedobomber" and key ~= "reconplane" and key ~= "submarine" and key ~= "landfort" and key ~= "airfield" and key ~= "landvehicle" and key ~="kamikaze" and (searchedtype == nil or searchedtype == key) then
		if (key == "destroyer" or key == "submarine" or key == "mothership" or key == "cargo" or key == "cruiser" or key == "torpedoboat"  or key == "battleship" or key == "landingship" ) and (searchedtype == nil or searchedtype == key) then
			for key2, unit in pairs(unittype) do
				if index == nil then
-- RELEASE_LOGOFF  					luaHelperLog("    Unit "..unit.Name)
					if not unit.Dead and luaGetDistance(unit, target) < radius then
-- RELEASE_LOGOFF  						luaHelperLog("      OK")
						if noretreaters ~= nil and not unit.Retreat then
							table.insert(shipsAround, unit)
						elseif noretreaters == nil then
							table.insert(shipsAround, unit)
						end
					end
				else
-- RELEASE_LOGOFF  					luaHelperLog("    Unit "..unit.Name)
					if not unit.Dead and luaGetDistance(unit, target) < radius then
						if noretreaters ~= nil and not unit.Retreat then
							tonumber(i)
							i = i+1
							uType = key..tostring(i)
							shipsAround[key..tostring(i)] = unit
						elseif noretreaters == nil then
							tonumber(i)
							i = i+1
							uType = key..tostring(i)
							shipsAround[key..tostring(i)] = unit
						end
					end
				end
			end
		end
	end

	--return shipsAround
	if next(shipsAround) == nil then
		return nil
	else
		return shipsAround
	end
end

--[[AutoDoc
usage: planesAroundTable = luaGetPlanesAround(target, radius, allegiance [,index])
category: Mission
shortdesc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu repuloket valogatja ossze
desc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu repuloket valogatja ossze, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string, elobbi esetben csak a tablat adja vissza, utobbiban a tablat es a tabla elemszamat; visszateresi ertek a unitokat tartalmazo tabla
target: table, adott egyseg amelyhez kepest keresunk ellenseges repuloket
radius: number, ilyen messze levo repulok szamitanak, meter
allegriance: string, a targethez kepest milyen repuloket keresunk: allegiance lehet "enemy", "allied", "neutral", "own"
index: bool, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string
planesAroundTable: table, entitasokat tartalmazo tabla, sorszam vagy unit.Type indexxel
]]
function luaGetPlanesAround(target, radius, allegiance, index)
-- RELEASE_LOGOFF  	Assert(target ~= nil and target.ID ~= nil, "***ERROR: luaGetPlanesAround needs a targetentity as first param!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(allegiance ~= nil, "***Script function error: no 'allegiance' parameter at luaGetPlanesAround."..debug.traceback())
-- RELEASE_LOGOFF  	Assert(allegiance == "enemy" or allegiance == "neutral" or allegiance == "own" or allegiance == "unknown", "***Script function error: bad 'allegiance' parameter at luaGetPlanesAround:"..allegiance.."\n"..debug.traceback())

	local targetUnit = thisTable[target.ID]
	local dist, uType
	local number = 0
	local i = 0
	local planesAround = {}

-- RELEASE_LOGOFF  --	luaHelperLog("ShipsAround initiated")
-- RELEASE_LOGOFF  --	luaHelperLog("Allegiance : "..allegiance)
-- RELEASE_LOGOFF  --	LogToFile("examined unit: ", targetUnit.Name)
-- RELEASE_LOGOFF  --	luaHelperLog("its party: "..targetUnit.Party)
	if index == nil then
		for key, unittype in pairs(recon[targetUnit.Party][allegiance]) do
-- RELEASE_LOGOFF  --			luaHelperLog("key: "..key)
			if key == "fighter" or key == "levelbomber" or key == "divebomber" or key == "torpedobomber" or key == "reconplane" or key == "kamikaze" then
				for key2, unit in pairs(unittype) do
-- RELEASE_LOGOFF  --					luaHelperLog("kakas")
					if not unit.Dead then
						dist = luaGetDistance(unit, targetUnit)
						if dist < radius and unit ~= targetUnit then
							i = i+1
							planesAround[i] = unit
-- RELEASE_LOGOFF  		--						luaHelperLog("-- planesAround inside. i = "..i..", PlanesAround table: "..planesAround[i])
						end
					end
				end
			end
		end

		number = table.getn(planesAround)
		if number ~= 0 then
			return planesAround, number
		else
			return nil
		end
	else
		for key, unittype in pairs(recon[targetUnit.Party][allegiance]) do
-- RELEASE_LOGOFF  --			luaHelperLog("luaGetPlanesAround key: "..key)
			if key == "fighter" or key == "levelbomber" or key == "divebomber" or key == "torpedobomber" or key == "reconplane" then
-- RELEASE_LOGOFF  --				luaHelperLog("Im in")
				tonumber(i)
				i = 0
				for key2, unit in pairs(unittype) do
					if not unit.Dead then
						dist = luaGetDistance(unit, targetUnit)
						if dist < radius and unit.ID ~= targetUnit.ID then
							tonumber(i)
							i = i+1
							uType = key..tostring(i)
-- RELEASE_LOGOFF  --							luaHelperLog("key "..key..", uType: "..tostring(uType))
							planesAround[key..tostring(i)] = unit
-- RELEASE_LOGOFF  --							luaHelperLog("PlanesAround: "..planesAround)
							number = number + 1
						end
					end
				end
			end
		end
		if number ~= 0 then
			return planesAround, number
		else
			return nil
		end
	end
end

--[[AutoDoc
usage: planesAroundTable = luaGetPlanesAroundCoordinate(target, radius, party, allegiance [,index] [,searchedtype] [,noretreaters])
category: Mission
shortdesc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu repuloket valogatja ossze
desc: Az adott 'target' körüli 'radius' sugaru korben elhelyezkedo 'allegiance' beallitottsagu repuloket valogatja ossze, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string, elobbi esetben csak a tablat adja vissza, utobbiban a tablat es a tabla elemszamat; visszateresi ertek a unitokat tartalmazo tabla
target: table, adott egyseg amelyhez kepest keresunk ellenseges repuloket
radius: number, ilyen messze levo repulok szamitanak, meter
party: enmum, milyen partyra vizsgalunk (PARTY_ALLIED, PARTY_JAPANESE)
allegriance: string, a targethez kepest milyen repuloket keresunk: allegiance lehet "enemy", "allied", "neutral", "own"
index: bool, ha 'index' nil, akkor sorszamozza a tablat; ha nem, akkor tipus string
searchedtype: string, 'searchedtype' a keresendo unittipust hatarozza meg, ha nem nil
noretreaters: bool, ha nem nil akkor csak a nem visszavonulo egysegeket keresi
planesAroundTable: table, entitasokat tartalmazo tabla, sorszam vagy unit.Type indexxel
]]
function luaGetPlanesAroundCoordinate(target, radius, party, allegiance, index, searchedtype, noretreaters)
-- RELEASE_LOGOFF  	LogToFile("luaGetShipsAroundCoordinate is running for point: ", target)

-- RELEASE_LOGOFF  	Assert(target ~= nil and luaIsCoordinate(target), "***ERROR: luaGetShipsAroundCoordinate's first param must be a {x, y, z} coordinate!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(party == PARTY_ALLIED or party == PARTY_JAPANESE, "***ERROR: luaGetShipsAroundCoordinate needs a party (PARTY_ALLIED or PARTY_JAPANESE) as third param!"..debug.traceback())

	if allegiance == nil then
		error("***Script function error: no 'allegiance' parameter at luaGetShipsAround.", 2)
	elseif allegiance ~= "enemy" and allegiance ~= "neutral" and allegiance ~= "own" then
		error("***Script function error: bad 'allegiance' parameter at luaGetShipsAround: "..allegiance, 2)
	end

	local planesAround = {}
	local i = 0
	local uType

	for key, unittype in pairs(recon[party][allegiance]) do
-- RELEASE_LOGOFF  		luaHelperLog("  Type "..key)
		if (key == "fighter" or key == "levelbomber" or key == "divebomber" or key == "torpedobomber" or key == "reconplane" or key == "kamikaze") and
				(searchedtype == nil or searchedtype == key) then
			for key2, unit in pairs(unittype) do
				if index == nil then
-- RELEASE_LOGOFF  					luaHelperLog("    Unit "..unit.Name)
					if not unit.Dead and luaGetDistance(unit, target) < radius then
-- RELEASE_LOGOFF  						luaHelperLog("      OK")
						if noretreaters ~= nil and not unit.Retreat then
							table.insert(planesAround, unit)
						elseif noretreaters == nil then
							table.insert(planesAround, unit)
						end
					end
				else
-- RELEASE_LOGOFF  					luaHelperLog("    Unit "..unit.Name)
					if not unit.Dead and luaGetDistance(unit, target) < radius then
						if noretreaters ~= nil and not unit.Retreat then
							tonumber(i)
							i = i+1
							uType = key..tostring(i)
							planesAround[key..tostring(i)] = unit
						elseif noretreaters == nil then
							tonumber(i)
							i = i+1
							uType = key..tostring(i)
							planesAround[key..tostring(i)] = unit
						end
					end
				end
			end
		end
	end

	--return planesAround
	if next(planesAround) == nil then
		return nil
	else
		return planesAround
	end
end

--[[
memoriafoglalas miatt kiveve
-- minden felderitett ellenseget visszaad egy tablaba. Key az enemy tipusa (szamozva).
function luaGetVisibleEnemies(target)
	local visibleEnemies = {}
	local i, enemynumber = 0, 0
	local uType

	for key, unittype in pairs(recon[target.Party]["enemy"]) do
		tonumber(i)
		i = 0
		for key2, unit in pairs(unittype) do
			tonumber(i)
			i = i+1
			uType = key..tostring(i)
-- RELEASE_LOGOFF  --			luaHelperLog("key "..key..", uType: "..uType)
			visibleEnemies[key..tostring(i)] = unit
			enemynumber = enemynumber + 1
		end
	end
-- RELEASE_LOGOFF  --	luaHelperLog(" teszt: enemynumber="..enemynumber)
-- RELEASE_LOGOFF  --	LogToFile("bakker", visibleEnemies)
	if enemynumber == 0 then
		return nil
	else
		return visibleEnemies
	end
end
]]

--[[
memoriafoglalas miatt kiveve
-- minden sajat repulot visszaad egy tablaba. Key a unit tipusa (szamozva).
function luaGetOwnPlanes(target)
	local ownPlanes = {}
	local i = 0
	local uType

	for key, unittype in pairs(recon[target.Party]["own"]) do
		tonumber(i)
		i = 0
		if key == "fighter" or key == "divebomber" or key == "levelbomber" or key == "torpedobomber" or key == "reconplane" then
			for key2, unit in pairs(unittype) do
				tonumber(i)
				i = i+1
				uType = key..tostring(i)
-- RELEASE_LOGOFF  --				luaHelperLog("key "..key..", uType: "..uType)
				ownPlanes[key..tostring(i)] = unit
			end
		end
	end

	--LogToFile("Party ", target.Party, " - sajat gepek", ownPlanes)
	return ownPlanes
end
]]

--[[AutoDoc
usage: isVisible = luaIsVisible(this,target)
category: Mission
shortdesc: visszaadja, latjuk-e targetet (boolean)
desc: Visszaadja, hogy adott target lathato e a recon systemben
this: table, thisTable, a MissionScript this tablaja
target: table, adott egyseg amelyhet keresunk a reconban
isVisible: bool, true ha belekerult mar a recon tablaba, false ha nem
]]
function luaIsVisible(this,target)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsVisible got a 'nil' target!"..debug.traceback())
	if target.ID == nil and target.x ~= nil then
		return true
	end

-- RELEASE_LOGOFF  	luaHelperLog("Is Target on:"..thisTable[target.ID].Name)
-- RELEASE_LOGOFF  	luaHelperLog(" For party: "..this.Party)
	for key, allegiance in pairs(recon[this.Party]) do
-- RELEASE_LOGOFF  		luaHelperLog(" Checking allegiance: "..key)
		for key2, unittype in pairs(allegiance) do
-- RELEASE_LOGOFF  			luaHelperLog("  Checking unittype: "..key2)
			if unittype[target.ID] ~= nil then
				return true
			end
		end
	end

--	for key, unittype in pairs(recon[this.Party].enemy) do
--		if unittype[target.ID] ~= nil then
--			return true
--		end
--	end


	if target.Path ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Target was a path...")
		return true
	else
-- RELEASE_LOGOFF  		luaHelperLog("Is Target on: "..thisTable[target.ID].Name.." failed")
		return false
	end
end

--[[AutoDoc
usage: isVisible = luaIsVisibleCoordinate(obj, coordinate)
category: Mission
shortdesc: adott objektumhoz kepest nezi meg, hogy az o partyja latja-e
desc: adott objektumhoz (entity!) kepest nezi meg, hogy az o partyja latja-e (reconrange-en belul van-e) a masodik paramban megadott koordinatat
obj: table, entitas, amelyhez kepest vizsgaljuk a koordinatat
coordinate: table, a keresett koordinata
dist: ilyen messzire lat el a recon default 3500
isVisible: bool, true ha recon rangen belul van, false ha nem
]]
-- adott objektumhoz (entity!) kepest nezi meg, hogy az o partyja latja-e (reconrange-en belul van-e) a masodik paramban megadott koordinatat
function luaIsVisibleCoordinate(obj, coordinate, dist)
-- RELEASE_LOGOFF  	Assert(obj.ID ~= nil, "***ERROR: luaIsVisibleCoordinate needs an entity as 1st param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(coordinate.x ~= nil and coordinate.y ~= nil and coordinate.z ~= nil, "***ERROR: luaIsVisibleCoordinate needs a coordinate as 2nd param!"..debug.traceback())

	if dist and type(dist) == "number" and dist > 0 then
-- RELEASE_LOGOFF  		luaHelperLog("Valid dist param")
	else
		dist = 3500
	end

-- RELEASE_LOGOFF  	luaHelperLog("luaIsVisibleCoordinate 's relative entity: "..obj.Name)
-- RELEASE_LOGOFF  	luaHelperLog("\texamined coordinate: ")
-- RELEASE_LOGOFF  	luaHelperLog(coordinate)

	for key, unittype in pairs(recon[obj.Party].own) do
		for key2, unit in pairs(unittype) do
-- RELEASE_LOGOFF  			luaHelperLog(" Checking: "..unit.Name)
			if not unit.Dead then
				if luaGetDistance(unit, coordinate) < dist then
-- RELEASE_LOGOFF  					luaHelperLog("  Coordinate is in reconrange.")
					return true
				else
-- RELEASE_LOGOFF  					luaHelperLog("  Coordinate is far, far away.")
				end
			else
-- RELEASE_LOGOFF  				luaHelperLog("Found a dead unit in recon.")
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("No own unit found in the vicinity of the given coordinate.")
	return false
end

--[[AutoDoc
usage: priorityTable, priority = luaPrioritySelect(visibleEnemies, priority1 [,priority2] [,priority3] [,priority4] [,priority5] [,priority6])
category: Mission
shortdesc: a megadott prioritasnak megfeleloen vegignezi az ellenseget a visibleEnemies tablaban
desc: tipikusan luaGetVisibleEnemies()-el, vagy mas tipus-key-es tablakban meghatarozott unitok kozul valogat (a key miatt erre figyeljunk), a prioritasoknak megfeleloen0
visibleEnemies: table, lathato ellensegek tablaja, melyek ertekei unit tablak
priority1: string, elso szamu prioritas
priority2: string, masodik szamu prioritas
priority3: string, harmadik szamu prioritas
priority4: string, negyedik szamu prioritas
priority5: string, otodik szamu prioritas
priority6: string, hatodik szamu prioritas
priorityTable: table, a keresett egyseg unittablaja
priority: string, a legelso megfelelo prioritas
]]
function luaPrioritySelect(visibleEnemies, priority1, priority2, priority3, priority4, priority5, priority6)
	local targetSelected
	local lpriority1, lpriority2, lpriority3, lpriority4, lpriority5, lpriority6 = priority1, priority2, priority3, priority4, priority5, priority6

-- RELEASE_LOGOFF  --	luaHelperLog("Selection parameters \n Visible units: ")
-- RELEASE_LOGOFF  --	luaHelperLog(visibleEnemies)
-- RELEASE_LOGOFF  --	luaHelperLog(" priorities: \n"..priority1.." "..priority2.." "..priority3.." "..priority4.." "..priority5.." "..priority6)
	if visibleEnemies == nil then
		error("\n***ERROR: function luaPrioritySelect first param is nil instead of a table.", 2)
	end

--	if type(visibleEnemies) ~= "table" then
--		error("\n***ERROR: function luaPrioritySelect first param must be a table.", 2)
--	end

	if lpriority1 == nil then
		lpriority1 = "nyavaja"
	end
	if lpriority2 == nil then
		lpriority2 = "nyavaja"
	end
	if lpriority3 == nil then
		lpriority3 = "nyavaja"
	end
	if lpriority4 == nil then
		lpriority4 = "nyavaja"
	end
	if lpriority5 == nil then
		lpriority5 = "nyavaja"
	end
	if lpriority6 == nil then
		lpriority6 = "nyavaja"
	end

-- RELEASE_LOGOFF  --	luaHelperLog("Selection parameters \n Visible units: ")
-- RELEASE_LOGOFF  --	luaHelperLog(visibleEnemies)
-- RELEASE_LOGOFF  --	luaHelperLog(" priorities: \n"..lpriority1.." "..lpriority2.." "..lpriority3.." "..lpriority4.." "..lpriority5.." "..lpriority6)

	for enemykey, enemyunit in pairs(visibleEnemies) do
-- RELEASE_LOGOFF  --		luaHelperLog("enemy type: "..enemykey)

		if string.find(enemykey, lpriority1)~=nil then
-- RELEASE_LOGOFF  --			luaHelperLog("inside 1, found: "..enemyunit.Name)
			return enemyunit, lpriority1
		end
	end

	for enemykey, enemyunit in pairs(visibleEnemies) do
-- RELEASE_LOGOFF  --		luaHelperLog("enemy type: "..enemykey)

		if string.find(enemykey, lpriority2)~=nil then
-- RELEASE_LOGOFF  --			luaHelperLog("inside 2, found: "..enemyunit.Name)
			return enemyunit, lpriority2
		end
	end

	for enemykey, enemyunit in pairs(visibleEnemies) do
-- RELEASE_LOGOFF  --		luaHelperLog("enemy type: "..enemykey)

		if string.find(enemykey, lpriority3)~=nil then
-- RELEASE_LOGOFF  --			luaHelperLog("inside 3, found: "..enemyunit.Name)
			return enemyunit, lpriority3
		end
	end

	for enemykey, enemyunit in pairs(visibleEnemies) do
-- RELEASE_LOGOFF  --		luaHelperLog("enemy type: "..enemykey)

		if string.find(enemykey, lpriority4)~=nil then
-- RELEASE_LOGOFF  --			luaHelperLog("inside 4, found: "..enemyunit.Name)
			return enemyunit, lpriority4
		end
	end

	for enemykey, enemyunit in pairs(visibleEnemies) do
-- RELEASE_LOGOFF  --		luaHelperLog("enemy type: "..enemykey)

		if string.find(enemykey, lpriority5)~=nil then
-- RELEASE_LOGOFF  --			luaHelperLog("inside 5, found: "..enemyunit.Name)
			return enemyunit, lpriority5
		end
	end

	for enemykey, enemyunit in pairs(visibleEnemies) do
-- RELEASE_LOGOFF  --		luaHelperLog("enemy type: "..enemykey)

		if string.find(enemykey, lpriority6)~=nil then
-- RELEASE_LOGOFF  --			luaHelperLog("inside 6, found: "..enemyunit.Name)
			return enemyunit, lpriority6
		end
	end

	return nil
end
--[[AutoDoc
usage: selected, dist = luaPrioritySelectNearest(...)
category: Mission
shortdesc: lsd. luaPrioritySelect csak ha ket vagy tobb egyezo key-u unitot talal, a legkozelebbit adja vissza
desc: A fuggveny argumentumai: 'target' unit, amihez kepest nezzuk a 'targetTable' unitjait es annyi prioritas-key, amennyi csak kell (stringkent)
selected: table, a keresett unit
dist: number, tavolsag a keresett es a target unit kozott
]]
function luaPrioritySelectNearest(...)	--luaPrioritySelectNearest(target, targettable, "priority1", "priorityn")
	local target, targetTable, selected
	local dist
	local mindist = 10000000000

-- RELEASE_LOGOFF  	luaHelperLog("Number of arguments at luaPrioritySelectNearest : "..table.getn(arg))
	if table.getn(arg) < 3 then
		error("***Script function 'luaPrioritySelectNearest' error: not enough params!", 2)
	end

	if arg[1].ID == nil then
		error("***Script function 'luaPrioritySelectNearest' error: first param must be an entity!", 2)
	end

	if type(arg[2]) ~= "table" then
		error("***Script function 'luaPrioritySelectNearest' error: second param must be a table!", 2)
	end

	for key, value in pairs(arg) do
		if key == 1 then
			target = value
		elseif key == 2 then
			targetTable = value
		elseif key == "n" then
			return nil
		else
			for uType, unit in pairs(targetTable) do
				if string.find(uType, value) ~= nil and not unit.Dead then
					dist = luaGetDistance(target, unit)
					if dist < mindist then
						mindist = dist
						selected = unit
					end
				end
			end
			if selected ~= nil then
				return selected, dist
			end
		end
	end
end

--[[
memoriafoglalas miatt kiveve
-- a fentiekhez hasonlo, csak itt az osszes, a tavolsaglimitben megadott tipust kigyujti egy tablaba
-- luaPriorityList(target, targetTable, distanceLimit, "priority1",..."priorityn")
function luaPriorityList(...)
	local selectionTable = {}

-- RELEASE_LOGOFF  	luaHelperLog("Number of arguments at luaPriorityList : "..table.getn(arg))
	if table.getn(arg) < 4 then
		error("***ERROR: luaPriorityList has not enough params! (must have at least 4)", 2)
	end

	if arg[1].ID == nil then
		error("***ERROR: luaPriorityList's first param must be an entity!", 2)
	end

	if type(arg[2]) ~= "table" then
		error("***ERROR: luaPriorityList's second param must be a table!", 2)
	end

	local target, targetTable, distanceLimit
	for key, value in pairs(arg) do
		if key == 1 then
			target = value
-- RELEASE_LOGOFF  			luaHelperLog("target: "..thisTable[value.ID].Name)
		elseif key == 2 then
			targetTable = value
-- RELEASE_LOGOFF  			luaLogElementNames(targetTable, "Targettable")
		elseif key == 3 then
			distanceLimit = value
-- RELEASE_LOGOFF  			luaHelperLog("distancelimit: "..distanceLimit)
		elseif key == "n" then
-- RELEASE_LOGOFF  			luaHelperLog("luaPriorityList failed")
			return nil
		else
			for uType, unit in pairs(targetTable) do
				if string.find(uType, value) ~= nil and not unit.Dead then
-- RELEASE_LOGOFF  					luaHelperLog("Found unittype "..value)
					if distanceLimit ~= nil then
						if luaGetDistance(target, unit) < distanceLimit then
-- RELEASE_LOGOFF  							luaHelperLog("...inserting...")
							table.insert(selectionTable, unit)
						else
-- RELEASE_LOGOFF  							luaHelperLog("but it is too far")
						end
					else
-- RELEASE_LOGOFF  						luaHelperLog("...inserting...")
						table.insert(selectionTable, unit)
					end
				end
			end
			if next(selectionTable) ~= nil then
-- RELEASE_LOGOFF  				luaLogElementNames(selectionTable, "luaPriorityList result")
				return selectionTable
			end
		end
	end
end
]]

--[[AutoDoc
usage: key, val = luaPickRnd(anytable [,tablekey])
category: Math
shortdesc: egy tetszoleges tablabol random mod kivalaszt es visszaad egy value-t
desc: visszaad egy key - value parost egy tablabol, ha 'tablekey' nem nil, akkor az indexet es az erteket adja vissza
anytable: table, amelybol megkapjuk a keresett, vagy veletlenszeru kulcs - eretek parost
tablekey: mixed, a tabla kulcsa, az ehhez tartozo erteket keresi ebben az esetben a fuggveny
key: mixed, az anytable egyik kulcsa
val: mixed, a key-hez tartozo ertek
]]
function luaPickRnd(anytable, tablekey)
	local rnd, rndmax = 0, 0
	local rndSelected
-- RELEASE_LOGOFF  --	luaHelperLog("Random selection from table ")
-- RELEASE_LOGOFF  --	luaHelperLog(anytable)
-- RELEASE_LOGOFF  --	luaHelperLog("initiated")
	for key, value in pairs(anytable) do
		rnd = luaRnd()
		if rnd > rndmax then
			rndmax = rnd
			rndSelected = value
			rndkey = key
		end
-- RELEASE_LOGOFF  --		luaHelperLog("Random values - rnd: "..rnd..", rndmax: "..rndmax..", rndSelected: "..rndSelected)
	end

	if tablekey == nil then
		return rndSelected
	else
		return rndkey, rndSelected
	end
end

--[[AutoDoc
usage: val = luaPickInRange(...)
category: Math
shortdesc:
desc:
val:
]]
function luaPickInRange(...)
	local pos = 1
	local vals = {}
	local chances = {}

	if arg[1] == "_tables_" then
		--luaHelperLog("luaPickInRange got tables as arguments!")
		vals = arg[2]
		chances = arg[3]

	else
		for key, value in pairs(arg) do
			if key ~= "n" then
				if pos == 1 then
					table.insert(vals, value)
					pos = 2
				elseif pos == 2 then
					table.insert(chances, value)
					pos = 1
				end
			end
		end
	end

--[[

-- RELEASE_LOGOFF  	luaLog("-----------Pick in range in action-----------")
-- RELEASE_LOGOFF  	luaLog("- ")
-- RELEASE_LOGOFF  	luaLog("- Chances")
	for i, v in pairs (chances) do
-- RELEASE_LOGOFF  		luaLog("-  "..i.." : "..v)
	end
]]

	local sumdice = 0
	for key, value in pairs(chances) do
-- RELEASE_LOGOFF  		Assert(value >= 0, "luaPickInRange must not get a value smaller than 0!\n"..debug.traceback())
		sumdice = sumdice + value
	end

-- RELEASE_LOGOFF  --	luaLog("- Dice : "..sumdice)

	--luaLog("- Chances: ")
	--luaLog(chances)
	local ranges = {}
	for key, value in pairs(chances) do
		local range = {}
		if key == 1 then
				range.min = 0
				range.max = value
				range.ParamNum = 1
			table.insert(ranges, range)
		else
				--luaLog("Key: "..key)
				range.min = ranges[table.getn(ranges)].max + 1
				range.max = ranges[table.getn(ranges)].max + value
				range.ParamNum = key
			if range.max - range.min >= 0 then
				table.insert(ranges, range)
			end
		end
	end


	--luaLog("- ")
	--luaLog("- Ranges")
	for i, v in pairs (ranges) do
		--luaLog("-  "..i.." : "..v.min..", "..v.max.." Paramnum: "..v.ParamNum)
	end

	local result = luaRnd(1, sumdice)
-- RELEASE_LOGOFF  --	luaLog("- ")
-- RELEASE_LOGOFF  --	luaLog("- Roll: "..result)

	local selectedRange
-- RELEASE_LOGOFF  --	luaLog("- ")
-- RELEASE_LOGOFF  --	luaLog("- Investigating ranges")
	for key, value in pairs(ranges) do
-- RELEASE_LOGOFF  --		luaLog("-  Range "..key.." : "..value.min..", "..value.max.." Paramnum: "..value.ParamNum)
		if result >= value.min and result <= value.max then
-- RELEASE_LOGOFF  --			luaLog("-   Roll found at key "..value.ParamNum)
			selectedRange = value.ParamNum
			break
		end
	end

-- RELEASE_LOGOFF  	Assert(selectedRange ~= nil, "***ERROR: luaPickInRange hasn't found solution for given data. Check args!"..debug.traceback())

-- RELEASE_LOGOFF  --	luaLog("---------------------------------")
	return vals[selectedRange]
end

-- 'target'-et tamado ellensegeket es azok szamat adja vissza
-- target.ID-vel a szokasos modon atadni a celpontot
--[[
function luaGetAttackers(target)
	local attackers = {}
	local i, enemynumber = 0, 0
	local enemytype
]]
--	for key, unittype in pairs(recon[thisTable[target.ID]["Party"]]["enemy"]) do
--[[		tonumber(i)
		i = 0
		for key2, unit in pairs(unittype) do
			if thisTable[unit.ID]["FireAtWillTarget"] ~= nil then
-- RELEASE_LOGOFF  --				luaHelperLog("luaGetAttackers: reference.ID = "..target.ID.."\n examined FAWTarget.ID = "..thisTable[unit.ID]["FireAtWillTarget"].ID)
				if thisTable[unit.ID]["FireAtWillTarget"].ID == target.ID or thisTable[unit.ID]["Target"].ID == target.ID and luaGetDistance(unit, target)<7000 then
					tonumber(i)
					i = i+1
					enemytype = key..tostring(i)
-- RELEASE_LOGOFF  		--			luaHelperLog("key "..key..", uType: "..uType)
					attackers[key..tostring(i)] = unit
					enemynumber = enemynumber + 1
				end
			elseif thisTable[unit.ID]["Target"] ~= nil then
-- RELEASE_LOGOFF  --				luaHelperLog("\nTarget.ID = "..thisTable[unit.ID]["Target"].ID)
				if thisTable[unit.ID]["Target"].ID == target.ID and luaGetDistance(unit, target)<7000 then
					tonumber(i)
					i = i+1
					enemytype = key..tostring(i)
-- RELEASE_LOGOFF  		--			luaHelperLog("key "..key..", uType: "..uType)
					attackers[key..tostring(i)] = unit
					enemynumber = enemynumber + 1
				end
			end
		end
	end
-- RELEASE_LOGOFF  	luaHelperLog(thisTable[target.ID].Name.." attackers' number = "..enemynumber)
	if enemynumber == 0 then
		return nil
	else
		return attackers, enemynumber
	end
end
]]

--[[AutoDoc
usage: table = luaSumTables(...)
category: Math
shortdesc: tablak osszegzese
desc: akarhany tabla osszegzese indexezesre erdemes figyelni, ami mar van, felulirja, a fv parameterei tablak
table: table, az osszevont tablak
]]
function luaSumTables(...)
	local argnumber = table.getn(arg)
	local sumtable = {}
-- RELEASE_LOGOFF  --	luaHelperLog("luaSumTables initiated, number of arguments: "..argnumber)
	--LogToFile("step1 ", arg)

	for key, value in pairs(arg) do
-- RELEASE_LOGOFF  --		luaHelperLog("key "..key)
-- RELEASE_LOGOFF  --		luaHelperLog("value "..value)
-- RELEASE_LOGOFF  --		luaHelperLog("step2"..value.." uType: "..type)
-- RELEASE_LOGOFF  --		Assert( 0, debug.traceback("debug trace faka:") )
-- RELEASE_LOGOFF  --		luaHelperLog("step3"..value.." uType: "..type(value))
--		if type(value) == "table" then
-- RELEASE_LOGOFF  --		Assert( 0, debug.traceback() )
		if key ~= "n" then
-- RELEASE_LOGOFF  			Assert( type(value) == "table", debug.traceback("Bad type for luaSumTables") )
			for key2, value2 in pairs(value) do
				if sumtable[key2] ~= nil then
-- RELEASE_LOGOFF  					luaHelperLog("Warning: adding tables, possible loss of data. Tablekey -"..key2.."- is already used, now it is overwritten.")
				end
				sumtable[key2] = value2
			end
		end
--		elseif type(value) ~= "table" and key ~= "n" then
-- RELEASE_LOGOFF  --			luaHelperLog("wrong value: "..value)
--			error("***ERROR: luaSumTables got a param which is not a table.", 2)
--		end
	end

	return sumtable
end

--[[AutoDoc
usage: table = luaSumTablesIndex(...)
category: Math
shortdesc: tablak osszegzese
desc: akarhany tabla osszegzese sajat indexezessel kerulnek be az uj tablaba (szamozas), itt mar nincs adatvesztes, ami mar van, felulirja, a fv parameterei tablak
table: table, az osszevont tablak
]]
function luaSumTablesIndex(...)
	local argnumber = table.getn(arg)
	local sumtable = {}
	local i = 0

-- RELEASE_LOGOFF  --	luaHelperLog("luaSumTablesIndex initiated, number of arguments: "..argnumber)
	--LogToFile("step1 ", arg)

	for key, value in pairs(arg) do
-- RELEASE_LOGOFF  --		luaHelperLog("step2"..value.." type: "..type(value))
--		if type(value) == "table" then
		if key ~= "n" then
			for key2, value2 in pairs(value) do
				i = i+1
				sumtable[i] = value2
			end
		end
--		elseif type(value) ~= "table" and key ~= "n" then
-- RELEASE_LOGOFF  --			luaHelperLog("type: "..type(value)..", key: "..key)
-- RELEASE_LOGOFF  --			LogToFile("value: ", value)
--			error("***ERROR: luaSumTablesIndex needs tables as arguments!", 2)
--		end
	end

	return sumtable
end

--[[AutoDoc
usage: number = luaCountTable(table)
category: Math
shortdesc: visszaadja egy tabla melyseget
desc: vegig iteral egy adott tablan kulcs - ertekparos alapjan es visszaadja, hogy mennyi eleme van egy tablanak
table: table, a kerdeses tabla
number: number, a kerdeses tabla melysege
]]
function luaCountTable(table)
	local number = 0

	if table == nil then
		error("***ERROR: luaCountTable got nil as param.", 2)
	end

	for key, value in pairs(table) do
		number = number + 1
	end

	return number
end

--[[AutoDoc
usage: distTable = luaSortByDistance2(unit, targets [,nearest])
category: Mission
shortdesc: tavolsagi sorrendbe teszi a tablaban szereplo unitokat
desc: egy unitokat value-kent tartalmazo tablaban tavolsagi sorrendbe teszi az egysegeket 'unit'-hoz kepest
unit: table, a kerdeses egyseg amihez kepest sorrendbe teszi a tobbi egyseget
targets: table, a sorrendbe teendo egysegek tablaja
nearest: table, ha nem nil akkor csak a legkozelebbi unitot adja vissza
distTable: table, ha 'nearest' nem nil, akkor a legkozelebbi unitot adja vissza es a tavolsagat, ha nil, akkor tablat; key- a tavolsag, value- a unit
]]
function luaSortByDistance2(unit, targets, nearest)
	local dist
	local distOrder = {}
	local targetList = luaSumTablesIndex(targets)

-- RELEASE_LOGOFF  	luaHelperLog("luaSortByDistance2 has been called")

	if next(targetList) == nil then
-- RELEASE_LOGOFF  		luaHelperLog("--> targettable is empty!")
		return
	end
	local sorted = {}
	local unitpos

	if unit.ID ~= nil then
		unitpos = GetPosition(thisTable[unit.ID])
	else
		unitpos = unit
	end

	while next(targetList) do
		local minKey = nil
		local minDist2 = 2000000000
		for key, value in pairs(targetList) do
		    local otherpos

			if value.ID ~= nil then
				otherpos = GetPosition(thisTable[value.ID])
			else
				otherpos = value
			end

			local diffx
			local diffz
			diffx=unitpos.x-otherpos.x
			diffz=unitpos.z-otherpos.z

			local dist2 = diffx*diffx+diffz*diffz

			if dist2 < minDist2 then
				minDist2 = dist2
				minKey = key
			end
		end

		table.insert(sorted, targetList[minKey])
		table.remove(targetList, minKey)
	end

	if nearest ~= nil then
		return sorted[1], luaGetDistance(unit, sorted[1])
	else
		return sorted
	end


end

--[[
memoriafoglalas miatt kiveve
-- kivalasztja az elso 'targetType'-nak megfelelo tipusu unitot 'targetTable' tablabol
function luaSelectType(targetTable, targetType)
-- RELEASE_LOGOFF  	Assert(type(targetTable) == "table", "***ERROR: luaSelectType first param must be a table with entities!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(targetType) == "string", "***ERROR: luaSelectType second param must be a unittype string!\n"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaSelectType called, searching for targettype "..targetType.."...")
	for key, value in pairs(targetTable) do
		if value.Class.Type == targetType then
-- RELEASE_LOGOFF  			luaHelperLog(" Found targettype "..targetType..": "..value.Name )
			return value
		end
	end
	return nil
end
]]

--[[AutoDoc
usage: distTable = luaSortByDistance(unit, targets [,nearest])
category: Mission
shortdesc: tavolsagi sorrendbe teszi a tablaban szereplo unitokat
desc: egy unitokat value-kent tartalmazo tablaban tavolsagi sorrendbe teszi az egysegeket 'unit'-hoz kepest
unit: table, a kerdeses egyseg amihez kepest sorrendbe teszi a tobbi egyseget
targets: table, a sorrendbe teendo egysegek tablaja
nearest: table, ha nem nil akkor csak a legkozelebbi unitot adja vissza
distTable: table, ha 'nearest' nem nil, akkor a legkozelebbi unitot adja vissza es a tavolsagat, ha nil, akkor tablat; key- a tavolsag, value- a unit
]]
function luaSortByDistance(unit, targets, nearest)
	local dist
	local distOrder = {}
	local targetList = luaSumTablesIndex(targets)

-- RELEASE_LOGOFF  	luaHelperLog("luaSortByDistance has been called")

	if next(targetList) == nil then
-- RELEASE_LOGOFF  		luaHelperLog("--> targettable is empty!")
		return
	end
--[[
	for key, value in pairs(targets) do
		if value.ID == nil then
			error("ERROR: function luaSortByDistance needs a table with values with ID!", 2)
		end

		-- ertekadas, kerekites lefele
		dist = math.floor(luaGetDistance(unit, value))

		if distOrder[dist] ~= nil then
-- RELEASE_LOGOFF  			luaHelperLog("found matching key, increasing number"..dist)
			dist = dist +1
		end

-- RELEASE_LOGOFF  		luaHelperLog("-Adding key "..dist.." with entity: "..value.Name)
		table.insert(distOrder, tonumber(dist), value)
		--distOrder[dist] = value
	end

	--LogToFile("-Distances :\n", distOrder)

	local minDist=1000000
	if nearest ~= nil then
		--LogToFile("Distance table: ", distOrder)
-- RELEASE_LOGOFF  	--	luaLogElementNames(distOrder, "distance table")
		for key, value in pairs(distOrder) do
-- RELEASE_LOGOFF  --			luaHelperLog("Checking "..value.Name..", distance: "..key)
-- RELEASE_LOGOFF  --			luaHelperLog("minimal distance: "..minDist)
			if key < minDist then
-- RELEASE_LOGOFF  --				luaHelperLog("dist less then mindist, updating")
				minDist = key
			end
		end

-- RELEASE_LOGOFF  	--	luaHelperLog("luaSortByDistance nearest: "..distOrder[minDist].Name.." Distance: "..minDist)
		return distOrder[minDist], minDist
	else
		return distOrder
	end

]]
	local sorted = {}
	while next(targetList) do
		local minKey = nil
		local minDist = 10000000
		for key, value in pairs(targetList) do
			local dist = math.floor(luaGetDistance(unit, value))
			if dist <= minDist then
				minDist = dist
				minKey = key
			end
		end

		table.insert(sorted, targetList[minKey])
		table.remove(targetList, minKey)
	end

	if nearest ~= nil then
		return sorted[1], luaGetDistance(unit, sorted[1])
	else
		return sorted
	end
end

--[[
memoriafoglalas miatt kiveve
-- kivalasztja az elso 'targetType'-nak megfelelo tipusu unitot 'targetTable' tablabol
function luaSelectType(targetTable, targetType)
-- RELEASE_LOGOFF  	Assert(type(targetTable) == "table", "***ERROR: luaSelectType first param must be a table with entities!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(targetType) == "string", "***ERROR: luaSelectType second param must be a unittype string!\n"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaSelectType called, searching for targettype "..targetType.."...")
	for key, value in pairs(targetTable) do
		if value.Class.Type == targetType then
-- RELEASE_LOGOFF  			luaHelperLog(" Found targettype "..targetType..": "..value.Name )
			return value
		end
	end
	return nil
end
]]

--[[AutoDoc
usage: element = luaGetElement(targettable, number, index)
category: Math
shortdesc: visszaad egy adott key-t vagy value-t egy tablabol
desc: A targettablaban a 'number' szamu kulcsot vagy erteket adja vissza.
targettable: table, a céltábla, amiben keresünk, mindegy, milyen indexelésû
number: number, ahanyadik elemet keressuk a tablaban (egesz szam!)
index: mixed, ha nem nil, akkor a kulcsot adja vissza a fuggveny, ha nil, akkor az erteket
elemnent: mixed, ha nincsen eleme a tablanak, akkor -1 -et ad vissza, ha magasabb szamot kapott paramkent, ahany eleme van, akkor nil-t
]]
function luaGetElement(targettable, number, index)
	local i = 0

	if targettable == nil then
		error("***ERROR: luaGetElement's first param is nil instead of a table.", 2)
	end

	if number == nil or number == 0 then
		error("***ERROR: luaGetElement's second param is nil or zero.", 2)
	end

	for key, value in pairs(targettable) do
		--luaHelperLog("***Kapott tabla***")
		--LogToFile(table)
		--luaHelperLog("***Kapott tablaEND***")
		--luaHelperLog("***Kapott num "..number.." ***")
		--luaHelperLog("***Kapott index "..index.." ***")
		i = i + 1

		if number == i then
			if index ~= nil then
				--luaHelperLog("i="..i)
				--luaHelperLog("KEY "..key)
				return key
			else
				--luaHelperLog("i="..i)
				--luaHelperLog("VALUE ")
				--luaHelperLog(value)
				return value
			end
		end
	end

	if i == 0 then
		return -1
	end

	if number > i then
		return nil
	end
end

--[[AutoDoc
usage: luaRemoveElements(targettable, removables)
category: Math
shortdesc: egy tablabol kivesz elemeket a kiveendo elemeket tartalmazo tabla segitsegevel
desc: Tablaelemeket tavolit el a fuggveny egy masodik tabla alapjan amelyben a tabla ertekei a az elso tabla eltavolitando elemeinek a kulcsai
targettable: table, az a tabla, ahonnan ki akarunk venni
removables: table, az a tabla, aminek az ERTEKEI tartalmazzak a kiveendo elemek KULCSAIT
]]
function luaRemoveElements(targettable, removables)
	for key, value in pairs(removables) do
		table.remove(targettable, value)
	end
end

--[[
memoriafoglalas miatt kiveve
-- adott tablat redukal le annyi elemuve, ami meg van hatarozva masodik paramkent
function luaReduceTableSize(targettable, size)
-- RELEASE_LOGOFF  	Assert(type(targettable) == "table" , "***ERROR: luaReduceTable needs a table for first param."..debug.traceback())
-- RELEASE_LOGOFF  	Assert(size ~= nil and size ~= 0, "***ERROR: luaReduceTable needs a number greater then 0 for second param."..debug.traceback())
	local reducedTable = {}
	local i = 1
	for key, value in pairs(targettable) do
		if i <= size then
			--table.insert(reducedTable, value)
			reducedTable[key] = value
		else
			break
		end

		i = i + 1
	end

	if next(reducedTable) ~= nil then
		return reducedTable
	else
		return nil
	end
end
]]

--[[AutoDoc
usage: ammoTable = luaRemoveEmptyPlanes(unitTable [,str])
category: Mission
shortdesc: Kiszuri a tablabol azokat a repuloket amelyeknek meg van fuggesztmenyuk
desc: A megadott tablabol visszaad egy tablat amelyben csak a fuggesztvennyel rendelkezo unitok szerepelnek
unitTable: table, a plane entityket tartalmazo tabla
str: string, ezt a stringet irja bele a helperlogba amikor nem talal a repulon fuggesztmenyt
ammoTable: table, azon unitok tablaja, amelyeken meg talalhato fuggesztmeny
]]
function luaRemoveEmptyPlanes(unitTable, str)
	local ammoTable = {}
	if str == nil then
		str = " "
	end

	for key, value in pairs(unitTable) do
-- RELEASE_LOGOFF  		Assert(luaGetType(value) == "plane", "***ERROR: luaRemoveEmptyPlanes must get a planetable!\n"..debug.traceback())
		value.ammo = GetProperty(value, "ammoType")
		--luaLog("KAKAS")
		--luaLog(value)
-- RELEASE_LOGOFF  		luaHelperLog("Ammo of unit "..value.Name..": "..value.ammo)
		if value.ammo ~= 0 then
-- RELEASE_LOGOFF  			luaHelperLog(" unit has ammo yet")
			table.insert(ammoTable, value)
		else
-- RELEASE_LOGOFF  			luaHelperLog("Unit has run out of ammo: "..str..value.Name)
		end
	end

-- RELEASE_LOGOFF  	luaLogElementNames(unitTable, "orig table ")
-- RELEASE_LOGOFF  	luaLogElementNames(ammoTable, "those having ammo ")

	return ammoTable
end

--[[AutoDoc
usage: aliveTable = luaRemoveDeadsFromTable(UnitTable [,str])
category: Mission
shortdesc: unittable-bol kiveszi a halott elemeket
desc: A megadott tablabol visszaad egy tablat amelyben csak az elo unitok szerepelnek
unitTable: table, a vizsgalt entityket tartalmazo tabla
str: string, ezt a stringet irja bele a logba amikor nem talal a repulon fuggesztmenyt
aliveTable: table, azon unitok tablaja, amelyek meg elnek
]]
function luaRemoveDeadsFromTable(UnitTable,str)
	local AliveTable = {}
	if str == nil then
		str = " "
	end

	for key, value in pairs(UnitTable) do
		--luaLog("unittable")
		--luaLog(UnitTable)
		--luaLog("value")
		--luaLog(value)
		if not value.Dead then
			table.insert(AliveTable, value)
		else
			--luaLog("Dead unit: "..str..value.Name)
		end
	end

	--luaLogElementNames(UnitTable, "orig table ")
	--luaHelperLog("----------")
	--luaLogElementNames(AliveTable, "those alive ")

	return AliveTable
end

--[[
memoriafoglalas miatt kiveve
function luaGetDirectionVector(Obj1, Obj2)
	local ax, ay, az
	local bx, by, bz
	local DirectionVector = {}

	if Obj1.ID ~= nil then
		local pos = GetPosition(thisTable[Obj1.ID])
		ax, ay, az = pos.x, pos.y, pos.z
	else
		ax, ay, az = Obj1.x, Obj1.y, Obj1.z
	end

	if Obj2.ID ~= nil then
		local pos = GetPosition(thisTable[Obj2.ID])
		bx, by, bz = pos.x, pos.y, pos.z
	else
		bx, by, bz = Obj2.x, Obj2.y, Obj2.z
	end

	DirectionVector["x"] = bx - ax
	DirectionVector["y"] = by - ay
	DirectionVector["z"] = bz - az

	return DirectionVector
end
]]

--[[
memoriafoglalas miatt kiveve
function luaRotateVector(vector, dir)	-- ez egy nagy fukk, hallo. Todo w. low prior.
-- RELEASE_LOGOFF  	Assert(vector.x ~= nil and vector.z ~= nil, "***ERROR: luaRotateVector's first param must be a vectortable!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(dir == -90 or dir == 90, "***ERROR: luaRotateVector's second param must be the degree of turning!"..debug.traceback())
	local normal = {}
	if dir == 90 then
		normal.x = vector.z
		normal.z = -1 * vector.x
	elseif dir == -90 then
		normal.x = -1 * vector.z
		normal.z = vector.x
	end

-- RELEASE_LOGOFF  	LogToFile("Rotated vector of ", vector, " towards ", dir, " is ", normal)
	return normal
end

]]


--[[
function luaGetGroupNumber(groupent)
-- RELEASE_LOGOFF  	LogToFile("Counting group size for group: ", groupent)
	local count = 0
	for key, childgroup in pairs(GetGroupChildren(groupent)) do
		count = count + 1
		for key2, childschildgroup in pairs(GetGroupChildren(childgroup)) do
			count = count + 1
		end
	end

	return count
end
]]

--[[
memoriafoglalas miatt kiveve
-- barmilyen indexelesu tablat atkonvertal tipusindexelesube
-- argumentum csak entity-kbol allo tabla lehet
function luaConvertIndicesToTypeIndices(EntTables)
-- RELEASE_LOGOFF  	Assert(EntTables ~= nil, "***ERROR: luaConvertIndicesToTypeIndices' argument is -nil- instead of a table."..debug.traceback())
	local typeIndexedTable = {}
	local i = 1
	local knownTypes = {}
	local inserting = true
	for index, ent in pairs(EntTables) do
		if knownTypes[ent.Class.Type] == nil then
-- RELEASE_LOGOFF  			luaHelperLog("New type "..ent.Class.Type)
			knownTypes[ent.Class.Type] = 1
		else
-- RELEASE_LOGOFF  			luaHelperLog("Already inserted type, increasing type num.")
			knownTypes[ent.Class.Type] = knownTypes[ent.Class.Type] + 1
		end
]]

--		typeIndexedTable[ent.Class.Type..knownTypes[ent.Class.Type]] = ent
--[[
	end

	if next(typeIndexedTable) ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Converting finished")
		for key, value in pairs(typeIndexedTable) do
-- RELEASE_LOGOFF  			luaHelperLog("Type: "..key)
-- RELEASE_LOGOFF  			luaHelperLog("Entity: "..value.Name)
		end
		return typeIndexedTable
	else
-- RELEASE_LOGOFF  		luaHelperLog("There were no elements to convert")
		return nil
	end
end
]]

--[[AutoDoc
usage: equal = luaAreEqualTables(table1, table2)
category: Math
shortdesc: ket tabla tartalmat hasonlitja ossze elemrol elemre
table1: table, elso tabla
table2: table, masodik tabla
equal: bool, igaz, ha 2 melysegig ugyananz a 2 table, ellenkezo esetben false
]]
function luaAreEqualTables(table1, table2)
-- RELEASE_LOGOFF  	luaHelperLog("Checking two tables whether they are equal.")
-- RELEASE_LOGOFF  	Assert(type(table1) == "table" and type(table2) == "table", "***ERROR: luaAreEqualTables needs two tables as arguments!\n instead of "..type(table1).." and "..type(table2).."\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(next(table1) ~= nil, "***ERROR: luaAreEqualTables got an empty table as first param!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(next(table2) ~= nil, "***ERROR: luaAreEqualTables got an empty table as second param!\n"..debug.traceback())

	for table1key, table1value in pairs(table1) do
		if type(table1value) ~= "table" and table2[table1key] ~= table1value then
-- RELEASE_LOGOFF  			luaHelperLog("Found difference at key "..table1key..", equality failed at first level.")
			return false
		elseif type(table1value) == "table" then
			for table1tablekey, table1tablevalue in pairs(table1value) do
				if table2[table1key] == nil or type(table1tablevalue) ~= "table" and table2[table1key][table1tablekey] ~= table1tablevalue then
-- RELEASE_LOGOFF  					luaHelperLog(" Found difference at key "..table1key..", equality failed at second level.")
					return false
				elseif type(table1tablevalue) == "table" then
-- RELEASE_LOGOFF  					luaHelperLog("  Unhandled depth, neglecting value at key "..table1tablekey)
				end
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("The given tables were the same for two levels depth.")
	return true
end

--[[AutoDoc
usage: hasParent = luaHasParentGroup(unitEnt)
category: Unit
shortdesc: visszaadja, hogy egy entitynek van-e parent groupja. Ha van, akkor az a groupentityt is visszaadja
desc: Megmondja hogy egy entitnek van e parentja, azaz formacioban van e eppen.
unitEnt: table, entity amelyet vizsgalunk
hasParent: bool, ha igaz akkor a parent ernty-t adja vissza ellenkezo esetben false-ot
]]
function luaHasParentGroup(unitEnt)
-- RELEASE_LOGOFF  	Assert(unitEnt.ID ~= nil, "***ERROR: luaHasParentGroup needs a game entity as argument!"..debug.traceback())
	if IsFormationFollower(unitEnt) then
		return GetFormationLeader(unitEnt)
	end
	return false
end

--[[AutoDoc
usage: inside = luaIsInside(searched, targetTable)
category: Math
shortdesc: visszaadja, hogy 'target' benne van-e az adott tablaban
desc: Megkeresi a targetTable-ben, hogy adott searched benne van e, ha igen visszaadja, ha nem false-ot kapunk
searched: table, lehet entity vagy koordinata, erre keresunk ra
targetTable: tabla, ebben keresunk
inside: mixed, kulcs, ha benne van a targetTable-ben, false abban az esetben, ha nem
]]
function luaIsInside(searched, targetTable)
	local coord = luaIsCoordinate(searched)
-- RELEASE_LOGOFF  	Assert(searched.ID ~= nil or coord, "***ERROR: luaIsInside needs a game entity or a coordinate as first argument!"..debug.traceback())
	--Assert(targetTable ~= nil and luaIsEntityTable(targetTable, true), "***ERROR: luaIsInside needs a table which consists of game entities as second argument!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Coord? ")
-- RELEASE_LOGOFF  	luaHelperLog(coord)
	for key, value in pairs(targetTable) do
		if not coord and value.ID == searched.ID or coord and luaAreEqualTables(value, searched) then
			return key
		end
	end
	return false
end

--[[AutoDoc
usage: removed = luaRemoveByName(targettable, name)
category: Math
shortdesc: name-mel megadott nevu entityt kiveszi egy entityket tartalmazo tablabol (targettable), ha megtalalja.
desc: Megkeresi a targetrable-ben, hogy adott nevu entity benne van e, ha igen kiveszi.
targettable: table, ebben keresunk
name: string, erre a nevu entityre kresunk ra
removed: mixed, true ha megtalalta a fuggveny es kivette, nil, ha nem talalt ilyen nevu entityt
]]
function luaRemoveByName(targettable, name)
-- RELEASE_LOGOFF  	Assert(type(targettable) == "table", "***ERROR: luaRemoveByName needs a table as first argument!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(name) == "string", "***ERROR: luaRemoveByName's 2nd param must be a name string!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaRemoveByName called.")
	for key, value in pairs(targettable) do
		if value.Name == name then
-- RELEASE_LOGOFF  			luaHelperLog(" Found element: "..name..", removing and exiting...")
			table.remove(targettable, key)
			return true
		end
	end
-- RELEASE_LOGOFF  	luaHelperLog(" No entity found with name: "..name)
	return nil
end

--[[AutoDoc
usage: reconlevel = luaGetReconLevel(ent, party)
category: Unit
shortdesc: visszadja egy entity reconszintjet
desc: Adott party-val rendelkezo entity felderitesi szintjet adja vissza
ent: table, a kerdeses entitas
party: enmum, az entitas party-ja
reconlevel: number, a kerdeses entity felderitettsegi szintje
]]
function luaGetReconLevel(ent, party)
-- RELEASE_LOGOFF  	Assert(ent ~= nil, "***ERROR: luaGetReconLevel must have an entity as first param to work!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(party ~= nil, "***ERROR: luaGetReconLevel must have a party as second param to work!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("luaGetReconLevel called. Entity: "..ent.Name..", party: "..party)
	ent.reconlevel = GetProperty(ent, "reconlevel")
-- RELEASE_LOGOFF  	luaHelperLog(" Result: ")
-- RELEASE_LOGOFF  	luaHelperLog(ent.reconlevel[party])
	return ent.reconlevel[party]
end

--[[AutoDoc
usage: luaMoveToInterval(unit, minx, maxx, minz, maxz, miny, maxy)
category: Math
shortdesc:
desc:
]]
function luaMoveToInterval(unit, minx, maxx, minz, maxz, miny, maxy)
-- RELEASE_LOGOFF  	Assert(unit.ID ~= nil, "***ERROR: luaMoveToInterval needs an entity as first param!"..debug.traceback())

	local trg = {}							-- random mozgas sajat unitokra
		trg.x = luaRnd(minx, maxx)
		if miny == nil then
			trg.y = 0
		else
			trg.y = luaRnd(miny, maxy)
		end
		trg.z = luaRnd(minz, maxz)
-- RELEASE_LOGOFF  	LogToFile("Selected moving target: ", trg)
	if luaGetType(unit) == "ship" or luaGetType(unit) == "sub" then
		NavigatorMoveToRange(unit, trg)
	elseif luaGetType(unit) == "plane" then
		PilotMoveToRange(unit, trg, 1000)
	elseif luaGetType(unit) == nil then
-- RELEASE_LOGOFF  		luaHelperLog("No type found for unit, movement is not executed.")
		return nil
	end
end

--[[AutoDoc
usage: type = luaGetType(unitent)
category: Math
shortdesc: visszaadja egy unit tipusat
desc: A keersett entity tipusat adja vissza
unitent: table, a kerdeses entity
type: mixed, az entity tipusa: ship, plane, sub, vehicle, landfort, vagy nil lehet
]]
function luaGetType(unitent)
-- RELEASE_LOGOFF  	Assert(unitent ~= nil and unitent.ID ~= nil, "***ERROR: luaGetType needs an entity as arg!"..debug.traceback())

	if unitent.Class.Type == "MotherShip" or unitent.Class.Type == "BattleShip" or unitent.Class.Type == "Cruiser" or unitent.Class.Type == "Cargo" or unitent.Class.Type == "Destroyer" or unitent.Class.Type == "TorpedoBoat" or unitent.Class.Type == "LandingShip" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a ship.")
		return "ship"
	elseif unitent.Class.Type == "Fighter" or unitent.Class.Type == "DiveBomber" or unitent.Class.Type == "TorpedoBomber" or unitent.Class.Type == "LevelBomber" or unitent.Class.Type == "SmallReconPlane" or unitent.Class.Type == "LargeReconPlane" or unitent.Class.Type == "Kamikaze" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a plane.")
		return "plane"
	elseif unitent.Class.Type == "Submarine" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a submarine.")
		return "sub"
	elseif unitent.Class.Type == "LandVehicle" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a land vehicle.")
		return "vehicle"
	elseif unitent.Class.Type == "LandFort" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a landfort.")
		return "landfort"
	elseif unitent.Class.Type == "CommandBuilding" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a commandbuilding.")
		return "commandbuilding"
	elseif unitent.Class.Type == "AirField" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is an airfield.")
		return "airfield"
	elseif unitent.Class.Type == "Shipyard" then
-- RELEASE_LOGOFF  		luaHelperLog(" Unit "..unitent.Name.." is a shipyard.")
		return "shipyard"
	end

-- RELEASE_LOGOFF  	luaHelperLog(" No type found for unit "..unitent.Name)
	return nil
end

--[[AutoDoc
usage: newTable = luaTypeFilter(origtable, filtertype)
category: Math
shortdesc:
desc:
]]
function luaTypeFilter(origtable, filtertype)
-- RELEASE_LOGOFF  	luaHelperLog("luaTypeFilter initiated...")
	--luaLogElementNames(origtable, "\torig: ")
-- RELEASE_LOGOFF  	luaHelperLog("filter type: "..filtertype)

-- RELEASE_LOGOFF  	Assert(type(origtable) == "table", "***ERROR: needs a table as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(filtertype) == "string", "***ERROR: needs a typestring as second param!"..debug.traceback())

	local newTable = {}

	for key, value in pairs (origtable) do
		if value.Class.Type == filtertype then
-- RELEASE_LOGOFF  			luaHelperLog("Found that "..value.Name.." is a "..filtertype..", inserting.")
			table.insert(newTable, value)
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("Filtering done.")
	--luaLogElementNames(newTable, "\tfiltered entity: ")

	return newTable
end

---------------------------------------------------------------------------------
-- RELEASE_LOGOFF  -- Logolast segito fuggvenyek
---------------------------------------------------------------------------------

--[[AutoDoc
-- RELEASE_LOGOFF  usage: luaDoCustomLog([lgfile,] txt [,mode] [,helper])
category: Debug
shortdesc: megadott logfileba ir
desc: Megadott logfilba ir, parameterezestol fuggoen felulirja, vagy hozzairja a 'txt' parametert
lgfile: string, a letrehozando file, ha nilt adunk meg akkor luaCustomLog.log neven jelenik meg a stuff
txt: string vagy tabla (2 melysegig)
mode: string, a - append, u - update, nil eseten append a default
helper: bool, ha true hozzafuzi a '---HelperLog---' stringet
]]
function luaDoCustomLog(lgfile,txt,mode,helper)
	if not Mission.CustomLog then
		return
	end
-- RELEASE_LOGOFF  	Assert(txt ~= nil,"ERROR in function luaDoCustomLog, txt is nil")
-- RELEASE_LOGOFF  	--Assert(mode ~= "a" or mode ~= "u", "ERROR luaDoCustomLog mode must be 'a' or 'u'")

	-- locals
	local firstLog = true
	local date = os.date()

	if helper then
		helper = " ---HelperLog--- "
	else
		helper = " "
	end

	if lgfile == nil then
		lgfile = "luaCustomLog.log"
	else
		lgfile = tostring(lgfile)
	end

	if PS2 then
		--lgfile = "host0:y:\\"..lgfile
		return
	elseif XBOX then
		lgfile = "T:\\"..lgfile
	elseif XENON then
		lgfile = "d:\\"..lgfile
	end

	-- file opening --
	if mode == "a" or mode == nil then
		mode = "a+"
	elseif mode == "u" then
		mode = "w+"
	else
		mode = "a+"
	end
	local log = io.open(lgfile, mode)
	if log == nil then
		return
	end

	-- first loging --
	if Mission.LuaCustomLog == nil then
		Mission.LuaCustomLog = {}
	end

	for idx,logname in pairs(Mission.LuaCustomLog) do
		if logname == lgfile then
			--Log("Logname ", logname)
			firstLog = false
		end
	end
	if firstLog then
		table.insert(Mission.LuaCustomLog,lgfile)
		log:write("----------------- NEW LOG ENTRY ----------------- \n")
	end
	--Log("FirstLog ", firstLog)
	--LogToFile(Mission.LuaCustomLog)

	if type(txt) == "table" then
		log:write(date,helper,"-TABLE LOGGING-","\n")
		for idx,val in pairs(txt) do
			if type(val) ~= "table" then
				log:write(date,helper,"KEY: ",idx," VALUE: ",tostring(val),"\n")
			else
				log:write(date,helper,"KEY: ",idx," VALUE IS A TABLE +-","\n")
				for idx2,val2 in pairs(val) do
					if type(val2) ~= "table" then
						log:write(date,helper,"\t|KEY: ",idx2," VALUE: ",tostring(val2),"\n")
					else
						log:write(date,helper,"\t|KEY: ",idx2," VALUE IS A TABLE +-","\n")
						for idx3,val3 in pairs(val2) do
							if type(val3) == "table" then
								log:write(date,helper,"\t\t|","KEY IS A TABLE. TO DEEP RECURSION","\n")
							else
								log:write(date,helper,"\t\t|KEY: ",idx3," VALUE: ",tostring(val3),"\n")
							end
						end
					end
				end
			end
		end
		log:write(date,helper,"-END OF TABLE LOGING-","\n")
	else
		txt = tostring(txt)
		log:write(date,helper,txt,"\n")
	end

	--Log("lgfile: ", lgfile)
	--Log("txt: ", txt)
	--Log("datetime ",date)

	-- closing file --
	log:close()
end

--[[AutoDoc
-- RELEASE_LOGOFF  usage: luaLog(text [,helper])
category: Debug
shortdesc: logfileba ir
-- RELEASE_LOGOFF  desc: luaDoCustomLog konnyebb, egyszerubb hivasa
txt: string vagy tabla (2 melysegig)
helper: bool, ha true hozzafuzi a '---HelperLog---' stringet
]]
function luaLog(text, helper)
-- RELEASE_LOGOFF  	Assert(Mission ~= nil and Mission.Name ~= nil and type(Mission.Name) == "string", "***ERROR: Mission must have .Name parameter!\n"..debug.traceback())
-- RELEASE_LOGOFF  	--Assert(text ~= nil, "***ERROR: luaLog needs an arg to work!\n"..debug.traceback())

	local mode

	if not Mission.LuaLogInit then
		Mission.LuaLogInit = true
		mode = "u"
	end

	if text == nil then
		text = "<NIL>"
	end

-- RELEASE_LOGOFF  	luaDoCustomLog(Mission.Name..".log", text, mode, helper)
end

--[[AutoDoc
-- RELEASE_LOGOFF  usage: luaLogTableNames(entTable [,str])
category: Debug
shortdesc: kilogolja egy entitytable elemeninek a nevet
desc: kilogolja a customlogban meghatarozott fileba egy entitytable elemeninek a nevet (unit.Name)
entTable: table, a logolando entitytabla
str: string, a log elejer hozzafuzendo string
]]
function luaLogTableNames(entTable, str)
-- RELEASE_LOGOFF  	luaHelperLog("luaLogTableNames called...")

-- RELEASE_LOGOFF  	Assert(type(entTable) == "table", "***ERROR: luaLogTableNames needs a table as param!"..debug.traceback())
	if str == nil then
		str = ""
	end

-- RELEASE_LOGOFF  	luaLog("Listing table "..tostring(str).."'s names:")
	for key, value in pairs(entTable) do
-- RELEASE_LOGOFF  		luaLog("\t- "..value.Name)
	end
end

--[[AutoDoc
-- RELEASE_LOGOFF  usage: luaHelperLog(text)
category: Debug
shortdesc: Mission-hoz kotodo helperlogolas engedelyezeset kezeli
desc: kilogolja 'txt' stringet, tablat a HelperLog.txt fileba
txt: mixed, a logolando string vagy tabla
]]
function luaHelperLog(text)
	if Mission == nil then
-- RELEASE_LOGOFF  	 	Log("luaHelperLog: Mission == nil")
	else
-- RELEASE_LOGOFF  		--Assert(Mission ~= nil, "***ERROR: luaHelperLog needs a Mission running!"..debug.traceback())
		if Mission.HelperLog then
-- RELEASE_LOGOFF  			luaLog(text, true)
		end
	end
end

--[[AutoDoc
-- RELEASE_LOGOFF  usage: luaLogElementNames(targettable [,str])
category: Debug
shortdesc: tabla ertekekent levo entitasok neveit logolja
desc: Adott tablaban levo entityk neveit logolja, str-kent tetszoleges megjegyzest adhatunk at
txt: mixed, a logolando string vagy tabla
str: string, tetszoleges string amit hozzafuz a logbejegyzeshez
]]
function luaLogElementNames(targettable, str)

	if str == nil then
		str = "Table"
	end

	if targettable == nil then
-- RELEASE_LOGOFF  		luaLog(str.." is nil")
		return
	end

	if next(targettable) == nil then
-- RELEASE_LOGOFF  		luaLog(str.." has no elements.")
		return
	end

-- RELEASE_LOGOFF  	Assert(type(targettable) == "table", "***ERROR: luaLogElementNames first param must be a table!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(targettable ~= nil, "***ERROR: luaLogElementNames first param must be a table!"..debug.traceback())
	for key, value in pairs(targettable) do
-- RELEASE_LOGOFF  --		Assert(value.Name ~= nil, "***ERROR: luaLogElementNames needs a table with value.Name as first param "..debug.traceback())
-- RELEASE_LOGOFF  		luaLog("Table "..str.."'s "..tostring(key).." element is "..value.Name)
	end
end

--[[
memoriafoglalas miatt kiveve
-- tabla ertekekent levo entitasok tipusait logolja
function luaLogElementTypes(targettable, str)
	if str == nil then
		str = " table "
	end
	if targettable == nil then
-- RELEASE_LOGOFF  		luaHelperLog(str.."is nil")
		return
	end

-- RELEASE_LOGOFF  	Assert(type(targettable) == "table", "***ERROR: luaLogElementTypes' first param must be a table!"..debug.traceback())

	for key, value in pairs(targettable) do
-- RELEASE_LOGOFF  		Log(" Table "..str, "'s ", key, " element's type is ", value.Type)
	end
end
]]

--[[AutoDoc
usage: luaIndent(level)
category: Debug
shortdesc: indentalashoz hasznalhato space-sorozatot ad vissza
desc:
]]
function luaIndent(level)
	s = ""
	for i = 1, level, 1 do
		s = s .. "    "
	end
	return s
end

--[[AutoDoc
usage: luaDumpTable_Tech(table, levels, labelVector, actLevel)
category: Debug
shortdesc:
desc: a tablat (table) a megadott szintig (levels) a megadott label-ekkel (labelVector) kidumpolja a megadott szinttol (actLevel)
]]
function luaDumpTable_Tech(table, levels, labelVector, actLevel)
	if actLevel > levels then
		return
	end
	for key, value in pairs(table) do
-- RELEASE_LOGOFF  		Log(luaIndent(actLevel), labelVector[actLevel], ": ", key)
		luaDumpTable_Tech(value, levels, labelVector, actLevel + 1)
	end
end

--[[AutoDoc
usage: luaDumpTable(table, levels, labelVector, comment)
category: Debug
shortdesc:
desc: a tablat (table) a megadott szintig (levels) a megadott label-ekkel (labelVector) kidumpolja a megadott kommenttel (comment)
]]
function luaDumpTable(table, levels, labelVector, comment)
-- RELEASE_LOGOFF  	Log(comment)
	luaDumpTable_Tech(table, levels, labelVector, 1)
end

--[[AutoDoc
usage: luaDumpRecon()
category: Debug
shortdesc: recon dump
desc: a recon tablat kidumpolja az id-k szintjeig
]]
function luaDumpRecon()
	luaDumpTable(recon, 4, {"party", "relation", "type", "id"}, "Recon table:")
end

--[[
---------------------------------------------------------------------------------
-- globalis AttackerTable kezelese
---------------------------------------------------------------------------------

-- attacker tablaba beillesztes
-- kaphat entityt, target-formatumot
-- 'target' az az objektum, akit tamadnak, 'attacker' az, aki tamad
function luaSetAttacker(target, attacker)
-- RELEASE_LOGOFF  	Assert(target.ID ~= nil, "***ERROR: luaSetAttacker's first param (target) must be a table with ID index!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(attacker.ID ~= nil, "***ERROR: luaSetAttacker's second param (attacker) must be a table with ID index!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("luaSetAttacker"..attacker.Name.." "..target.Name);

-- RELEASE_LOGOFF  --	luaHelperLog("luaSetAttacker has been called. TARGET: "..thisTable[target.ID].Name..", ATTACKER: "..thisTable[attacker.ID].Name)

	if AttackerTable[target.ID] == nil then
		AttackerTable[target.ID] = {}
	end

-- RELEASE_LOGOFF  	luaHelperLog("Attacker ID: "..attacker.ID)
	--table.insert(AttackerTable[target.ID], attacker.ID, thisTable[attacker.ID])
	AttackerTable[target.ID][attacker.ID] = thisTable[attacker.ID]
-- RELEASE_LOGOFF  --	LogToFile("1", AttackerTable[target.ID])
-- RELEASE_LOGOFF  --	luaHelperLog("2"..AttackerTable[target.ID][attacker.ID])
-- RELEASE_LOGOFF  --	luaHelperLog("3"..AttackerTable[target.ID][attacker.ID].Name)
	--luaHelperLog("Adding...")
	--luaLogGlobalAttackerTable()
end

-- kiveszi attackert a tablabol mindenhonnan
-- ha target nem nil, akkor csak a targettol veszi el
function luaClearAttacker(attacker, target)
-- RELEASE_LOGOFF  	Assert(attacker.ID ~= nil, "***ERROR: luaClearAttacker's first param (attacker) must be a table with ID index!"..debug.traceback())
	if target ~= nil then
		--LogToFile("Wrong value: ", target)
-- RELEASE_LOGOFF  		Assert(target.ID ~= nil, "***ERROR: luaClearAttacker's second param (target) must be nil or a table with ID index!"..debug.traceback())
	end

	if target ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("luaClearAttacker "..attacker.Name..","..target.Name);
		--luaHelperLog("luaClearAttacker has been called. ATTACKER: "..thisTable[attacker.ID].Name..", TARGET: "..thisTable[target.ID].Name)
	else
-- RELEASE_LOGOFF  		luaHelperLog("luaClearAttacker "..attacker.Name..",nil");
		--luaHelperLog("luaClearAttacker has been called. ATTACKER: "..thisTable[attacker.ID].Name..", TARGET is nil")
	end

	local removables = {}
	for targetID, attackers in pairs(AttackerTable) do
		for attackerID, attackerEnt in pairs(attackers) do
			if target == nil then
				if attackerID == attacker.ID then
-- RELEASE_LOGOFF  					luaHelperLog("Found removable element step 1: "..thisTable[attacker.ID].Name)
					--table.remove(AttackerTable[targetID], attackerID)
					AttackerTable[targetID][attackerID] = nil
				end
			else
				if attackerID == attacker.ID and targetID == target.ID then
-- RELEASE_LOGOFF  					luaHelperLog("Found removable element step 2: "..thisTable[attacker.ID].Name)
					--table.remove(AttackerTable[targetID], attackerID)
					AttackerTable[targetID][attackerID] = nil
				end
			end
		end

		if next(AttackerTable[targetID]) == nil then
			table.insert(removables, targetID)
		end
	end
-- RELEASE_LOGOFF  	LogToFile("Attacker table removables: ", removables)
	luaRemoveElements(AttackerTable, removables) -- ha nincs eleme, targetID-t kivenni a globalisbol
	--luaHelperLog("Removing...")
	--luaLogGlobalAttackerTable()
end

-- targetet tamado entityket adja vissza
-- kaphat entityt, target-formatumot
-- attackertype "ship", vagy "plane" lehet. Ha nil, akkor mindenkit visszaad. Ha az elozo ket ertek valamelyike, akkor csak azokat a tipusokat
-- ha distance nem nil, akkor csak azokat adja vissza, akik a tavolsagon belul vannak
function luaGetAttackers(target, attackertype, distance)
-- RELEASE_LOGOFF  	Assert(target.ID ~= nil, "***ERROR: luaGetAttackers' first param (target) must be a table with ID index!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(attackertype == "ship" or attackertype == "plane" or attackertype == nil, "***ERROR: luaGetAttackers' second param (attackertype) must be 'ship', 'plane', or nil! "..tostring(attackertype)..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(distance) == "number" or type(distance) == "nil", "***ERROR: luaGetAttackers' third param (distance) must be a number or nil!"..debug.traceback())

-- RELEASE_LOGOFF  --	luaHelperLog("luaGetAttackers' parameters: \t  target: "..target.Name.."\t  attackertype: "..attackertype.."\t  distance: "..distance)

	--luaRemoveDeadsFromTable(AttackerTable, "  **  Attacker table deads  **  ") -- befejezni, vagy kidobni...

	local attackers = {}
	if AttackerTable[target.ID] ~= nil then
		for attackerID, attackerEnt in pairs(AttackerTable[target.ID]) do
			--luaHelperLog("attacker entity: ")
			--luaHelperLog(attackerEnt)
			if not attackerEnt.Dead and attackertype == nil then
-- RELEASE_LOGOFF  --				luaHelperLog("entering non-type step")
				if distance == nil then
-- RELEASE_LOGOFF  --					luaHelperLog("inserted "..attackerEnt.Name)
					table.insert(attackers, attackerEnt)
				else
-- RELEASE_LOGOFF  --					luaHelperLog("measuring distance")
					if luaGetDistance(target, attackerEnt) < distance then
-- RELEASE_LOGOFF  --						luaHelperLog("inserted "..attackerEnt.Name)
						table.insert(attackers, attackerEnt)
					else
-- RELEASE_LOGOFF  --						luaHelperLog("distance was given, but the attacker is too far: "..luaGetDistance(target, attackerEnt))
					end
				end
			elseif not attackerEnt.Dead and attackertype == "ship" then
-- RELEASE_LOGOFF  --				luaHelperLog("entering ship-checking step")
				if attackerEnt.Class.Type == "MotherShip" or attackerEnt.Class.Type == "battleship" or attackerEnt.Class.Type == "cruiser" or attackerEnt.Class.Type == "destroyer" or attackerEnt.Class.Type == "TBoat" then
-- RELEASE_LOGOFF  --					luaHelperLog("attacker is ship: "..attackerEnt.Name)
					if distance == nil then
-- RELEASE_LOGOFF  --						luaHelperLog("inserted "..attackerEnt.Name)
						table.insert(attackers, attackerEnt)
					else
-- RELEASE_LOGOFF  --						luaHelperLog("measuring distance")
						if luaGetDistance(target, attackerEnt) < distance then
-- RELEASE_LOGOFF  --							luaHelperLog("inserted "..attackerEnt.Name)
							table.insert(attackers, attackerEnt)
						else
-- RELEASE_LOGOFF  --							luaHelperLog("distance was given, but the attacker is too far: "..luaGetDistance(target, attackerEnt))
						end
					end
				else
-- RELEASE_LOGOFF  --					luaHelperLog("attacker is not a ship, its type: "..thisTable[attackerID].Class.Type)
				end
			elseif not attackerEnt.Dead and attackertype == "plane" then
-- RELEASE_LOGOFF  --				luaHelperLog("entering plane-checking step")
				if attackerEnt.Class.Type == "DiveBomber" or attackerEnt.Class.Type == "TorpedoBomber" or attackerEnt.Class.Type == "LevelBomber" or attackerEnt.Class.Type == "Fighter" or attackerEnt.Class.Type == "Reconplane" then
-- RELEASE_LOGOFF  --					luaHelperLog("attacker is plane: "..attackerEnt.Name)
					if distance == nil then
-- RELEASE_LOGOFF  --						luaHelperLog("inserted "..attackerEnt.Name)
						table.insert(attackers, attackerEnt)
					else
-- RELEASE_LOGOFF  --						luaHelperLog("measuring distance")
						if luaGetDistance(target, attackerEnt) < distance then
-- RELEASE_LOGOFF  --							luaHelperLog("inserted "..attackerEnt.Name)
							table.insert(attackers, attackerEnt)
						else
-- RELEASE_LOGOFF  --							luaHelperLog("distance was given, but the attacker is too far: "..luaGetDistance(target, attackerEnt))
						end
					end
				else
-- RELEASE_LOGOFF  --					luaHelperLog("attacker is not a plane, its type: "..attackerEnt.Class.Type)
				end
			end
		end
	else
		return nil	-- there's no attacker
	end

	luaRemoveDeadsFromTable(attackers, " dead attackers")	-- itt mar csak nincs...

	return attackers
end

-- az osszes tamado szamat adja vissza
function luaGetAttackersNumber(target, attackertype, distance)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaGetAttackersNumber's first param is nil instead of a table!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(target.ID ~= nil, "***ERROR: luaGetAttackersNumber's param must be a table with ID index!"..debug.traceback())
	local attackers = luaGetAttackers(target, attackertype, distance)
	if attackers ~= nil then
		return table.getn(attackers)
	else
		return 0
	end
end

function luaGetTarget(attacker)
-- RELEASE_LOGOFF  	Assert(attacker ~= nil, "***ERROR: luaGetTarget got -nil- instead of a table!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(attacker.ID ~= nil, "***ERROR: luaGetTarget needs a table with ID!"..debug.traceback())
	local targets = {}

	for targetID, attackers in pairs(AttackerTable) do
		for attackerID, attackerEnt in pairs(attackers) do
			if attackerID == attacker.ID then
-- RELEASE_LOGOFF  				luaHelperLog("Found target for "..thisTable[attacker.ID].Name.." : "..thisTable[targetID].Name)
				if thisTable[targetID].Dead then
-- RELEASE_LOGOFF  					luaHelperLog(" But its dead...")
				else
					table.insert(targets, thisTable[targetID])
				end
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("All targets of "..thisTable[attacker.ID].Name.." are :")
-- RELEASE_LOGOFF  	luaLogElementNames(targets, " Targets")
	if next(targets) ~= nil then
		return luaSortByDistance(attacker, targets, 1)
	else
		return nil
	end
end
]]
---------------------------------------------------------------------------------
-- missionkezeles
---------------------------------------------------------------------------------
--[[
function luaCheckDamageRetreatConditions(party, limit)
	local retreaters = {}
	for typeidx, unittype in pairs(recon[party].own) do
		if typeidx ~= "fighter" and typeidx ~= "divebomber" and typeidx ~= "torpedobomber" and typeidx ~= "levelbomber" and typeidx ~= "reconplane" then
			for ID, unitEnt in pairs(unittype) do
				if not unitEnt.Retreat then
					local firepowerTable = GetFirepower(unitEnt)
					if (typeidx == "torpedoboat" or typeidx == "destroyer" or typeidx == "cruiser" or typeidx == "battleship") and firepowerTable.ArtilleryFirePowerRatio < limit and firepowerTable.AAFirePowerRatio < limit and firepowerTable.TorpedoFirePowerRatio < limit and firepowerTable.DepthChargeFirePowerRatio < limit or firepowerTable.Maneuverability < limit then
						--MissionNarrative(unitEnt.Name.." reached retreating conditions.Limit was "..tostring(limit)..", ArtilleryFirePowerRatio: "..tostring(firepowerTable.ArtilleryFirePowerRatio)..", AAFirePowerRatio: "..tostring(firepowerTable.AAFirePowerRatio)..", TorpedoFirePowerRatio: "..tostring(firepowerTable.TorpedoFirePowerRatio)..", DepthChargeFirePowerRatio: "..tostring(firepowerTable.DepthChargeFirePowerRatio)..", Maneuverability: "..tostring(firepowerTable.Maneuverability))
						MissionNarrative(unitEnt.Name.." reached retreating conditions. Limit was "..tostring(limit))
						unitEnt.Retreat = true
						table.insert(retreaters, unitEnt)
					elseif typeidx == "mothership" and table.getn(unitEnt.planes) == 0 then
						MissionNarrative("Carrier "..unitEnt.Name.." is out of planes")
						unitEnt.Retreat = true
						table.insert(retreaters, unitEnt)
					end
				end
			end
		end
	end

	if next(retreaters) ~= nil then
		return retreaters
	else
		return nil
	end
end

function luaGetRetreatersAround(target, radius, allegiance, index, all, searchedtype)
	local ships = luaGetShipsAround(target, radius, allegiance, index, all, searchedtype)
	local retreaters = {}
	for idx, unitEnt in pairs(ships) do
-- RELEASE_LOGOFF  		luaHelperLog("Checking "..unitEnt.Name)
		if unitEnt.Retreat then
-- RELEASE_LOGOFF  			luaHelperLog("  The ship is retreating")
			table.insert(retreaters, unitEnt)
		end
	end
	return retreaters
end

function luaShipRetreat(unitEnt, evacSide, escortUnits)
	local retreaters = luaGetRetreatersAround(unitEnt, 5000, "own", 1)
-- RELEASE_LOGOFF  	luaLogElementNames(retreaters, "Retreaters around "..unitEnt.Name)
	if retreaters == nil then
-- RELEASE_LOGOFF  		luaHelperLog("No retreaters found around, moving towards evacuation side: "..evacSide)
		GroupOrder(unitEnt, "Moveto", evacSide)
	else
-- RELEASE_LOGOFF  		luaHelperLog("There are retreaters around, joining in.")
		GroupOrder(unitEnt, "FixFollow", luaSortByDistance(unitEnt, retreaters, 1))
	end
	if escortUnits ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Adding escorts to retreater")
-- RELEASE_LOGOFF  		luaLogElementNames(escortUnits, "Escort")
		local escortnum = 1
		for idx, escortEnt in pairs(escortUnits) do
			if escortnum == 1 then
				local trg = {}
				GroupOrder(escortEnt, "Leave", trg)
				GroupOrder(escortEnt, "FixFollow", unitEnt)
			elseif escortnum > 1 then
				local trg = {}
				GroupOrder(escortEnt, "Leave", trg)
				GroupOrder(escortEnt, "FreeFollow", unitEnt)
			end
		end
	end
end
]]
--[[AutoDoc
usage: activeSquads, squadEntTable = luaGetSlotsAndSquads(airbaseEnt)
category: Mission
shortdesc: visszaadja egy AirBase enytity aktiv squadjait es entitasait
desc: Adott AirBase entity aktiv, levegoben levo squadronok szamat es this tablait adja vissza, ha nincs ilyen a visszateresi ertek nil
airbaseEnt:table,  a vizsgalando airbase (airfield, carrier)
activeSquads: number, mennyi squadron aktiv az adott airbase-en
squadEntTable: table, az aktiv squadronok entity tablaja
]]
function luaGetSlotsAndSquads(airbaseEnt)
	if airbaseEnt.ID == nil or airbaseEnt.Dead then
-- RELEASE_LOGOFF  		luaHelperLog("luaGetSlotsAndSquads first param is not a valid entity")
		return
	end

	local activeSquads = 0
	local planeEntTable = {}

	airbaseEnt.slots = GetProperty(airbaseEnt, "slots")
	for idx, slot in pairs(airbaseEnt.slots) do
		if slot.squadron ~= nil then
			activeSquads = activeSquads + 1
			local planeEnt = thisTable[tostring(slot.squadron)]
			table.insert(planeEntTable, planeEnt)
		end
	end

	if activeSquads == 0 then
		return 0, nil
	else
		return activeSquads, planeEntTable
	end
end

--[[AutoDoc
usage: rnd = luaRnd([min,] [max])
category: Math
shortdesc: randomszam generator
desc: veletlenszeruen general egy szamot, min es max kozott
min: number, a szam minimumerteke
max: number, a szam maximumerteke
rnd: number, a generalt szam
]]
function luaRnd(min, max)
	--Assert(type(min) == "number" and type(max) == "number", "***ERROR: luaRnd needs two integer to work!"..debug.traceback())
	--luaHelperLog("luaRnd called with min value: "..min.." and max value: "..max)

--[[
	local seeddate = os.date("*t")
	local seed = ""
	for key, value in pairs(seeddate) do
		if key ~= "isdst" then
			seed = seed..tostring(value)
		else
			break
		end
	end
]]

--[[
	--local seedb = tonumber(seed)*os.clock()
	if seedb == nil then	-- warning : global seed!
		seedb = os.clock()*1000
		math.randomseed(seedb)
		for i = 1, 10 do
			random(0,1)
		end
		--luaDoCustomLog("random.log", " Value for seeding: "..seedb)
	end
]]

	--local rnd = random(min, max)

	local rnd

	if min == nil then		-- nincs argumentum
		rnd = random()
	elseif min ~= nil and max == nil then	-- egy param
		rnd = random(min)
	elseif min ~= nil and max ~= nil then	-- ket param
-- RELEASE_LOGOFF  		Assert(type(min) == "number" and type(max) == "number", "***ERROR: luaRnd needs two integers to work!"..debug.traceback())
		--luaHelperLog("min: "..tostring(min)..", max: "..tostring(max))
		--luaLog("Random Min value: "..min..", Max value: "..max)
		--luaLog("Called from: "..debug.traceback())
		if min == max then
			rnd = min
		else
			rnd = random(min, max)
		end
	end

	--luaHelperLog("Final result: "..rnd)
	--luaDoCustomLog("random.log", " Final value "..rnd)

	return rnd
end

--[[AutoDoc
usage: round = luaRound(number)
category: Math
shortdesc: egeszszamra kerekit
desc: Egy adott szamot kerekit, 0.5 es folotte fel, egyebkent lefele kerekit
number: number, a kerekitendo szam
round: number, a kerekitett ertek
]]
function luaRound(number)
-- RELEASE_LOGOFF  	Assert( type(number) == "number", "***ERROR: luaRound needs a number as param!"..debug.traceback())
	if number < (math.floor(number) + 0.5) then
		number = math.floor(number)
	else
		number = math.ceil(number)
	end
	return number
end

--[[AutoDoc
usage: coord = luaMoveCoordinate(coordinate, distance, angle)
category: Math
shortdesc: egy kordinatat elmozgat a megadott parameterek alapjan
desc: Elmozgataja a 'coordinate' vektort 'distance' tavolsagra, 'angle' fokkal
coordinate: table, koordinata tabla, az elmozgatando koordinata
distance: number, az elmozgatas merteke, meterben
angle: number, az elmozgatas irany, fokban
coord: table, az elmozgatott vektor koordinatai
]]
function luaMoveCoordinate(coordinate, distance, angle)
-- RELEASE_LOGOFF  	Assert(coordinate ~= nil and luaIsCoordinate(coordinate), "***ERROR: luaMoveCoordinate needs a coordinate as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(distance) == "number", "***ERROR: luaMoveCoordinate needs a number as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(angle) == "number", "***ERROR: luaMoveCoordinate needs a number as third param!"..debug.traceback())

	if angle < 0 then
		angle = math.mod(angle, 360) + 360
	else
		angle = math.mod(angle, 360)
	end
-- RELEASE_LOGOFF  	luaHelperLog("luaMoveCoordinate angle: "..angle)

-- RELEASE_LOGOFF  	luaHelperLog("luaMoveCoordinate original coordinate:")
-- RELEASE_LOGOFF  	luaHelperLog(coordinate)

	local finalCoordinate =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 0
	}

	finalCoordinate.x = luaRound(coordinate.x + distance * math.sin(math.rad(angle)))
	finalCoordinate.y = coordinate.y
	finalCoordinate.z = luaRound(coordinate.z + distance * math.cos(math.rad(angle)))

-- RELEASE_LOGOFF  	luaHelperLog("luaMoveCoordinate final coordinate:")
-- RELEASE_LOGOFF  	luaHelperLog(finalCoordinate)

	return finalCoordinate
end

--[[AutoDoc
usage: numberTable = luaIsNumberTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei 'number' tipusuak e
desc: Egy adott tabla value-it vizsgalva megmondja h azok 'number' tipusuak e, allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
numberTable: bool, true ha a tabla elemei 'number' tipusuak e, illetve false ha nem vagy a target nem tabla
]]
function luaIsNumberTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsNumberTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsNumberTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if not (type(value) == "number") then
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: stringrTable = luaIsStringTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei 'string' tipusuak e
desc: Egy adott tabla value-it vizsgalva megmondja h azok 'string' tipusuak e, allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
stringTable: bool, true ha a tabla elemei 'string' tipusuak e, illetve false ha nem vagy a target nem tabla
]]
function luaIsStringTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsStringTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsStringTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if not (type(value) == "string") then
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: entTable = luaIsIsEntityTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei entityk e
desc: Egy adott tabla value-it vizsgalva megmondja h azok entityk e, allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
entTable: bool, true ha a tabla elemei entityk, illetve false ha nem vagy a target nem tabla
]]
function luaIsEntityTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsEntityTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsEntityTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if type(value) == "table" then
				if value.ID == nil then
					return false
				end
			else
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: returnTable = luaIsEntityOrCoordinateTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei entityk vagy koordinatak e
desc: Egy adott tabla value-it vizsgalva megmondja h azok entityk vagy koordinatak, allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
entTable: bool, true ha a tabla elemei entityk vagy koordinatak, illetve false ha nem vagy a target nem tabla
]]
function luaIsEntityOrCoordinateTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsEntityOrCoordinateTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsEntityOrCoordinateTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if not (luaIsEntityTable({value}, false) or luaIsCoordinate(value)) then
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: returnTable = luaIsPlaneTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei repulok e
desc: Egy adott tabla value-it vizsgalva megmondja h azok plane entityk (luaGetType alapjan), allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
returnTable: bool, true ha a tabla elemei plane entityk, illetve false ha nem vagy a target nem tabla
]]
function luaIsPlaneTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsPlaneTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsPlaneTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if value.ID ~= nil then
				if not luaGetType(value) == "plane" then
					return false
				end
			else
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: returnTable = luaIsShipTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei hajok e
desc: Egy adott tabla value-it vizsgalva megmondja h azok ship entityk (luaGetType alapjan), allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
returnTable: bool, true ha a tabla elemei ship entityk, illetve false ha nem vagy a target nem tabla
]]
function luaIsShipTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsShipTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsShipTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if value.ID ~= nil then
				if not luaGetType(value) == "ship" then
					return false
				end
			else
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: returnTable = luaIsAirfieldTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei AirBase tipusuak e
desc: Egy adott tabla value-it vizsgalva megmondja h azok airbase entityk (luaGetType alapjan, aifield es carrier), allowEmptyTable eseten ures tablara is true-val ter vissza
target: table a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
returnTable: bool, true ha a tabla elemei airbase entityk, illetve false ha nem vagy a target nem tabla
]]
function luaIsAirfieldTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsAirfieldTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsAirfieldTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if value.ID ~= nil then
				if not (value.Class.Type == "AirField" or value.Class.Type == "MotherShip") then
					return false
				end
			else
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: returnTable = luaIsAirPatrolTable(target [,allowEmptyTable])
category: Mission
shortdesc: megmondja h egy tabla elemei patrol tipusuak e
desc: Egy adott tabla value-it vizsgalva megmondja h azok airbase entityk (luaGetType alapjan, FighterPlane, BomberPlane), allowEmptyTable eseten ures tablara is true-val ter vissza
target: table, a vizsgalando tabla
allowEmptyTable: bool, vizsgaljunk e ures tablat
returnTable: bool, true ha a tabla elemei patrol entity, illetve false ha nem vagy a target nem tabla
]]
function luaIsAirPatrolTable(target, allowEmptyTable)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsAirPatrolTable needs a target!"..debug.traceback())
	if allowEmptyTable then
-- RELEASE_LOGOFF  		Assert(type(allowEmptyTable) == "boolean", "***ERROR: luaIsAirPatrolTable needs a boolean as second param!"..debug.traceback())
	end
	local emptyTable = true
	if type(target) == "table" then
		for key, value in pairs (target) do
			if type(value) == "table" then
				for patrolKey, patrolValue in pairs (value) do
					if patrolKey == "FighterPlane" then
						if not luaIsEntityTable({patrolValue}) then
							return false
						end
					elseif patrolKey == "BomberPlane" then
						if not luaIsEntityTable({patrolValue}) then
							return false
						end
					elseif patrolKey == "UpToDate" then
						if not type(patrolValue) == "boolean" then
							return false
						end
					else
						return false
					end
				end
			else
				return false
			end
			emptyTable = false
		end
		if emptyTable and not allowEmptyTable then
			return false
		end
	else
		return false
	end
	return true
end

--[[AutoDoc
usage: returnEnt = luaGetScriptTarget(entity)
category: Unit
shortdesc: visszaadja egy unit celpontjat, amelyet a MissionScript valasztott neki
desc: A vizsgalt entity luaSetScriptTarget altal megadott celpontja adja vissza, nil-t ha nincsen ilyen neki (entity.ScriptTarget)
entity: table, a vizsgalt entitas
returnEnt: mixed, az entity.ScriptTarget-ben beallitott entitas, illetve nil ha nincsen ilyen
]]
function luaGetScriptTarget(entity)
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({entity}), "***ERROR: luaGetScriptTarget needs an entity as param!"..debug.traceback())
	if UnitGetAttackTarget(entity) == entity.ScriptTarget and entity.ScriptTarget ~= nil then
		return entity.ScriptTarget
	end
	return nil
end

--[[AutoDoc
usage: luaSetScriptTarget(entity, target [,attackType])
category: Unit
shortdesc: beallit egy celpontot az entitynek
desc: A vizsgalt entity entity.ScriptTarget property-jet allitja be es megkezdi a tamadast, attacktype-pall szabalyozhatjuk, hogy milyen tamadast hajtson vegre az adott egyseg
entity: table, a vizsgalt entitas
target: table, a 'entity'ben meghatarozott unit celpontja
attackType: mixed, ATTACKTYPE_ANY, ATTACKTYPE_GUN_ONLY, ATTACKTYPE_BOMB_OR_TORPEDO, nil erteket veheti fel
]]
function luaSetScriptTarget(entity, target, attackType)
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({entity}), "***ERROR: luaSetScriptTarget needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({target}, true), "***ERROR: luaSetScriptTarget needs an entity or nil as second param!"..debug.traceback())
	if attackType then
-- RELEASE_LOGOFF  		Assert(target ~= nil, "***ERROR: luaSetScriptTarget's attackType should be nil if the second parameter is nil!"..debug.traceback())
-- RELEASE_LOGOFF  		Assert(luaIsPlaneTable({entity}), "***ERROR: luaSetScriptTarget's third parameter should be declared only for planes!"..debug.traceback())
-- RELEASE_LOGOFF  		Assert(attackType == "ATTACKTYPE_ANY" or attackType == "ATTACKTYPE_GUN_ONLY" or attackType == "ATTACKTYPE_BOMB_OR_TORPEDO", "***ERROR: luaSetScriptTarget third param shoud be ATTACKTYPE_ANY, ATTACKTYPE_GUN_ONLY or ATTACKTYPE_BOMB_OR_TORPEDO!"..debug.traceback())
	end

	if luaGetType(entity) == "ship" or luaGetType(entity) == "sub" then
		SetFireTarget(entity, target)
		entity.ScriptTarget = target
	elseif luaGetType(entity) == "plane" then
		if attackType then
			PilotSetTarget(entity, target, attacktype)
			entity.ScriptTarget = target
		else
			if target ~= nil then
				PilotSetTarget(entity, target)
			end
			entity.ScriptTarget = target
		end
	end
end

--[[AutoDoc
usage: idleTable = luaIdleUnitFilter(unitTable [,filterType])
category: Mission
shortdesc:
desc:
]]
function luaIdleUnitFilter(unitTable, filterType)
-- RELEASE_LOGOFF  	Assert(unitTable ~= nil and luaIsEntityTable(unitTable, true), "***ERROR: luaIdleUnitFilter needs a table which consists of entities as first param!"..debug.traceback())
	if filterType then
-- RELEASE_LOGOFF  		Assert(type(filterType) == "string" and (filterType == "script" or filterType == "code"), "***ERROR: luaIdleUnitFilter's filterType parameter should be \"script\" or \"code\"!"..debug.traceback())
	end

	if not filterType then
		filterType = "script"
	end

	local idleTable = {}

	if filterType == "script" then
		for index, unit in pairs (unitTable) do
			if not luaGetScriptTarget(unit) then
				table.insert(idleTable, unit)
			end
		end
		return idleTable
	elseif filterType == "code" then
		for index, unit in pairs (unitTable) do
			if not UnitGetAttackTarget(unit) then
				table.insert(idleTable, unit)
			end
		end
		return idleTable
	end
end

--[[AutoDoc
usage: angle = luaGetAngle(a, b, c)
category: Math
shortdesc:
desc:
]]
--2D-s szog
function luaGetAngle(a, b, c)
-- RELEASE_LOGOFF  	Assert(a ~= nil and (luaIsCoordinate(a) or a == "world" ), "***ERROR: luaGetAngle needs a coordinate or \"world\" as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(b ~= nil and luaIsCoordinate(b), "***ERROR: luaGetAngle needs a coordinate as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(c ~= nil and luaIsCoordinate(c), "***ERROR: luaGetAngle needs a coordinate as third param!"..debug.traceback())

	if a ~= "world" then
		if a.z == b.z and a.x == b.x then
			return 0
		elseif a.z == c.z and a.x == c.x then
			return 0
		end
	end
	if b.z == c.z and b.x == c.x then
		return 0
	end

	local n = luaMoveCoordinate(b, 100, 0)
	local angle_nba = 0
	local angle_nbc
	local angle
	local nb = luaGetDistance(n, b)
	local bc = luaGetDistance(b, c)
	local cn = luaGetDistance(c, n)

	if c.x < n.x then
		angle_nbc = 360 - math.deg(luaACOS((math.pow(nb, 2) + math.pow(bc, 2) - math.pow(cn, 2)) / ( 2 * nb * bc)))
	else
		angle_nbc = math.deg(luaACOS((math.pow(nb, 2) + math.pow(bc, 2) - math.pow(cn, 2)) / ( 2 * nb * bc)))
	end

	if a ~= "world" then
		local ba = luaGetDistance(b, a)
		local an = luaGetDistance(a, n)
		if a.x < n.x then
			angle_nba = 360 - math.deg(luaACOS((math.pow(nb, 2) + math.pow(ba, 2) - math.pow(an, 2)) / ( 2 * nb * ba)))
		else
			angle_nba = math.deg(luaACOS((math.pow(nb, 2) + math.pow(ba, 2) - math.pow(an, 2)) / ( 2 * nb * ba)))
		end
	end

	angle = angle_nbc - angle_nba
	if angle < 0 then
		angle = angle + 360
	end
	angle = luaRound(angle)
	return angle
end

--[[AutoDoc
usage: acos = luaACOS(number)
category: Math
shortdesc:
desc:
]]
function luaACOS(number)
	return math.acos(math.min(math.max(number, -1), 1))
end

--[[AutoDoc
usage: inArea = luaIsInArea(area, pos)
category: Math
shortdesc: ellenorzi, hogy egy adott pos egy teglalap alapu teruleten belul van-e.
desc: Megnezi hogy az 'area' tablaban szereplo 2 koordinata alapjan meghatarozott teglalapon (atlos sarkainak koordinataja) belul helyezkedik e a 'pos' koordinata, Figyelem: 2D only!
area: table, elso ket eleme egy-egy vektor melyek egy teglalap atlos csucsanak koordinataja
pos: table, a vizsgalt koordinata
inArea: bool, true, ha a megadott 'pos' a kerdeses teruleten belul van e, illetve false, ha nem
]]
function luaIsInArea(area, pos)
-- RELEASE_LOGOFF  	Assert(area ~= nil, "***ERROR: luaIsInArea needs {coordinate1, coordinate2} table as first parameter!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(pos ~= nil and luaIsCoordinate(pos), "***ERROR: luaIsInArea needs a coordinate as second parameter!"..debug.traceback())
	local minX, minZ, maxX, maxZ
	for i, coordinate in pairs (area) do
-- RELEASE_LOGOFF  		Assert(coordinate ~= nil and luaIsCoordinate(coordinate), "***ERROR: luaIsInArea needs {coordinate1, coordinate2} table as first parameter!"..debug.traceback())
		if i == 1 then
			minX = coordinate.x
			minZ = coordinate.z
			maxX = coordinate.x
			maxZ = coordinate.z
		elseif i == 2 then
			if coordinate.x < minX then
				minX = coordinate.x
			else
				maxX = coordinate.x
			end
			if coordinate.z < minZ then
				minZ = coordinate.z
			else
				maxZ = coordinate.z
			end
		else
-- RELEASE_LOGOFF  			Assert(false, "***ERROR: luaIsInArea needs {coordinate1, coordinate2} table as first parameter!"..debug.traceback())
		end
	end

	if minX < pos.x and pos.x < maxX and minZ < pos.z and pos.z < maxZ then
		return true
	else
		return false
	end
end

--[[
luaMoveOnBorder egy a borderen levo poziciot eltol distance tavolsaggal.
A megadando parameter a GetBorderCross fv segitsegevel kaphato meg.
2 koordinatat ad vissza, az elso az oramutato jarasanak megfelelo iranyba eltolt,
a masodik az ellenkezo iranyba tolt koordinata. A distance nem lehet nagyobb mint a felkerulet!
]]
--[[
memoriafoglalas miatt kiveve
function luaMoveOnBorder(originalPos, distance)
-- RELEASE_LOGOFF  	Assert(originalPos ~= nil and luaIsCoordinate(originalPos), "***ERROR: luaMoveOnBorder needs a coordinate on the border as first parameter!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(distance ~= nil and type(distance) == "number" and distance > 0, "***ERROR: luaMoveOnBorder needs a positive number as second parameter!"..debug.traceback())

	local exitZone1, exitZone2
	exitZone1, exitZone2 = GetBorderZone()
	local exitZone = {}
		table.insert(exitZone, exitZone1)
		table.insert(exitZone, exitZone2)
	local height = math.abs(exitZone[2].z - exitZone[1].z)
	local width = math.abs(exitZone[2].x - exitZone[1].x)

	if distance > (height + width) then
		return nil, nil
	end

	local a = 0
	local b = 0
-- RELEASE_LOGOFF  	luaHelperLog("luaMoveOnBorder: originalPos")
-- RELEASE_LOGOFF  	luaHelperLog(originalPos)
-- RELEASE_LOGOFF  	luaHelperLog("luaMoveOnBorder: exitZone")
-- RELEASE_LOGOFF  	luaHelperLog(exitZone)
	if luaRound(exitZone[1].x) == luaRound(originalPos.x) then
		--W
		a = 0
		b = 0
	elseif luaRound(exitZone[1].z) == luaRound(originalPos.z) then
		--N
		a = 1
		b = 0
	elseif luaRound(exitZone[2].x) == luaRound(originalPos.x) then
		--E
		a = 1
		b = 1
	elseif luaRound(exitZone[2].z) == luaRound(originalPos.z) then
		--S
		a = 0
		b = 1
	else
-- RELEASE_LOGOFF  		Assert(false, "***ERROR: luaMoveOnBorder needs a coordinate on the border as first parameter!"..debug.traceback())
	end
	local alignment = math.abs(a - b)

	local movedPos = {}
	for i = 0, 1 do
		if luaRound(alignment) == 0 then
			local distanceC1 = math.abs(originalPos.z - exitZone[luaRound(math.pow(2, math.abs(b-i)))].z)
			local distanceC2 = distanceC1 + width
			if distance > distanceC1 then
				if distance > distanceC2 then
					--kiszamolja az uj helyet, ami a nem szomszedos oldalon van
					local tempPos = { ["x"] = 0, ["y"] = 0, ["z"] = 0 }
					tempPos.x = exitZone[luaRound(math.pow(2, (1-b)))].x
					tempPos.z = exitZone[luaRound(math.pow(2, math.abs(b-i)))].z + math.pow(-1, math.abs(1-b-i)) * (distance - distanceC2)
					tempPos.y = originalPos.y
					table.insert(movedPos, tempPos)
				else
					--kiszamolja az uj helyet, ami a szomszedos oldalon van
					local tempPos = { ["x"] = 0, ["y"] = 0, ["z"] = 0 }
					tempPos.x = exitZone[luaRound(math.pow(2, math.abs(b)))].x + math.pow(-1, a) * (distance - distanceC1)
					tempPos.z = exitZone[luaRound(math.pow(2, math.abs(b-i)))].z
					tempPos.y = originalPos.y
					table.insert(movedPos, tempPos)
				end
			else
				--kiszamolja az uj helyet, ami az eredeti oldalon van
				local tempPos = { ["x"] = 0, ["y"] = 0, ["z"] = 0 }
				tempPos.x = originalPos.x
				tempPos.z = originalPos.z + math.pow(-1, math.abs(b-i)) * distance
				tempPos.y = originalPos.y
				table.insert(movedPos, tempPos)
			end
		else
			local distanceC1 = math.abs(originalPos.x - exitZone[luaRound(math.pow(2, math.abs(a-i)))].x)
			local distanceC2 = distanceC1 + height
			if distance > distanceC1 then
				if distance > distanceC2 then
					--kiszamolja az uj helyet, ami a nem szomszedos oldalon van
					local tempPos = { ["x"] = 0, ["y"] = 0, ["z"] = 0 }
					tempPos.x = exitZone[luaRound(math.pow(2, math.abs(a-i)))].x + math.pow(-1, math.abs(a-i)) * (distance - distanceC2)
					tempPos.z = exitZone[luaRound(math.pow(2, a))].z
					tempPos.y = originalPos.y
					table.insert(movedPos, tempPos)
				else
					--kiszamolja az uj helyet, ami a szomszedos oldalon van
					local tempPos = { ["x"] = 0, ["y"] = 0, ["z"] = 0 }
					tempPos.x = exitZone[luaRound(math.pow(2, math.abs(a-i)))].x
					tempPos.z = exitZone[luaRound(math.pow(2, math.abs(b)))].z + math.pow(-1, a) * (distance - distanceC1)
					tempPos.y = originalPos.y
					table.insert(movedPos, tempPos)
				end
			else
				--kiszamolja az uj helyet, ami az eredeti oldalon van
				local tempPos = { ["x"] = 0, ["y"] = 0, ["z"] = 0 }
				tempPos.x = originalPos.x + math.pow(-1, math.abs(b-i)) * distance
				tempPos.z = originalPos.z
				tempPos.y = originalPos.y
				table.insert(movedPos, tempPos)
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("luaMoveOnBorder: movedPos")
-- RELEASE_LOGOFF  	luaHelperLog(movedPos[1])
-- RELEASE_LOGOFF  	luaHelperLog(movedPos[2])

	return movedPos[1], movedPos[2]
end
]]

--[[AutoDoc
usage: localCoordinate, camPos, targetPos, a, angle = luaGetCamRelPos(targetEnt)
category: Camera
shortdesc:
desc:
]]
function luaGetCamRelPos(targetEnt)
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({targetEnt}), "***ERROR: luaGetCamRelPos needs an entity as param!"..debug.traceback())
	if targetEnt.Dead then
		return
	end

	local targetPos = GetPosition(targetEnt)

	local camState = GetCameraState()
	local camPos =
	{
		["x"] = camState.Position.x,
		["y"] = camState.Position.y,
		["z"] = camState.Position.z
	}

	local coordinate =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 0
	}
	local distance = luaGetDistance(targetPos, camPos)

	local a = luaMoveCoordinate(targetPos, 1000, luaGetRotation(targetEnt))
	local b = targetPos
	local c = camPos
	local angle = luaGetAngle(a, b, c)

	local localCoordinate =	luaMoveCoordinate(coordinate, distance, angle)
	localCoordinate.y = camPos.y - targetPos.y

	return localCoordinate, camPos, targetPos, a, angle
end

--[[AutoDoc
usage: dist = luaGetDistance3D(Obj1, Obj2)
category: Math
shortdesc: 2 objektum tavolsagat adja vissza 3D-ben
desc: Ket koordinata vagy entity tavolsagat adja vissza, figyelembe veve az y koordinatat is
Obj1: table, entity vagy koordinatatabla
Obj2: table, entity vagy koordinatatabla
dist: number, a ket vizsgalt parameter tavolsaga meterben
]]
function luaGetDistance3D(Obj1, Obj2)
	if type(Obj1) ~= "table" then
		error("***ERROR: luaGetDistance's first param is a non-table parameter.", 2)
	end

	if type(Obj2) ~= "table" then
		error("***ERROR: luaGetDistance's second param is a non-table parameter.", 2)
	end

-- RELEASE_LOGOFF  	Assert(Obj1.ID ~= nil or Obj1.x ~= nil, "***ERROR: luaGetDistance's first param is a table without ID or X index!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Obj2.ID ~= nil or Obj2.x ~= nil, "***ERROR: luaGetDistance's second param is a table without ID or X index!"..debug.traceback())

	if Obj1.ID ~= nil then
-- RELEASE_LOGOFF  		Assert(not thisTable[Obj1.ID].Dead, "***ERROR: luaGetDistance's first param is a dead entity! ("..tostring(thisTable[Obj1.ID].Name)..")\n"..debug.traceback())
--		if thisTable[Obj1.ID].Dead then
-- RELEASE_LOGOFF  --			luaHelperLog(" Warning: luaGetDistance got a dead entity! 1st arg: "..thisTable[Obj1.ID].Name)
--		end
	end

	if Obj2.ID ~= nil then
-- RELEASE_LOGOFF  		Assert(not thisTable[Obj2.ID].Dead, "***ERROR: luaGetDistance's second param is a dead entity! ("..tostring(thisTable[Obj2.ID].Name)..")\n"..debug.traceback())
--		if thisTable[Obj2.ID].Dead then
-- RELEASE_LOGOFF  --			luaHelperLog(" Warning: luaGetDistance got a dead entity! 2nd arg: "..thisTable[Obj2.ID].Name)
--		end
	end
--[[
	if Obj1 == nil then
		error("***ERROR: luaGetDistance's first parameter is nil.", 2)
	end

	if Obj2 == nil then
		error("***ERROR: luaGetDistance's second parameter is nil.", 2)
	end
]]
	local distance
	local posa
	local posb
	local posc = {}

	if Obj1.ID ~= nil then
		--luaHelperLog("Object: "..Obj1.Name.." ID: "..Obj1.ID.." thist: "..thisTable[Obj1.ID].." Dead? "..tostring(Obj1.Dead))
		posa = GetPosition(thisTable[Obj1.ID])
	else
		posa = Obj1
	end

	if Obj2.ID ~= nil then
		posb = GetPosition(thisTable[Obj2.ID])
	else
		posb = Obj2
	end

	posc.x = posa.x-posb.x
	posc.y = posa.y-posb.y
	posc.z = posa.z-posb.z
	distance = math.sqrt(math.pow(posc.x, 2)+math.pow(posc.z, 2)+math.pow(posc.y, 2))
-- RELEASE_LOGOFF  --	luaHelperLog("Distance between "..Obj1.." and "..Obj2.." is "..distance.." m.")
	return distance
end

--[[AutoDoc
usage: nearestUnit = luaGetCamTargetEnt()
category: Camera
shortdesc: visszaadja a kamerahoz legkozelebbi unitot
desc: A recon alapjan megmondja hogy melyik unit vana  legkozelebb a kamera fouszahoz GetDistanceFromCrosshair fv alapjan
nearestUnit: mixed, nil vagy a legkozelebbi unit
]]
function luaGetCamTargetEnt()
	ForceRecon()
	local camTargets = {}
	for i, reconParty in pairs(recon) do
		for j, reconCategory in pairs(reconParty.own) do
			for k, unit in pairs(reconCategory) do
				if not unit.Dead then
					local camDist = GetDistFromCrosshair(unit)
					if camDist < 0.1 and camDist > -0.1 then
						table.insert(camTargets, unit)
					end
				end
			end
		end
	end

	local camState = GetCameraState()
	local camPos =
	{
		["x"] = camState.Position.x,
		["y"] = camState.Position.y,
		["z"] = camState.Position.z
	}

	local nearestUnit
	local nearestUnitDistance = 0
	for index, unit in pairs (camTargets) do
		local unitDistance = luaGetDistance3D(unit, camPos)
		if not nearestUnit or unitDistance < nearestUnitDistance then
			nearestUnit = unit
			nearestUnitDistance = unitDistance
		end
	end
	return nearestUnit
end

--[[AutoDoc
usage: luaPressDisabledInput(inputID [,mul])
category: Mission
shortdesc: tiltott inputID szimulalasa
desc: szimulal egy letiltott inputIDt, illetve ad egy impulzust neki opcionalisan, szorzoval
inputID: enum, lsd. inputs.lua, a szimulalando inputID
mul: number, impulzus erossege
]]
function luaPressDisabledInput(inputID, mul)
-- RELEASE_LOGOFF  	Assert(inputID ~= nil and type(inputID) == "number", "***ERROR: luaPressDisabledInput needs an InputID as first param!"..debug.traceback())
	ForceEnableInput(inputID, true)
	if mul then
-- RELEASE_LOGOFF  		Assert(type(mul) == "number", "***ERROR: luaPressDisabledInput needs an number as second param!"..debug.traceback())
		HackPressInput(inputID, mul)
	else
		HackPressInput(inputID)
	end
	ForceEnableInput(inputID, false)
end

--[[AutoDoc
usage: pos = luaConvertXYZTo123(coordinate)
category: Mission
shortdesc: koordinata tablat konvertal
desc: Egy koordinata tablat konvertal moviekameranak megfelelo tablaba.
coordinate: table, a konvertalando koordinata
pos: table, a konvertalt koordinata
]]
function luaConvertXYZTo123(coordinate)
-- RELEASE_LOGOFF  	Assert(coordinate ~= nil and luaIsCoordinate(coordinate), "***ERROR: luaConvertXYZTo123 needs a coordinate as param!"..debug.traceback())
	local pos = {}
	table.insert(pos, coordinate.x)
	table.insert(pos, coordinate.y)
	table.insert(pos, coordinate.z)
	return pos
end

--[[AutoDoc
usage: pos = luaConvertRelPosToPolar(coordinate)
category: Math
shortdesc: relative coordinatabol nem regularis polar coordinatat konvertal
desc: Egy relative koordinata tablat konvertal moviekameranak megfelelo polar tablaba.
coordinate: table, a konvertalando koordinata
pos: table, a konvertalt polar {radius, theta, rho}
]]
function luaConvertRelPosToPolar(coordinate)
-- RELEASE_LOGOFF  	Assert(coordinate ~= nil and luaIsCoordinate(coordinate), "***ERROR: luaConvertRelPosToPolar needs a coordinate as param!"..debug.traceback())
	local origo =
	{
		["x"] = 0,
		["y"] = 0,
		["z"] = 0
	}
	local radius = luaGetDistance3D(origo, coordinate)

	local rho = luaGetAngle("world", origo, coordinate)
	if rho > 180 then
		rho = 360 - rho
	elseif rho < 180 then
		rho = -1 * rho
	end

	local transformedCoordinate =
	{
		["x"] = coordinate.y,
		["y"] = coordinate.x,
		["z"] = math.abs(coordinate.z)
	}
	local theta = luaGetAngle("world", origo, transformedCoordinate)

	local polar = { radius, theta, rho }
	return polar
end
---------------------------------------------------------- REGI MISSIONHELPERS --------------------------------------------------
--[[AutoDoc
usage: pos = luaMessageHandler(this, msg)
category: Mission
shortdesc: a MissionScript altal kapott uzeneteket dolgozza fel
desc: Kulonbozo cheatek illetve Mission terminalast feldolgozo script
this:  table, a Mission thisTable-je
msg: string, a Mission-nek atadott uzenet
]]
function luaMessageHandler(this, msg)
-- RELEASE_LOGOFF  	Log("luaMessageHandler has been called.")
	if msg ~= nil then
		if msg.Message == MSG_KILLED then
-- RELEASE_LOGOFF  			Log("Missionscript terminated.")
-- RELEASE_LOGOFF  			Log(" Playtime was ", math.floor(GameTime()), " secs (", GameTime()/60, " mins)")
			this.Dead = true	-- kodbol nem allitodik?
			return "killed"
		elseif msg.Message == MSG_CHEAT then
-- RELEASE_LOGOFF  			Log("---------------------------CHEAT----------------------------------")
-- RELEASE_LOGOFF  			Log("CHEATparams: F-", msg.F, ", Alt-", msg.Alt, ", Ctrl-", msg.Ctrl, ", Shift-", msg.Shift)

-------------------------- Single
			-- torpedok feltoltese
			if msg.F == 1 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Loading up torpedoes (8) for all own boats")
				for key, value in pairs(recon[this.Party].own.torpedoboat) do
					ShipSetTorpedoStock(value, 8)
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- torpedok nullazasa
			elseif msg.F == 2 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Taking away all own boats' torpedoes...")
				for key, value in pairs(recon[this.Party].own.torpedoboat) do
					ShipSetTorpedoStock(value, 0)
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- ellenseges torpedok feltoltese
			elseif msg.F == 3 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Loading up torpedoes (8) for all enemy boats.")
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own.torpedoboat) do
						ShipSetTorpedoStock(value, 8)
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_JAPANESE].own.torpedoboat) do
						ShipSetTorpedoStock(value, 8)
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- ellenseges torpedok elvetele
			elseif msg.F == 4 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Taking away all enemy boats' torpedoes...")
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own.torpedoboat) do
						ShipSetTorpedoStock(value, 0)
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_JAPANESE].own.torpedoboat) do
						ShipSetTorpedoStock(value, 0)
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				local unit = GetSelectedUnit()
				if unit == nil then
					return
				end

				if luaGetType(unit) == "plane" then
					MissionNarrative("CHEAT: Reloading bombs on plane "..unit.Name)
					PlaneReloadBombPlatforms(unit)
				elseif luaGetType(unit) == "plane" or luaGetType(unit) == "sub" then
					MissionNarrative("CHEAT: Reloading torpedoes on unit "..unit.Name)
					ShipSetTorpedoStock(unit, 20)
					ReloadTorpedoes(unit)
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("Reloading bombs on all plane in scene")

				for key, rParty in pairs(recon) do
					for key2, ownUnits in pairs(rParty.own) do
						for uID, unit in pairs(ownUnits) do
							if luaGetType(unit) == "plane" then
								PlaneReloadBombPlatforms(unit)
							end
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				local unit = GetSelectedUnit()
				if unit == nil then
					return
				end
				if unit.Dead then
					return
				end

				if not Mission.AutomaticReloaderTable then
					Mission.AutomaticReloaderTable = {}
				end
				local activateReloader = true
				if luaGetType(unit) == "plane" then
					for key, value in pairs (Mission.AutomaticReloaderTable) do
						if value == unit then
							RemoveTrigger(unit, "Reloader_"..tostring(unit))
							table.remove(Mission.AutomaticReloaderTable, key)
							MissionNarrative("CHEAT: Automatic reloader deactivated on plane "..unit.Name)
							activateReloader = nil
							break
						end
					end
					if activateReloader then
						MissionNarrative("CHEAT: Automatic reloader activated on plane "..unit.Name)
						PlaneReloadBombPlatforms(unit)
						AddSquadOrdnanceDroppedTrigger(unit, "Reloader_"..tostring(unit), "luaAutomaticReloader")
						table.insert(Mission.AutomaticReloaderTable, unit)
					end
				else
					for key, value in pairs (Mission.AutomaticReloaderTable) do
						if value == unit then
							if not unit.ReloaderTimer.Dead then
								luaClearDelay(unit.ReloaderTimer)
				end
							table.remove(Mission.AutomaticReloaderTable, key)
							MissionNarrative("CHEAT: Automatic reloader deactivated on "..unit.Name)
							activateReloader = nil
							break
						end
					end
					if activateReloader then
						MissionNarrative("CHEAT: Automatic reloader activated on "..unit.Name)
						ShipSetTorpedoStock(unit, 20)
						ReloadTorpedoes(unit)
						table.insert(Mission.AutomaticReloaderTable, unit)
						luaAutomaticReloader(unit)
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Fading new sound sample")




-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- Killing selected unit
			elseif msg.F == 9 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				local unit = GetSelectedUnit()
				if unit == nil then
					return
				end
-- RELEASE_LOGOFF  				Log("CHEAT: F9. Killing selected unit ("..unit.Name..")")
				MissionNarrative("CHEAT: Killing selected unit ("..unit.Name..")")
				Kill(unit)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- OneShotKill
			elseif msg.F == 10 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				if OneShotKill then
-- RELEASE_LOGOFF  					Log("Oneshotkill switched OFF")
					MissionNarrative("CHEAT: One shot kill turned OFF")
					OneShotKill = false
				else
-- RELEASE_LOGOFF  					Log("Oneshotkill switched ON")
					MissionNarrative("CHEAT: One shot kill activated")
					OneShotKill = true
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			-- Ctrl
			elseif msg.F == 1 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
				local unit = GetSelectedUnit()
				if unit ~= nil then
-- RELEASE_LOGOFF  					luaHelperLog(" Setting "..unit.Name.." to invincible")
					MissionNarrative("CHEAT: Invulnerability for "..unit.Name)
					SetInvincible(unit, true)
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 2 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
				local unit = GetSelectedUnit()
				if unit ~= nil then
-- RELEASE_LOGOFF  					luaHelperLog(" Setting "..unit.Name.." to vulnerable")
					MissionNarrative("CHEAT: Vulnerability for "..unit.Name)
					SetInvincible(unit, false)
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 3 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("CHEAT: Ctrl-F3. Invulnerability for all player-side units.")
				MissionNarrative("CHEAT: Invulnerability for all player-units")
				for key, value in pairs(recon[this.Party].own) do
					for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  						Log("Setting invincible: ", unit.Name)
						SetInvincible(unit, true)
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 4 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("CHEAT: Ctrl-F4. Vulnerability for all player-side units.")
				MissionNarrative("CHEAT: Vulnerability for all player-units")
				for key, value in pairs(recon[this.Party].own) do
					for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  						Log("Setting invincible: ", unit.Name)
						SetInvincible(unit, false)
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("CHEAT: Ctrl-F5. Invulnerability for all enemy units.")
				MissionNarrative("CHEAT: Invulnerability for all enemy units")
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  							Log("Setting invincible: ", unit.Name)
							SetInvincible(unit, true)
						end
					end
				else
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  							Log("Setting invincible: ", unit.Name)
							SetInvincible(unit, true)
						end
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("CHEAT: Ctrl-F6. Vulnerability for all enemy units.")
				MissionNarrative("CHEAT: Vulnerability for all enemy units")
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  							Log("Setting invincible: ", unit.Name)
							SetInvincible(unit, false)
						end
					end
				else
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  							Log("Setting invincible: ", unit.Name)
							SetInvincible(unit, false)
						end
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
				local unit = GetSelectedUnit()
				if not unit then
					return
				end

-- RELEASE_LOGOFF  				Log("CHEAT: repairing unit "..unit.Name)

				MissionNarrative("CHEAT: Reapairing unit "..unit.Name)
				CheatMaxRepair(unit)

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("CHEAT: repairing all unit in scene")

				MissionNarrative("CHEAT: Reapairing all unit in scene")

				for key, rParty in pairs(recon) do
					for key2, ownUnits in pairs(rParty.own) do
						for uID, unit in pairs(ownUnits) do
							CheatMaxRepair(unit)
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
				local unit = GetSelectedUnit()
				if not unit then
					return
				end

				if luaGetType(unit) == "ship" or luaGetType(unit) == "sub" then
					MissionNarrative("CHEAT: Removing water from ship "..unit.Name)
					CheatRemoveWater(unit)
-- RELEASE_LOGOFF  					Log("CHEAT: removing water from unit "..unit.Name)
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 10 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("CHEAT: removing water from all ship/sub in scene")

				MissionNarrative("CHEAT: Removing water from all ship and submarine in scene")

				for key, rParty in pairs(recon) do
					for key2, ownUnits in pairs(rParty.own) do
						for uID, unit in pairs(ownUnits) do
							if luaGetType(unit) == "ship" or luaGetType(unit) == "sub" then
								CheatRemoveWater(unit)
							end
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			-- Alt - AI
			elseif msg.F == 1 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("Holdfire on: ", GetSelectedUnit().Name)
				MissionNarrative("CHEAT: setting HoldFire on selected unit ("..GetSelectedUnit().Name..")")
				UnitHoldFire(GetSelectedUnit())

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			elseif msg.F == 2 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
-- RELEASE_LOGOFF  				Log("Freefire on: ", GetSelectedUnit().Name)
				MissionNarrative("CHEAT: setting FreeFire on selected unit ("..GetSelectedUnit().Name..")")
				UnitFreeFire(GetSelectedUnit())
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 3 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then

				local sel = GetSelectedUnit()
				if sel == nil then
					return
				end

-- RELEASE_LOGOFF  				Log("Disable AI on unit ", sel.Name)

				local selType = luaGetType(sel)

				if selType == "ship" then
					MissionNarrative("CHEAT: disable AI on ship "..sel.Name)
					SetFireTarget(sel, nil)
					luaShutUp(sel, false)
					luaEnableNavigator(sel, false)
					UnitHoldFire(sel)
				elseif selType == "sub" then
					MissionNarrative("CHEAT: disable AI on submarine "..sel.Name)
					SetFireTarget(sel, nil)
					luaShutUp(sel, false)
					luaEnableNavigator(sel, false)
					UnitHoldFire(sel)
					SetSubmarineDepthLevel(sel, 0)
				elseif selType == "plane" then
					MissionNarrative("CHEAT: disable AI on plane "..sel.Name)
					UnitHoldFire(sel)
					PilotMoveTo(sel, GetPosition(sel))
				elseif selType == "landfort" then
					AAEnable(sel, false)
					ArtilleryEnable(sel, false)
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 4 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then

				local sel = GetSelectedUnit()
				if sel == nil then
					return
				end

-- RELEASE_LOGOFF  				Log("Enable AI on unit ", sel.Name)

				local selType = luaGetType(sel)

				if selType == "ship" then
					MissionNarrative("CHEAT: enable AI on ship "..sel.Name)
					luaShutUp(sel, true)
					luaEnableNavigator(sel, true)
					UnitFreeAttack(sel)
				elseif selType == "sub" then
					MissionNarrative("CHEAT: enable AI on submarine "..sel.Name)
					luaShutUp(sel, true)
					luaEnableNavigator(sel, true)
					UnitFreeAttack(sel)
					SetSubmarineDepthLevel(sel, 1)
				elseif selType == "plane" then
					MissionNarrative("CHEAT: enable AI on plane "..sel.Name)
					UnitFreeAttack(sel)
				elseif selType == "landfort" then
					AAEnable(sel, true)
					ArtilleryEnable(sel, true)
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Disable AI on all unit")
				for key, rParty in pairs(recon) do
-- RELEASE_LOGOFF  					luaHelperLog("Checking party "..key)
					for key2, ownUnits in pairs(rParty.own) do
-- RELEASE_LOGOFF  						luaLog(" Checking ownUnits table at key "..key2)
						for uID, unit in pairs(ownUnits) do
-- RELEASE_LOGOFF  							Log("Disable AI on unit ", unit.Name)

							local selType = luaGetType(unit)

							if selType == "ship" then
								SetFireTarget(unit, nil)
								luaShutUp(unit, false)
								luaEnableNavigator(unit, false)
								UnitHoldFire(unit)
							elseif selType == "sub" then
								SetFireTarget(unit, nil)
								luaShutUp(unit, false)
								luaEnableNavigator(unit, false)
								UnitHoldFire(unit)
								SetSubmarineDepthLevel(unit, 0)
							elseif selType == "plane" then
								UnitHoldFire(unit)
								PilotMoveTo(unit, GetPosition(unit))
							elseif selType == "landfort" then
								--AAEnable(unit, false)
								ArtilleryEnable(unit, false)
							end
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Enable AI on all unit")
				for key, rParty in pairs(recon) do
					for key2, ownUnits in pairs(rParty.own) do
						for unitType, unit in pairs(ownUnits) do
-- RELEASE_LOGOFF  							Log("Enable AI on unit ", unit.Name)

							local selType = luaGetType(unit)

							if selType == "ship" then
								luaShutUp(unit, true)
								luaEnableNavigator(unit, true)
								UnitFreeAttack(unit)
							elseif selType == "sub" then
								luaShutUp(unit, true)
								luaEnableNavigator(unit, true)
								UnitFreeAttack(unit)
								SetSubmarineDepthLevel(unit, 1)
							elseif selType == "plane" then
								UnitFreeAttack(unit)
							elseif selType == "landfort" then
								--AAEnable(unit, true)
								ArtilleryEnable(unit, true)
							end
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
				SelectedUnit = GetSelectedUnit()
				currlevel = GetCrewLevel(SelectedUnit)
				if currlevel < 3 then
					SetCrewLevel(SelectedUnit, currlevel + 1)
				else
					SetCrewLevel(SelectedUnit, 0)
				end

				local CrewText = ""
				if GetCrewLevel(SelectedUnit) == 0 then
					CrewText = "Rookie"
				elseif GetCrewLevel(SelectedUnit) == 1 then
					CrewText = "Regular"
				elseif GetCrewLevel(SelectedUnit) == 2 then
					CrewText = "Veteran"
				elseif GetCrewLevel(SelectedUnit) == 3 then
					CrewText = "Elite"
				end

				MissionNarrative("CHEAT: Setting current unit level to:"..CrewText)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
				if Mission.AlliedCrewLevelCheat == nil then
					Mission.AlliedCrewLevelCheat = 0
				elseif Mission.AlliedCrewLevelCheat < 3 then
					Mission.AlliedCrewLevelCheat = Mission.AlliedCrewLevelCheat + 1
				else
					Mission.AlliedCrewLevelCheat = 0
				end

				local CrewText = ""
				if Mission.AlliedCrewLevelCheat == 0 then
					CrewText = "Rookie"
				elseif Mission.AlliedCrewLevelCheat == 1 then
					CrewText = "Regular"
				elseif Mission.AlliedCrewLevelCheat == 2 then
					CrewText = "Veteran"
				elseif Mission.AlliedCrewLevelCheat == 3 then
					CrewText = "Elite"
				end


				if this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							SetCrewLevel(unit, Mission.AlliedCrewLevelCheat)
						end
					end
				elseif this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							SetCrewLevel(unit, Mission.AlliedCrewLevelCheat)
						end
					end
				end
				MissionNarrative("CHEAT: Own party crew level is: "..CrewText)

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
				if Mission.JapCrewLevelCheat == nil then
					Mission.JapCrewLevelCheat = 0
				elseif Mission.JapCrewLevelCheat < 3 then
					Mission.JapCrewLevelCheat = Mission.JapCrewLevelCheat + 1
				else
					Mission.JapCrewLevelCheat = 0
				end
				local CrewText = ""
				if Mission.JapCrewLevelCheat == 0 then
					CrewText = "Rookie"
				elseif Mission.JapCrewLevelCheat == 1 then
					CrewText = "Regular"
				elseif Mission.JapCrewLevelCheat == 2 then
					CrewText = "Veteran"
				elseif Mission.JapCrewLevelCheat == 3 then
					CrewText = "Elite"
				end

				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							SetCrewLevel(unit, Mission.JapCrewLevelCheat)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							SetCrewLevel(unit, Mission.JapCrewLevelCheat)
						end
					end
				end
				MissionNarrative("CHEAT: Enemy party crew level is: "..CrewText)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 10 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 0 then
				local unit = GetSelectedUnit()
				if unit ~= nil then
					local uType = luaGetType(unit)
					if uType == "ship" or uType == "sub" then
						if unit.CurrentBooster == nil then
							unit.OrigSpeed = GetShipMaxSpeed(unit)
							unit.CurrentBooster = 5
						elseif unit.CurrentBooster == 1 then
							unit.CurrentBooster = 5
						elseif unit.CurrentBooster == 5 then
							unit.CurrentBooster = 10
						elseif unit.CurrentBooster == 10 then
							unit.CurrentBooster = 1
						end

						SetShipMaxSpeed(unit, unit.OrigSpeed*unit.CurrentBooster)
						MissionNarrative("CHEAT: Setting max speed to "..tostring(unit.CurrentBooster).."x ("..tostring(GetShipMaxSpeed(unit))..")")

					elseif uType == "plane" then
						if unit.CurrentBooster == nil or unit.CurrentBooster == 1 then
							unit.CurrentBooster = 2
						elseif unit.CurrentBooster == 2 then
							unit.CurrentBooster = 3
						elseif unit.CurrentBooster == 3 then
							unit.CurrentBooster = 1
						end

						SetCheatTurbo(unit, unit.CurrentBooster)
						MissionNarrative("CHEAT: Setting max speed to "..tostring(unit.CurrentBooster).."x")
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

-------------------------- Shift
			-- Missionfazis leptetese
			elseif msg.F == 1 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Stepping missionphase")
				this.Cheat_PhaseShift = true
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- Kuldetes sikeresse tetele
			elseif msg.F == 2 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrativeOverride("CHEAT: Mission success")
				--this.Cheat_MissionSuccess = true
-- RELEASE_LOGOFF  				luaLog(">>> CHEAT CALLED: Mission success")

				luaObj_CompletedAll()
				Scoring_SetMissionCompleted(true)
				EndScene()

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 3 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Starting/Stopping countdown")
				if Mission.CountdownTbl == nil then
-- RELEASE_LOGOFF  					luaHelperLog("CountdownTbl not declared, quitting.")
					return
				end

				--if Mission.CountdownStopped == nil then
-- RELEASE_LOGOFF  				--	luaHelperLog("CountdownStopped flag value is not set. It is now false.")
				--	Mission.CountdownStopped = false
				--end

				if not Mission.CountdownStopped then
					Mission.CountdownTbl.CountdownTime = CountdownTimeLeft()
-- RELEASE_LOGOFF  					luaHelperLog("Setting countdown time to "..tostring(Mission.CountdownTbl.CountdownTime))
					CountdownCancel()
					Mission.CountdownStopped = true
-- RELEASE_LOGOFF  					luaHelperLog("Stopping countdown, CountdownStopped flag is true.")
				elseif Mission.CountdownStopped then
					Countdown(Mission.CountdownTbl.txt, Mission.CountdownTbl.StartLevel, Mission.CountdownTbl.CountdownTime, Mission.CountdownTbl.Callback, Mission.CountdownTbl.CallbackParams)
					Mission.CountdownStopped = false
-- RELEASE_LOGOFF  					luaHelperLog("Starting countdown with params: txt: "..tostring(Mission.CountdownTbl.txt)..", startlvl: "..tostring(Mission.CountdownTbl.StartLevel)..", time: "..tostring(Mission.CountdownTbl.CountdownTime)..", callback: "..tostring(Mission.CountdownTbl.Callback)..", clbparams: "..tostring(Mission.CountdownTbl.CallbackParams))
-- RELEASE_LOGOFF  					luaHelperLog("CountdownStopped falg is false.")
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 4 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrativeOverride("CHEAT: Mission failure")

-- RELEASE_LOGOFF  				luaLog(">>> CHEAT CALLED: Mission failed")

				luaObj_FailedAll()
				Scoring_SetMissionCompleted(false)
				EndScene()

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				--MissionNarrative("CHEAT: Switching custom log")

				if not Mission.CustomLog then
-- RELEASE_LOGOFF  					Log("\t-> ON")
					Mission.CustomLog = true
					MissionNarrative("Turning Custom log ON")
				else
-- RELEASE_LOGOFF  					Log("\t-> OFF")
					Mission.CustomLog = false
					MissionNarrative("Turning Custom log OFF")
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
-- RELEASE_LOGOFF  				Log("CHEAT: Switching helpers' log")

				if not Mission.HelperLog then
-- RELEASE_LOGOFF  					Log("\t-> ON")
					Mission.HelperLog = true
					MissionNarrative("Turning Helpers' log ON")
				else
-- RELEASE_LOGOFF  					Log("\t-> OFF")
					Mission.HelperLog = false
					MissionNarrative("Turning Helpers' log OFF")
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				if not MessageSender then
					MissionNarrative("CHEAT: MessageSender is not active!")
					return
				end

-- RELEASE_LOGOFF  				Log("CHEAT: Switching message sender log")
				if not MessageSender.Logging then
-- RELEASE_LOGOFF  					Log("\t-> ON")
					SETLOG(MessageSender, true)
					MessageSender.Logging = true
					MissionNarrative("CHEAT : Turning MessageSender log ON")
				else
-- RELEASE_LOGOFF  					Log("\t-> OFF")
					SETLOG(MessageSender, false)
					MessageSender.Logging = false
					MissionNarrative("CHEAT: Turning MessageSender log OFF")
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("Log for mission is ON")
				if Mission ~= nil then
					SETLOG(Mission, true)
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("Log for mission is OFF")
				if Mission ~= nil then
					SETLOG(Mission, false)
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			elseif msg.F == 10 and msg.Ctrl == 0 and msg.Alt == 0 and msg.Shift == 1 then
				if Mission.UnitCountEnabled then
					MissionNarrativeUrgent("Unitcount turned OFF")
					Mission.UnitCountEnabled = false
-- RELEASE_LOGOFF  					luaHelperLog("Unitcount disabled")
				else
					MissionNarrativeUrgent("Unitcount turned ON")
					Mission.UnitCountEnabled = true
-- RELEASE_LOGOFF  					luaHelperLog("Unitcount enabled")
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			-- Shift + Ctrl
			-- minden ellenseg felderitese
			elseif msg.F == 1 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: All enemy unit is identified.")

				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 2, PARTY_ALLIED)
						end
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- minden ellenseg elrejtese
			elseif msg.F == 2 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: All enemy unit is hidden.")

				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 0, PARTY_JAPANESE)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 0, PARTY_ALLIED)
						end
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- Setting recon data to normal level
			elseif msg.F == 3 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Recon system set to normal mode.")
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							ClearForcedReconLevel(value, PARTY_JAPANESE)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							ClearForcedReconLevel(value, PARTY_ALLIED)
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- minden sajat egyseg felderitese az ellenseg altal
			elseif msg.F == 4 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: All own unit is identified by our enemy.")

				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 2, PARTY_ALLIED)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
						end
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- sajat egysegek elrejtese az ellenseg elol
			elseif msg.F == 5 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Hiding own units from enemy.")
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 0, PARTY_ALLIED)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							SetForcedReconLevel(unit, 0, PARTY_JAPANESE)
						end
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			-- sajat egysegek felderitettsegenek normalisra valo visszaallitasa
			elseif msg.F == 6 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				if this.Party == PARTY_JAPANESE then
					for key, value in pairs(recon[PARTY_JAPANESE].own) do
						for unittype, unit in pairs(value) do
							ClearForcedReconLevel(value, PARTY_ALLIED)
						end
					end
				elseif this.Party == PARTY_ALLIED then
					for key, value in pairs(recon[PARTY_ALLIED].own) do
						for unittype, unit in pairs(value) do
							ClearForcedReconLevel(value, PARTY_JAPANESE)
						end
					end
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Music custom1")
				Music_Control_SetLevel(MUSIC_CUSTOM1)

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Music custom2")
				Music_Control_SetLevel(MUSIC_CUSTOM2)

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Music custom3")
				Music_Control_SetLevel(MUSIC_CUSTOM3)

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 10 and msg.Ctrl == 1 and msg.Alt == 0 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Turning messages off")
				EnableMessages(false)

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

------------------- Alt + Shift
			elseif msg.F == 1 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				local unit = GetSelectedUnit()
				if unit then
					local lvl = GetCrewLevel(unit)

					if lvl == CREW_ROOKIE then
						MissionNarrative("DEBUG: "..unit.Name.."'s crewlevel is ROOKIE")
					elseif lvl == CREW_REGULAR then
						MissionNarrative("DEBUG: "..unit.Name.."'s crewlevel is REGULAR")
					elseif lvl == CREW_VETERAN then
						MissionNarrative("DEBUG: "..unit.Name.."'s crewlevel is VETERAN")
					elseif lvl == CREW_ELITE then
						MissionNarrative("DEBUG: "..unit.Name.."'s crewlevel is ELITE")
					end
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 2 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				local unit = GetSelectedUnit()

				if unit ~= nil then
					local cID = unit.Class.ID
					local classUnits = luaGetClassUnits(cID)

					for key, value in pairs(classUnits) do
						Kill(value, true)
					end

					UnloadClass(tonumber(cID))
					MissionNarrative("CHEAT: Clearing unitclass: "..cID)
				else
					MissionNarrative("CHEAT: Clearing unitclass is not possible now!")
				end

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			elseif msg.F == 3 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
-- RELEASE_LOGOFF  				luaLog("Narrative on screen: Missionphase "..Mission.MissionPhase)
				MissionNarrative("Missionphase: "..Mission.MissionPhase)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 4 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Siralyt rakok a scene-be bele")
					TempAddAnim({
						["AnimClassName"] = "Siralyok",
						--["Position"] = { ["x"] = 197, ["y"] = 502, ["z"] = -2642 },
						["Position"] = GetCameraState().Position
					})
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Killing landscape")
					local ls = FindEntity("Landscape")
-- RELEASE_LOGOFF  					luaLog("LS: "..ls.Name)

					Kill(ls, true)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

			-- kamerahelyzet kimentese CameraState.log-ba
			elseif msg.F == 7 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CameraState logging")
				luaWriteCamState()

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then

				if FOVBase == nil then
					FOVBase = 30
				else
					FOVBase = FOVBase + 10
				end

				SetFovBase(FOVBase)

				MissionNarrativeClear()
				MissionNarrative("FOV set to "..tostring(FOVBase))

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				if FOVBase == nil then
					FOVBase = 30
				else
					FOVBase = FOVBase - 10
				end

				SetFovBase(FOVBase)

				MissionNarrativeClear()
				MissionNarrative("FOV set to "..tostring(FOVBase))

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 10 and msg.Ctrl == 0 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: missionend")
				if Mission.MissionStatus ~= nil then
					luaMissionEnd_Finale()
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

----------------------- Alt + Ctrl
			elseif msg.F == 1 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Sinking current ship")
				Sink(GetSelectedUnit(), 1)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 2 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: movieplay")
				PlayBinkMovie("Test.bik", "")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 3 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				PS2Rectangle();
				MissionNarrative("CHEAT: ")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 4 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Engine start failure")
				Effect("BoatEngineStartFail", GetCameraState().Position)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Engine start")
				Effect("BoatEngineStart", GetCameraState().Position)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Music calm")
				Music_Control_SetLevel(MUSIC_CALM)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Music tension")
				Music_Control_SetLevel(MUSIC_TENSION)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Music action")
				Music_Control_SetLevel(MUSIC_ACTION)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Music defeat")
				Music_Control_SetLevel(MUSIC_DEFEAT)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 10 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 0 then
				MissionNarrative("CHEAT: Music victory")
				Music_Control_SetLevel(MUSIC_VICTORY)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return

----------------------- Alt + Ctrl + Shift
--[[
			elseif msg.F == 1 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				local unit = GetSelectedUnit()

				if unit then
					MissionNarrative("MovCam test: CamGoRound on unit - "..tostring(unit.Name))
					local pos0 = {
							["postype"]="cameraandtarget",
							["position"]= {
								["parent"]=unit,
								["modifier"] = {
									["name"] = "goaround",
									["radius"] = {150},
									["radiuslinearblend"] = 0.3,
									--["theta"] = {0, 6, 5, 12, 30, },
									["theta"] = {0},
									["thetalinearblend"] = 0.3,
									["rho"] = {180, 13, -170, 18, -230 },
									["rholinearblend"] = 0.5,
								}
							},
							["transformtype"]="keepy",
							["starttime"]=0,
							["blendtime"]=2.0,
							["linearblend"]=0.0,
							["wanderer"]=true,
							["smoothtime"]=2.0,
						}
					MovCamNew_AddPosition(pos0)
				end
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 2 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Sound fade away")
				SoundFade(0, "luaSoundFadeTestCB", 5)
				--Blackout(true, "luaSoundFadeTestCB", 5, 1)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 3 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Sound fade in")
				SoundFade(1, "luaSoundFadeTestCB", 5)
				--Blackout(false, "luaSoundFadeTestCB", 5, 0)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 4 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Sound fade to half volume")
				SoundFade(0.5, "luaSoundFadeTestCB", 5)
				--Blackout(true, "luaSoundFadeTestCB", 5, 0.5)
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 5 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: ")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 6 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: ")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 7 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: ")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 8 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: ")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 9 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: ")
-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
			elseif msg.F == 10 and msg.Ctrl == 1 and msg.Alt == 1 and msg.Shift == 1 then
				MissionNarrative("CHEAT: Clearing dialogues")
				luaClearDialogs()

-- RELEASE_LOGOFF  				Log("---------------------------CHEAT END------------------------------")
				return
]]
			end
		end
	else
-- RELEASE_LOGOFF  		Log(" No message")
	end
end

--[[AutoDoc
usage: luaFakeMG(target [,num] [,angle] [,hit])
category: Mission
shortdesc: fake machinegun effect generalas
desc: 'target' korul 'num' mennyisegu, 'angle' szogben genereal MG effectet, 'hit' eseten nem tolja el 'target' korul az effecteket, kulon scriptEntitykent fut, sajat thinkkel
target: table, entity, koordinata, e korul generaljuk az effekteket
num: number, maximum ennyi effectet generalunk (sorok)
angle: number, ilyen szogben toljuk el
hit: bool, eltallja e a 'target'-et vagy sem
]]
-- generating fake machine-gunning around target
function luaFakeMG(target, num, angle, hit)
-- RELEASE_LOGOFF  	luaHelperLog("Generating fake MGeffects...")

	local pos, trgtype, fireangle
	local bpos = {}
	local bnum

	-- loadup
-- RELEASE_LOGOFF  	luaHelperLog(" + Carpetbombing!")

	if not num then	-- itt a sorok szama
		bnum = 1
	else
		bnum = num
	end

	if angle == nil then
		fireAngle = 0
	else
-- RELEASE_LOGOFF  		luaHelperLog(" Angle given: "..angle)
		fireAngle = angle
	end

	local rndEltolas
	if not hit then
		if luaPickInRange("front", 5, "back", 5) == "front" then
-- RELEASE_LOGOFF  			luaHelperLog(" Front selected")
			rndEltolas = target.Class.Length/2 + luaRnd(10, 40)
		else
-- RELEASE_LOGOFF  			luaHelperLog(" Back selected")
			rndEltolas = -target.Class.Length/2 - luaRnd(10, 40)
		end
	else
		rndEltolas = 0
	end

	local seriesDist = 100
	local firstbpos = {}
	local bombnum = luaRnd(20, 35)

	table.insert(firstbpos, luaMoveCoordinate(GetPosition(target), 15*bombnum/2+rndEltolas, fireAngle))	-- sorozat elso tagja

	for i = 1, bombnum, 1 do	-- sorozat tobbi tagja
		table.insert(firstbpos, luaMoveCoordinate(firstbpos[i], 15, fireAngle+180))
	end

	local bpos = {}
	for key, value in pairs(firstbpos) do
		table.insert(bpos, value)	-- eredeti
		if bnum > 1 then
			local shift = 10
			for i = 1, bnum-1, 1 do
				table.insert(bpos, luaMoveCoordinate(value, shift, fireAngle+90))	-- eltolt
				shift = shift + shift
			end
		end
	end

-- RELEASE_LOGOFF  	LogToFile("Final positions: ", bpos)

	--  Effect generation
	local delay = 0.1
	local i = 0
	local multiPos = {}

	-- idoziteshez szukseges paramok
	local paramTable = {["Pos"]={}}
	local timer =
		{
			{
				[1] = false,
				[2] = delay
			}
		}

	for key, value in pairs(bpos) do
-- RELEASE_LOGOFF  		luaHelperLog(" Examining pos "..key)
		if bnum > 1 then	-- tobb oszlop
-- RELEASE_LOGOFF  			luaHelperLog(" > Multiple insertation ("..bnum..")")
			table.insert(multiPos, value)
			i = i + 1
			if i == bnum then
				i = 0
-- RELEASE_LOGOFF  				luaHelperLog(" >> now inserting.")
				--delay = delay + 0.1
				table.insert(timer, {[1] = luaFakeMGTimer, [2] = delay})
				table.insert(paramTable.Pos, multiPos)
				--LogToFile("KAKAS2", paramTable)

				multiPos = {}
			end
		else
-- RELEASE_LOGOFF  			luaHelperLog(" > single insertation.")
			table.insert(timer, {[1] = luaFakeMGTimer, [2] = delay})
			table.insert(paramTable.Pos, {value})
			--luaDelay(luaFakeMGTimer, delay, "Pos", value)
			--delay = delay + 0.1
		end
	end
	--LogToFile("KAKASEND", paramTable)
	CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaFakeMGTimer(timerthis)
category: Mission
shortdesc: fake machinegun effect idozitofuggvenye
desc: Fake MG generalo fuggveny idozitoje, amely tenylegesen generalja az effekteket
tmethis: table, a luaFakeMG fv altal atdott valtozok
]]
function luaFakeMGTimer(timerthis)
	SETLOG(timerthis, true)
-- RELEASE_LOGOFF  	luaHelperLog("Generating fake bomb explosion...")
-- RELEASE_LOGOFF  	luaHelperLog(" Positions: "..timerthis.ParamTable.Pos)

	if timerthis.TimerFunctionNum == nil then
		timerthis.TimerFunctionNum = 1
	else
		timerthis.TimerFunctionNum = timerthis.TimerFunctionNum + 1
	end

-- RELEASE_LOGOFF  	luaHelperLog(" FunctionNum: "..timerthis.TimerFunctionNum)

--	for key, value in pairs(timerthis.ParamTable.Pos) do
-- RELEASE_LOGOFF  --		luaHelperLog("TESZTPOS: key - "..key..", value: "..tostring(value))
--	end

	luaHelperLog("  Pos to function num: "..timerthis.ParamTable.Pos[timerthis.TimerFunctionNum])

	for key, value in pairs(timerthis.ParamTable.Pos[timerthis.TimerFunctionNum]) do
-- RELEASE_LOGOFF  		luaHelperLog("  > POS: "..value)
		local land = IsLandscape(value)
		local ship = IsShip(value)

		if not ship and not land then				-- water
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on water!")
			Effect("MachinegunHitWater", value)
		elseif land then					-- landscape
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on landscape!")
			value.y = land
			Effect("MachinegunHit", value)
		elseif ship then					-- ship
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on ship!")
			value.y = ship
			Effect("MachinegunHitGround", value)
		end
	end


--[[
	-- OLD !!
	local pos = timerthis.ParamTable.Pos
	if pos.x == nil then
-- RELEASE_LOGOFF  		luaHelperLog(" Multiple coordinates!")
		for key, value in pairs(pos) do
			local land = IsLandscape(value)
			local ship = IsShip(value)

			if not ship and not land then				-- water
-- RELEASE_LOGOFF  				luaHelperLog("  Target is on water!")
				Effect("MachinegunHitWater", value)
			elseif land then					-- landscape
-- RELEASE_LOGOFF  				luaHelperLog("  Target is on landscape!")
				value.y = land
				Effect("MachinegunHit", value)
			elseif ship then					-- ship
-- RELEASE_LOGOFF  				luaHelperLog("  Target is on ship!")
				value.y = ship
				Effect("MachinegunHitGround", value)
			end
		end

	else
		local land = IsLandscape(pos)
		local ship = IsShip(pos)

		if not ship and not land then				-- water
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on water!")
			Effect("MachinegunHitWater", pos)
		elseif land then					-- landscape
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on landscape!")
			pos.y = land
			Effect("MachinegunHit", pos)
		elseif ship then					-- ship
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on ship!")
			pos.y = ship
			Effect("MachinegunHitGround", pos)
		end
	end
]]

	SETLOG(timerthis, false)
end

--[[AutoDoc
usage: luaFakeBombing(target ,mode [,num] [,angle] [,hit])
category: Mission
shortdesc: fake bomb effect generalas
desc: 'target' korul 'num' mennyisegu, 'angle' szogben genereal bomb effectet, 'hit' eseten nem tolja el 'target' korul az effecteket, kulon scriptEntitykent fut, sajat thinkkel
target: table, entity, koordinata, e korul generaljuk az effekteket
mode: string, 'carpet', 'single', szonyeg illetve sima bombaeffekt
num: number, 'single'-nel a korbe becsapodo bombak szama, 'carpet'-nel az oszlopszam
angle: number, carpetnel szamit, az erkezesi szog (oramutato jarasaval megyezo iranyba novekszik, 0-360 fokig)
hit: bool, carpetnal szamit, ha true, akkor biztos eltalalja az effekt a celpontot, egyebkent eltolassal mukodik (nincs kizarva a talalat)
]]
function luaFakeBombing(target, mode, num, angle, hit)
-- RELEASE_LOGOFF  	luaHelperLog("Generating fake bombeffects...")

	local pos, trgtype, fireangle
	local bpos = {}
	local bnum

	local delay = 0.2

	-- idoziteshez szukseges paramok
	local paramTable = {["Pos"]={}}
	local timer =
		{
			{
				[1] = false,
				[2] = delay
			}
		}

	-- loadup
	if mode == "carpet" then
-- RELEASE_LOGOFF  		luaHelperLog(" + Carpetbombing!")

		if not num then	-- itt a sorok szama
			bnum = 1
		else
			bnum = num
		end

		if angle == nil then
			fireAngle = 0
		else
-- RELEASE_LOGOFF  			luaHelperLog(" Angle given: "..angle)
			fireAngle = angle
		end

		local rndEltolas
		if not hit then
			if luaPickInRange("front", 5, "back", 5) == "front" then
-- RELEASE_LOGOFF  				luaHelperLog(" Front selected")
				rndEltolas = target.Class.Length/2 + luaRnd(10, 40)
			else
-- RELEASE_LOGOFF  				luaHelperLog(" Back selected")
				rndEltolas = -target.Class.Length/2 - luaRnd(10, 40)
			end
		else
			rndEltolas = 0
		end

		local seriesDist = 50
		local firstbpos = {}
		local bombnum = luaRnd(8, 10)

		table.insert(firstbpos, luaMoveCoordinate(GetPosition(target), 70*bombnum/2+rndEltolas, fireAngle))	-- sorozat elso tagja

		for i = 1, bombnum, 1 do	-- sorozat tobbi tagja
			table.insert(firstbpos, luaMoveCoordinate(firstbpos[i], 70, fireAngle+180))
		end

		local bpos = {}
		for key, value in pairs(firstbpos) do
			table.insert(bpos, value)	-- eredeti
			if bnum > 1 then
				local shift = 70
				for i = 1, bnum-1, 1 do
					table.insert(bpos, luaMoveCoordinate(value, shift, fireAngle+90))	-- eltolt
					shift = shift + shift
				end
			end
		end

-- RELEASE_LOGOFF  		LogToFile("Final positions: ", bpos)
		local multiPos = {}
		local i = 0
		for key, value in pairs(bpos) do
-- RELEASE_LOGOFF  			luaHelperLog(" Examining pos "..key)
			if bnum > 1 then	-- tobb oszlop
-- RELEASE_LOGOFF  				luaHelperLog(" > Multiple insertation ("..bnum..")")
				table.insert(multiPos, value)
				i = i + 1
				if i == bnum then
					i = 0
-- RELEASE_LOGOFF  					luaHelperLog(" >> now inserting.")
					--delay = delay + 0.1
					table.insert(timer, {[1] = luaFakeBombingTimer, [2] = delay})
					table.insert(paramTable.Pos, multiPos)
					--LogToFile("KAKAS2", paramTable)

					multiPos = {}
				end
			else
-- RELEASE_LOGOFF  				luaHelperLog(" > single insertation.")
				table.insert(timer, {[1] = luaFakeBombingTimer, [2] = delay})
				table.insert(paramTable.Pos, {value})
				--luaDelay(luaFakeMGTimer, delay, "Pos", value)
				--delay = delay + 0.1
			end
		end

--[[	OLD !!
		--  Effect generation
		local delay = 1
		local i = 0
		local multiPos = {}
		for key, value in pairs(bpos) do
-- RELEASE_LOGOFF  			luaHelperLog(" Examining pos "..key)
			if bnum > 1 then	-- tobb oszlop
-- RELEASE_LOGOFF  				luaHelperLog(" > Multiple insertation ("..bnum..")")
				table.insert(multiPos, value)
				i = i + 1
				if i == bnum then
					i = 0
-- RELEASE_LOGOFF  					luaHelperLog(" >> now inserting.")
					luaDelay(luaFakeBombingTimer, delay, "Pos", multiPos)
					multiPos = {}
					delay = delay + 0.2
				end
			else
-- RELEASE_LOGOFF  				luaHelperLog(" >> single insertation.")
				luaDelay(luaFakeBombingTimer, delay, "Pos", value)
				delay = delay + 0.2
			end
		end
]]
	elseif mode == "single" then
-- RELEASE_LOGOFF  		luaHelperLog(" + Single bombing with "..tostring(bnum).." bombs!")
		if num == nil or num == 0 then
			bnum = 5	-- default 5
		else
			bnum = num
		end

		for i = 1, bnum do
			-- todo: rnd pos around ship
			local side = luaPickInRange("left", 5, "right", 5)
-- RELEASE_LOGOFF  			luaHelperLog(" - Effect on the "..side.."!")

			local localPos
			if side == "left" then
				localPos = {["x"] = luaRnd(-70,-30), ["y"] = 0, ["z"] = luaRnd(-70,70)}
			else
				localPos = {["x"] = luaRnd(30,70), ["y"] = 0, ["z"] = luaRnd(-70,70)}
			end

			local trgPos = RelativePosition(target, localPos)
-- RELEASE_LOGOFF  			luaHelperLog("Final Coordinate "..tostring(bnum)..": ")
-- RELEASE_LOGOFF  			luaHelperLog(trgPos)
			table.insert(bpos, trgPos)
		end

		--  Effect generation
		for key, value in pairs(bpos) do
-- RELEASE_LOGOFF  			luaHelperLog(" Calling timer ")
			--luaDelay(luaFakeBombingTimer, delay, "Pos", value)
			--delay = delay + 0.2
			table.insert(timer, {[1] = luaFakeBombingTimer, [2] = delay})
			table.insert(paramTable.Pos, {value})
		end
	end

	CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaFakeBombingTimer(timerthis)
category: Mission
shortdesc: fake bomb effect idozitofuggvenye
desc: Fake bomb generalo fuggveny idozitoje, amely tenylegesen generalja az effekteket
tmethis: table, a luaFakeMG fv altal atdott valtozok
]]
function luaFakeBombingTimer(timerthis)
	SETLOG(timerthis, false)
-- RELEASE_LOGOFF  	luaHelperLog("Generating fake bomb explosion...")
-- RELEASE_LOGOFF  	luaHelperLog(" Position: ")
-- RELEASE_LOGOFF  	luaHelperLog(timerthis.ParamTable.Pos)

	if timerthis.TimerFunctionNum == nil then
		timerthis.TimerFunctionNum = 1
	else
		timerthis.TimerFunctionNum = timerthis.TimerFunctionNum + 1
	end

-- RELEASE_LOGOFF  	luaHelperLog(" FunctionNum: "..timerthis.TimerFunctionNum)

--	for key, value in pairs(timerthis.ParamTable.Pos) do
-- RELEASE_LOGOFF  --		luaHelperLog("TESZTPOS: key - "..key..", value: "..tostring(value))
--	end

	luaHelperLog("  Pos to function num: ")
-- RELEASE_LOGOFF  	luaHelperLog(timerthis.ParamTable.Pos[timerthis.TimerFunctionNum])

	for key, value in pairs(timerthis.ParamTable.Pos[timerthis.TimerFunctionNum]) do
-- RELEASE_LOGOFF  		luaHelperLog("  > POS: ")
-- RELEASE_LOGOFF  		luaHelperLog(value)
		local land = IsLandscape(value)
		local ship = IsShip(value)

		-- only tmp test!
-- RELEASE_LOGOFF  		luaLog(" -+- FAKEBOMB EFFECT GEN")

		if not ship and not land then				-- water
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on water!")
			Effect("ImpactBigBombWater", value)
		elseif land then					-- landscape
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on landscape!")
			value.y = land
			Effect("ImpactBigGround", value)
		elseif ship then					-- ship
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on ship!")
			value.y = ship
			Effect("ExplosionBigShip", value)
		end
	end

--[[	OLD !!
	local pos = timerthis.ParamTable.Pos
	if pos.x == nil then
-- RELEASE_LOGOFF  		luaHelperLog(" Multiple coordinates!")
		for key, value in pairs(pos) do
			local land = IsLandscape(value)
			local ship = IsShip(value)

			if not ship and not land then				-- water
-- RELEASE_LOGOFF  				luaHelperLog("  Target is on water!")
				Effect("LargeBombExplosionWater", value)
			elseif land then					-- landscape
-- RELEASE_LOGOFF  				luaHelperLog("  Target is on landscape!")
				value.y = land
				Effect("LargeBombExplosionArmour", value)
			elseif ship then					-- ship
-- RELEASE_LOGOFF  				luaHelperLog("  Target is on ship!")
				value.y = ship
				Effect("LargeBombExplosionGround", value)
			end
		end
	else
		local land = IsLandscape(pos)
		local ship = IsShip(pos)

		if not ship and not land then				-- water
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on water!")
			Effect("LargeBombExplosionWater", pos)
		elseif land then					-- landscape
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on landscape!")
			pos.y = land
			Effect("LargeBombExplosionArmour", pos)
		elseif ship then					-- ship
-- RELEASE_LOGOFF  			luaHelperLog("  Target is on ship!")
			pos.y = ship
			Effect("LargeBombExplosionGround", pos)
		end
	end
]]
end

-- Message SENDING CHECKERS ---------------------------------------------------------------------

--[[AutoDoc
usage: luaCheckArrival(unit, func)
category: Mission
shortdesc: luaMessageSender fv inicializalo scriptje
desc: A luaMessageSender fv altal lekezelt uzenetek egyiket allitja be, kvazi proximity trigger
unit: table, a vizsgalt entitas
func: function, a feltetel teljesulese esten meghivott fv neve
]]
function luaCheckArrival(unit, func)
-- RELEASE_LOGOFF  	Assert(type(func) == "function", "***ERROR: luaCheckArrival needs a callback function to work properly!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "***ERROR: luaCheckArrival needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaCheckArrival called on unit "..unit.Name)

	if unit.MsgFunctions == nil then
		unit.MsgFunctions = {}
	end

	unit.MsgFunctions.Arrival = {}
		unit.MsgFunctions.Arrival.Function = func

	if MessageSender == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Creating MessageSender entity")
		MessageSender = CreateScript("luaInitMessageSender")
	end

	table.insert(MessageSender.Arrivals, unit)
end

--[[AutoDoc
usage: luaClearCheckArrival(unit)
category: Mission
shortdesc: luaCheckArrival atlal bejegyzett valtozokat torli
desc: Nem vizsgal tovabb 'unit'-ra luaCheckArrival bealitott valtozokat, a MesageSender.Arrivals tablabol torli a unit-ot
unit: table, a vizsgalt entitas
]]
function luaClearCheckArrival(unit)
-- RELEASE_LOGOFF  	Assert(unit ~= nil and unit.Name ~= nil, "***ERROR: luaClearCheckArrival needs an entity as param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Clearing arrival check on unit "..unit.Name)
	luaRemoveByName(MessageSender.Arrivals, unit.Name)
	unit.MsgFunctions.Arrival = nil
end

--[[AutoDoc
usage: luaCheckDeath(unit, func)
category: Mission
shortdesc: luaMessageSender fv inicializalo scriptje
desc: A luaMessageSender fv altal lekezelt uzenetek egyiket allitja be, kvazi death trigger
unit: table, a vizsgalt entitas
func: function, a feltetel teljesulese esten meghivott fv neve
]]
function luaCheckDeath(unit, func)
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "***ERROR: luaCheckDeath needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(func) == "function", "***ERROR: luaCheckDeath needs a callback function to work properly!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("luaCheckDeath called on unit "..unit.Name)

	if unit.MsgFunctions == nil then
		unit.MsgFunctions = {}
	end

	unit.MsgFunctions.Death = {}
		unit.MsgFunctions.Death.Function = func

	if MessageSender == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Creating MessageSender entity")
		MessageSender = CreateScript("luaInitMessageSender")
--		luaDelay(luaInsertToMessageSender, 4, "unit", unit, "Type", "Diers")
--	else
-- RELEASE_LOGOFF  --		luaHelperLog("MessageSender already exists, inserting unit")
--		table.insert(MessageSender.Diers, unit)
	end

	table.insert(MessageSender.Diers, unit)
end

--[[AutoDoc
usage: luaClearCheckDeath(unit)
category: Mission
shortdesc: luaCheckArrival atlal bejegyzett valtozokat torli
desc: Nem vizsgal tovabb 'unit'-ra luaCheckDeath bealitott valtozokat, a MesageSender.Death tablabol torli a unit-ot
unit: table, a vizsgalt entitas
]]
function luaClearCheckDeath(unit)
-- RELEASE_LOGOFF  	Assert(unit ~= nil and unit.Name ~= nil, "***ERROR: luaClearCheckDeath needs an entity as param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Clearing death check on unit "..unit.Name)
	luaRemoveByName(MessageSender.Death, unit.Name)
	unit.MsgFunctions.Death = nil
end

--[[AutoDoc
usage: luaCheckAmmo(unit, func [,ammotype])
category: Mission
shortdesc: luaMessageSender fv inicializalo scriptje
desc: A luaMessageSender fv altal lekezelt uzenetek egyiket allitja be, kvazi ammochange trigger
unit: table, a vizsgalt entitas
func: function, a feltetel teljesulese esten meghivott fv neve
ammotype: enum, a vizsgalt ammo tipusa(AMMO_DEPTHCHARGE, AMMO_TORPEDO, AMMO_NONE)
]]
function luaCheckAmmo(unit, func,  ammotype)
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "***ERROR: luaCheckAmmo needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(func) == "function", "***ERROR: luaCheckAmmo needs a callback function as third param to work properly!"..debug.traceback())
	--Assert(ammotype == AMMO_DEPTHCHARGE or ammotype == AMMO_BOMB or ammotype == AMMO_TORPEDO or ammotype == AMMO_NONE, "***ERROR: luaCheckPlaneAmmo needs an ammo as second param!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("luaCheckAmmo called on unit "..unit.Name)

	if unit.MsgFunctions == nil then
		unit.MsgFunctions = {}
	end

	unit.MsgFunctions.AmmoCheck = {}
		unit.MsgFunctions.AmmoCheck.Function = func

	if ammotype == nil then
		if luaGetType(unit) == "plane" then
			unit.MsgFunctions.AmmoCheck.AmmoToCheck = AMMO_NONE
		else
			unit.MsgFunctions.AmmoCheck.AmmoToCheck = 0
		end
	else
		unit.MsgFunctions.AmmoCheck.AmmoToCheck = ammotype
	end

	if MessageSender == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Creating MessageSender entity")
		MessageSender = CreateScript("luaInitMessageSender")
--		luaDelay(luaInsertToMessageSender, 4, "unit", unit, "Type", "AmmoCheckers")
--	else
-- RELEASE_LOGOFF  --		luaHelperLog("MessageSender already exists, inserting unit")
--		table.insert(MessageSender.AmmoCheckers, unit)
	end

	table.insert(MessageSender.AmmoCheckers, unit)
end

--[[AutoDoc
usage: luaClearCheckAmmo(unit)
category: Mission
shortdesc: luaCheckAmmo atlal bejegyzett valtozokat torli
desc: Nem vizsgal tovabb 'unit'-ra luaCheckAmmo bealitott valtozokat, a MesageSender.AmmoCheck tablabol torli a unit-ot
unit: table, a vizsgalt entitas
]]
function luaClearCheckAmmo(unit)
-- RELEASE_LOGOFF  	Assert(unit ~= nil and unit.Name ~= nil, "***ERROR: luaClearCheckAmmo needs an entity as param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Clearing ammo check on unit "..unit.Name)

	if unit.MsgFunctions.AmmoCheck == nil then
-- RELEASE_LOGOFF  		luaHelperLog("There is no ammo check on unit!")
		return
	end

	luaRemoveByName(MessageSender.AmmoCheckers, unit.Name)
	unit.MsgFunctions.AmmoCheck = nil
end

--[[AutoDoc
usage: luaCheckDistance(unit, targetUnit, distance, func)
category: Mission
shortdesc: luaMessageSender fv inicializalo scriptje
desc: A luaMessageSender fv altal lekezelt uzenetek egyiket allitja be, kvazi distance trigger
unit: table, a vizsgalt entitas
targetunit: table, 'unit'hoz kepest vizsgalt masik entitas
distance: number, a vizsgalt tavolsag
func: function, a feltetel teljesulese esten meghivott fv neve
]]
function luaCheckDistance(unit, targetUnit, distance, func)
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "***ERROR: luaCheckDistance needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(targetUnit ~= nil, "***ERROR: luaCheckDistance needs a target (entity/coordinate) as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(distance ~= nil, "***ERROR: luaCheckDistance needs a distance as third param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(func) == "function", "***ERROR: luaCheckDistance needs a callback function as fourth param to work properly!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("luaCheckDistance called on unit "..unit.Name..", target: "..tostring(targetUnit)..", distance: "..distance)

	if unit.MsgFunctions == nil then
		unit.MsgFunctions = {}
	end

	if unit.MsgFunctions.DistanceCheck == nil then
		unit.MsgFunctions.DistanceCheck = {}
	end

	local execTable = {}
		execTable.Target = targetUnit
		execTable.Distance = distance
		execTable.Function = func

	table.insert(unit.MsgFunctions.DistanceCheck, execTable)

-- RELEASE_LOGOFF  	-- too deep recursion LogToFile(" final unittable: ", unit.MsgFunctions.DistanceCheck)


	if MessageSender == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Creating MessageSender entity")
		MessageSender = CreateScript("luaInitMessageSender")
--		luaDelay(luaInsertToMessageSender, 4, "unit", unit, "Type", "DistanceCheckers")
--	else
-- RELEASE_LOGOFF  --		luaHelperLog("MessageSender already exists, inserting unit")
--		table.insert(MessageSender.DistanceCheckers, unit)
	end

	if not luaIsInside(unit, MessageSender.DistanceCheckers) then
		table.insert(MessageSender.DistanceCheckers, unit)
	end
end

--[[AutoDoc
usage: luaClearCheckDistance(unit, target)
category: Mission
shortdesc: luaCheckAmmo atlal bejegyzett valtozokat torli
desc: Nem vizsgal tovabb 'unit'-ra luaCheckDistance bealitott valtozokat, a MesageSender.Distance tablabol torli a unit-ot es a target-et
unit: table, a vizsgalt entitas
target: table, a 'unit'-hoz kepest vizsgalt entitas
]]
function luaClearCheckDistance(unit, target)
-- RELEASE_LOGOFF  	Assert(unit ~= nil and unit.Name ~= nil, "***ERROR: luaClearCheckDistance needs an entity as first param!"..debug.traceback())
	--Assert(target ~= nil, "***ERROR: luaClearCheckDistance needs an entity/coordinate as second param!"..debug.traceback())

	if target ~= nil then
		if not luaIsCoordinate(target) then
-- RELEASE_LOGOFF  			luaHelperLog("Clearing distance check on unit "..unit.Name..", and target: "..target.Name)
		else
-- RELEASE_LOGOFF  			LogToFile("Clearing distance check on unit ", unit.Name, ", and target: ", target)
		end

		if unit.MsgFunctions.DistanceCheck == nil then
-- RELEASE_LOGOFF  			luaHelperLog("unit doesn't have any distance check running!")
			return
		end

		local targetFound = false
		for key, value in pairs(unit.MsgFunctions.DistanceCheck) do
			if luaAreEqualTables(value.Target, target) then
-- RELEASE_LOGOFF  				luaHelperLog(" found target, clearing...")
				table.remove(unit.MsgFunctions.DistanceCheck, key)
				targetFound = true
				break
			end
		end
		if not targetFound then
-- RELEASE_LOGOFF  			luaHelperLog("Target not found!")
			return false
		end

		if next(unit.MsgFunctions.DistanceCheck) == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" All distancetarget removed, clearing from main table...")
			luaRemoveByName(MessageSender.DistanceCheckers, unit.Name)
			unit.MsgFunctions.DistanceCheck = nil
		else
-- RELEASE_LOGOFF  			luaHelperLog(unit.Name.." has other target(s) yet")
		end
	else
-- RELEASE_LOGOFF  		luaHelperLog("Removing all distance check from unit "..unit.Name)
		luaRemoveByName(MessageSender.DistanceCheckers..unit.Name)
		unit.MsgFunctions.DistanceCheck = nil
	end
end

--[[AutoDoc
usage: luaCheckRecon(unit, reconstate, func)
category: Mission
shortdesc: luaMessageSender fv inicializalo scriptje
desc: A luaMessageSender fv altal lekezelt uzenetek egyiket allitja be, kvazi reconchange trigger
unit: table, a vizsgalt entitas
reconstate: number, a vizsgalt recon level
func: function, a feltetel teljesulese esten meghivott fv neve
]]
function luaCheckRecon(unit, reconstate, func)
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "***ERROR: luaCheckRecon needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(reconstate >= 0 and reconstate <= 3, "***ERROR: luaCheckRecon needs a valid reconstate (0-3) as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(func) == "function", "***ERROR: luaCheckRecon needs a callback function as third param to work properly!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("luaCheckRecon called on unit "..unit.Name)

	if unit.MsgFunctions == nil then
		unit.MsgFunctions = {}
	end

	unit.MsgFunctions.ReconCheck = {}
		unit.MsgFunctions.ReconCheck.Function = func
		unit.MsgFunctions.ReconCheck.ReconState = reconstate

	if MessageSender == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Creating MessageSender entity")
		MessageSender = CreateScript("luaInitMessageSender")
	end

	table.insert(MessageSender.ReconCheckers, unit)
end

--[[AutoDoc
usage: luaClearCheckRecon(unit)
category: Mission
shortdesc: luaCheckRecon atlal bejegyzett valtozokat torli
desc: Nem vizsgal tovabb 'unit'-ra luaCheckRecon bealitott valtozokat, a MesageSender.ReconChekers tablabol torli a unit-ot
unit: table, a vizsgalt entitas
]]
function luaClearCheckRecon(unit)
-- RELEASE_LOGOFF  	Assert(unit ~= nil and unit.Name ~= nil, "***ERROR: luaClearCheckRecon needs an entity as param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Clearing reconcheck on unit "..unit.Name)
	luaRemoveByName(MessageSender.ReconCheckers, unit.Name)
	if unit.MsgFunctions ~= nil then
		unit.MsgFunctions.ReconCheck = nil
	else
-- RELEASE_LOGOFF  		luaHelperLog("***WARNING: no MsgFunction at unit!")
	end
end

--[[AutoDoc
usage: luaCheckExit(unit, func)
category: Mission
shortdesc: luaMessageSender fv inicializalo scriptje
desc: A luaMessageSender fv altal lekezelt uzenetek egyiket allitja be, kvazi exit trigger
unit: table, a vizsgalt entitas
func: function, a feltetel teljesulese esten meghivott fv neve
]]
function luaCheckExit(unit, func)
-- RELEASE_LOGOFF  	Assert(unit ~= nil, "***ERROR: luaCheckExit needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(func) == "function", "***ERROR: luaCheckExit needs a callback function as second param to work properly!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("luaCheckExit called on unit "..unit.Name)

	if unit.MsgFunctions == nil then
		unit.MsgFunctions = {}
	end

	if unit.MsgFunctions.ExitCheck == nil then
		unit.MsgFunctions.ExitCheck = {}
		unit.MsgFunctions.ExitCheck.Function = func
	end

	if MessageSender == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Creating MessageSender entity")
		MessageSender = CreateScript("luaInitMessageSender")
	end

	table.insert(MessageSender.Exiters, unit)
end

--[[AutoDoc
usage: luaClearCheckExit(unit)
category: Mission
shortdesc: luaCheckExit atlal bejegyzett valtozokat torli
desc: Nem vizsgal tovabb 'unit'-ra luaCheckExit bealitott valtozokat, a MesageSender.Exiters tablabol torli a unit-ot
unit: table, a vizsgalt entitas
]]
function luaClearCheckExit(unit)
-- RELEASE_LOGOFF  	Assert(unit ~= nil and unit.Name ~= nil, "***ERROR: luaClearCheckExit needs an entity as param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Clearing exit check on unit: "..unit.Name)

	luaRemoveByName(MessageSender.Exiters, unit.Name)
	unit.MsgFunctions.ExitCheck = nil
end
---------------------------------------------- KK-k ---------------------------------------------
--[[
memoriafoglalas miatt kiveve
-- reconsaver
function luaTCReconSaver(this)
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaHelperLog("luaTCReconSaver is initiated.")

	local selected = GetSelectedUnit()
-- RELEASE_LOGOFF  	luaHelperLog("Currently selected unit: "..selected.Name)
-- RELEASE_LOGOFF  	luaHelperLog(" its party: "..selected.Party)
	this.Party = SetParty(this, selected.Party)
	this.Carriers = {}
	this.SpawnTimeLimit = 120	-- az ido, ami leteltekor ujrahivodnak a fighterek
	this.SpawnTime = 0
	this.DistanceLimit = 13000	-- az a tavolsag a repulok es anyahajok kozott, amin tul bespawnolunk enemyt.
	this.Interceptors = {}		-- azok a gepek, amiket bespawnolunk elfogasra
	for key, value in pairs(recon[this.Party].own.mothership) do
-- RELEASE_LOGOFF  		luaHelperLog("Own carrier found: "..value.Name)
		table.insert(this.Carriers, value)
	end

	if table.getn(this.Carriers) == 0 then
-- RELEASE_LOGOFF  		luaHelperLog("++ No own carrier found, deleting ReconSaver ++")
		DeleteScript(this)
		return
	end

	SetThink(this, "luaTCReconSaver_think")
end

function luaTCReconSaver_think(this, msg)
-- RELEASE_LOGOFF  	luaHelperLog("luaTCReconSaver is running.")
-- RELEASE_LOGOFF  	luaHelperLog(" Time since last spawned fighter: "..GameTime()-this.SpawnTime)

	if msg ~= nil and msg.Message == MSG_KILLED then
-- RELEASE_LOGOFF  		luaHelperLog("ReconSaver killed")
		return
	end

	this.Carriers = luaRemoveDeadsFromTable(this.Carriers, " carrier sunk: ")
	if table.getn(this.Carriers) == 0 then
-- RELEASE_LOGOFF  		luaHelperLog("++ No own carrier found, deleting ReconSaver ++")
		DeleteScript(this)
		return
	end

	for key, value in pairs(this.Interceptors) do
		if value.Dead then
-- RELEASE_LOGOFF  			luaHelperLog(value.Name.." interceptor shot down (ID: "..value.ID..") deleting attacked flag from "..value.Target.Name)
			value.Target.attacked = false
		end
		if value.Target.Dead and not value.Dead then
-- RELEASE_LOGOFF  			luaHelperLog(value.Name.."(ID: ", value.ID, ") interceptor's target is shot down, leaving area")
			local trg = {}
				trg.x = -2000000
				trg.y = 1000
				trg.z = 0
			PilotMoveToRange(value, trg, 2000)	-- most vmi kurva messzi pont
		end
	end
	this.Interceptors = luaRemoveDeadsFromTable(this.Interceptors, " Dead interceptor: ")

	this.Planes = {}
	for key, unittype in pairs(recon[this.Party].own) do
		for key2, unit in pairs(unittype) do
-- RELEASE_LOGOFF  			luaHelperLog("Checking "..unit.Name.." type: "..key)
			if (key == "fighter" or key == "divebomber" or key == "torpedobomber" or key == "levelbomber" or key == "reconplane") and not unit.Dead then
-- RELEASE_LOGOFF  				luaHelperLog(" Plane found, inserting...")
				table.insert(this.Planes, unit)
			else
-- RELEASE_LOGOFF  				luaHelperLog(" Unit is not a plane (or a dead plane), neglecting.")
			end
		end

	end

	if table.getn(this.Planes) ~= 0 then
		for key, plane in pairs(this.Planes) do
-- RELEASE_LOGOFF  			luaHelperLog("Checking distance of "..plane.Name.." from carriers...")
			local dist, mindist
			for key2, carrier in pairs(this.Carriers) do
				dist = luaGetDistance(carrier, plane)
				if key2 == 1 then
					mindist = dist
				else
					if dist < mindist then
						mindist = dist
					end
				end
-- RELEASE_LOGOFF  				luaHelperLog(" distance from "..carrier.Name.." is "..dist.." m.")
			end
-- RELEASE_LOGOFF  			luaHelperLog(" Minimal distance from carriers: "..mindist.." m")
			if mindist > this.DistanceLimit and GameTime() - this.SpawnTime > this.SpawnTimeLimit then
				if plane.attacked == nil then
-- RELEASE_LOGOFF  					luaHelperLog("  plane is too far, spawning enemy fighters. (Limit was "..this.DistanceLimit.." m)")
					-- spawn
					local spawned
					this.SpawnTime = GameTime()
					if this.Party == PARTY_ALLIED then
						spawned = Spawn("Zero", ST_ABSANGLE, plane, 3500, 4000, 300, 0, 360)
					else
						spawned = Spawn("Wildcat", ST_ABSANGLE, plane, 3500, 4000, 300, 0, 360)
					end

					if plane.Class.Type ~= "ReconPlane" then
-- RELEASE_LOGOFF  						luaHelperLog("   Target is not a reconplane, attacking")
						PilotGunFire(spawned, plane)
						spawned.Target = plane
						table.insert(this.Interceptors, spawned)
					else
-- RELEASE_LOGOFF  						luaHelperLog("   Target is a reconplane, leaving area")
						local trg = {}
							trg.x = -2000000
							trg.y = 1000
							trg.z = 0
						PilotMoveToRange(spawned, trg, 2000)	-- most vmi kurva messzi pont
					end
					plane.attacked = true
				else
-- RELEASE_LOGOFF  					luaHelperLog("  already allocated enemy on it, neglecting.")
				end
			end
		end
	else
-- RELEASE_LOGOFF  		luaHelperLog("No plane in air...")
	end

end
]]

--[[
-- Airstrike egy squadnak
function luaAirstrikeManager(this, squad, home, targettype)
	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaHelperLog("--Airstrike manager is initiated with "..squad.Name)

	this.Party = SetParty(this, squad.Party)

	this.TargetType = targettype
	this.Squad = squad
	this.Home = home
	SetThink(this, "luaAirstrikeManager_think")
end

function luaAirstrikeManager_think(this, msg)
	if msg ~= nil and msg.Message == MSG_KILLED then
-- RELEASE_LOGOFF  		luaHelperLog("-Airstrike manager killed-")
		return
	end

	if this.Squad.Dead then
-- RELEASE_LOGOFF  		luaHelperLog(" Squad "..this.Squad.Name.." has died. Exiting Airstrike.")
		DeleteScript(this)
		return
	end

	this.Squad.unitcommand = GetProperty(this.Squad, "unitcommand")
	this.Squad.ammo = GetProperty(this.Squad, "ammoType")
	this.Squad.state = GetProperty(this.Squad, "state")
-- RELEASE_LOGOFF  	luaHelperLog(this.Squad.Name.."'s state is: "..this.Squad.state..", phase: "..this.Squad.phase)
	--if this.Squad.state == 2 and this.Squad.phase == PHASE_IDLE then
	if this.Squad.state == 2 and this.Squad.unitcommand == COMMAND_HOLDPOS then
		local enemyToAttack

		if this.Party == PARTY_JAPANESE then
			enemyToAttack = luaPickRnd(recon[PARTY_ALLIED].own[this.TargetType])
		elseif this.Party == PARTY_ALLIED then
			enemyToAttack = luaPickRnd(recon[PARTY_JAPANESE].own[this.TargetType])
		end

		if enemyToAttack == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" No enemy found for the criteria. Waiting...")
			return
		end

-- RELEASE_LOGOFF  		luaHelperLog(" Squad "..this.Squad.Name.." is attacking "..enemyToAttack.Name)

		if this.Squad.ammo == 1 then
			PilotBomb(this.Squad, enemyToAttack)
		elseif this.Squad.ammo == 2 then
			PilotTorpedo(this.Squad, enemyToAttack)
		end
	end

	if this.Squad.ammo == 0 and this.Squad.unitcommand ~= COMMAND_LAND and not this.Leaving then
-- RELEASE_LOGOFF  		luaHelperLog(" Squad "..this.Squad.Name.." is going home to land.")
		if not this.Home.Dead then
			PilotLand(this.Squad, this.Home)
		else
-- RELEASE_LOGOFF  			luaHelperLog("  Own carrier sunk, choosing another.")
			for key, value in pairs(recon[this.Party].own.mothership) do
				if not value.Dead then
					PilotLand(this.Squad, value)
					break
				end
			end

-- RELEASE_LOGOFF  			luaHelperLog("   no carrier found on own side, leaving scene.")
			local trg = {}
				trg.x = -35000
				trg.y = 2000
				trg.z = -35000
			PilotMoveToRange(this, trg)
			this.Leaving = true
		end
	end

	if this.Squad.unitcommand == COMMAND_LAND and this.Squad.state == 1 then
-- RELEASE_LOGOFF  		luaHelperLog(" Squad "..this.Squad.Name.." returned home and landing is ongoing. Terminating Airstrike manager.")
		DeleteScript(this)
	end
end
]]

--------------------------------------------------------------------------------------------------------

--[[AutoDoc
usage: luaDelay(timedFunction, timerTime, ...)
category: Mission
shortdesc: kesleltetett fv hivas
desc: Kesleltetve meghivja a 'timedFunction'-t, 'timerTime' masodperccel, a timerTable-ben megadott parameterekkel
timedFunction: function, a kesleltetett fv
timerTime: number, a kesleltetes ideje masodpercben
]]
function luaDelay(timedFunction, timerTime, ...)
	if timerTime < 0.5 then
-- RELEASE_LOGOFF  		luaLog("***Warning: luaDelay second parameter is less than 0.5!")
	end
	--luaHelperLog("Delay function called with "..tostring(timedFunction).." in "..tostring(timerTime).." secs.")

	local paramTable
		paramTable = {}

	-- ha van parameter, akkor feltankoljuk
	--luaHelperLog(" params: "..table.getn(arg))
	if table.getn(arg) > 0 then
		--luaLog(" Number of params given: "..table.getn(arg))
		local paramname = true

		for key, value in pairs(arg) do

			if key ~= "n" then
				if paramname then
					--luaLog("  Would-be key: "..tostring(value))
					paramname = false
				else
					--luaLog("  Loading up value: "..tostring(value))
					paramTable[arg[key-1]] = value
					paramname = true
				end
			end
		end
		--LogToFile(" Final paramTable: ", paramTable)
	end

	local timer =
	{
		{
			[1] = false,
			[2] = timerTime
		},
		{
			[1] = timedFunction,
			[2] = 0
		}
	}
	return CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaClearDelay(timerEnt)
category: Mission
shortdesc: kesleltetett fv hivas torlese
desc: A luaDelay altal letrehozott script entitast torli, megszuntetve ezzel a kesleltett fv hivast
timerEnt: table, script entity, a luaDelay hozza letre
]]
function luaClearDelay(timerEnt)
-- RELEASE_LOGOFF  	Assert( type(timerEnt) == "table", "***ERROR: luaClearDelay needs a timer entity as param!"..debug.traceback())
	if not timerEnt.Dead then
		ClearThink(timerEnt)
		DeleteScript(timerEnt)
	else
-- RELEASE_LOGOFF  		luaLog("Timer ID"..timerEnt.ID.." to clear is already dead.")
	end
end

--[[AutoDoc
usage: luaDelaySet(variable, vvalue, delaytime)
category: Mission
shortdesc: Mission-valtozok idozitett beallitasa
desc: A 'variable' valtozo erteket beallitja 'vvalue'-ra, 'delaytime' masodperc mulva
variable: string, a vizsgalt valtozo neve (this. es Mission. nelkul) -> string
vvalue: mixed, a 'variable' valtozo ezt az erteket fogja felvenni
delaytime: number, ennyi sec mulva tortenik a valtozas
]]
function luaDelaySet(variable, vvalue, delaytime)
	luaHelperLog("DelaySet function called with "..variable.." to set "..tostring(vvalue).." in "..delaytime.." secs.")

	local paramTable = {}
		table.insert(paramTable, variable)
		table.insert(paramTable, vvalue)

	local timer =
	{
		{
			[1] = false,
			[2] = delaytime
		},
		{
			[1] = luaDelaySetTimer,
			[2] = 0
		}
	}


	return CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaDelaySetTimer(timerthis)
category: Mission
shortdesc: a luaDelaySet timer fv-e
desc: a luaDelaySetben meghatarozott valtozasokat ez a fv hajtja vegre
timerthis: table, a luaDelaySetben atadott valtozok, parameterek osszessege
]]
function luaDelaySetTimer(timerthis)
	Mission[timerthis.ParamTable[1]] = timerthis.ParamTable[2]
end

------------------------ OBJECTIVES -------------------------
--[[AutoDoc
usage: luaObj_Add(level, num  [,trg] [,quiet])
category: Objectives
shortdesc: objektiva hozzaadasa
desc: egy a initben meghatarozott tablaban levo objektivat aktivva tesz
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
trg: table, entitas,koordinata, ha megadjuk erre az entityre, koordinatara kerul az objektiva marker
quiet: bool, csnedes uzemmod, nem kap warningot az uj objektivarol a jatekos
]]
function luaObj_Add(level, num, trg, quiet)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_Add needs a level and an objective number as param!"..debug.traceback())

	if luaObj_IsActive(level, num) then
-- RELEASE_LOGOFF  		luaHelperLog("Objective "..level..num.." is already added...")
		return
	end

	if not Mission.LuaObjLog then
		Mission.LuaObjLog = true
-- RELEASE_LOGOFF  		luaDoCustomLog("Objectives.log", "Objective added: "..level.." "..tostring(num), "u")
	else
-- RELEASE_LOGOFF  		luaDoCustomLog("Objectives.log", "Objective added: "..level.." "..tostring(num))
	end

-- RELEASE_LOGOFF  	luaHelperLog("Objective is being added: "..level..num)

	local obj = Mission.Objectives[level][num]

	if trg == nil then
		if obj.Party ~= nil and obj.PlayerIndex == nil then
			if quiet then
				Objectives_Add(obj.Party, nil, obj.ID, obj.Text, level, true)
			else
				Objectives_Add(obj.Party, nil, obj.ID, obj.Text, level)
			end
		elseif obj.Party ~= nil and obj.PlayerIndex ~= nil then
			if quiet then
				Objectives_Add(nil, obj.PlayerIndex, obj.ID, obj.Text, level, true)
			else
				Objectives_Add(nil, obj.PlayerIndex, obj.ID, obj.Text, level)
			end
		else
			if quiet then
				Objectives_Add(Mission.Party, nil, obj.ID, obj.Text, level, true)
			else
				Objectives_Add(Mission.Party, nil, obj.ID, obj.Text, level)
			end
		end
		obj.Active = true
	else
		if obj.Party ~= nil and obj.PlayerIndex == nil then
			if quiet then
				Objectives_Add(obj.Party, nil, obj.ID, obj.Text, level, true, trg)
			else
				Objectives_Add(obj.Party, nil, obj.ID, obj.Text, level, trg)
			end
		elseif obj.Party ~= nil and obj.PlayerIndex ~= nil then
			if quiet then
				Objectives_Add(nil, obj.PlayerIndex, obj.ID, obj.Text, level, true, trg)
			else
				Objectives_Add(nil, obj.PlayerIndex, obj.ID, obj.Text, level, trg)
			end
		else
			if quiet then
				Objectives_Add(Mission.Party, nil, obj.ID, obj.Text, level, true, trg)
			else
				Objectives_Add(Mission.Party, nil, obj.ID, obj.Text, level, trg)
			end
		end
		if luaIsEntityOrCoordinateTable({trg}) then
			table.insert(obj.Target, trg)
		elseif luaIsEntityOrCoordinateTable(trg) then
			for key, value in pairs (trg) do
				table.insert(obj.Target, value)
			end
		end
		obj.Active = true
	end

	if Mission.Multiplayer then
		Objectives_ClientRefresh()
	end
end


--[[AutoDoc
usage: luaObj_AddUnit(level, num, target)
category: Objectives
shortdesc: Meglevo objektivahoz rendeli a megadott unit-ot
desc: egy a luaObjAdd fv-nyel aktivalt objektivahoz rendel egy celpontot
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
target: table, entitas,koordinata, ha megadjuk erre az entityre, koordinatara kerul az objektiva marker
]]
function luaObj_AddUnit(level, num, target)
-- RELEASE_LOGOFF  	Assert(level == "primary" or level == "secondary" or level == "hidden" or level == "marker1" or level == "marker2" or level == "marker3", "ERROR: luaObj_AddUnit's first param must be primary/secondary/hidden/marker!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(num) == "number", "ERROR: luaObj_AddUnit's 2nd param must be a number!"..debug.traceback())

	if target.Name ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Adding unit "..target.Name.."to objective: "..level..num)
	end

	local obj = Mission.Objectives[level][num]

	if obj.Party ~= nil and obj.PlayerIndex == nil then
		Objectives_AddUnit(obj.Party, nil, obj.ID, target)
	elseif obj.Party ~= nil and obj.PlayerIndex ~= nil then
		Objectives_AddUnit(nil, obj.PlayerIndex, obj.ID, target)
	else
		Objectives_AddUnit(Mission.Party, nil, obj.ID, target)
	end
	table.insert(obj.Target, target)
end

--[[AutoDoc
usage: luaObj_RemoveUnit(level, num, target)
category: Objectives
shortdesc: Meglevo objektivabol kiveszi a megadott unit-ot
desc: egy a luaObjAddUnit vagy luaObjAdd fv-nyel aktiv objektivahoz rendelt celpontot torol
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
target: table, entitas,koordinata, ha megadjuk erre az entityre, koordinatara kerul az objektiva marker
]]
function luaObj_RemoveUnit(level, num, target)
-- RELEASE_LOGOFF  	Assert(level == "primary" or level == "secondary" or level == "hidden" or level == "marker1" or level == "marker2" or level == "marker3", "ERROR: luaObj_RemoveUnit's first param must be primary/secondary/hidden!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(num) == "number", "ERROR: luaObj_AddUnit's 2nd param must be a number!"..debug.traceback())

	if target.Name ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Removing unit "..target.Name.." from objective: "..level..num)
	end

	local obj = Mission.Objectives[level][num]

	if obj.Party ~= nil and obj.PlayerIndex == nil then
		Objectives_RemoveUnit(obj.Party, nil, obj.ID, target)
	elseif obj.Party ~= nil and obj.PlayerIndex ~= nil then
		Objectives_RemoveUnit(nil, obj.PlayerIndex, obj.ID, target)
	else
		Objectives_RemoveUnit(Mission.Party, nil, obj.ID, target)
	end

	local idx = luaIsInside(target, obj.Target)

-- RELEASE_LOGOFF  	luaHelperLog(" > targettable before: ")
-- RELEASE_LOGOFF  	luaHelperLog(obj.Target)
-- RELEASE_LOGOFF  	luaHelperLog(" > index of removable unit in targettable: "..tostring(idx))

	if idx then
-- RELEASE_LOGOFF  		luaHelperLog(" > element found at index \""..tostring(idx).."\", removing")
		table.remove(obj.Target, idx)
	end

-- RELEASE_LOGOFF  	luaHelperLog(" > targettable after: ")
-- RELEASE_LOGOFF  	luaHelperLog(obj.Target)
end

--[[AutoDoc
usage: luaObj_Completed(level, num[, setMusic, quiet])
category: Objectives
shortdesc: egy aktiv objektivat complete statuszra tesz
desc: egy aktiv objektivahoz completed statuszt rendel es opcionlaisan befadeli a MinorVictory zenet
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
setMusic: bool, true eseten lejatszodik a MinorVictory zene
quiet: boot, true eseten nem jatszodik le hang effect
]]
function luaObj_Completed(level, num, setMusic, quiet)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_Completed needs a level and an objective number as param!"..debug.traceback())

	if not luaObj_IsActive(level, num) or luaObj_GetSuccess(level, num) ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Obj_Completed called but objective is not added or finished/failed yet.")
		return
	end

	if not Mission.LuaObjLog then
		Mission.LuaObjLog = true
-- RELEASE_LOGOFF  		luaDoCustomLog("Objectives.log", "+ Objective completed: "..level.." "..tostring(num), "u")
	else
-- RELEASE_LOGOFF  		luaDoCustomLog("Objectives.log", "+ Objective completed: "..level.." "..tostring(num))
	end

	local obj = Mission.Objectives[level][num]
-- RELEASE_LOGOFF  	luaHelperLog("Completing objective : "..obj.ID)
	if obj.Party ~= nil and obj.PlayerIndex == nil then
		Objectives_Completed(obj.Party, nil, obj.ID, obj.TextCompleted, quiet)
	elseif obj.Party ~= nil and obj.PlayerIndex ~= nil then
		Objectives_Completed(nil, obj.PlayerIndex, obj.ID, obj.TextCompleted, quiet)
	else
		Objectives_Completed(Mission.Party, nil, obj.ID, obj.TextCompleted, quiet)
	end
	--obj.Active = false
	obj.Success = true

	if setMusic then
		luaCheckMusic(nil, nil, "MinorVictory")
	end

	if Mission.Multiplayer then
		Objectives_ClientRefresh()
	end
end

--[[AutoDoc
usage: luaObj_Failed(level, num[, setMusic, quiet])
category: Objectives
shortdesc: egy aktiv objektivat failed statuszra tesz
desc: egy aktiv objektivahoz failed statuszt rendel es opcionlaisan befadeli a MinorDefeat zenet
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
setMusic: bool, true eseten lejatszodik a MinorDefeat zene
quiet: boot, true eseten nem jatszodik le hang effect
]]
function luaObj_Failed(level, num, setMusic, quiet)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_Failed needs a level and an objective number as param!"..debug.traceback())

	if not luaObj_IsActive(level, num) or luaObj_GetSuccess(level, num) ~= nil then
-- RELEASE_LOGOFF  		luaHelperLog("Obj_Failed called but objective is not added or finished/failed yet.")
		return
	end

	if not Mission.LuaObjLog then
		Mission.LuaObjLog = true
-- RELEASE_LOGOFF  		luaDoCustomLog("Objectives.log", "- Objective failed: "..level.." "..tostring(num), "u")
	else
-- RELEASE_LOGOFF  		luaDoCustomLog("Objectives.log", "- Objective failed: "..level.." "..tostring(num))
	end

	local obj = Mission.Objectives[level][num]
-- RELEASE_LOGOFF  	luaHelperLog("Failed objective : "..obj.ID)
	if obj.Party ~= nil and obj.PlayerIndex == nil then
		Objectives_Failed(obj.Party, nil, obj.ID, obj.TextFailed, quiet)
	elseif obj.Party ~= nil and obj.PlayerIndex ~= nil then
		Objectives_Failed(nil, obj.PlayerIndex, obj.ID, obj.TextFailed, quiet)
	else
		Objectives_Failed(Mission.Party, nil, obj.ID, obj.TextFailed, quiet)
	end
	obj.Success = false
	--obj.Active = false

	if setMusic then
		luaCheckMusic(nil, nil, "MinorDefeat")
	end

	if Mission.Multiplayer then
		Objectives_ClientRefresh()
	end
end

--[[AutoDoc
usage: active = luaObj_IsActive(level, num)
category: Objectives
shortdesc: visszaasja h adott objektiva aktiv e
desc: megatott objektiva .Active statuszat
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
active: bool, true, ha az objektiva aktiv, false ha nem
]]
function luaObj_IsActive(level, num)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_IsActive needs a level and an objective number as param!"..debug.traceback())
	if Mission.Objectives[level][num].Active then
		return true
	else
		return false
	end
end

--[[AutoDoc
usage: success = luaObj_GetSuccess(level, num)
category: Objectives
shortdesc: visszaasja h adott objektiva befejezett e
desc: megatott objektiva .Success statuszat
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
success: true, ha az objektiva sikeresen teljesult, false ha elbukott es nil, ha meg nem zarult le sehogyan
]]
function luaObj_GetSuccess(level, num)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_GetSuccess needs a level and an objective number as param!"..debug.traceback())
	if Mission.Objectives[level][num].Success == nil then
-- RELEASE_LOGOFF  		luaHelperLog("Objective "..level..num.." has not been finished yet.")
		return nil
	elseif Mission.Objectives[level][num].Success then
-- RELEASE_LOGOFF  		luaHelperLog("Objective "..level..num.." is finished successfully.")
		return true
	elseif not Mission.Objectives[level][num].Success then
-- RELEASE_LOGOFF  		luaHelperLog("Objective "..level..num.." is failed.")
		return false
	end
end

--[[AutoDoc
usage: luaObj_FailedAll([active])
category: Objectives
shortdesc: az osszes objaktivat failed statuszra teszi
desc: vegigiteral az objektiva tablan es mindegyikhez failed statuszt rendel, 'active' eseten csak az aktiv objektivakat
active: bool, ha nem nil, akkor csak az aktiv objektivakat veszi figyelembe
]]
function luaObj_FailedAll(active)
	for priority, ptable in pairs (Mission.Objectives) do
		for num, obj in pairs (ptable) do
			if luaObj_GetSuccess(priority, num) == nil and (not active or (active and luaObj_IsActive(priority, num))) then
				if not active and not luaObj_IsActive(priority, num) then
-- RELEASE_LOGOFF  					luaHelperLog("Objective no given yet, adding to fail: "..priority.." "..num)
					luaObj_Add(priority, num, nil, true)
				end
-- RELEASE_LOGOFF  				luaHelperLog("Failing objective "..priority.." "..num)
				luaObj_Failed(priority, num, false, true)
			end
		end
	end

	if Mission.Multiplayer then
		Objectives_ClientRefresh()
	end
end

--[[AutoDoc
usage: luaObj_CompletedAll([active])
category: Objectives
shortdesc: az osszes objaktivat completed statuszra teszi
desc: vegigiteral az objektiva tablan es mindegyikhez completed statuszt rendel, 'active' eseten csak az aktiv objektivakat
active: bool, ha nem nil, akkor csak az aktiv objektivakat veszi figyelembe
]]
function luaObj_CompletedAll(active)
	for priority, ptable in pairs (Mission.Objectives) do
		for num, obj in pairs (ptable) do
			if luaObj_GetSuccess(priority, num) == nil and (not active or (active and luaObj_IsActive(priority, num))) then
				if not luaObj_IsActive(priority, num) and not active then
-- RELEASE_LOGOFF  					luaHelperLog("Objective not active yet, adding...")
					--luaObj_Add(priority, num)	-- quietben kell hozzaadni
					luaObj_Add(priority, num, nil, true)	-- quietben kell hozzaadni
				end
-- RELEASE_LOGOFF  				luaHelperLog("Completing objective "..priority.." "..num)
				luaObj_Completed(priority, num)
			end
		end
	end

	if Mission.Multiplayer then
		Objectives_ClientRefresh()
	end
end

--[[AutoDoc
usage: luaSurrender(surrendererParty)
category: Mission
shortdesc: az egyik fel feladasaval befejezi a missiont
desc: FIXME
surrendererParty: partyID (PARTY_ALLIED/PARTY_JAPANESE)
]]
function luaSurrender(surrendererParty)
-- RELEASE_LOGOFF  	luaLog("Surrender")
-- RELEASE_LOGOFF  	Assert(surrendererParty ~= nil and type(surrendererParty) == "number", "***ERROR: luaSurrender needs a PartyID as first param!"..debug.traceback())
	Mission.MissionEnd = true
	Mission.Surrender = true
	Mission.SurrendererParty = surrendererParty
	local winnerParty = (1 - surrendererParty)
-- RELEASE_LOGOFF  	luaLog("winnerParty: "..tostring(winnerParty))
	local active = true
	local firstWinnerUnit
	local firstLoserUnit
	local firstDeadLoserUnit

	if Mission.Multiplayer then
		if LobbySettings.GameMode ~= "globals.gamemode_competitive" then
			if surrendererParty == PARTY_ALLIED then
-- RELEASE_LOGOFF  				luaHelperLog("-- "..tostring(LobbySettings.GameMode).." playing Japanese victory voice-over --")
				for i = 1, 8 do
					local slotID = i - 1
					DisplayMessage(slotID, "scoremulti_japanese_win")
				end
			else
-- RELEASE_LOGOFF  				luaHelperLog("-- "..tostring(LobbySettings.GameMode).." playing Allied victory voice-over --")
				for i = 1, 8 do
					local slotID = i - 1
					DisplayMessage(slotID, "scoremulti_allies_win")
				end
			end
		end
	end

	if Mission.Multiplayer then
		if LobbySettings.Map == "mp08.name" then
			if winnerParty == PARTY_ALLIED then
				for i = 0, 3 do
					SetAchievements(i, "MA_FD")
				end
			else
				for i = 4, 7 do
					SetAchievements(i, "MA_FD")
				end
			end
		end
	end

	for priority, ptable in pairs (Mission.Objectives) do
		for num, obj in pairs (ptable) do
			if luaObj_GetSuccess(priority, num) == nil and (not active or (active and luaObj_IsActive(priority, num))) then
				if not luaObj_IsActive(priority, num) and not active then
-- RELEASE_LOGOFF  					luaLog("Objective not active yet, adding...")
					luaObj_Add(priority, num, nil, true)	-- quietben kell hozzaadni
				end
-- RELEASE_LOGOFF  				luaLog("obj.Party: "..tostring(obj.Party))
				if winnerParty == obj.Party then
-- RELEASE_LOGOFF  					luaLog("Completing objective "..priority.." "..num)
					luaObj_Completed(priority, num)
					if obj.Target and not firstWinnerUnit then
						for i, unit in pairs (obj.Target) do
							if unit.ID and unit.Party ~= nil and unit.Party == winnerParty and not unit.Dead then
								firstWinnerUnit = unit
-- RELEASE_LOGOFF  								luaLog("####firstWinnerUnit:")
-- RELEASE_LOGOFF  								luaLog(firstWinnerUnit)
								break
							end
						end
					end
				else
-- RELEASE_LOGOFF  					luaLog("Failing objective "..priority.." "..num)
					luaObj_Failed(priority, num)
					if obj.Target and not firstLoserUnit then
						for i, unit in pairs (obj.Target) do
							if unit.ID and unit.Party ~= nil and unit.Party ~= winnerParty and not unit.Dead then
								firstLoserUnit = unit
-- RELEASE_LOGOFF  								luaLog("####firstLoserUnit:")
-- RELEASE_LOGOFF  								luaLog(firstLoserUnit)
								break
							elseif unit.ID and unit.Party ~= nil and unit.Party ~= winnerParty then
								if not TrulyDead(unit) then
									firstDeadLoserUnit = unit
-- RELEASE_LOGOFF  									luaLog("####firstDeadLoserUnit:")
-- RELEASE_LOGOFF  									luaLog(firstDeadLoserUnit)
									break
								end
							end
						end
					end
				end
			end
		end
	end
	if firstLoserUnit then
		if not luaGetType(firstLoserUnit) == "plane" then
			SetDeadMeat(firstLoserUnit)
		end
		luaMissionCompletedNew(firstLoserUnit, "", nil, nil, nil, winnerParty)
	elseif firstDeadLoserUnit then
		luaMissionCompletedNew(firstDeadLoserUnit, "", nil, nil, nil, winnerParty)
	elseif firstWinnerUnit then
		luaMissionCompletedNew(firstWinnerUnit, "", nil, nil, nil, winnerParty)
	else
		if Mission.MultiplayerType == "Duel" and not Mission.InitDuelSurrender then
-- RELEASE_LOGOFF  			luaLog("Duel mode recognized...")
			Mission.InitDuelSurrender = true
			local alliedUnits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 40000, PARTY_ALLIED, "own")
			local japaneseUnits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 40000, PARTY_JAPANESE, "own")
			if alliedUnits ~= nil then
-- RELEASE_LOGOFF  				luaLog("Units in alliedUnits: "..table.getn(alliedUnits))
			else
-- RELEASE_LOGOFF  				luaLog("No Allied units found!")
			end
			if japaneseUnits ~= nil then
-- RELEASE_LOGOFF  				luaLog("Units in japaneseUnits: "..table.getn(japaneseUnits))
			else
-- RELEASE_LOGOFF  				luaLog("No Japanese units found!")
			end
			if winnerParty == PARTY_ALLIED then
				if alliedUnits ~= nil then
					luaMissionCompletedNew(luaPickRnd(alliedUnits), "", nil, nil, nil, winnerParty)
				elseif japaneseUnits ~= nil then
					luaMissionCompletedNew(luaPickRnd(japaneseUnits), "", nil, nil, nil, winnerParty)
				else
-- RELEASE_LOGOFF  					luaLog("Spawning a unit for mission complete!")
					local unitToShow = GenerateObject(Mission.USEndUnit.Name)
					luaMissionCompletedNew(unitToShow, "", nil, nil, nil, winnerParty)
				end
			elseif winnerParty == PARTY_JAPANESE then
				if japaneseUnits ~= nil then
					luaMissionCompletedNew(luaPickRnd(japaneseUnits), "", nil, nil, nil, winnerParty)
				elseif alliedUnits ~= nil then
					luaMissionCompletedNew(luaPickRnd(alliedUnits), "", nil, nil, nil, winnerParty)
				else
-- RELEASE_LOGOFF  					luaLog("Spawning a unit for mission complete!")
					local unitToShow = GenerateObject(Mission.JapEndUnit.Name)
					luaMissionCompletedNew(unitToShow, "", nil, nil, nil, winnerParty)
				end
			end
		else
			ForceRecon()
			local unitfound = false
			for key, unittype in pairs(recon[winnerParty]["own"]) do
-- RELEASE_LOGOFF  				luaLog(key)
				if key ~= "path" and key ~= "landvehicle" then
					for i, unit in pairs(unittype) do
						if not unit.Dead then
							luaMissionCompletedNew(unit, "", nil, nil, nil, winnerParty)
							break
						end
					end
				end
			end
			if not unitfound then
				for key, unittype in pairs(recon[surrendererParty]["own"]) do
-- RELEASE_LOGOFF  					luaLog(key)
					if key ~= "path" and key ~= "landvehicle" then
						for i, unit in pairs(unittype) do
							if not unit.Dead then
								luaMissionCompletedNew(unit, "", nil, nil, nil, winnerParty)
								break
							end
						end
					end
				end
			end
		end
	end
end

--[[AutoDoc
usage: luaObj_FillSingleScores()
category: Objectives
shortdesc: az objektivakhoz beallitja a scoreokat
desc: Az objektivakhoz beallitja a ScoreCompleted-eket a Mission.Objectives tablaban.
]]
function luaObj_FillSingleScores()
	if Mission.Objectives then
		local priscore, secscore, hidscore
		if Mission.Objectives["primary"] then
			local num = 0
			for x, y in pairs(Mission.Objectives["primary"]) do
				num = num + 1
			end
			priscore = OBJ_PRIMARY_SCORE
			if num > 0 then
				priscore = priscore / num
			end
		end
		if Mission.Objectives["secondary"] then
			local num = 0
			for x, y in pairs(Mission.Objectives["secondary"]) do
				num = num + 1
			end
			secscore = OBJ_SECONDARY_SCORE
			if num > 0 then
				secscore = secscore	/ num
			end
		end
		if Mission.Objectives["hidden"] then
			local num = 0
			for x, y in pairs(Mission.Objectives["hidden"]) do
				num = num + 1
			end
			hidscore = OBJ_HIDDEN_SCORE
			if num > 0 then
				hidscore = hidscore / num
			end
		end
		for idx, unit in pairs(Mission.Objectives) do
			for i, u in pairs(unit) do
				if idx == "primary" then
					u.ScoreCompleted = priscore
				elseif idx == "secondary" then
					u.ScoreCompleted = secscore
				elseif idx == "hidden" then
					u.ScoreCompleted = hidscore
				end
			end
		end
	else
-- RELEASE_LOGOFF  		luaDoCustomLog("ERROR: No objective table present!")
	end
end

--[[AutoDoc
usage: luaObj_DoScoring()
category: Objectives
shortdesc: az objektivak alapjan kiosztja a pontokat es a mission medalt
desc: vegigiteral az objektiva tablan es a .Success statuszuk alapjan kiosztja a missionscore-t es megallapitja h bronze, silver avagy gold medalt ert e el a jatekos
]]
function luaObj_DoScoring()
	luaSetMultiMessages(false, false, false)

	if Mission.Objectives == nil then
		return
	end

	if not Mission.Multiplayer then
-- RELEASE_LOGOFF  		luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Objective score log\n","u")
		for priority, ptable in pairs(Mission.Objectives) do
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Checking "..priority.." objectives...")
			for num, obj in pairs(ptable) do
				if luaObj_GetSuccess(priority, num) then
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
					Scoring_SetMissionScore(obj.ID, luaRound(obj.ScoreCompleted))
				else
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
					Scoring_SetMissionScore(obj.ID, luaRound(obj.ScoreFailed))
				end
			end
		end
	else
		if LobbySettings.GameMode == "globals.gamemode_competitive" then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- MODE: "..tostring(LobbySettings.GameMode).." ---","u")
			if Mission.PointLimit ~= 0 then
				local MPlayers = GetPlayerDetails()
				local actplayerscore = 0
				local objindex = 0
				local highestplayerscore = 0
				Mission.CompetitiveWinnerIndex = 0
				for slotID, value in pairs (MPlayers) do
					actplayerscore = Scoring_GetTotalMissionScore(slotID)
					objindex = slotID + 1
					if actplayerscore > highestplayerscore then
						highestplayerscore = actplayerscore
						Mission.CompetitiveWinnerIndex = slotID
					end
					if actplayerscore > 0 then
						Mission.Objectives.primary[objindex].ScoreFailed = ( Mission.Objectives.primary[objindex].ScoreCompleted / Mission.PointLimit ) * actplayerscore
					else
						Mission.Objectives.primary[objindex].ScoreFailed = 0
					end
					if Mission.Objectives.primary[objindex].ScoreFailed ~= 0 then
						Mission.Objectives.primary[objindex].ScoreFailed = luaRound(Mission.Objectives.primary[objindex].ScoreFailed)
					end
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..tostring(Mission.Objectives.primary[objindex].ID).." | objective.ScoreFailed: "..tostring(Mission.Objectives.primary[objindex].ScoreFailed))
				end
			else
-- RELEASE_LOGOFF  				luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  ERROR! Mission.PointLimit == 0! ")
			end
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- ---")
		elseif LobbySettings.GameMode == "globals.gamemode_duel" then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- MODE: "..tostring(LobbySettings.GameMode).." ---","u")
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if Mission.RoundLimit ~= 0 then
							if objective.Party == PARTY_ALLIED then
								objective.ScoreFailed = ( objective.ScoreCompleted / Mission.RoundLimit ) * Mission.AlliedRoundWon
							else
								objective.ScoreFailed = ( objective.ScoreCompleted / Mission.RoundLimit ) * Mission.JapaneseRoundWon
							end
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." | objective.ScoreFailed: "..tostring(objective.ScoreFailed))
						else
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  ERROR! Mission.RoundLimit == 0! ")
						end
					end
				end
			end
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- ---")
		elseif LobbySettings.GameMode == "globals.gamemode_escort" then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- MODE: "..tostring(LobbySettings.GameMode).." ---","u")
			local MPlayers = GetPlayerDetails()
			local usplayersscore = 0
			local japplayersscore = 0
			local allplayersscore = 0
			if GameTime() > 300 then
				for slotID, value in pairs (MPlayers) do
					if slotID <= 3 then
						if Scoring_GetTotalMissionScore(slotID) > 0 then
							usplayersscore = usplayersscore + Scoring_GetTotalMissionScore(slotID)
						end
					else
						if Scoring_GetTotalMissionScore(slotID) > 0 then
							japplayersscore = japplayersscore + Scoring_GetTotalMissionScore(slotID)
						end
					end
				end
			end
			allplayersscore = usplayersscore + japplayersscore
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if allplayersscore ~= 0 then
							if objective.Party == PARTY_ALLIED then
								objective.ScoreFailed = ( objective.ScoreCompleted / allplayersscore ) * usplayersscore
							else
								objective.ScoreFailed = ( objective.ScoreCompleted / allplayersscore ) * japplayersscore
							end
						else
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  ERROR! allplayersscore == 0 or GameTime() < 300! ")
						end
						if objective.ScoreFailed ~= 0 then
							objective.ScoreFailed = luaRound(objective.ScoreFailed)
						end
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." | objective.ScoreFailed: "..tostring(objective.ScoreFailed))
					end
				end
			end
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- ---")
		elseif LobbySettings.GameMode == "globals.gamemode_islandcapture" then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- MODE: "..tostring(LobbySettings.GameMode).." ---","u")
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if Mission.CapturePointLimit ~= 0 then
							if objective.Party == PARTY_ALLIED then
								if Mission.AlliedCapturePoints > Mission.CapturePointLimit then
									local points = Mission.CapturePointLimit - 1
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.CapturePointLimit ) * points
								else
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.CapturePointLimit ) * Mission.AlliedCapturePoints
								end
							else
								if Mission.JapaneseCapturePoints > Mission.CapturePointLimit then
									local points = Mission.CapturePointLimit - 1
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.CapturePointLimit ) * points
								else
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.CapturePointLimit ) * Mission.JapaneseCapturePoints
								end
							end
						elseif GameTime() > 300 then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " GameTime() > 300 ")
							if objective.Party == PARTY_ALLIED then
								objective.ScoreFailed = ( objective.ScoreCompleted / ( Mission.AlliedCapturePoints + Mission.JapaneseCapturePoints ) ) * Mission.AlliedCapturePoints
							else
								objective.ScoreFailed = ( objective.ScoreCompleted / ( Mission.AlliedCapturePoints + Mission.JapaneseCapturePoints ) ) * Mission.JapaneseCapturePoints
							end
						end
						if objective.ScoreFailed ~= 0 then
							objective.ScoreFailed = luaRound(objective.ScoreFailed)
						end
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." | objective.ScoreFailed: "..tostring(objective.ScoreFailed))
					end
				end
			end
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- ---")
		elseif LobbySettings.GameMode == "globals.gamemode_siege" then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- MODE: "..tostring(LobbySettings.GameMode).." ---","u")
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						local scoremultiplier = objective.ScoreCompleted / Mission.ResourcePoolBase
						if objective.Party == PARTY_ALLIED then
							objective.ScoreFailed = ( Mission.ResourcePoolBase - Mission.ResourceJapPool ) * scoremultiplier
						else
							objective.ScoreFailed = ( Mission.ResourcePoolBase - Mission.ResourceUSPool ) * scoremultiplier
						end
						if objective.ScoreFailed ~= 0 then
							objective.ScoreFailed = luaRound(objective.ScoreFailed)
						end
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." | objective.ScoreFailed: "..tostring(objective.ScoreFailed))
					end
				end
			end
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " --- ---")
		end

		local MPlayers = Multi_GetPlayers()
		for playerID, PartyID in pairs (MPlayers) do
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
			for priority, ptable in pairs(Mission.Objectives) do
-- RELEASE_LOGOFF  				luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Checking "..priority.." objectives...")
				for num, obj in pairs(ptable) do
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " PartyID: "..tostring(PartyID).." | obj.Party: "..tostring(obj.Party))
					if obj.Party == PartyID then
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Num: "..num)
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "PlayerID: "..playerID + 1)
						if luaObj_GetSuccess(priority, num) then
							if Mission.CompetitiveWinnerIndex == nil or Mission.CompetitiveWinnerIndex ~= nil and obj.PlayerIndex == nil then
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD nil Winner!")
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
								Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
							elseif Mission.CompetitiveWinnerIndex ~= nil then
								local objID = Mission.CompetitiveWinnerIndex + 1
								local playerObjID = playerID + 1
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " PlayerID "..playerID)
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " CompetitiveWinnerIndex "..Mission.CompetitiveWinnerIndex)
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Number "..num)
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Obj ID "..obj.ID)
								if playerID == Mission.CompetitiveWinnerIndex then
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Good Win!")
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
									Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
								elseif num == playerObjID then
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD Fail!")
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
									Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
								else
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD End!")
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by 0")
									Scoring_SetMissionScore(playerID, obj.ID, 0)
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
								end
							end
						elseif LobbySettings.GameMode ~= "globals.gamemode_competitive" then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD Obj!")
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
							Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
						elseif num == playerID + 1 then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD Comp Obj!")
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
							Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
						end
					end
				end
			end
		end
	end
		------ DISON
		--[[
			iteralni a playerek kozott
				iteralni az ojjektivak kozott
				ha valami teljesult a jatekosi oldalnak, akkor adott playerre
				Scoring_SetMissionScore(PLAYERINDEX, Mission.Objectives[x].ID, Mission.Objectives[x].ScoreCompleted)
		]]

	local MPlayers = GetPlayerDetails()
	for slotID, value in pairs (MPlayers) do
		if value.ai == true then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
			for priority, ptable in pairs(Mission.Objectives) do
-- RELEASE_LOGOFF  				luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Checking "..priority.." objectives...")
				for num, obj in pairs(ptable) do
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " value.party: "..tostring(value.party).." | obj.Party: "..tostring(obj.Party))
					if obj.Party == value.party then
						if luaObj_GetSuccess(priority, num) then
							if Mission.CompetitiveWinnerIndex == nil or Mission.CompetitiveWinnerIndex ~= nil and obj.PlayerIndex == nil then
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD nil Winner!")
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
								Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
							elseif Mission.CompetitiveWinnerIndex ~= nil then
								local objID = Mission.CompetitiveWinnerIndex + 1
								local playerObjID = slotID + 1
								if slotID == Mission.CompetitiveWinnerIndex then
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Good Win!")
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
									Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
								elseif num == playerObjID then
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD Fail!")
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
									Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
								else
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD End!")
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by 0")
									Scoring_SetMissionScore(slotID, obj.ID, 0)
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
								end
							end
						elseif LobbySettings.GameMode ~= "globals.gamemode_competitive" then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD Comp Obj!")
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
							Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
						elseif num == slotID + 1 then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "BAD Obj!")
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
							Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
						end
					end
				end
			end
		end
	end
end

--[[AutoDoc
usage: luaObj_AddReminder(level, num, counter)
category: Objectives
shortdesc: idozitett warningot rendel egy objektivahoz
desc: beallitja az objektiva .Remind statuszat ami alapjan a luaObj_Reminder() idonkent kiirja az objektiva szoveget warning formaban
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
]]
function luaObj_AddReminder(level, num, counter)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_AddReminder needs a level and an objective number as param!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("Adding reminder to objective "..level..num)

	Mission.Objectives[level][num].Counter = counter
	Mission.Objectives[level][num].Remind = true
	Mission.Objectives[level][num].Displayed = 0
	Mission.Objectives[level][num].ObjPrevRemindTime = GameTime()
end

--[[AutoDoc
usage: luaObj_RemoveReminder(level, num)
category: Objectives
shortdesc: idozitett warningot torol egy objektivanal
desc: beallitja az objektiva .Remind statuszat ami alapjan a luaObj_Reminder() leveszi az objektiva szoveget a warning rendszerbol
level: string, az objektiva szintje, primary, secondary, hidden
num: mixed, az objektiva kulcsa a tablaban
]]
function luaObj_RemoveReminder(level, num)
-- RELEASE_LOGOFF  	Assert(level ~= nil and num ~= nil, "***ERROR: luaObj_RemoveReminder needs a level and an objective number as param!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("Removing reminder to objective "..level..num)

	Mission.Objectives[level][num].Remind = nil
	Mission.Objectives[level][num].Displayed = 0
end

--[[AutoDoc
usage: luaObj_Reminder()
category: Objectives
shortdesc: adott valtozok alapjan kiirja/leveszi a warning systembol a objektiva szoveget
desc: idozitot hoz letre, ha az objektivahoz aktiv tartozik .Remind valtozo es kiirja a kepernyore warning formaban
]]
function luaObj_Reminder()
-- RELEASE_LOGOFF  	luaHelperLog("luaObj_Reminder called...")

	local remindTime

	if Mission.ObjRemindTime then
		remindTime = Mission.ObjRemindTime
	else
		remindTime = 60
	end

	if Mission.Objectives.primary ~= nil then
		for key, value in pairs(Mission.Objectives.primary) do
			if value.ObjPrevRemindTime == nil then
				value.ObjPrevRemindTime = 0
			end
			if value.Active and value.Success == nil and value.Remind and GameTime()-value.ObjPrevRemindTime > remindTime then
-- RELEASE_LOGOFF  				luaHelperLog(" reminding primary objective: "..key)
				value.ObjPrevRemindTime = GameTime()
				if not value.Reminded then
-- RELEASE_LOGOFF  					luaHelperLog("First time reminder, not printing!")
					value.Reminded = true
					return
				elseif value.Counter ~= nil and value.Counter > value.Displayed then
					MissionNarrativeEnqueue(value.Text)
					value.Displayed = value.Displayed + 1
					return value.Displayed
				elseif value.Counter == nil then
					MissionNarrativeEnqueue(value.Text)
				end
				return
			end
		end
	end

	if Mission.Objectives.secondary ~= nil then
		for key, value in pairs(Mission.Objectives.secondary) do
			if value.ObjPrevRemindTime == nil then
				value.ObjPrevRemindTime = 0
			end
			if value.Active and value.Success == nil and value.Remind and GameTime()-value.ObjPrevRemindTime > remindTime then
-- RELEASE_LOGOFF  				luaHelperLog(" reminding secondary objective: "..key)
				value.ObjPrevRemindTime = GameTime()
				if not value.Reminded then
-- RELEASE_LOGOFF  					luaHelperLog("First time reminder, not printing!")
					value.Reminded = true
					return
				elseif value.Counter ~= nil and value.Counter > value.Displayed then
					MissionNarrativeEnqueue(value.Text)
					value.Displayed = value.Displayed + 1
					return value.Displayed
				elseif value.Counter == nil then
					MissionNarrativeEnqueue(value.Text)
				end
				return
			end
		end
	end
end

---------------------------------------------------------------------------------
--[[AutoDoc
usage: party = luaGetEnemyParty(unit)
category: Unit
shortdesc: visszadja az adott egyseg ellenseges Party-jat
desc: megvizsgalja a unit .Party property-jet es visszaadja az ellenkezo Party-t, PARTY_NEUTRAL eseten a sajat Party-t adja vissza
unit: table, a vizsgalt egyseg
party: enum, PARTY_ALLIED, PARTY_JAPANESE, PARTY_NEUTRAL
]]
function luaGetEnemyParty(unit)
	if unit.Party == PARTY_ALLIED then
		return PARTY_JAPANESE
	elseif unit.Party == PARTY_JAPANESE then
		return PARTY_ALLIED
	else
		return PARTY_NEUTRAL
	end
end

--[[AutoDoc
usage: hiddenName = luaFindHidden(name)
category: Unit
shortdesc: visszaadja egy hidden unit nevet
desc: visszaad egy tablat, melynek 'Name' kulcsa a keresett hidden unit neve
name: string, a keresett hidden unit neve
hiddenName: table, mely tartalmazza a hidden unit nevet
]]
function luaFindHidden(name)
-- RELEASE_LOGOFF  	Assert(type(name) == "string" , "***ERROR: luaFindHidden needs a string as param!"..debug.traceback())
	return {["Name"] = name}
end

--[[AutoDoc
usage: generatedElements = luaGenerateObjects(hiddenTable [,renametable])
category: Unit
shortdesc: luaFindHidden-nel visszaadott tabla alpajn begenralja a hidden unitokat
desc: begeneralja a rejtett egyseget, es atnevezi oket ha a 'renamtable'-ben megadott szempontok alapjan
hiddenTable: table, a begeneralando egysegek neveit tartalmazo tabla
renametable: table, melyben 'Name' kulcsok ertekeinek megfeleloen atnevezi a generalt egysegeket
generatedElements: table, mely tartalmazza a generealt unitok this tablait
]]
function luaGenerateObjects(hiddenTable, renametable)
-- RELEASE_LOGOFF  	luaHelperLog("luaGenerateElements initiated")
	local generatedElements = {}
	for key, value in pairs (hiddenTable) do
-- RELEASE_LOGOFF  		Assert(value.Name ~= nil, "***ERROR: luaGenerateObjects failed because of a noname element at key "..key.."!"..debug.traceback())
		if renametable then
			generatedElements[key] = GenerateObject(value.Name, renametable[key].Name)
		else
			generatedElements[key] = GenerateObject(value.Name)
		end
	end

-- RELEASE_LOGOFF  	luaLogElementNames(generatedElements, "Generated ")

	return generatedElements
end

--[[AutoDoc
usage: point = luaGetPathPoint(pathent, num)
category: Unit
shortdesc: visszaadja egy path adott pontjat
desc: adott path entity bizonyos pontjat adja vissza, a parametereknek megfeleloen
pathent: table, path entity, a vizsgalt path
num: mixed, a keresett pont a pathon belul, lehet string: 'first', 'last' vagy number, ha tudjuk, hogy pontosan melyik pontot keressuk
point: table, szabvany koordinata tabla
]]
function luaGetPathPoint(pathent, num)
-- RELEASE_LOGOFF  	luaHelperLog("Initiating luaGetPathPoint...")


-- RELEASE_LOGOFF  	Assert(pathent ~= nil, "***ERROR: luaGetPathPoint's first param must be a path entity (got nil)!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog("\tPathent: "..pathent.Name)
-- RELEASE_LOGOFF  	luaHelperLog("\tpoint: "..num)

-- RELEASE_LOGOFF  	Assert(pathent.ID ~= nil, "***ERROR: luaGetPathPoint's first param must be a path entity!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(num == "last" or num == "first" or type(num) == "number", "***ERROR: luaGetPathPoints' second param must be 'first', 'last' or a number!"..debug.traceback())

	local pathPoints = FillPathPoints(pathent)
	local pathSize = luaCountTable(pathPoints)
-- RELEASE_LOGOFF  	luaHelperLog(" Path points' num: "..pathSize)

	if num == "first" then
-- RELEASE_LOGOFF  		luaHelperLog("\nGivin' back first coordinate")
		return pathPoints[1]
	elseif num == "last" then
-- RELEASE_LOGOFF  		luaHelperLog("\nGivin' back last coordinate")
		return pathPoints[pathSize]
	end

	for key, value in pairs (pathPoints) do
		if key == num then
-- RELEASE_LOGOFF  			luaHelperLog("\nGivin' back "..key.."st/nd/rd/th coordinate")
			return value
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("No point found, probably exceeding threshold.")
	return nil
end

--[[AutoDoc
usage: luaShutUp(entity, enable)
category: Unit
shortdesc: letiltja/engedelyezi a fegyverzetet egy egysegrol
desc: Torpedo, AA es Artil bot letiltasa/engedelyezese adott uniton
entity: table, a kerdeses entitas this tablaja
enable: bool, true eseten engedelyez mindent, false eseten tilt
]]
function luaShutUp(entity, enable)
-- RELEASE_LOGOFF  	luaHelperLog("luaShutUp "..tostring(enable).." initiated on unit "..entity.Name)
-- RELEASE_LOGOFF  	Assert(entity.Name ~= nil, "***ERROR: luaShutUp needs an entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(enable) == "boolean", "***ERROR: luaShutUp needs a boolean as second param!"..debug.traceback())

	TorpedoEnable(entity, enable)
	AAEnable(entity, enable)
	ArtilleryEnable(entity, enable)
end

--[[AutoDoc
usage: luaEnableNavigator(entity, enable)
category: Unit
shortdesc: letiltja a navigacios AI-t
desc: navigator bot tiltas/engedelyezes beleertve a hajo-szarazfold, hajo-hajo es hajo-torpedo elkerulest
entity: table, a kerdeses entitas this tablaja
enable: bool, true eseten engedelyez mindent, false eseten tilt
]]
function luaEnableNavigator(entity, enable)
-- RELEASE_LOGOFF  	luaHelperLog("luaDisableNavigator "..enable.." initiated on unit "..entity.Name)
-- RELEASE_LOGOFF  	Assert(entity.Name ~= nil and (luaGetType(entity) == "ship" or luaGetType(entity) == "sub"), "***ERROR: luaDisableNavigator needs a ship or submarine entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(enable) == "boolean", "***ERROR: luaDisableNavigator needs a boolean as second param!"..debug.traceback())

	if not enable then
		NavigatorStop(entity)
		luaDelay(luaEnableNavigator_ext, 2)
		if Mission.TmpParam_extEnt == nil then
			Mission.TmpParam_extEnt = {}
			Mission.TmpParam_extBool = {}
		end
		table.insert(Mission.TmpParam_extEnt, entity)
		table.insert(Mission.TmpParam_extBool, false)
	else
		NavigatorEnable(entity, enable)
	end

	NavigatorSetAvoidLandCollision(entity, enable)
	NavigatorSetAvoidShipCollision(entity, enable)
	NavigatorSetTorpedoEvasion(entity, enable)
end

--[[AutoDoc
usage: luaEnableNavigator_ext()
category: Unit
shortdesc: idozitett letiltja a navigacios AI-t vezerles
desc: luaEnableNavigator() fv altal hivott oidoziteto fv
]]
function luaEnableNavigator_ext()
-- RELEASE_LOGOFF  	Assert(Mission.TmpParam_extEnt ~= nil and next(Mission.TmpParam_extEnt) ~= nil, "***ERROR: delayed navigator setup got an empty parameter!"..debug.traceback())

	NavigatorEnable(Mission.TmpParam_extEnt[1], Mission.TmpParam_extBool[1])

	table.remove(Mission.TmpParam_extEnt, 1)
	table.remove(Mission.TmpParam_extBool, 1)

	if next(Mission.TmpParam_extEnt) == nil then
		Mission.TmpParam_extEnt = nil
		Mission.TmpParam_extBool = nil
	end
end

--[[AutoDoc
usage: isCoord = luaIsCoordinate(target)
category: World
shortdesc: visszaadja, hogy a parameterben szereplo tabla koordinata tabla e
desc: a 'target' alapjan eldonti, hogy koordinatarol van es szo, ergo tartalmaz e x,y,z kulcsokat amelynek ertekei 'number' tipusuak
target: table, a vizsgalt celpont
isCoord: bool, true ha a celpont koordinata, false ha nem
]]
function luaIsCoordinate(target)
-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaIsCoordinate needs a target!"..debug.traceback())

	--luaHelperLog("Checking "..target.." whether it's a coordinate...")
	if type(target) == "table" then
		if type(target.x) == "number" and type(target.y) == "number" and type(target.z) == "number" and luaCountTable(target) == 3 then
			--luaHelperLog(" it's a coordinate.")
			return true
		else
			--luaHelperLog(" well, it's not.")
			return false
		end
	else
		return false
	end
end
------------------------------Clouds--------------------------------------------------

--[[AutoDoc
usage: luaGenerateRandomClouds(cloudNumber, cloudBox [,prevalenceBig] [,prevalenceMedium] [,prevalenceSmall])
category: World
shortdesc: adott parameterek alapjan legeneralja a felhoket
desc: a parameterek alapjan (felhok szama, terulet es sulyozas) beeleszti a felhoket, celszeru init time-ban, blackout alatt hivni
cloudNumber: number, ennyi felhot fog generalni
cloudBox: table, ezen a teruleten belul fognak letrejonni a felhok, tabla melynek 2 kulcsa 2 tabla az elso a maximum x,y,z koordinatakakkal, mig a masodik a minimum ertekekkel
prevalenceBig: number, ilyen sulyozassal fog CloudBig-et generalni
prevalenceMedium: number, ilyen sulyozassal fog CloudMedium-ot generalni
prevalenceSmall: number, ilyen sulyozassal fog CloudSmall-t generalni
]]
function luaGenerateRandomClouds(cloudNumber, cloudBox, prevalenceBig, prevalenceMedium, prevalenceSmall)
-- random felhogeneralas

	if cloudNumber < 1 then
		error("***ERROR: luaGenerateRandomClouds first param must a positive number!", 2)
	end

	if type(cloudBox) ~= "table" then
		error("***ERROR: luaGenerateRandomClouds second param must be a table!", 2)
	end

	if table.getn(cloudBox) ~= 2 then
		error("***ERROR: luaGenerateRandomClouds second param must have 2 elements of vectors!)", 2)
	end

	if prevalenceBig == nil then
		prevalenceBig = 1
	end

	if prevalenceMedium == nil then
		prevalenceMedium = 1
	end

	if prevalenceSmall == nil then
		prevalenceSmall = 1
	end

	if not FindHiddenEntity("CloudBig") then
		prevalenceBig = 0
	end

	if not FindHiddenEntity("CloudMedium") then
		prevalenceMedium = 0
	end

	if not FindHiddenEntity("CloudSmall") then
		prevalenceSmall = 0
	end

	if cloudNumber <= 0 or (prevalenceBig <= 0 and prevalenceMedium <= 0 and prevalenceSmall <= 0) then
-- RELEASE_LOGOFF  		luaHelperLog(" Illegal cloud number, prevalences, cloud names or cloudbox, no cloud generated ")
		return nil
	else
		local CloudSky = {}
		local CloudTypes =
				{
					[1] =
					{
						["Name"] = "CloudBig",
						["Dist"] = 500,
					},
					[2] =
					{
						["Name"] = "CloudMedium",
						["Dist"] = 300,
					},
					[3] =
					{
						["Name"] = "CloudSmall",
						["Dist"] = 100,
					},
				}

		for count = 1, cloudNumber do
			local CloudPos =
					{
						["x"] = 0,
						["y"] = 0,
						["z"] = 0,
					}
			local CloudRot =
					{
						["x"] = 0,
						["y"] = 0,
						["z"] = 0,
					}

			local CloudOK = nil					-- elfogadjuk-e a generalt felho poziciot
												-- sulyozott random, melyik tipusu felho legyen
			local which
			if prevalenceBig > 0 and prevalenceMedium > 0 and prevalenceSmall > 0 then
				which = luaPickInRange(1, prevalenceBig, 2, prevalenceMedium, 3, prevalenceSmall)
			elseif prevalenceBig > 0 and prevalenceMedium > 0 and prevalenceSmall <= 0 then
				which = luaPickInRange(1, prevalenceBig, 2, prevalenceMedium)
			elseif prevalenceBig <= 0 and prevalenceMedium > 0 and prevalenceSmall > 0 then
				which = luaPickInRange(1, prevalenceMedium, 2, prevalenceSmall)
			elseif prevalenceBig > 0 and prevalenceMedium <= 0 and prevalenceSmall > 0 then
				which = luaPickInRange(1, prevalenceBig, 2, prevalenceSmall)
			elseif prevalenceBig > 0 and prevalenceMedium <= 0 and prevalenceSmall <= 0 then
				which = 1
			elseif prevalenceBig <= 0 and prevalenceMedium > 0 and prevalenceSmall <= 0 then
				which = 2
			elseif prevalenceBig <= 0 and prevalenceMedium <= 0 and prevalenceSmall > 0 then
				which = 3
			end

-- RELEASE_LOGOFF  --			luaHelperLog(" Generating "..count..". cloud, type: "..which)

			repeat
				CloudOK = true

				CloudPos.x = luaRnd(cloudBox[1].x, cloudBox[2].x)
				CloudPos.y = luaRnd(cloudBox[1].y, cloudBox[2].y)
				CloudPos.z = luaRnd(cloudBox[1].z, cloudBox[2].z)
-- RELEASE_LOGOFF  				luaHelperLog(" Current CloudPos: "..CloudPos.x.." ; "..CloudPos.y.." ; "..CloudPos.z)

				for num, value in pairs(CloudSky) do
					if value ~= nil and num ~= count then
-- RELEASE_LOGOFF  --						luaHelperLog(num..". CloudPos: "..value.x.." ; "..value.y.." ; "..value.z)

						local diffX = value.x - CloudPos.x
						local diffY = value.y - CloudPos.y
						local diffZ = value.z - CloudPos.z
						local cloudDist = math.sqrt(math.pow(diffX, 2) + math.pow(diffY, 2) + math.pow(diffZ, 2))

						-- a mar meglevokhoz tul kozel generalt felho nem jo, ujat kerunk
						if cloudDist < CloudSky[num].Dist + CloudTypes[which].Dist then
-- RELEASE_LOGOFF  							luaHelperLog(" CLOUD denied, because dists are: "..cloudDist.." ; "..CloudSky[num].Dist.." ; "..CloudTypes[which].Dist)
							CloudOK = false
							break
						end
					end
				end
			until CloudOK

			CloudRot.y = DEG(luaRnd(0, 180))
-- RELEASE_LOGOFF  --			luaHelperLog(" Cloud rotated by: "..CloudRot.y * 180 / math.pi)

			SpawnLight(CloudTypes[which].Name, CloudPos, CloudRot)
			table.insert(CloudSky, CloudPos)
			CloudSky[count].Dist = CloudTypes[which].Dist
		end
	end
end

--[[
memoriafoglalas miatt kiveve
function luaGenerateOvercast(cloudBox)
-- felhos egbolt generalas

	if type(cloudBox) ~= "table" then
		error("***ERROR: luaGenerateOvercast param must be a table!", 2)
	end

	if table.getn(cloudBox) ~= 2 then
		error("***ERROR: luaGenerateOvercast param must have 2 elements of vectors!)", 2)
	end

	if not FindHiddenEntity("CloudBig") then
		error("***ERROR: luaGenerateOvercast needs a 'CloudBig' hidden cloud!)", 2)
	end

	if table.getn(cloudBox) == 2 then
		local CloudPos =
				{
					["x"] = 0,
					["y"] = 0,
					["z"] = 0,
				}
		local CloudRot =
				{
					["x"] = 0,
					["y"] = 0,
					["z"] = 0,
				}

		CloudPos.x = cloudBox[1].x
		repeat
			CloudPos.z = cloudBox[1].z
			repeat
				CloudPos.y = cloudBox[1].y + luaRnd(1, 500)
				CloudRot.y = DEG(luaRnd(0, 180))
				SpawnLight("CloudBig", CloudPos, CloudRot)
				CloudPos.z = CloudPos.z + 1000
			until CloudPos.z > cloudBox[2].z
			CloudPos.x = CloudPos.x + 1000
		until CloudPos.x > cloudBox[2].x
	end
end
]]

--------------------------Narratives------------------------------------------------------
--[[
function luaWriteNarrative(narrIndex, narrSpeed)
-- NarrIndex: melyik szovegreszt irja
-- NarrSpeed: milyen sebesseggel valtogassa a sorokat
	local num = table.getn(Mission.Narratives[narrIndex])
	for count = 0, num-1 do
		luaDelay(luaTimedNarrative, 1+(count*narrSpeed), "txt", Mission.Narratives[narrIndex][count+1], "fi", 1, "osc", narrSpeed, "fo", 1)
	end
end


function luaTimedNarrative(timerThis)
	if timerThis.ParamTable.fi == nil or type(timerThis.ParamTable.fi) ~= number then
		timerThis.ParamTable.fi = 1
	end
	if timerThis.ParamTable.osc == nil or type(timerThis.ParamTable.osc) ~= number then
		timerThis.ParamTable.osc = 1
	end
	if timerThis.ParamTable.fo == nil or type(timerThis.ParamTable.fo) ~= number then
		timerThis.ParamTable.fo = 1
	end
	if timerThis.ParamTable.txt == nil then
		return
	end
	MissionNarrative(timerThis.ParamTable.txt)
end
]]
--[[
A kovetkezo fv-ek hasznalatahoz az initbe keruljon be a kovetkezo nehany sor:
	this.NarrativeReady = true
	this.NarrativeQueueText = {}

A thinkbe pedig ezt kell beirni:
	luaNarrativePlay()
]]

--[[
function luaNarrativePlay()
	if table.getn(Mission.NarrativeQueueText) ~= 0 and Mission.NarrativeReady then
		local i = next(Mission.NarrativeQueueText)
		local length = MissionNarrative(Mission.NarrativeQueueText[i])
		Mission.NarrativeReady = false
		luaDelay(luaNarrativeReady, length+1)
		table.remove(Mission.NarrativeQueueText, i)
	end
end

function luaNarrativeEnqueue(text)
	table.insert(Mission.NarrativeQueueText, text)
end

function luaNarrativeUrgent(text)
	table.insert(Mission.NarrativeQueueText, 1, text)
end

function luaNarrativeOverride(text)
	Mission.NarrativeQueueText = {}
	table.insert(Mission.NarrativeQueueText, text)
end

function luaNarrativeReady()
	Mission.NarrativeReady = true
end

]]
------------------------------Dialogues--------------------------------------------------
--[[AutoDoc
usage: luaStartDialog(dialogID)
category: Dialog
shortdesc: lejatsza a megadott dialogust
desc: lejatsza a Mission.Dialogues tablabol a 'dialogID' kulcsal rendelkezo dialogust
dialogID: mixed, a dilogus kulcsa a Mission.Dialogues tablaban
]]
function luaStartDialog(dialogID, log)
-- dialog indito wrapper

	if type(dialogID) ~= "string" then
		error("***ERROR: luaStartDialog's param must be a string!", 2)
	end

	if Mission.Dialogues[dialogID] == nil then
		error("***ERROR: luaStartDialog cannot continue, non existing dialog: "..dialogID, 2)
	end

	StartDialog(dialogID, Mission.Dialogues[dialogID])

	if log then
-- RELEASE_LOGOFF  		luaLog("Dialog started. ID: "..dialogID)
	end
end

------------------------------Camera handling--------------------------------------------------
--[[AutoDoc
usage: luaCamOnTarget(target [,pos] [,select] [,special] [,flytime] [,callback])
category: Camera
shortdesc: adott targetre mozgatja a kamerat a megadott feltetelek alapjan
desc: megadott entityre mozgatja a kamerat 'pos' iranybol, 'flytime' ido alatt, es meghivja a 'callback' fv-t, Figyelem regi kamera
target: table, entitas, erre a unitra fog mozogni a kamera
pos: string, ilyen iranbol mozog a kamera, fornt, back, right, left
select: bool, ha nem nil akkor a mozgas vegen kivalasztja az egyseget
special: string, "noupdate" nagyobb radiusban mozgatja a kamerat
flytime: number, ennyi ido alatt mozog at a kamera a targetre, default 4 sec.
callback: function, ez a fv hivodik meg ha a kameramozgas veget ert
]]
-- pos: "front", "back", "left", "right", "top", "bottom"
function luaCamOnTarget(target, pos, select, special, flytime, callback)
-- RELEASE_LOGOFF  	luaHelperLog("luaCamOnTarget initiated...")

-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaCamOnTarget needs a target entity at first!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog(" Desired position: ")
-- RELEASE_LOGOFF  	luaHelperLog(pos)
-- RELEASE_LOGOFF  	luaHelperLog(" on target: "..target.Name)
	local radius, rho, theta
	local targetType = luaGetType(target)
	local moveTime
	if flytime == nil then
		moveTime = 4	-- secs
	else
		moveTime = flytime
	end

	EnableInput(false)

	-- tavolsag
	if pos == "back" or pos == nil then
		radius = target.Class.Length
	else
		radius = target.Class.Length * 1.4
	end

	if radius == nil then
		if targetType == "ship" then
			if not special or special == "noupdate" then
				radius = 250
			else
				radius = 40
			end
		elseif targetType == "plane" then
			if not special then
				radius = 40
			else
				radius = 120
			end
		elseif targetType == "sub" then
			radius = 100
		else
			if not special or special == "noupdate" then
				radius = 150
			else
				radius = 40
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog(" CamTarget "..target.Name.." is a "..targetType..", radius set to "..radius)

	-- irany
	if pos == "front" then
		rho = 0
		theta = math.pi/12
	elseif pos == "back" then
		rho = math.pi
		theta = math.pi/12
	elseif pos == "left" then
		rho = math.pi/2
		theta = math.pi/12
	elseif pos == "right" then
		rho = 3*math.pi/2
		theta = math.pi/12
	elseif pos == "top" then
		rho = 1
		theta = math.pi/2
	elseif pos == "bottom" then
		rho = 1
		theta = -math.pi/2
	else
		rho = math.pi
		theta = math.pi/12
	end

	MovCam_SetDeviationFactor(0)
	MovCam_RefPos_Polar(target, radius, rho, theta, false, moveTime)

--	if select ~= false then
	if callback ~= nil then
		return luaDelay(luaCamOnTargetExt, moveTime + 1, "CB", callback, "select", select)
	else
		return luaDelay(luaCamOnTargetExt, moveTime + 1, "select", select)
	end
--	end
end

-- pos: "front", "back", "left", "right", "top", "bottom"
--[[AutoDoc
usage: luaCamOnTargetNew(target [,pos] [,select] [,special] [,flytime] [,callback])
category: Camera
shortdesc: adott targetre mozgatja a kamerat a megadott feltetelek alapjan
desc: megadott entityre mozgatja a kamerat 'pos' iranybol, 'flytime' ido alatt, es meghivja a 'callback' fv-t, uj Cuci fele kamerakezeles
target: table, entitas, erre a unitra fog mozogni a kamera
pos: string, ilyen iranbol mozog a kamera, fornt, back, right, left
select: bool, ha nem nil akkor a mozgas vegen kivalasztja az egyseget
special: string, "noupdate" nagyobb radiusban mozgatja a kamerat
flytime: number, ennyi ido alatt mozog at a kamera a targetre, default 4 sec.
callback: function, ez a fv hivodik meg ha a kameramozgas veget ert
]]
function luaCamOnTargetNew(target, pos, select, special, flytime, callback)
-- RELEASE_LOGOFF  	luaHelperLog("luaCamOnTargetNew initiated...")

-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaCamOnTarget needs a target entity at first!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog(" Desired position: ")
-- RELEASE_LOGOFF  	luaHelperLog(pos)
-- RELEASE_LOGOFF  	luaHelperLog(" on target: "..target.Name)
	local radius, rho, theta
	local targetType = luaGetType(target)
	local moveTime
	if flytime == nil then
		moveTime = 4	-- secs
	else
		moveTime = flytime
	end

	EnableInput(false)

	-- tavolsag
	if pos == "back" or pos == nil then
		radius = target.Class.Length
	else
		radius = target.Class.Length * 1.4
	end

	if radius == nil then
		if targetType == "ship" then
			if not special or special == "noupdate" then
				radius = 250
			else
				radius = 40
			end
		elseif targetType == "plane" then
			if not special then
				radius = 40
			else
				radius = 120
			end
		elseif targetType == "sub" then
			radius = 100
		else
			if not special or special == "noupdate" then
				radius = 150
			else
				radius = 40
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog(" CamTarget "..target.Name.." is a "..targetType..", radius set to "..radius)

	-- irany
	if pos == "front" then
		rho = 0
		theta = math.pi/12
	elseif pos == "back" then
		rho = math.pi
		theta = math.pi/12
	elseif pos == "left" then
		rho = math.pi/2
		theta = math.pi/12
	elseif pos == "right" then
		rho = 3*math.pi/2
		theta = math.pi/12
	elseif pos == "top" then
		rho = 1
		theta = math.pi/2
	elseif pos == "bottom" then
		rho = 1
		theta = -math.pi/2
	else
		rho = math.pi
		theta = math.pi/12
	end

	local campos

	if pos == "back" or pos == nil then
		local cam = GetCameraState().Position
		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {cam.x, cam.y, cam.z}
				},
				["starttime"] = 0,
				["blendtime"] = 0,
				["transformtype"] = "keepy",
			}
		MovCamNew_AddPosition(campos)

		campos =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = target,
				},
				["starttime"] = 0,
				["blendtime"] = 2,
				["transformtype"] = "keepy",
				["nonlinearblend"] = 0.5,
			}
		MovCamNew_AddPosition(campos)

		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["parent"] = target,
					["modifier"] =
						{
							["name"] = "gamecamera"
						},
				},
				["starttime"] = 1,
				["blendtime"] = moveTime-1,
				["transformtype"] = "keepy",
				["nonlinearblend"] = 10,
				["wanderer"] = true
			}
		MovCamNew_AddPosition(campos)

--[[

		campos =
			{
				["postype"] = "camera",
				["position"] =
				{
					["parent"] = target,
					["modifier"] =
						{
							["name"] = "gamecamera"
						},
				},
				["starttime"] = 0,
				["blendtime"] = moveTime,
				["transformtype"] = "keepy",
				["wanderer"] = true
			}
]]

	else
		local cam = GetCameraState().Position
		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {cam.x, cam.y, cam.z}
				},
				["starttime"] = 0,
				["blendtime"] = 0,
				["transformtype"] = "keepy",
				["smoothtime"] = 0,

			}
		MovCamNew_AddPosition(campos)
--[[

		campos =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = target,
				},
				["starttime"] = 0,
				["blendtime"] = moveTime/2,
				["transformtype"] = "keepy",

			}
		MovCamNew_AddPosition(campos)
]]

		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["parent"] = target,
					["polar"] = {radius, math.deg(theta), math.deg(rho)}
				},
				["starttime"] = 0,
				["blendtime"] = moveTime,
				["transformtype"] = "keepy"
			}
	end

	MovCamNew_AddPosition(campos)

	if callback ~= nil then
		return luaDelay(luaCamOnTargetExt, moveTime + 1, "CB", callback, "select", select)
	else
		return luaDelay(luaCamOnTargetExt, moveTime + 1, "select", select)
	end
end

--[[AutoDoc
usage: luaCamOnTargetFree(target, theta, rho, distance [,select] [,special] [,flytime] [,callback])
category: Camera
shortdesc: adott targetre mozgatja a kamerat a megadott feltetelek alapjan
desc: megadott entityre mozgatja a kamerat, 'flytime' ido alatt, es meghivja a 'callback' fv-t
target: table, entitas, erre a unitra fog mozogni a kamera
theta: függõleges forgásszög. 0 - vízszintes, 90 - felülrõl
rho: vízszintes forgásszög. 0 - szembõl, 90 - balról, 180 - hátulról, 270 - jobbról
select: bool, ha nem nil akkor a mozgas vegen kivalasztja az egyseget
special: string, "noupdate" nagyobb radiusban mozgatja a kamerat
flytime: number, ennyi ido alatt mozog at a kamera a targetre, default 4 sec.
callback: function, ez a fv hivodik meg ha a kameramozgas veget ert
]]
function luaCamOnTargetFree(target, theta, rho, distance, select, special, flytime, callback)
-- RELEASE_LOGOFF  	luaHelperLog("luaCamOnTargetFree initiated...")

-- RELEASE_LOGOFF  	Assert(target ~= nil, "***ERROR: luaCamOnTarget needs a target entity at first!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(theta ~= nil, "***ERROR: luaCamOnTarget needs a theta parameter!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(rho ~= nil, "***ERROR: luaCamOnTarget needs a rho parameter!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(distance ~= nil, "***ERROR: luaCamOnTarget needs a distance parameter!"..debug.traceback())

-- RELEASE_LOGOFF  	luaHelperLog(" Desired position: ")
-- RELEASE_LOGOFF  	luaHelperLog(" on target: "..target.Name)
	local targetType = luaGetType(target)
	local moveTime
	if flytime == nil then
		moveTime = 4	-- secs
	else
		moveTime = flytime
	end

	EnableInput(false)

	local campos

	local cam = GetCameraState().Position
	campos =
		{
			["postype"] = "cameraandtarget",
			["position"] =
			{
				["pos"] = {cam.x, cam.y, cam.z}
			},
			["starttime"] = 0,
			["blendtime"] = 0,
			["transformtype"] = "keepy",
			["smoothtime"] = 0,

		}
	MovCamNew_AddPosition(campos)
--[[

		campos =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = target,
				},
				["starttime"] = 0,
				["blendtime"] = moveTime/2,
				["transformtype"] = "keepy",

			}
		MovCamNew_AddPosition(campos)
]]

	campos =
		{
			["postype"] = "cameraandtarget",
			["position"] =
			{
				["parent"] = target,
				["polar"] = {distance, theta, rho}
			},
			["starttime"] = 0,
			["blendtime"] = moveTime,
			["transformtype"] = "keepy"
		}

	MovCamNew_AddPosition(campos)

	if callback ~= nil then
		return luaDelay(luaCamOnTargetExt, moveTime + 1, "CB", callback, "select", select)
	else
		return luaDelay(luaCamOnTargetExt, moveTime + 1, "select", select)
	end
end
--[[AutoDoc
usage: luaCamIngameMovieAuto(postables, callback, bo)
category: Camera
postables: A http://wiki.eidos.hu/wiki/doku.php?id=projects:bsj:tools:script_system:movie_functions:movcamnew_addposition-ban leírt paramétertáblákat tartalmazó tábla.
instantly: kell e blackout
shortdesc: A luaCamOnTargetFreehez hasonloan mukodik, csak postables-ben több pozíciót adhatunk meg.
desc: A luaCamOnTargetFreehez hasonloan mukodik, csak postables-ben több pozíciót adhatunk meg. Azért auto, mert a kameramozgás kezdeti idõpontja automatikusan az elõzõ vége. Ezért a starttime-ot ne is adjuk meg. Pl: luaCamIngameMovieAuto(
	{
		{["postype"] = "cameraandtarget", ["target"] = GetSelectedUnit(), ["distance"] = 150, ["theta"] = 25, ["rho"] = 21, ["moveTime"] = 5, ["smoothtime"] = 2},
		{["postype"] = "cameraandtarget", ["target"] = GetSelectedUnit(), ["distance"] = 180, ["theta"] = 5, ["rho"] = 231, ["moveTime"] = 15, ["transformtype"] = "keepall"}
	},
	luaGotoNextPhase,
	true)
]]
function luaCamIngameMovieAuto(postables, callback, bo, cbtime)
-- RELEASE_LOGOFF  	luaHelperLog("luaCamIngameMovieAuto initiated...")
--(target, theta, rho, distance, select, special, flytime, callback)
-- RELEASE_LOGOFF  --	Assert(target ~= nil, "***ERROR: luaCamOnTarget needs a target entity at first!"..debug.traceback())
-- RELEASE_LOGOFF  --	Assert(theta ~= nil, "***ERROR: luaCamOnTarget needs a theta parameter!"..debug.traceback())
-- RELEASE_LOGOFF  --	Assert(rho ~= nil, "***ERROR: luaCamOnTarget needs a rho parameter!"..debug.traceback())
-- RELEASE_LOGOFF  --	Assert(distance ~= nil, "***ERROR: luaCamOnTarget needs a distance parameter!"..debug.traceback())

	EnableInput(false)
	BlackBars(true)
	if bo then
		Blackout(false, "", 0.5)
	end

	local starttime = 0
	local campos = {}

	for idx, unit in pairs(postables) do
		if unit.postype == nil then
			unit.postype = "camera"
		end

		if unit.moveTime == nil then
			unit.moveTime = 0
		end

		if unit.position ~= nil then
			campos =
				{
					["postype"] = unit.postype, --"cameraandtarget"
					["position"] = unit.position,
					["event"] = unit.event,
					["starttime"] = starttime,
					["blendtime"] = unit.moveTime,
					["nonlinearblend"] = unit.nonlinearblend,
					["wanderer"] = unit.wanderer,
					["smoothtime"] = unit.smoothtime,
					["transformtype"] = unit.transformtype,
					["zoom"] = unit.zoom,
			}
		else
			campos =
				{
					["postype"] = unit.postype, --"cameraandtarget"
					["position"] =
					{
						["parent"] = unit.target, --target
						["polar"] = {unit.distance, unit.theta, unit.rho}
					},
					["event"] = unit.event,
					["starttime"] = starttime,
					["blendtime"] = unit.moveTime,
					["nonlinearblend"] = unit.nonlinearblend,
					["wanderer"] = unit.wanderer,
					["smoothtime"] = unit.smoothtime,
					["transformtype"] = unit.transformtype,
					["zoom"] = unit.zoom,
			}
		end

		starttime = starttime + unit.moveTime
		if campos.position.polar then
			if next(campos.position.polar) == nil then
				campos.position.polar = nil
			end
		end

-- RELEASE_LOGOFF  		luaLog(campos)

		MovCamNew_AddPosition(campos)
	end

	local callbackTime
	if cbtime == nil or type(cbtime) ~= "number" then
		callbackTime = starttime - 1
	elseif cbtime ~= nil and type(cbtime) == "number" then
		callbackTime = cbtime
	end

	if callback ~= nil then
		return luaDelay(luaCamOnTargetExt, callbackTime, "CB", callback, "select", false)
	else
		return luaDelay(luaCamOnTargetExt,callbackTime)
	end
end

--[[AutoDoc
usage: luaIngameMovie(table)
category: Camera
shortdesc: A luaCamIngameMovieAuto wrappere, ami létrehoz egy Mission.CamScript-et, és egy inputlistenert ("movielistenerID").
desc: A luaCamIngameMovieAuto wrappere, ami létrehoz egy Mission.CamScript változót, és egy inputlistenert ("movielistenerID"). Paramétere ugyanaz, mint az autósmozi fv-nek.

params:
	- tab				: tabla, ami a kamerapoziciot, mozgasat, stb. tarolja
	- cb				: legyen -e callback a movie vegen
	- bo				: legyen -e blackout movie elejen
	- cbtime		: mennyi ido mulva jojjon a callback
	- bb				: a blackbar kezdjen -e kimenni movie vege elott (default: false)
]]
function luaIngameMovie(tab, cb, bo, cbtime, bb)
-- RELEASE_LOGOFF  	luaHelperLog("luaIngameMovie initiated...")

-- RELEASE_LOGOFF  --	Assert(table ~= nil, "***ERROR: luaIngameMovie needs a table."..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("*** table ***")
-- RELEASE_LOGOFF  	luaHelperLog(tab)
-- RELEASE_LOGOFF  	luaHelperLog("*** table ***")

--	for i = 1,10 do
--		HideScoreDisplay(i,0)
--	end
--	HideUnitHP()

	Mission.MovieCallbackParameters = {}

	Mission.MovieCallbackParameters.Callback = cb
	Mission.MovieCallbackParameters.Select = false
	Mission.MovieCallbackParameters.bo = bo
	Mission.MovieCallbackParameters.CallbackTime = cbtime

	if (bb == true) then
		local nTime = 0
		for idx, record in pairs (tab) do
			nTime = nTime + record["moveTime"]
		end
		--LogToConsole("Movie hossz = "..nTime)
		if (nTime > 3) then
			nTime = nTime - 3
			Mission.MovieCallbackParameters.Delay = luaDelay(luaIngameMovieBlackBars, nTime)
		else
			Mission.MovieCallbackParameters.Delay = nil
		end
	end

	if bo then
		Mission.MovieCallbackParameters.tab = tab
		Blackout(true, "luaIngameMovieBOStart", 1)
	else
		Mission.CamScript = luaCamIngameMovieAuto(tab, cb, bo, cbtime)

		AddListener("input", "IngameMovieInputListenerID", {
			["callback"] = "luaCamOnTargetExt",  -- callback fuggveny
			["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})

	end

end


function luaIngameMovieBlackBars()
	BlackBars(false)
end

function luaIngameMovieBOStart()
		AddListener("input", "IngameMovieInputListenerID", {
			["callback"] = "luaCamOnTargetExt",  -- callback fuggveny
			["inputID"] = {IC_ENDMOVIEPLAY}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})

	local tab = Mission.MovieCallbackParameters.tab
	local cb = Mission.MovieCallbackParameters.Callback
	local bo = Mission.MovieCallbackParameters.bo
	local cbtime = Mission.MovieCallbackParameters.CallbackTime
	Mission.CamScript = luaCamIngameMovieAuto(tab, cb, bo, cbtime)
end


--[[AutoDoc
usage: luaCamOnTargetExt(timerthis)
category: Camera
shortdesc: a luaCamOnTargetNew() idozito fv-e
desc: a luaCamOnTargetNew() alapjan beallitott callbacket hivja meg
timerthis: table, a luaCamOnTargetNew()-ban beallitott valtozok
]]
function luaCamOnTargetExt(timerthis)
	if IsListenerActive("input", "IngameMovieInputListenerID") then
		RemoveListener("input", "IngameMovieInputListenerID")
	end
	if Mission.CamScript ~= nil then
		if Mission.CamScript.Dead == false then
			Kill(Mission.CamScript)
		end
	end
	if (Mission.MovieCallbackParameters ~= nil) and (Mission.MovieCallbackParameters.Delay ~= nil) then
		if (Mission.MovieCallbackParameters.Delay.Dead == false) then
			DeleteScript(Mission.MovieCallbackParameters.Delay)
		end
	end
-- RELEASE_LOGOFF  	luaHelperLog("*** timerthis before ***")
-- RELEASE_LOGOFF  	luaHelperLog(timerthis)
-- RELEASE_LOGOFF  	luaHelperLog("*****************")
-- RELEASE_LOGOFF  	luaHelperLog(Mission.MovieCallbackParameters)
	if type(timerthis) ~= "table" then
		timerthis = {}
		timerthis.ParamTable = {}
		timerthis.ParamTable.select = Mission.MovieCallbackParameters.Select
		timerthis.ParamTable.CB = Mission.MovieCallbackParameters.Callback
		Mission.MovieCallbackParameters = nil
	end
-- RELEASE_LOGOFF  	luaHelperLog("*** timerthis after ***")
-- RELEASE_LOGOFF  	luaHelperLog(timerthis)
-- RELEASE_LOGOFF  	luaHelperLog("*****************")
	--BlackBars(false)
	if timerthis.ParamTable.CB then
		timerthis.ParamTable.CB()
	end
end

------------------------------Airstrike / Airfield / Carrier--------------------------------------
--[[
luaAirfieldManager az airfieldek es a carrierek automatikus squadvezerleset latja el.
Meg kell adni neki egy repteret, es ket tablat amikben repulo classID-k vannak.
Az elso tabla fighter planeket tartalmazzon, mig a masodik dive/torpedo/levelbomb unitot.
A repter celja, hogy mindig legyen egy patrol fighter squadja, es a tobbieket meg feltoltse
random tamado unitokkal az other listabol.
]]
--[[AutoDoc
usage: luaAirfieldManager(airfield, fighterClassIDs, otherClassIDs, targetList, travelAlt, wingCount)
category: Unit
shortdesc:
desc:
]]
function luaAirfieldManager(airfield, fighterClassIDs, otherClassIDs, targetList, travelAlt, wingCount)
-- RELEASE_LOGOFF  	luaHelperLog("luaAirfieldManager Called!")
-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable({airfield}), "***ERROR: luaAirfieldManager needs an airfield/carrier as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(fighterClassIDs ~= nil and luaIsNumberTable(fighterClassIDs), "***ERROR: luaAirfieldManager needs a classID table as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(otherClassIDs ~= nil and luaIsNumberTable(otherClassIDs), "***ERROR: luaAirfieldManager needs a classID table as third param!"..debug.traceback())
	if targetList then
-- RELEASE_LOGOFF  		Assert(luaIsEntityTable(targetList, true), "***ERROR: luaAirfieldManager's targetList must be a unitlist!"..debug.traceback())
	else
		targetList = {}
	end
	if travelAlt then
-- RELEASE_LOGOFF  		Assert(type(travelAlt) == "number", "***ERROR: luaAirfieldManager's travelAlt must be a number!"..debug.traceback())
	end
	if wingCount then
-- RELEASE_LOGOFF  		Assert(wingCount == 1 or wingCount == 2 or wingCount == 3, "***ERROR: luaAirfieldManager's wingCount must be 1, 2 or 3!"..debug.traceback())
	else
		wingCount = 3
	end

	local slotSetting = GetProperty(airfield, "NumSlots")
	--luaLog("slotsetting "..tostring(slotsetting))
	local activeSquads = 0
	local planeEntTable = {}
	local slotIndex
	activeSquads, planeEntTable = luaGetSlotsAndSquads(airfield)
	--luaHelperLog("active squads: "..tostring(activeSquads))
	if activeSquads == 0 and IsReadyToSendPlanes(airfield) then
		local i = luaRnd(1,table.getn(fighterClassIDs))
		if VehicleClass[fighterClassIDs[i]].Type == "Kamikaze" then
			slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
		else
			slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
		end
		airfield.slots = GetProperty(airfield, "slots")
		planeEntTable = {}
		table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
	elseif activeSquads < slotSetting and IsReadyToSendPlanes(airfield) then
		if table.getn(luaTypeFilter(planeEntTable, "Fighter")) == 0 then
			local i = luaRnd(1,table.getn(fighterClassIDs))
			if VehicleClass[fighterClassIDs[i]].Type == "Kamikaze" then
				slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
			else
				slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],wingCount)
			end
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
-- RELEASE_LOGOFF  			luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		else
			local i = luaRnd(1,table.getn(otherClassIDs))
			if VehicleClass[otherClassIDs[i]].Type == "Kamikaze" then
				slotIndex = LaunchSquadron(airfield,otherClassIDs[i],wingCount)
			else
				slotIndex = LaunchSquadron(airfield,otherClassIDs[i],wingCount)
			end
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
-- RELEASE_LOGOFF  			luaHelperLog("luaAirfieldManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		end
	elseif activeSquads >= slotSetting then
-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Status: There isn't any free slots!"..airfield.Name)
	else
-- RELEASE_LOGOFF  		luaHelperLog("luaAirfieldManager Status: Airfield occupied!"..airfield.Name)
	end

	if not planeEntTable then
		return
	end

	for index, unit in pairs (planeEntTable) do
		unit.ammo = GetProperty(unit, "ammoType")
		if unit.Class.Type == "Fighter" then
-- RELEASE_LOGOFF  			luaHelperLog("Unit on patrol:"..unit.Name)
		elseif ( UnitGetAttackTarget(unit) == nil ) and (unit.ammo ~= 0 or unit.Class.Type == "Kamikaze") then
-- RELEASE_LOGOFF  			luaHelperLog("Unit searching for new target:"..unit.Name)
			--luaHelperLog("targetList")
			--luaHelperLog(targetList)
			local filteredTargetList = {}
			if unit.ammo == AMMO_TORPEDO and next(targetList) then
				local tempTargetList = {}
				local filtered = false
				for index, target in pairs (targetList) do
					if target.Class.Type == "MotherShip" or target.Class.Type == "BattleShip" or target.Class.Type == "Cruiser" or target.Class.Type == "Cargo" or target.Class.Type == "Destroyer" then
						table.insert(tempTargetList, target)
					else
						filtered = true
					end
				end
				if filtered and table.getn(tempTargetList) == 0 then
-- RELEASE_LOGOFF  					luaHelperLog("There is no valid torpedo target in targetList!")
				elseif filtered then
-- RELEASE_LOGOFF  					luaHelperLog("Invalid torpedo targets removed from targetList!")
				end
				filteredTargetList = tempTargetList
			else
-- RELEASE_LOGOFF  				luaHelperLog("There is no need for target filtering for this unit!")
				filteredTargetList = targetList
			end
			--luaHelperLog("filteredTargetList")
			--luaHelperLog(filteredTargetList)

			local shipsAround
			local number
			if not filteredTargetList or not next(filteredTargetList) then
				shipsAround, number = luaGetShipsAround(airfield, 10000, "enemy")
				if shipsAround and (unit.ammo == AMMO_TORPEDO or unit.Class.Type == "Kamikaze") then
					local tempShipsAround = {}
					local filtered = false
					for index, target in pairs (shipsAround) do
						if target.Class.Type == "MotherShip" or target.Class.Type == "BattleShip" or target.Class.Type == "Cruiser" or target.Class.Type == "Cargo" or target.Class.Type == "Destroyer" then
							table.insert(tempShipsAround, target)
						else
							filtered = true
						end
					end
					if filtered and table.getn(tempShipsAround) == 0 then
-- RELEASE_LOGOFF  						luaHelperLog("There isn't any valid torpedo/kamikaze target in range!")
						shipsAround = nil
					elseif filtered then
						shipsAround = tempShipsAround
					end
				end
			end

			if shipsAround then
				local preferedTargets = luaTypeFilter(shipsAround, "MotherShip")
				if table.getn(preferedTargets) == 0 then
					preferedTargets = shipsAround
				end
				---luaLogElementNames(preferedTargets, "preferedTargets")

				local currentTarget
				local distance
				currentTarget, distance = luaSortByDistance(unit, preferedTargets, true)
-- RELEASE_LOGOFF  				luaHelperLog("Targeting... "..tostring(currentTarget.Name))
				PilotSetTarget(unit, currentTarget)
				if unit.ammo == AMMO_BOMB and travelAlt then
					SquadronSetTravelAlt(unit, travelAlt)
					SquadronSetAttackAlt(unit, travelAlt)
				end
				unit.AirfieldManager = nil
-- RELEASE_LOGOFF  				luaHelperLog("Orders received, Target confirmed:"..unit.Name..currentTarget.Name)
			elseif filteredTargetList and next(filteredTargetList) then
				--luaLogElementNames(filteredTargetList, " Designated target ")
-- RELEASE_LOGOFF  				luaHelperLog("Choosing one from the designated targets...")
				local currentTarget = luaPickRnd(filteredTargetList)
-- RELEASE_LOGOFF  				luaHelperLog(" Chosen target: "..currentTarget.Name)
				PilotSetTarget(unit, currentTarget)
				if unit.ammo == AMMO_BOMB and travelAlt then
					SquadronSetTravelAlt(unit, travelAlt)
					SquadronSetAttackAlt(unit, travelAlt)
				end
				unit.AirfieldManager = nil
			else
				if unit.AirfieldManager == nil then
					PilotMoveToRange(unit,airfield,2000)
					unit.AirfieldManager = "PilotMoveToRange"
-- RELEASE_LOGOFF  					luaHelperLog("No tangos in sight! Returning for patrol!"..unit.Name..GetProperty(unit, "unitcommand"))
				else
-- RELEASE_LOGOFF  					luaHelperLog("No tangos in sight! Continuing patrol!"..unit.Name..GetProperty(unit, "unitcommand"))
				end
			end
		elseif unit.ammo ~= 0 or unit.Class.Type == "Kamikaze" then
-- RELEASE_LOGOFF  			luaHelperLog("Unit with ammo and active target:"..unit.Name..GetProperty(unit, "unitcommand")..GetPrimaryTarget(unit).Name)
		end
	end
end

--[[
luaCapManager az airfieldek es a carrierek cap vezerleset latja el.
Meg kell adni neki egy repteret, es egy tablat amikben fighter classID-k vannak.
Opcionalis harmadik parameterkent megadhato, hogy hany figter squad szalljon fel capnek (defaultja 1).
A repter celja, hogy mindig legyen fent megadott szamu fighter squadja.
]]
--[[AutoDoc
usage: luaCapManager(airfield, fighterClassIDs, capSquadNumber)
category: Unit
shortdesc:
desc:
]]
function luaCapManager(airfield, fighterClassIDs, capSquadNumber)
-- RELEASE_LOGOFF  	luaHelperLog("luaCapManager Called!")
-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable({airfield}), "***ERROR: luaCapManager needs an airfield/carrier as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(fighterClassIDs ~= nil and luaIsNumberTable(fighterClassIDs), "***ERROR: luaCapManager needs a classID table as second param!"..debug.traceback())
	if capSquadNumber then
-- RELEASE_LOGOFF  		Assert(type(capSquadNumber) == "number", "***ERROR: luaCapManager's capSquadNumber must be a number!"..debug.traceback())
	else
		capSquadNumber = 1
	end

	local slotSetting = GetProperty(airfield, "NumSlots")
	local activeSquads = 0
	local planeEntTable = {}
	activeSquads, planeEntTable = luaGetSlotsAndSquads(airfield)
	if activeSquads == 0 and IsReadyToSendPlanes(airfield) then
		local i = luaRnd(1,table.getn(fighterClassIDs))
		local slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],3)
		airfield.slots = GetProperty(airfield, "slots")
		planeEntTable = {}
		table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
-- RELEASE_LOGOFF  		luaHelperLog("luaCapManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
	elseif activeSquads < slotSetting and IsReadyToSendPlanes(airfield) then
		if table.getn(luaTypeFilter(planeEntTable, "Fighter")) < capSquadNumber then
			local i = luaRnd(1,table.getn(fighterClassIDs))
			local slotIndex = LaunchSquadron(airfield,fighterClassIDs[i],3)
			airfield.slots = GetProperty(airfield, "slots")
			table.insert(planeEntTable, thisTable[tostring(airfield.slots[slotIndex].squadron)])
-- RELEASE_LOGOFF  			luaHelperLog("luaCapManager Generated:"..planeEntTable[table.getn(planeEntTable)].Name)
		end
	elseif activeSquads >= slotSetting then
-- RELEASE_LOGOFF  		luaHelperLog("luaCapManager Status: There isn't any free slots!"..airfield.Name)
	else
-- RELEASE_LOGOFF  		luaHelperLog("luaCapManager Status: Airfield occupied!"..airfield.Name)
	end

	if not planeEntTable then
		return
	end

	for index, unit in pairs (planeEntTable) do
		unit.unitcommand = GetProperty(unit, "unitcommand")
		if unit.Class.Type == "Fighter" then
			--luaHelperLog("Unit on patrol:"..unit.Name..unit.unitcommand)
		end
	end
end

--[[
luaLaunchAirstrike egy legicsapas elokeszitesere szolgal.
Meg kell adni neki ket pozitiv szamot, egy reptereket tartalmazo tablat, egy tablat amikben classID-k vannak,
es egy ures/entity-ket tartalmazo tablat.
A fv a kovetkezoket hajtja vegre:
Ha a phase kisebb mint a stopPhase megprobal a megadott airfield listaban szereplo repterekrol/hordozokrol
felkuldeni classID listaban szereplo squadokat (a listabol mindig a phase szerint kovetkezo elemet veszi loopolva).
Minden egyes squad felkuldese utan lepteti a phase-t es hozzaadja az ujonnan generalt entityt a megadott listahoz.
Ha a phase nem kisebb mint a stopPhase, akkor nem csinal semmit.
Celszeru a fv a megadott ideig minden thinkben meghivni ugyanazokkal a parameterekkel. Ilyenkor egyszercsak eloall
egy entitylista akiket ezutan majd kuldhetunk legicsapni.
Visszateresi ertek a phase, az entitytabla es egy errorLevel.
Az errorLevel a kovetkezo ertekeket veszi fel:
0 -	minden franko, a squadok felszallas alatt.
1 -	a megadott phase nem kisebb mint a stopPhase, azaz keszen vagyunk.
	kuldhetjuk a csapast, ha nem nil az entitylista.
2 - 	error, minden repter halott ahonnan kuldeni akarunk. a phase felveszi a stopPhase erteket.
	ettol fuggetlenul kuldhetjuk a csapast, ha nem ures az entitylista.
3 - 	error, egyik repteren sincs szabad slot. a phase felveszi a stopPhase erteket.
	ettol fuggetlenul kuldhetjuk a csapast, ha nem ures az entitylista.
4 - 	skip, minden repter foglalt, bar ez nem feltetlenul problema.
	ha fontos, hogy ne varjunk sokaig, akkor x skip utan kuldhetjuk a csapast, ha nem ures az entitylista.
]]
--[[AutoDoc
usage: luaLaunchAirstrike(phase, stopPhase, airfields, classIDs, entities)
category: Unit
shortdesc:
desc:
]]
function luaLaunchAirstrike(phase, stopPhase, airfields, classIDs, entities, equipments)
-- RELEASE_LOGOFF  	Assert(type(phase) == "number" and phase > 0, "***ERROR: luaLaunchAirstrike needs a positive number as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(stopPhase) == "number" and phase > 0, "***ERROR: luaLaunchAirstrike needs a positive number as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(airfields ~= nil and luaIsAirfieldTable(airfields, true), "***ERROR: luaLaunchAirstrike needs a table which consists of airfield/carrier entities as third param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(classIDs ~= nil and luaIsNumberTable(classIDs), "***ERROR: luaLaunchAirstrike needs a classID table as fourth param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(entities ~= nil and luaIsEntityTable(entities, true), "***ERROR: luaLaunchAirstrike needs an entity table as fifth param!"..debug.traceback())

	if not equipments or type(equipments) ~= "table" then
		equipments = {}
	end

	if phase >= stopPhase then
-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Warning: StopPhase already reached!")
		--luaLog("luaLaunchAirstrike Warning: StopPhase already reached!")
		return phase, entities, 1
	end
	airfields = luaRemoveDeadsFromTable(airfields)
	if table.getn(airfields) == 0 then
-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Error: There isn't any living airfield!")
		--luaLog("luaLaunchAirstrike Error: There isn't any living airfield!")
		phase = stopPhase
		return phase, entities, 2
	end
	local airfieldWarning = 0
	local airfieldSuccess = 0

	for index, airfield in pairs (airfields) do
		if phase >= stopPhase then
-- RELEASE_LOGOFF  			luaHelperLog("luaLaunchAirstrike Skipped: StopPhase reached! "..airfield.Name)
			--luaLog("luaLaunchAirstrike Skipped: StopPhase reached! "..airfield.Name)
		else
			airfield.slots = GetProperty(airfield, "slots")
			local numberOfUsedSlots = 0
			local i=1
			while i<5 do
				if airfield.slots[i].squadron ~= nil then
					numberOfUsedSlots = numberOfUsedSlots + 1
				end
				i=i+1
			end
			if numberOfUsedSlots > 3 then
-- RELEASE_LOGOFF  				luaHelperLog("luaLaunchAirstrike Warning: The following airfield has no available slots! "..airfield.Name)
				--luaLog("luaLaunchAirstrike Warning: The following airfield has no available slots! "..airfield.Name)
				airfieldWarning = airfieldWarning + 1
			elseif numberOfUsedSlots < 4 then
				if IsReadyToSendPlanes(airfield) then
					local i = math.mod(phase-1,table.getn(classIDs))+1
					local slotIndex
					if equipments[i] and type(equipments[i]) == "number" then
						slotIndex = LaunchSquadron(airfield,classIDs[i],3,equipments[i])
					else
						slotIndex = LaunchSquadron(airfield,classIDs[i],3)
					end
					airfield.slots = GetProperty(airfield, "slots")
					table.insert(entities, thisTable[tostring(airfield.slots[slotIndex].squadron)])
-- RELEASE_LOGOFF  					luaHelperLog("luaLaunchAirstrike Generated: "..entities[table.getn(entities)].Name)
					--luaLog("luaLaunchAirstrike Generated: "..entities[table.getn(entities)].Name)
					phase = phase + 1
					airfieldSuccess = airfieldSuccess + 1
				elseif not IsReadyToSendPlanes(airfield) then
-- RELEASE_LOGOFF  					luaHelperLog("luaLaunchAirstrike Skipped: Airfield occupied! "..airfield.Name)
					--luaLog("luaLaunchAirstrike Skipped: Airfield occupied! "..airfield.Name)
				end
			end
		end
	end
	if airfieldWarning == table.getn(airfields) then
-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Skipped: There isn't any free slots!")
		--luaLog("luaLaunchAirstrike Skipped: There isn't any free slots!")
		--phase = stopPhase
		return phase, entities, 3
	end
	if airfieldSuccess > 0 then
		return phase, entities, 0
	else
-- RELEASE_LOGOFF  		luaHelperLog("luaLaunchAirstrike Skipped: All airfields are busy!")
		--luaLog("luaLaunchAirstrike Skipped: All airfields are busy!")
		return phase, entities, 4
	end
end

--[[AutoDoc
usage: luaAirPatrol(target, innerRange, outerRange, airPatrolPlanes, airPatrolTable, airPatrolParty)
category: Unit
shortdesc:
desc:
]]
function luaAirPatrol(target, innerRange, outerRange, airPatrolPlanes, airPatrolTable, airPatrolParty)
-- RELEASE_LOGOFF  	luaHelperLog("luaAirPatrol Called!")
-- RELEASE_LOGOFF  	Assert(target ~= nil and (luaIsCoordinate(target) or target.ID ~= nil), "***ERROR: luaAirPatrol needs a coordinate/entity as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(innerRange) == "number" and innerRange >= 0, "***ERROR: luaAirPatrol needs a positive number or 0 as second param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(outerRange) == "number" and outerRange > 0, "***ERROR: luaAirPatrol needs a positive number as third param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(innerRange <= outerRange, "***ERROR: luaAirPatrol's outerRange should be equal to or greater than innerRange!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(airPatrolPlanes ~= nil and luaIsPlaneTable(airPatrolPlanes, true), "***ERROR: luaAirPatrol needs a table which consists of airplane entities as fourth param!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(airPatrolTable ~= nil and luaIsAirPatrolTable(airPatrolTable, true), "***ERROR: luaAirPatrol needs a table which consists of AirPatrol entries as fifth param!"..debug.traceback())
	if airPatrolParty then
		if luaIsCoordinate(target) then
-- RELEASE_LOGOFF  			Assert(airPatrolParty == PARTY_ALLIED or airPatrolParty == PARTY_JAPANESE, "***ERROR: luaAirPatrol needs a party (PARTY_ALLIED or PARTY_JAPANESE) as sixth param!"..debug.traceback())
		else
-- RELEASE_LOGOFF  			Assert(false, "***ERROR: luaAirPatrol needs a party only if the target is a coordinate!"..debug.traceback())
		end
	end

	local bombersAround = {}
	local targetPos

	if luaIsCoordinate(target) then
		local planesAround = luaGetPlanesAroundCoordinate(target, outerRange, airPatrolParty, "enemy", nil, "divebomber")
		if planesAround then
			bombersAround = planesAround
		end
		targetPos = target
	else
		local planesAround  = luaGetPlanesAround(target, outerRange, "enemy")
		if not planesAround then
			planesAround = {}
		end
		bombersAround = luaTypeFilter(planesAround, "DiveBomber")
		targetPos = GetPosition(target)
	end

	if table.getn(bombersAround) == 0 then
-- RELEASE_LOGOFF  		luaHelperLog("There are no bombers in range!")
	end

	local idleFighters = luaIdleUnitFilter(airPatrolPlanes)

	for i, bomberPlane in pairs (bombersAround) do
		local foundInTable = false
-- RELEASE_LOGOFF  		luaHelperLog("luaAirPatrol Status: Checking "..bomberPlane.Name.." in AirPatrol list...")
		for index, airPatrol in pairs (airPatrolTable) do
			if airPatrol.BomberPlane == bomberPlane then
				if airPatrol.FighterPlane.Dead then
-- RELEASE_LOGOFF  					luaHelperLog("luaAirPatrol Status: Previous guardian squad is killed!")
					table.remove(airPatrolTable[index])
					break
				else
-- RELEASE_LOGOFF  					luaHelperLog("luaAirPatrol Status: Guardian squad "..airPatrol.FighterPlane.Name.." is chasing this enemy!")
					foundInTable = true
					airPatrol.UpToDate = true
					break
				end
			end
		end
		if not foundInTable then
			if table.getn(idleFighters) ~= 0 then
				idleFighters = luaIdleUnitFilter(idleFighters)
			end

			if table.getn(idleFighters) ~= 0 then
-- RELEASE_LOGOFF  				luaHelperLog("luaAirPatrol Status: Selecting guardian squad for the chase...")
				local nearestFighter = luaSortByDistance(bomberPlane, idleFighters, true)
				luaSetScriptTarget(nearestFighter, bomberPlane)
-- RELEASE_LOGOFF  				luaHelperLog("luaAirPatrol Status: Guardian squad "..nearestFighter.Name.." has locked this enemy!")
				local tempTable = {}
					tempTable["FighterPlane"] = nearestFighter
					tempTable["BomberPlane"] = bomberPlane
					tempTable["UpToDate"] = true
				table.insert(airPatrolTable, tempTable)
			else
-- RELEASE_LOGOFF  				luaHelperLog("luaAirPatrol Status: There is no idle guardian squad!")
			end
		end
	end

	if table.getn(airPatrolTable) ~= 0 then
-- RELEASE_LOGOFF  		luaHelperLog("luaAirPatrol Status: Updating AirPatrol list!")
	end
	local tempPatrolTable = {}
	for index, airPatrol in pairs (airPatrolTable) do
		if airPatrol.UpToDate then
			airPatrol.UpToDate = false
			table.insert(tempPatrolTable, airPatrol)
		else
-- RELEASE_LOGOFF  			luaHelperLog("luaAirPatrol Status: Removing "..airPatrol.BomberPlane.Name.." from AirPatrol list!")
			if not airPatrol.FighterPlane.Dead then
				luaSetScriptTarget(airPatrol.FighterPlane, nil)
			end
		end
	end
	airPatrolTable = tempPatrolTable

	local sortedAngleTable = {}
	local wanderingPlanes = {}
	for index, unit in pairs (airPatrolPlanes) do
		unit.unitcommand = GetProperty(unit, "unitcommand")
		if unit.unitcommand == "moveto" then
			local currentTargetPos = GetPrimaryTarget(unit)
			if not luaIsCoordinate(currentTargetPos) then
				currentTargetPos = GetPosition(currentTargetPos)
			end

			if innerRange <= luaGetDistance(targetPos, currentTargetPos) and luaGetDistance(targetPos, currentTargetPos) <= (innerRange + 10) then
				local newAngle = luaGetAngle("world", targetPos, currentTargetPos)

				if table.getn(sortedAngleTable) == 0 then
					table.insert(sortedAngleTable, newAngle)
				else
					for i, angle in pairs (sortedAngleTable) do
						if newAngle < angle then
							table.insert(sortedAngleTable, i, newAngle)
							break
						elseif table.getn(sortedAngleTable) == i then
							table.insert(sortedAngleTable, newAngle)
							break
						end
					end
				end
			else
				table.insert(wanderingPlanes, unit)
			end
		end
	end

	for index, unit in pairs (wanderingPlanes) do
		if table.getn(sortedAngleTable) ~= 0 then
			local firstAngle = sortedAngleTable[1]
			local lastAngle = sortedAngleTable[1]
			local bestIndex = 1
			local bestDifferenceAngle = 360
			for i, angle in pairs (sortedAngleTable) do
				if i ~= 1 then
					if bestDifferenceAngle == 360 or (angle - lastAngle) > bestDifferenceAngle then
						bestIndex = i
						bestDifferenceAngle = angle - lastAngle
					end
					lastAngle = angle
				end
				if i == table.getn(sortedAngleTable) and table.getn(sortedAngleTable) ~= 1 then
					if (360 - angle + firstAngle) > bestDifferenceAngle then
						bestIndex = 1
						bestDifferenceAngle = 360 - angle + firstAngle
					end
				end
			end
			local newAngle = sortedAngleTable[bestIndex] - luaRound((bestDifferenceAngle / 2))
			if newAngle < 0 then
				newAngle = newAngle + 360
			end

			for i, angle in pairs (sortedAngleTable) do
				if newAngle < angle then
					table.insert(sortedAngleTable, i, newAngle)
					break
				elseif table.getn(sortedAngleTable) == i then
					table.insert(sortedAngleTable, newAngle)
					break
				end
			end

-- RELEASE_LOGOFF  			luaHelperLog("luaAirPatrol Status: Guardian squad "..unit.Name.." is returning for patrol at "..newAngle.."!")
			PilotMoveTo(unit, luaMoveCoordinate(targetPos, (innerRange+5), newAngle))
		else
			local currentTargetPos = GetPosition(unit)
			local newAngle = luaGetAngle("world", targetPos, currentTargetPos)
			table.insert(sortedAngleTable, newAngle)

-- RELEASE_LOGOFF  			luaHelperLog("luaAirPatrol Status: Guardian squad "..unit.Name.." is returning for patrol at "..newAngle.."!")
			PilotMoveTo(unit, luaMoveCoordinate(targetPos, innerRange, newAngle))
		end
	end
	return airPatrolTable
end

--[[AutoDoc
usage: luaRemoveAllFromStocks(airbase, classID)
category: Unit
shortdesc: adott 'clasID'-u repulok kivesz az airbasebol
desc: vegigiteral egy airbase stockjain es kiszedi belole a 'classID'-u unitokat
airbase: table, a vizsgalt airbase entity
calssID: number, adott unit VechicleClasses.lua-ban szereplo kulcsa
]]
function luaRemoveAllFromStocks(airbase, classID)
-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable({airbase}), "***ERROR: luaRemoveAllFromStocks requires an airbase as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaHelperLog("Removing full stock from airbase "..airbase.Name)
-- RELEASE_LOGOFF  	luaHelperLog("Removable class: "..classID)

	local classnum = 0
	airbase.planes = GetProperty(airbase, "planes")
	for key, value in pairs(airbase.planes) do
		if value.classid == classID then
			classnum = classnum + value.count
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("Total number: "..classnum)

	RemoveAirBasePlanes(airbase, classID, classnum)
end

--[[AutoDoc
usage: luaClearDialogs()
category: Dialog
shortdesc: torli a dialogusokat
desc: a kiirasra varo dialogusokat troli egy idozito segitsegevel a queue-bol
]]
function luaClearDialogs()
	luaDelay(luaClearDialogsCallback, 0.01)
end

--[[AutoDoc
usage: luaClearDialogs()
category: Dialog
shortdesc: luaClearDialogs() idozito fv-e
desc: ez az idozito torli a dialogusokat
]]
function luaClearDialogsCallback()
-- RELEASE_LOGOFF  	luaHelperLog("Removing all dialogues from queue.")
	local dlgs = GetActDialogIDs()

	for key, value in pairs(dlgs) do
-- RELEASE_LOGOFF  		luaHelperLog("+ Clearing dialogue: "..value)
		--BreakDialog(value)
		KillDialog(value)
	end

-- RELEASE_LOGOFF  	luaHelperLog("-> Done!")
end

--[[AutoDoc
usage: luaTorpedoReloader(entityOrCoordinateTable [,range] [,torpedoNumberOverride])
category: Unit
shortdesc: feltolti a unit torpedostockjat
desc: az 'entityOrCoordinateTable'-ben listazott objektumok 'range' tavolsagon belul 'torpedoNumberOverride' szamu torpedoval toltik fel egy egyseg torpedostockjat
entityOrCoordinateTable: table, egy lista melynek kozeleben a feltoltes tortenik
range: number, ilyen messze kezd el feltolteni, default 200 m
torpedoNumberOverride: number, ennyi torpedoval toltodik fel, default az egyseg max. torpedo szama
]]
function luaTorpedoReloader(entityOrCoordinateTable, range, torpedoNumberOverride)
-- RELEASE_LOGOFF  	luaHelperLog("luaTorpedoReloader Called!")
-- RELEASE_LOGOFF  	Assert(entityOrCoordinateTable ~= nil and luaIsEntityOrCoordinateTable(entityOrCoordinateTable), "***ERROR: luaTorpedoReloader needs a table which consists of coordinates and/or entities as first param!"..debug.traceback())
	if range then
-- RELEASE_LOGOFF  		Assert(type(range) == "number" and range > 0, "***ERROR: luaTorpedoReloader needs a positive number as second param!"..debug.traceback())
	else
		range = 200
	end
	if torpedoNumberOverride then
-- RELEASE_LOGOFF  		Assert(type(torpedoNumberOverride) == "number" and torpedoNumberOverride > 0, "***ERROR: luaTorpedoReloader needs a positive number as third param!"..debug.traceback())
	end

	for index, harbor in pairs (entityOrCoordinateTable) do
		local shipsAround = {}
		if luaIsCoordinate(harbor) then
-- RELEASE_LOGOFF  			luaHelperLog("luaTorpedoReloader Harbor: coordinate")
			shipsAround = luaGetShipsAroundCoordinate(harbor, range, Mission.Party, "own")
		else
-- RELEASE_LOGOFF  			luaHelperLog("luaTorpedoReloader Harbor: "..harbor.Name..", Dead: "..tostring(harbor.Dead))
			if not harbor.Dead then
				shipsAround = luaGetShipsAround(harbor, range, "own")
			end
		end

		if shipsAround then
			for i, ship in pairs (shipsAround) do
				if ship.Class.MaxTorpedoStock ~= nil then
					if torpedoNumberOverride then
-- RELEASE_LOGOFF  						luaHelperLog("luaTorpedoReloader Setting torpedo stock of "..ship.Name.." to "..torpedoNumberOverride)
						ShipSetTorpedoStock(ship, torpedoNumberOverride)
					else
-- RELEASE_LOGOFF  						luaHelperLog("luaTorpedoReloader Setting torpedo stock of "..ship.Name.." to "..tostring(ship.Class.MaxTorpedoStock))
						ShipSetTorpedoStock(ship, ship.Class.MaxTorpedoStock)
					end
				end
			end
		end
	end
end

--[[AutoDoc
usage: luaSetCountdown(txt,startlvl,cdwntime,clbk,clbkparams)
category: Mission
shortdesc: beallitja egy visszaszamlalas parametereit
desc: osszegzi egy visszaszamlalas felteteleit a megadott parameterek alapjan
txt: string, a szoveg amit kiirunk
startlvl: number,
cdwntime: number, ennyi sec. utan jar le a countdown
clbk: function, ezt a fv-t hivja meg, ha lejar a visszaszamlalas
clbkparams: table, a callback fv parameterei
]]
function luaSetCountdown(txt,startlvl,cdwntime,clbk,clbkparams)
-- RELEASE_LOGOFF  	Assert(type(txt) == "string", "ERROR: luaSetCountdown first param is not set or it's type isn't string")
-- RELEASE_LOGOFF  	Assert(type(startlvl) == "number", "ERROR: luaSetCountdown second param is not set or it's type isn't number")
-- RELEASE_LOGOFF  	Assert(type(cdwntime) == "number", "ERROR: ERROR: luaSetCountdown third param is not set or it's type isn't number")
-- RELEASE_LOGOFF  	Assert(type(clbk) == "string", "ERROR: ERROR: luaSetCountdown fourth param is not set or it's type isn't string")

	if startlvl > 3 then
-- RELEASE_LOGOFF  		luaHelperLog("Warning luaSetCountdown startlevel value is more than 3, you made a bad lookin' gui dude!")
	end

	Mission.CountdownTbl = {
		["txt"] = txt,
		["StartLevel"] = startlvl,
		["CountdownTime"] = cdwntime,
		["Callback"] = clbk,
		["CallbackParams"] = clbkparams,
	}

	Mission.CountdownStopped = false
end

--[[AutoDoc
usage: luaStartCountdown()
category: Mission
shortdesc: elinditja a visszaszamlalast
desc: egy luaSetCountdown() altal beallitott visszamlalast indit el
]]
function luaStartCountdown()
	Countdown(Mission.CountdownTbl.txt, Mission.CountdownTbl.StartLevel, Mission.CountdownTbl.CountdownTime, Mission.CountdownTbl.Callback, Mission.CountdownTbl.CallbackParams)
-- RELEASE_LOGOFF  	luaHelperLog("Starting countdown with params: txt: "..tostring(Mission.CountdownTbl.txt)..", startlvl: "..tostring(Mission.CountdownTbl.StartLevel)..", time: "..tostring(Mission.CountdownTbl.CountdownTime)..", callback: "..tostring(Mission.CountdownTbl.Callback)..", clbparams: "..tostring(Mission.CountdownTbl.CallbackParams))
end

--[[AutoDoc
usage: luaGenerateObjectsDelayed(entNameTable, callback [,callbackType] [,renameTable])
category: Mission
shortdesc: idozitett entity generalas
desc: az 'entNameTable'-ben felsorolt entityket generalja be majd meghivja a 'callback' fv-t, a 'callbackType' alapjan, es atnevezi oket a 'renameTable' alapjan
entNameTable: table, ezeket az entityket generaljuk be
callback: function, ezt a fuggvenyt hivjuk meg
callbackType: string, 'each' vagy 'end' lehet, azaz minden generalas utan avagy csak a vegen hivjuk e meg a 'callback' fv-t
renameTable: table, nevek felsorolva Name kulccsal, erre nevezodnek at a generalt unitok
]]
function luaGenerateObjectsDelayed(entNameTable, callback, callbackType, renameTable)
-- RELEASE_LOGOFF  	luaHelperLog("Calling delayed generation")
-- RELEASE_LOGOFF  	Assert(type(entNameTable) == "table", "***ERROR: luaGenerateObjectsDelayed(entNameTable, callback, cbType) first param is not a table!"..debug.traceback())
	--Assert(type(callback) == "function", "***ERROR: luaGenerateObjectsDelayed(entNameTable, callback, cbType) second param must be a function!"..debug.traceback())

	local paramTable = {}

	if callbackType == nil then
		paramTable.CallbackType = "each"
	else
		paramTable.CallbackType = callbackType
	end

-- RELEASE_LOGOFF  	Assert(paramTable.CallbackType == "each" or paramTable.CallbackType == "end", "***ERROR: luaGenerateObjectsDelayed 3rd param must be 'each' or 'end' or nil!"..debug.traceback())

-- RELEASE_LOGOFF  	luaLogTableNames(entNameTable, "Delayed generation :")

	paramTable.Names = {}

	local delay = 0.1 + luaRnd()

	--luaLog("KAKAS! : "..tostring(delay))

	local timer =
		{
			{
				[1] = false,
				[2] = delay
			}
		}

	for key, value in pairs(entNameTable) do
		if value.Name == nil then
			error("***ERROR: luaGenerateObjectsDelayed has a value without Name at key "..key, 3)
		end

		local delay = 0.1 + luaRnd()

		--luaLog("KAKAS! : "..tostring(delay))

		table.insert(timer, {[1] = luaGenerateObjectsDelayedTimer, [2] = delay})
-- RELEASE_LOGOFF  		luaHelperLog(" Packing "..value.Name.." to param table")
		table.insert(paramTable.Names, value)
	end

	paramTable.Callback = callback
	if renameTable ~= nil then
-- RELEASE_LOGOFF  		Assert(type(renameTable) == "table", "***ERROR: renameTable must be a table!"..debug.traceback())
-- RELEASE_LOGOFF  		Assert(luaCountTable(renameTable) == luaCountTable(entNameTable), "***ERROR: renameTable size must be equal to entNameTable size!"..debug.traceback())
		paramTable.RenameTable = renameTable
	end

	return CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaGenerateObjectsDelayedTimer(timerthis)
category: Mission
shortdesc: idozitett entity generalas idozito fv-e
desc: a luaGenerateObjectsDelayed() fv idozito fv, mely a tenyleges generalast vegzi
timerthis: table, luaGenerateObjectsDelayed() altal atadott valtozok osszessege
]]
function luaGenerateObjectsDelayedTimer(timerthis)
-- RELEASE_LOGOFF  	luaHelperLog("Delayed timer called")

	if timerthis.EnteredNum == nil then
		timerthis.EnteredNum = 1
		timerthis.GeneratedUnits = {}
	else
		timerthis.EnteredNum = timerthis.EnteredNum + 1
	end

-- RELEASE_LOGOFF  	luaHelperLog(timerthis.ParamTable.Names)
-- RELEASE_LOGOFF  	luaHelperLog(" Entered num : "..timerthis.EnteredNum)
-- RELEASE_LOGOFF  	luaHelperLog(" Generating "..timerthis.ParamTable.Names[timerthis.EnteredNum].Name)

	local generatedUnit

	if timerthis.ParamTable.RenameTable == nil then
		generatedUnit = GenerateObject(timerthis.ParamTable.Names[timerthis.EnteredNum].Name)
	else
-- RELEASE_LOGOFF  		luaHelperLog(" New name given: "..timerthis.ParamTable.RenameTable[timerthis.EnteredNum].Name)
		generatedUnit = GenerateObject(timerthis.ParamTable.Names[timerthis.EnteredNum].Name, timerthis.ParamTable.RenameTable[timerthis.EnteredNum].Name)
	end

	table.insert(timerthis.GeneratedUnits, generatedUnit)
-- RELEASE_LOGOFF  	luaHelperLog(" + Done!")

	if timerthis.ParamTable.Callback ~= nil then
		if timerthis.ParamTable.CallbackType == "end" and timerthis.ParamTable.Names[timerthis.EnteredNum+1] == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" Entered last time, calling callback function...")
			timerthis.ParamTable.Callback(timerthis.GeneratedUnits)
		elseif timerthis.ParamTable.CallbackType == "each" then
			timerthis.ParamTable.Callback(generatedUnit)
		end
	end

end

--[[AutoDoc
usage: luaSpawnDelayed(entNameTable, spawnType, target, minDist, maxDist, height, angle0, angle1, callback, callbackType, renameTable)
category: Mission
shortdesc: idozitett entity spawn
desc: az 'entNameTable'-ben felsorolt entityket generalja be majd meghivja a 'callback' fv-t, a 'callbackType' alapjan, es atnevezi oket a 'renameTable' alapjan, a spawn az angle es dist, height paramaeterek figyelmbevetelevel tortenik
entNameTable: table, ezeket az entityket generaljuk be
spawnType:
target: table, ehhez kepest spawnolunk
minDist: number, minimum ilyen messze tortenik a spqwn, m.
maxDist: number, maximum ilyen messze tortenik a spqwn, m.
height: number, ilyen magasan jon letre az uj entitas, m.
angle0: number, a szogtartomany elso szoge amelyben a targethez kepest spawnolunk
angle1: number, a szogtartomany masodik szoge amelyben a targethez kepest spawnolunk
callback: function, ezt a fuggvenyt hivjuk meg
callbackType: string, 'each' vagy 'end' lehet, azaz minden generalas utan avagy csak a vegen hivjuk e meg a 'callback' fv-t
renameTable: table, nevek felsorolva Name kulccsal, erre nevezodnek at a generalt unitok
]]
function luaSpawnDelayed(entNameTable, spawnType, target, minDist, maxDist, height, angle0, angle1, callback, callbackType, renameTable)
-- RELEASE_LOGOFF  	luaHelperLog("Calling delayed spawn")


-- RELEASE_LOGOFF  	Assert(type(entNameTable) == "table", "***ERROR: luaSpawnDelayed' first param must be a templatename table!"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(not target.Dead, "***ERROR: luaSpawnDelayed' target is already dead!"..debug.traceback())

	local paramTable = {}

	if callbackType == nil then
		paramTable.CallbackType = "each"
	else
		paramTable.CallbackType = callbackType
	end

-- RELEASE_LOGOFF  	Assert(paramTable.CallbackType == "each" or paramTable.CallbackType == "end", "***ERROR: luaSpawnDelayed callbackType param must be 'each' or 'end' or nil!"..debug.traceback())

-- RELEASE_LOGOFF  	luaLogElementNames(entNameTable, "Delayed spawn :")
	local delay = 0.1 + luaRnd()

	paramTable.Names = {}

	local timer =
		{
			{
				[1] = false,
				[2] = delay
			}
		}

	for key, value in pairs(entNameTable) do
		if value.Name == nil then
			error("***ERROR: luaSpawnDelayed template list has an element without Name at key "..key, 3)
		end
		local delay = 0.1 + luaRnd()
		table.insert(timer, {[1] = luaSpawnDelayedTimer, [2] = delay})
-- RELEASE_LOGOFF  		luaHelperLog(" Packing "..value.Name.." to param table")
		table.insert(paramTable.Names, value)
	end

	local trg
	if target.ID and spawnType ~= ST_RELANGLE then
		trg = GetPosition(target)
	else
		trg = target
	end

	paramTable.Callback = callback
	if renameTable ~= nil then
-- RELEASE_LOGOFF  		Assert(type(renameTable) == "table", "***ERROR: renameTable must be a table!"..debug.traceback())
-- RELEASE_LOGOFF  		Assert(luaCountTable(renameTable) == luaCountTable(entNameTable), "***ERROR: renameTable size must be equal to entNameTable size!"..debug.traceback())
		paramTable.RenameTable = renameTable
	end

	paramTable.SpawnArgs = {
			["spawnType"] = spawnType,
			["target"] = trg,
			["minDist"] = minDist,
			["maxDist"] = maxDist,
			["height"] = height,
			["angle0"] = angle0,
			["angle1"] = angle1,
		}
--[[
		table.insert(paramTable.SpawnArgs, spawnType)
		table.insert(paramTable.SpawnArgs, target)
		table.insert(paramTable.SpawnArgs, minDist)
		table.insert(paramTable.SpawnArgs, maxDist)
		table.insert(paramTable.SpawnArgs, height)
		table.insert(paramTable.SpawnArgs, angle0)
		table.insert(paramTable.SpawnArgs, angle1)
]]
	return CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaSpawnDelayed(entNameTable, spawnType, target, minDist, maxDist, height, angle0, angle1, callback, callbackType, renameTable)
category: Mission
shortdesc: idozitett entity spawn idozito fv-e
desc: a luaSpawnDelayed() parameteri alapjan elvegzi az idozitett spawnt
]]
function luaSpawnDelayedTimer(timerthis)
-- RELEASE_LOGOFF  	luaHelperLog("Delayed timer called")

	if timerthis.EnteredNum == nil then
		timerthis.EnteredNum = 1
		timerthis.GeneratedUnits = {}
	else
		timerthis.EnteredNum = timerthis.EnteredNum + 1
	end

-- RELEASE_LOGOFF  	luaHelperLog(timerthis.ParamTable.Names)
-- RELEASE_LOGOFF  	luaHelperLog(" Entered num : "..timerthis.EnteredNum)
-- RELEASE_LOGOFF  	luaHelperLog(" Spawning "..timerthis.ParamTable.Names[timerthis.EnteredNum].Name)

	local params = timerthis.ParamTable
	local spawnParams = timerthis.ParamTable.SpawnArgs

	--local generatedUnit = GenerateObject(timerthis.ParamTable.Names[timerthis.EnteredNum].Name)

	local generatedUnit
	if spawnParams.target.Dead and spawnParams.spawnType == ST_RELANGLE then
-- RELEASE_LOGOFF  		luaHelperLog(" -- Target is dead and angle was relative!")
		return
	end

	if params.RenameTable ~= nil then
		generatedUnit = luaSpawn(params.Names[timerthis.EnteredNum].Name, spawnParams.spawnType,
			spawnParams.target, spawnParams.minDist, spawnParams.maxDist, spawnParams.height,
			spawnParams.angle0, spawnParams.angle1, params.RenameTable[timerthis.EnteredNum].Name)
	else
		generatedUnit = luaSpawn(params.Names[timerthis.EnteredNum].Name, spawnParams.spawnType,
			spawnParams.target, spawnParams.minDist, spawnParams.maxDist, spawnParams.height,
			spawnParams.angle0, spawnParams.angle1)
	end

	table.insert(timerthis.GeneratedUnits, generatedUnit)
-- RELEASE_LOGOFF  	luaHelperLog(" + Done!")

	if timerthis.ParamTable.Callback ~= nil then
		if timerthis.ParamTable.CallbackType == "end" and timerthis.ParamTable.Names[timerthis.EnteredNum+1] == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" Entered last time, calling callback function...")
			timerthis.ParamTable.Callback(timerthis.GeneratedUnits)
		elseif timerthis.ParamTable.CallbackType == "each" then
			timerthis.ParamTable.Callback(generatedUnit)
		end
	end
end

--[[AutoDoc
usage: luaMassKillDelayed(entTable, callback, callbackType)
category: Mission
shortdesc: idozitett entity kill
desc: az 'entTable'-ben felsorolt entityket idozitve megoli
entTable: table, a megsemmisitendo entityk listaja
callback: function, ezt a fuggvenyt hivjuk meg
callbackType: string, 'each' vagy 'end' lehet, azaz minden generalas utan avagy csak a vegen hivjuk e meg a 'callback' fv-t
]]
function luaMassKillDelayed(entTable, callback, callbackType)
-- RELEASE_LOGOFF  	luaHelperLog("Calling mass kill...")
-- RELEASE_LOGOFF  	Assert(type(entTable) == "table", "***ERROR: luaMassKillDelayed(entTable, callback, cbType) first param is not a table!"..debug.traceback())
	--Assert(type(callback) == "function", "***ERROR: luaGenerateObjectsDelayed(entNameTable, callback, cbType) second param must be a function!"..debug.traceback())

	local paramTable = {}

	if callbackType == nil then
		paramTable.CallbackType = "each"
	else
		paramTable.CallbackType = callbackType
	end

-- RELEASE_LOGOFF  	Assert(paramTable.CallbackType == "each" or paramTable.CallbackType == "end", "***ERROR: luaMassKillDelayed 3rd param must be 'each' or 'end' or nil!"..debug.traceback())

-- RELEASE_LOGOFF  	luaLogTableNames(entTable, "Delayed kill :")
	local delay = 0.1 + luaRnd()

	paramTable.Ents = {}

	local timer =
		{
			{
				[1] = false,
				[2] = delay
			}
		}

	for key, value in pairs(entTable) do
		local delay = 0.1 + luaRnd()
		table.insert(timer, {[1] = luaMassKillDelayedTimer, [2] = delay})
-- RELEASE_LOGOFF  		luaHelperLog(" Packing "..value.Name.." to param table")
		table.insert(paramTable.Ents, value)
	end

	paramTable.Callback = callback

	return CreateScript("luaDoTimeTable", timer, paramTable)
end

--[[AutoDoc
usage: luaMassKillDelayedTimer(timerthis)
category: Mission
shortdesc: idozitett entity kill idozito fv-e
desc: luaMassKillDelayed()-ben beallitott parameterek alapjan vegrehajtja a kill-t
timerthis: table, luaMassKillDelayed()-ben osszegzett valtozok
]]
function luaMassKillDelayedTimer(timerthis)
-- RELEASE_LOGOFF  	luaHelperLog("Delayed killtimer called")

	if timerthis.EnteredNum == nil then
		timerthis.EnteredNum = 1
		timerthis.KilledUnits = {}
	else
		timerthis.EnteredNum = timerthis.EnteredNum + 1
	end

	--luaHelperLog(timerthis.ParamTable.Ents) 	-- too deep recursion
-- RELEASE_LOGOFF  	luaHelperLog(" Entered num : "..timerthis.EnteredNum)

	local killedUnit = timerthis.ParamTable.Ents[timerthis.EnteredNum]
-- RELEASE_LOGOFF  	luaHelperLog(" Unit being killed: "..killedUnit.Name)
	table.insert(timerthis.KilledUnits, killedUnit)

	if killedUnit.Dead then
-- RELEASE_LOGOFF  		luaHelperLog("  Its already dead, skippin'")
	else
-- RELEASE_LOGOFF  		luaHelperLog("  Killin'")
		Kill(killedUnit, true)
	end

-- RELEASE_LOGOFF  	luaHelperLog(" + Done!")

	if timerthis.ParamTable.Callback ~= nil then
		if timerthis.ParamTable.CallbackType == "end" and timerthis.ParamTable.Ents[timerthis.EnteredNum+1] == nil then
-- RELEASE_LOGOFF  			luaHelperLog(" Entered last time, calling callback function...")
			timerthis.ParamTable.Callback(timerthis.KilledUnits)
		elseif timerthis.ParamTable.CallbackType == "each" then
			timerthis.ParamTable.Callback(killedUnit)
		end
	end
end

--[[
luaSpawn a Spawn kodfuggveny upgradelt valtozata.
A feladata, hogy a normal spawn hibas mukodese eseten is letrehozza az entitast,
amit az nem volt hajlando begeneralni.
Parameterezese teljesen megegyezik a regi spawn fuggvennyel, problema nelkul cserelheto.
Ha a spawn nem generalt, akkor repulo eseteben megprobalja 1500-al magasabb magassagban
letrehozni eloszor a unitot.
Ha ez nem sikerul, vagy a hajot generaltatunk, akkor jon a teljesen uj resz:
Keres egy poziciot a scene borderen, a megadott szogek alapjan.
Ezutan elekzd innen jobbra-balra lepkedni, ameddig nem talal egy olyan helyet ahol nincs
gep/landscape amivel utkozhetne.
Van meg egy specialis lehetoseg amit celszeru kihasznalni, ha nehezen bejarhato helyek
vannak a palyan:
Megadhatunk egy InvalidSpawnAreas tablat (amit ezennel le is foglalok a luaSpawn fuggvenynek)
amivel kiszurhetjuk azt, hogy egy toba generaljunk egy csatahajot.
Ezt a teruletet a teglalap barmelyik ket atlos csucsaval megadhatjuk a kovetkezok szerint:
	Mission.InvalidSpawnAreas = {}
	table.insert(Mission.InvalidSpawnAreas, {{ ["x"] = -1500, ["y"] = 0, ["z"] = 950 }, { ["x"] = -500, ["y"] = 0, ["z"] = -800 }})
Az y erteke termeszetesen nem szamit.
Ha ennek a fuggvenynek sem sikerul generalnia (Assertal) az azt jelenti, hogy komoly script/design problema van,
ugyanis egy 20*20-as scene keruleten tobb unit elfer mint amennyit az engine elbir!
]]
--[[AutoDoc
usage: luaSpawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1, callback, callbackType, newName)
category: Mission
shortdesc: entity spawn
desc: az 'entNameTable'-ben levo entity-t generalja be majd meghivja a 'callback' fv-t, a 'callbackType' alapjan, es atnevezi oket a 'newName' alapjan, a spawn az angle es dist, height paramaeterek figyelmbevetelevel tortenik
templateName: table, ezt az entity-t generaljuk be
spawnType:
targetEntOrPos: table, ehhez kepest spawnolunk
minDist: number, minimum ilyen messze tortenik a spqwn, m.
maxDist: number, maximum ilyen messze tortenik a spqwn, m.
height: number, ilyen magasan jon letre az uj entitas, m.
angle0: number, a szogtartomany elso szoge amelyben a targethez kepest spawnolunk
angle1: number, a szogtartomany masodik szoge amelyben a targethez kepest spawnolunk
callback: function, ezt a fuggvenyt hivjuk meg
callbackType: string, 'each' vagy 'end' lehet, azaz minden generalas utan avagy csak a vegen hivjuk e meg a 'callback' fv-t
newName: string, erre nevezodik at a general unit
]]
function luaSpawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1, newName)

	return Spawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1, newName, true)

--[[
	--luaHelperLog("luaSpawn Called!")

	if targetEntOrPos then
		if not luaIsCoordinate(targetEntOrPos) then
-- RELEASE_LOGOFF  			Assert(not targetEntOrPos.Dead, "***ERROR: luaSpawn needs a coordinate or living entity as fourth parameter!"..debug.traceback())
		end
	end
	local invalidSpawn = true
	--TODO: gaborral egyeztetni, hogy a sima Spawn ne generaljon szarazfoldre, avagy a laci fele IsAreaClear-t beleiratni
	local tempEntity
	if newName then
		tempEntity = Spawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1, newName)
	else
		tempEntity = Spawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1)
	end
	if tempEntity then
-- RELEASE_LOGOFF  		luaHelperLog("luaSpawn: Spawn has generated an entity.")
		invalidSpawn = false
		if luaGetType(tempEntity) ~= "plane" then
			local tempPos = GetPosition(tempEntity)
			if Mission.InvalidSpawnAreas then
				for index, spawnArea in pairs (Mission.InvalidSpawnAreas) do
					if luaIsInArea(spawnArea, tempPos) then
-- RELEASE_LOGOFF  						luaHelperLog("luaSpawn: Killing the generated ship because it has been generated into a restricted area!")
						invalidSpawn = true
						Kill(tempEntity, true)
						break
					end
				end
			end
		end
	end
	if invalidSpawn then
-- RELEASE_LOGOFF  		luaHelperLog("luaSpawn: Previous Spawn attempts has failed!")
		if newName then
			tempEntity = GenerateObject(templateName, newName)
		else
			tempEntity = GenerateObject(templateName)
		end
		if luaGetType(tempEntity) == "plane" then
-- RELEASE_LOGOFF  			luaHelperLog("luaSpawn: Spawning the plane with higher altitude ...")
			local tempEntity2
			if newName then
				tempEntity2 = Spawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, (height + 2100), angle0, angle1, newName)
			else
				tempEntity2 = Spawn(templateName, spawnType, targetEntOrPos, minDist, maxDist, (height + 2100), angle0, angle1)
			end
			if tempEntity2 then
-- RELEASE_LOGOFF  				luaHelperLog("luaSpawn: ... has succeded!")
				Kill(tempEntity, true)
				tempEntity = tempEntity2
			else
-- RELEASE_LOGOFF  				luaHelperLog("luaSpawn: ... has failed!")
-- RELEASE_LOGOFF  				luaHelperLog("luaSpawn: The last option is to spawn the unit on the scene border!")
				local radius = 100
				--luaHelperLog("radius")
				--luaHelperLog(radius)

				local angle = (angle0 + angle1) / 2
				local borderCross
				if luaIsEntityTable({targetEntOrPos}, false) and spawnType == ST_ABSANGLE then
					local tempPos = GetPosition(targetEntOrPos)
					borderCross = GetBorderCross(tempPos, angle)
				else
					borderCross = GetBorderCross(targetEntOrPos, angle)
				end
				--luaHelperLog("borderCross")
				--luaHelperLog(borderCross)
				if borderCross == nil then
-- RELEASE_LOGOFF  					Assert(false, "GetBorderCross has returned nil!!!", debug.traceback())
				else
					local newPos =
					{
						["x"] = borderCross.x,
						["y"] = borderCross.y + 2000,
						["z"] = borderCross.z
					}
					borderCross = newPos
				end

				local secureBorderCross
				local i = 0
				repeat
					local movedPos = {}
					--luaHelperLog("i = "..i)
					--luaHelperLog("movedPos tabla uresen")
					--luaHelperLog(movedPos)
					if i == 0 then
						table.insert(movedPos, borderCross)
					else
						local movedPos1
						local movedPos2
						movedPos1, movedPos2 = luaMoveOnBorder(borderCross, (i*radius*2))
						if movedPos1 then
							table.insert(movedPos, movedPos1)
						end
						if movedPos1 then
							table.insert(movedPos, movedPos2)
						end
					end
					--luaHelperLog("movedPos tabla feltoltve")
					--luaHelperLog(movedPos)
					if table.getn(movedPos) ~= 0 then
						for i, tempPos in pairs (movedPos) do
							--luaHelperLog("tempPos")
							--luaHelperLog(tempPos)
							local invalidSpawnPos
							if Mission.InvalidSpawnAreas then
								for index, spawnArea in pairs (Mission.InvalidSpawnAreas) do
									if luaIsInArea(spawnArea, tempPos) then
										invalidSpawnPos = true
										break
									end
								end
							end
							if not invalidSpawnPos then
								invalidSpawnPos = luaGetPlanesAroundCoordinate(tempPos, radius*1.5, PARTY_ALLIED, "own", nil)
								--luaHelperLog("allied")
								--luaHelperLog(invalidSpawnPos)
							end
							if not invalidSpawnPos then
								invalidSpawnPos = luaGetPlanesAroundCoordinate(tempPos, radius*1.5, PARTY_JAPANESE, "own", nil)
								--luaHelperLog("japanese")
								--luaHelperLog(invalidSpawnPos)
							end
							if not invalidSpawnPos then
								local rotation
								if luaIsEntityTable({targetEntOrPos}, false) then
									rotation = luaGetAngle("world", tempPos, GetPosition(targetEntOrPos))
								else
									rotation = luaGetAngle("world", tempPos, targetEntOrPos)
								end
								secureBorderCross = tempPos
-- RELEASE_LOGOFF  								luaHelperLog("luaSpawn: Found a secure border position ...")
								--luaHelperLog("secureBorderCross")
-- RELEASE_LOGOFF  								luaHelperLog(secureBorderCross)
								rotation = 360 - rotation
								--TODO: repulo squadokra is leellenorizni a forgatast, mert nem volt jo
								PutTo(tempEntity, secureBorderCross, rotation)
								--luaHelperLog("tempEntity's position after PutTo")
								--luaHelperLog(GetPosition(tempEntity))
								break
							end
						end
					else
-- RELEASE_LOGOFF  						Assert(false, "luaSpawn: Can't spawn unit! Report this immediately to the level designer!")
					end
					i = i + 1
				until secureBorderCross
			end
		else
-- RELEASE_LOGOFF  			luaHelperLog("luaSpawn: The last option is to spawn the unit on the scene border!")
			local radius = (tempEntity.Class.Length / 2)
			--luaHelperLog("length / 2")
			if (tempEntity.Class.Width / 2) > radius then
				radius = (tempEntity.Class.Width / 2)
				--luaHelperLog("width / 2")
			end
			--luaHelperLog("radius")
			--luaHelperLog(radius)

			local angle = (angle0 + angle1) / 2
			local borderCross
			if luaIsEntityTable({targetEntOrPos}, false) and spawnType == ST_ABSANGLE then
				local tempPos = GetPosition(targetEntOrPos)
				borderCross = GetBorderCross(tempPos, angle)
			else
				borderCross = GetBorderCross(targetEntOrPos, angle)
			end
			--luaHelperLog("borderCross")
			--luaHelperLog(borderCross)
			if borderCross == nil then
-- RELEASE_LOGOFF  				Assert(false, "GetBorderCross has returned nil!!!", debug.traceback())
			end

			local secureBorderCross
			local i = 0
			repeat
				local movedPos = {}
				--luaHelperLog("i = "..i)
				--luaHelperLog("movedPos tabla uresen")
				--luaHelperLog(movedPos)
				if i == 0 then
					table.insert(movedPos, borderCross)
				else
					local movedPos1
					local movedPos2
					movedPos1, movedPos2 = luaMoveOnBorder(borderCross, (i*radius*2))
					if movedPos1 then
						table.insert(movedPos, movedPos1)
					end
					if movedPos1 then
						table.insert(movedPos, movedPos2)
					end
				end
				--luaHelperLog("movedPos tabla feltoltve")
				--luaHelperLog(movedPos)
				if table.getn(movedPos) ~= 0 then
					for i, tempPos in pairs (movedPos) do
						--luaHelperLog("tempPos")
						--luaHelperLog(tempPos)
						local invalidSpawnPos
						if Mission.InvalidSpawnAreas then
							for index, spawnArea in pairs (Mission.InvalidSpawnAreas) do
								if luaIsInArea(spawnArea, tempPos) then
									invalidSpawnPos = true
									break
								end
							end
						end
						if not invalidSpawnPos then
							--luaHelperLog("IsAreaEmpty")
							--luaHelperLog(IsAreaEmpty(tempPos, radius))
							invalidSpawnPos = not(IsAreaEmpty(tempPos, radius))
							--luaHelperLog("invalidSpawnPos")
							--luaHelperLog(invalidSpawnPos)
						end
						if not invalidSpawnPos then
							local rotation
							if luaIsEntityTable({targetEntOrPos}, false) then
								rotation = luaGetAngle("world", tempPos, GetPosition(targetEntOrPos))
							else
								rotation = luaGetAngle("world", tempPos, targetEntOrPos)
							end
							secureBorderCross = tempPos
							--luaHelperLog("secureBorderCross")
-- RELEASE_LOGOFF  							luaHelperLog("luaSpawn: Found a secure border position ...")
-- RELEASE_LOGOFF  							luaHelperLog(secureBorderCross)
							rotation = 360 - rotation
							PutTo(tempEntity, secureBorderCross, rotation)
							--luaHelperLog("tempEntity's position after PutTo")
							--luaHelperLog(GetPosition(tempEntity))
							break
						end
					end
				else
-- RELEASE_LOGOFF  					Assert(false, "luaSpawn: Can't spawn unit! Report this immediately to the level designer!")
				end
				i = i + 1
			until secureBorderCross
		end
	end

	return tempEntity
]]
end

--[[AutoDoc
usage: luaGetNearestPathPointCoordinate(targetUnit, pathEnt [,ignoredIndeces])
category: Mission
shortdesc: visszaadja path legkozelebbi pontjat
desc: visszadja a 'pathEnt' legkozelebbi pontjat a 'targetUnit'-hoz kepest, esetleges kihagyva az 'ignoredIndeces' pathpoint indexeket
targetUnit: table, ehhez kepest vizsgaljuk a path-t
pathEnt: table, ennek a pathnak a pointjaira vagyunk kivancsiak
ignoredIndeces: table, ezeket a pathpoint indexeket nem vesszuk figyelembe
]]
function luaGetNearestPathPointCoordinate(targetUnit, pathEnt, ignoredIndeces)
	local pathTable = FillPathPoints(pathEnt)
	local nearestCoordinate = {}
	local nearestIndex
	local nearestDistance = 1000000
	if ignoredIndeces == nil then
		ignoredIndeces = {}
	end
	if next(pathTable) then
		for index, coordinate in pairs (pathTable) do
			local allowedIndex = true
			for i, ignoredIndex in pairs (ignoredIndeces) do
				if index == ignoredIndex then
					allowedIndex = false
					break
				end
			end
			if allowedIndex then
				local currentDistance = luaGetDistance(targetUnit, coordinate)
				if currentDistance < nearestDistance then
					nearestCoordinate = coordinate
					nearestIndex = index
					nearestDistance = currentDistance
				end
			end
		end
		table.insert(ignoredIndeces, nearestIndex)
		return nearestCoordinate, ignoredIndeces, nearestDistance
	else
		return nil
	end
end

--[[AutoDoc
usage: luaGetFarthestPathPointCoordinate(targetUnit, pathEnt [,ignoredIndeces])
category: Mission
shortdesc: visszaadja path legtavolabbi pontjat
desc: visszadja a 'pathEnt' legtavolabbi pontjat a 'targetUnit'-hoz kepest, esetleges kihagyva az 'ignoredIndeces' pathpoint indexeket
targetUnit: table, ehhez kepest vizsgaljuk a path-t
pathEnt: table, ennek a pathnak a pointjaira vagyunk kivancsiak
ignoredIndeces: table, ezeket a pathpoint indexeket nem vesszuk figyelembe
]]
function luaGetFarthestPathPointCoordinate(targetUnit, pathEnt, ignoredIndeces)
	local pathTable = FillPathPoints(pathEnt)
	local farthestCoordinate = {}
	local farthestIndex
	local farthestDistance = 0
	if ignoredIndeces == nil then
		ignoredIndeces = {}
	end
	if next(pathTable) then
		for index, coordinate in pairs (pathTable) do
			local allowedIndex = true
			for i, ignoredIndex in pairs (ignoredIndeces) do
				if index == ignoredIndex then
					allowedIndex = false
					break
				end
			end
			if allowedIndex then
				local currentDistance = luaGetDistance(targetUnit, coordinate)
				if currentDistance > farthestDistance then
					farthestCoordinate = coordinate
					farthestIndex = index
					farthestDistance = currentDistance
				end
			end
		end
		table.insert(ignoredIndeces, farthestIndex)
		return farthestCoordinate, ignoredIndeces, farthestDistance
	else
		return nil
	end
end

--[[AutoDoc
usage: typeNum, planeNum, shipNum, vehicleNum, fortNum = luaCountUnits(watch)
category: Mission
shortdesc: konzolra kiirja, hogy a Mission terheleset, szerintem mar elavult jol
desc: kiirja a konzolra a Mission terhelest, hogy okos designerek lassak, hogy el fogja e birni adott platform a missziot
watch: bool, true eseten kiirja a konzolra, false es nil eseten nem
typeNum: number, ennyi tipusu unitunk van a misszioban
planeNum: number, ennyi repulonk van a misszioban
vehicleNum: number, ennyi vehicle tipusu unitunk van a misszioban
fortNum: number, ennyi landfort tipusu unitunk van a misszioban
]]
function luaCountUnits(watch)
-- RELEASE_LOGOFF  	luaHelperLog("Counting unit numbers and types")

	if not Mission.UnitCountEnabled then
-- RELEASE_LOGOFF  		luaHelperLog(" Count not allowed.")
		return
	end

	local types, typeNum, planeNum, shipNum, vehicleNum, fortNum = {}, 0, 0, 0, 0, 0
	local poolEater = 0

	for sideStr, side in pairs(recon) do
		for typeStr, unittype in pairs(side.own) do

-- RELEASE_LOGOFF  			luaHelperLog("  unittype: "..typeStr)

			for ID, unit in pairs(unittype) do
-- RELEASE_LOGOFF  				luaHelperLog("   unit: "..unit.Name)

				if not unit.Dead then
					-- typecounter
					local inside = false
					local uType = unit.Class.Type

-- RELEASE_LOGOFF  					luaHelperLog("    checking type: "..uType)
					for key, value in pairs(types) do
						if value == uType then
							inside = true
						end
					end

					if not inside then
-- RELEASE_LOGOFF  						luaHelperLog("    + type "..uType.." not found yet, inserting")
						table.insert(types, uType)
					end

					-- numcounter
					local uType = luaGetType(unit)
					if uType == "plane" then
						planeNum = planeNum + luaGetSquadronPlaneNum(unit)
					elseif uType == "ship" or uType == "sub" then
						shipNum = shipNum + 1
					elseif uType == "vehicle" then
						vehicleNum = vehicleNum + 1
					elseif uType == "landfort" then
						fortNum = fortNum + 1
					end

					--[[ lista
					["Type"] = "AirField",
					["Type"] = "BattleShip",
					["Type"] = "Cargo",
					["Type"] = "Cruiser",
					["Type"] = "Destroyer",
					["Type"] = "DiveBomber",
					["Type"] = "DummyTargetVehicle",
					["Type"] = "Fighter",
					["Type"] = "LandFort",
					["Type"] = "LandVehicle",
					["Type"] = "LandingShip",
					["Type"] = "LargeReconPlane",
					["Type"] = "LevelBomber",
					["Type"] = "MotherShip",
					["Type"] = "Shipyard",
					["Type"] = "SmallReconPlane",
					["Type"] = "Submarine",
					["Type"] = "TorpedoBoat",
					["Type"] = "TorpedoBomber",
					]]

					-- pontos szamitas a terhelesre
					local classType = unit.Class.Type
					if classType == "Fighter" or classType == "DiveBomber" or classType == "TorpedoBomber" or classType == "SmallReconPlane" then
						poolEater = poolEater + luaGetSquadronPlaneNum(unit)
					elseif classType == "LargeReconPlane" or classType == "LevelBomber" then
						poolEater = poolEater + 2*luaGetSquadronPlaneNum(unit)
					elseif classType == "Destroyer" or classType == "Cruiser" or classType == "BattleShip" or classType == "MotherShip" or classType == "Submarine" or classType == "Cargo" then
						poolEater = poolEater + 4
					elseif classType == "TorpedoBoat" or classType == "LandingShip" then
						poolEater = poolEater + 2
					end
				end
			end
		end
	end

	typeNum = luaCountTable(types)
-- RELEASE_LOGOFF  	luaHelperLog("Final types:")
-- RELEASE_LOGOFF  	luaHelperLog(types)
-- RELEASE_LOGOFF  	luaHelperLog(" + typenum: "..typeNum)
-- RELEASE_LOGOFF  	luaHelperLog(" + planenum: "..planeNum)
-- RELEASE_LOGOFF  	luaHelperLog(" + shipnum: "..shipNum)
-- RELEASE_LOGOFF  	luaHelperLog(" + vehiclenum: "..vehicleNum)
-- RELEASE_LOGOFF  	luaHelperLog(" + fortnum: "..fortNum)


	--- obsolete!!
	-- terhelesi mutato (most meg eleg rough kerekitesekkel es pontatlanul)
	-- 20 repulo, 12 hajo --> 1 hajo : 3 repulo, 5 repulo : 1 hajo
	local poolShip = 12
	local poolPlane = 20
	local shipToPlane = 3
	local planeToShip = 1/5

	-- ez hasznalt
	local limit = 68	-- repulokben szamolunk es ott ez a max

	local loadShip = poolShip + poolPlane*planeToShip
	local loadPlane = poolPlane + poolShip*shipToPlane

-- RELEASE_LOGOFF  	luaHelperLog("Ship load: "..loadShip)
-- RELEASE_LOGOFF  	luaHelperLog("Plane load: "..loadPlane)

	--local load = (freeFromPlane*planeToShip + shipNum) + (freeFromShip*shipToPlane + planeNum)

	--local load = planeNum + shipNum*3	-- pontatlan szamitas
	--local load = poolEater		-- pontosabb szamitas
	local load = tostring(poolEater/limit*100).."%"

-- RELEASE_LOGOFF  	luaHelperLog("Load: "..tostring(load))
	--luaHelperLog("Load / limit ratio: "..tostring(load/limit))
-- RELEASE_LOGOFF  	luaHelperLog("Load / limit ratio: "..tostring(poolEater/limit))

	if poolEater/limit > 1 then
-- RELEASE_LOGOFF  		luaLog(" WARNING: Over the PS2's unitlimit!!")	-- warning: missionlog!
	end

	--[[
	if load/limit < 0.5 then
		load = "Very good"
	elseif load/limit > 0.5 and load/limit < 0.8 then
		load = "Good"
	elseif load/limit < 1 and load/limit > 0.8 then
		load = "Loaded"
	elseif load/limit > 1 and load/limit < 1.2 then
		load = "Overloaded"
	elseif load/limit > 1.2 then
		load = "Heavily overloaded !"
	end
	]]

	------------------------------------------

	if watch then
		if not Mission.UnitCount then
			Mission.UnitCount = {}
		end

		Mission.UnitCount.TypeNum = typeNum
-- RELEASE_LOGOFF  		AddWatch("Mission.UnitCount.TypeNum")

		Mission.UnitCount.PlaneNum = planeNum
-- RELEASE_LOGOFF  		AddWatch("Mission.UnitCount.PlaneNum")

		Mission.UnitCount.ShipNum = shipNum
-- RELEASE_LOGOFF  		AddWatch("Mission.UnitCount.ShipNum")

		Mission.UnitCount.VehicleNum = vehicleNum
-- RELEASE_LOGOFF  		AddWatch("Mission.UnitCount.VehicleNum")

		Mission.UnitCount.FortNum = fortNum
-- RELEASE_LOGOFF  		AddWatch("Mission.UnitCount.FortNum")

		Mission.UnitCount.Load = load
-- RELEASE_LOGOFF  		AddWatch("Mission.UnitCount.Load")
	end

	return typeNum, planeNum, shipNum, vehicleNum, fortNum
end

function luaCountUnitsRemoveWatches()
-- RELEASE_LOGOFF  	luaHelperLog("Removing countunits watches")
	if Mission.UnitCount then
		RemoveWatch("Mission.UnitCount.TypeNum")
		RemoveWatch("Mission.UnitCount.PlaneNum")
		RemoveWatch("Mission.UnitCount.ShipNum")
		RemoveWatch("Mission.UnitCount.VehicleNum")
		RemoveWatch("Mission.UnitCount.FortNum")
		RemoveWatch("Mission.UnitCount.Load")
	end
end

--[[AutoDoc
usage: num = luaGetSquadronPlaneNum(ent)
category: Unit
shortdesc: visszadja egy squadronban levo repulok szamat
desc: adott squadron repuloinek szamat adja vissza
ent: table, squadron entity
num: number, ennyi repulot tartalmaz a squadron
]]
function luaGetSquadronPlaneNum(ent)
	local num = 0
	for key, value in pairs(GetSquadronPlanes(ent)) do
		num = num + 1
	end

-- RELEASE_LOGOFF  	luaHelperLog("Plane num in squad "..ent.Name.." is "..num)
	return num
end

--[[AutoDoc
usage: fcoord = luaGetCapPoint(source, target, distance)
category: Mission
shortdesc:
desc:
source:
target:
distance:
]]
function luaGetCapPoint(source, target, distance)
-- RELEASE_LOGOFF  	Assert(source ~= nil and target ~= nil and distance ~= nil, "***ERROR: luaGetCapPoint got a nil parameter!\n--"..debug.traceback())

	local sourceP, sourceT
	if luaIsEntityTable({source}) then
		sourceP = GetPosition(source)
	elseif luaIsCoordinate(source) then
		sourceP = source
	else
-- RELEASE_LOGOFF  		Assert(false, "***ERROR: luaGetCapPoint's source must be a coordinate or entity!\n--"..debug.traceback())
	end

	if luaIsEntityTable({target}) then
		targetP = GetPosition(target)
	elseif luaIsCoordinate(target) then
		targetP = target
	else
-- RELEASE_LOGOFF  		Assert(false, "***ERROR: luaGetCapPoint's target must be a coordinate or entity!\n--"..debug.traceback())
	end

-- RELEASE_LOGOFF  	Assert(type(distance) == "number", "***ERROR: luaGetCapPoint's third param must be a number!\n--"..debug.traceback())

	local angle = luaGetAngle("world", sourceP, targetP)
-- RELEASE_LOGOFF  	luaHelperLog("Angle: "..angle)
	local fcoord = luaMoveCoordinate(sourceP, distance, angle)
-- RELEASE_LOGOFF  	luaHelperLog("Final coordinate: ")
-- RELEASE_LOGOFF  	luaHelperLog(fcoord)

	return fcoord
end

-- Mission fail eseten ezt kell meghivni
--[[AutoDoc
usage: luaMissionFailed(failEnt, failText, movie)
category: Mission
shortdesc: elbuktatja az adott missziot
desc: elbuktatja a missziot, ramozgatja a kamerat a 'failEnt' entityre, kiirja a 'failText'-et es lejatsza a 'movie'-t
failEnt: table, entity, amelyre a kamerat dobjuk
failText: string, ezt az uzenetet irjuk ki warningkent
movie: string, a .bik file neve amit lejatszunk a kameramozgas utan
]]
function luaMissionFailed(failEnt, failText, movie)
-- RELEASE_LOGOFF  	luaHelperLog("luaMissionFailed called...")

-- RELEASE_LOGOFF  	Assert(type(failText) == "string", "***ERROR: luaMissionFailed requires a string as 'failtext'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({failEnt}), "***ERROR: luaMissionFailed requires an entity as 'failent'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Mission ~= nil, "***ERROR: luaMissionFailed requires a Mission running!\n"..debug.traceback())

	Mission.MissionStatus = false

	-- todo:
	-- gameover
	-- +20%-os fade
	-- kritikus entityre kameradobas
	-- bukta okanak kiirasa

	---kuldetes elvesztesenel eloszor "game over" felirat +20%os
	---fade, es zoom a mission failed okara (pl elsullyedo hajo, lelott repulo) Dead ENTITY !!!	-	Arpi
	---majd az 'ok' kiirasa

	EnableInput(false)
	CountdownCancel()
	-- atadjuk az iranyitast az AI-nak
	if not failEnt.Dead then
		local uType = luaGetType(failEnt)
		--luaDoCustomLog(cLog,"getype "..tostring(uType))

		if uType == "plane" then
			--luaDoCustomLog(cLog,"Retreating plane")
			--PilotRetreat(failEnt)
			SetRoleAvailable(failEnt, EROLF_ALL, PLAYER_AI)
		elseif uType == "ship" then
			--luaDoCustomLog(cLog,"Moving ship to borderzone")
			SetRoleAvailable(failEnt, EROLF_ALL, PLAYER_AI)
			NavigatorMoveToRange(failEnt, GetClosestBorderZone(GetPosition(failEnt)))
		end
	end

	-- letiltunk minden warningot
	EnableMessages(false)

	-- mindenkit serthetetlenne teszunk
	for key, value in pairs(luaGetOwnUnits(nil, PARTY_ALLIED)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, true)
		end
	end
	for key, value in pairs(luaGetOwnUnits(nil, PARTY_JAPANESE)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, true)
		end
	end
	for key, value in pairs(luaGetOwnUnits(nil, PARTY_NEUTRAL)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, true)
		end
	end
	HideHint("all")
	Music_Control_SetLevel(MUSIC_DEFEAT)
	Blackout(true, "", false, 0.25)

	MissionNarrativeClear()
	luaClearDialogs()
	MissionNarrative(" Game over ", "luaMissionFailed_CamOnFailEnt")

	Mission.MissionFailParams = {}
	Mission.MissionFailParams.Text = failText
	Mission.MissionFailParams.Ent = failEnt
	Mission.MissionFailParams.Movie = movie
end

--[[AutoDoc
usage: luaMissionFailed_CamOnFailEnt()
category: Mission
shortdesc: a luaMissionFailed() fv kamera fv-e
desc: a luaMissionFailed()-ben meghivott kameramozgast vezerlo fv
]]
function luaMissionFailed_CamOnFailEnt()		-- kameradobas fv
	local ent = Mission.MissionFailParams.Ent
	if TrulyDead(ent) then
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is cold dead, getting last position")
		local pos = ent.LastPosition
		if pos.y < 2 then
			pos.y = 2
		end
		MovCam_PathWalkPathPointPropertyPotlekokkal({ { ["pos"] = pos, }, }, 1, false, 4)
	else
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is just deadmeat yet")
		MovCam_SetDeviationFactor(0)

		local size = ent.Class.Length*1.15
		Mission.MissionFailParams.Size = size

		local uType = luaGetType(ent)

		-- iranybaallitas szamitasai
		local camPos = GetCameraState().Position
		local entDir = luaGetRotation(ent)
		local entPos = GetPosition(ent)
		local fakePos = luaMoveCoordinate(entPos, 1000, entDir)
		local angle = luaGetAngle(camPos, entPos, fakePos)

		if uType == "sub" then
			--MovCam_RefPos_Polar(ent, size, -math.pi/8, -math.pi/12, false, 2)
			MovCam_RefPos_Polar(ent, size, math.rad(angle), -math.pi/12, false, 2)
		elseif uType == "plane" then
			--MovCam_RefPos_Polar(ent, size*1.2, math.pi/4, math.pi/12, false, 2)
			MovCam_RefPos_Polar(ent, size*1.2, math.rad(angle), math.pi/12, false, 2)
		else
			--MovCam_RefPos_Polar(ent, size, math.pi/4, math.pi/12, false, 2)
			MovCam_RefPos_Polar(ent, size, math.rad(angle), math.pi/12, false, 2)
		end

--[[ old
		if luaGetType(Mission.MissionFailParams.Ent) == "plane" then
			MovCam_RefPos_Radius(Mission.MissionFailParams.Ent, 100, false, 4)
		else
			MovCam_RefPos_Radius(Mission.MissionFailParams.Ent, 350, false, 4)
		end
]]
		luaDelay(luaMissionFailed_CamRound, 2)
	end

	luaDelay(luaMissionFailed_FailText, 2)
	luaDelay(luaFadeAway, 12)
end

--[[AutoDoc
usage: luaMissionFailed_CamRound()
category: Mission
shortdesc: a luaMissionFailed() fv kamera fv-e
desc: a luaMissionFailed()-ben meghivott kameramozgast vezerlo fv
]]
function luaMissionFailed_CamRound()
	local size = Mission.MissionFailParams.Size
	local uType = luaGetType (Mission.MissionFailParams.Ent)

	if not TrulyDead(Mission.MissionFailParams.Ent) then
		MovCam_HandMode_Targeted(Mission.MissionFailParams.Ent, true)
		-- old MovCam_AddInterpolator("walkHInput", 0.5, 0.5, 0, 30)

		-- visszaallitjuk az eredeti sebesseget es gyorsulast
		MovCam_ResetSpeedLimits()
		MovCam_ResetAccelTime()
-- RELEASE_LOGOFF  		luaLog("<< _CamRound type: "..tostring(uType)..", size: "..tostring(size).." >>")
-- RELEASE_LOGOFF  		luaLog("Origsize in mission: "..tostring(Mission.MissionFailParams.Size))
		luaMissionEndCamRound_ext(uType, size)

		if Mission.MissionFailParams.Ent.Dead and (uType == "plane" or uType == "sub" or uType == "ship") then
			luaDelay(luaMissionFailed_CamDown, 0.3)
		end
	end
end

--[[AutoDoc
usage: luaMissionEndCamRound_ext(uType, size)
category: Mission
shortdesc: a luaMissionFailed() fv interpolalt kamera fv-e
desc: a luaMissionFailed()-ben meghivott kameramozgast vezerlo fv
uType: string, a luaMissionFailed()-ben beallitott entity tipusa
size: number, a kamera mozgast meghatarzo parameter, a luaMissionFailed() beallitja
]]
function luaMissionEndCamRound_ext(uType, size)
-- RELEASE_LOGOFF  	luaLog("<< _ext type: "..tostring(uType)..", size: "..tostring(size).." >>")
	if uType == "plane" then
		MovCam_AddInterpolator("walkHInput", size/1400, size/1400, 0, 18)	-- es korbemegyunk a merettol fuggo sebesseggel
	elseif uType == "ship" then
		MovCam_AddInterpolator("walkHInput", size/1500, size/1500, 0, 18)	-- es korbemegyunk a merettol fuggo sebesseggel
	elseif uType == "sub" then
		MovCam_AddInterpolator("walkHInput", size/1550, size/1550, 0, 18)	-- es korbemegyunk a merettol fuggo sebesseggel
	else
		MovCam_AddInterpolator("walkHInput", size/1500, size/1500, 0, 18)	-- es korbemegyunk a merettol fuggo sebesseggel
	end
end

--[[AutoDoc
usage: luaMissionFailed_CamDown()
category: Mission
shortdesc: a luaMissionFailed() fv interpolalt kamera fv-e
desc: a luaMissionFailed()-ben meghivott kameramozgast vezerlo fv
]]
function luaMissionFailed_CamDown()
	MovCam_AddInterpolator("walkVInput", 0.15, 0, 0, 10)	-- lefele megyunk
	MovCam_AddInterpolator("zoomInput", 0.15, 0, 0, 4)	-- zoom
end

--[[AutoDoc
usage: luaFadeAway([callback] [,turnMusicOff] [,fadeTime])
category: Mission
shortdesc: lefadeli a kepernyot
desc: Blackout fv segitsegevel lefadel 'fadeTime' sec alatt, es opcionalisan kikapcsolja a zenet
callback: string, a fv neve amit meghivunk blackout eseten
turnMusicOff: bool, true eseten elhallgat a zene, false es nil eseten nem
fadeTime: number, ennyi sec. utan tortenik meg a teljes fade
]]
function luaFadeAway(callback, turnMusicOff, fadeTime)
-- RELEASE_LOGOFF  	luaHelperLog("Fading away to dark")
	--luaLog("Fadeaway called, messages false "..debug.traceback())
	EnableMessages(false)
	SoundFade(0, "", 2)
-- RELEASE_LOGOFF  	luaLog("turnMusicOff: "..tostring(turnMusicOff))
	if turnMusicOff then
		MusicFade(0) -- 2 sec alatt
	end
	BlackBars(false)
	if callback == nil or type(callback) ~= "string" then
		if fadeTime and type(fadeTime) == "number" then
			Blackout(true, "", fadeTime)
		else
			Blackout(true, "")
		end
	else
-- RELEASE_LOGOFF  		luaHelperLog("Param: "..tostring(callback))
		if fadeTime and type(fadeTime) == "number" then
			Blackout(true, callback, fadeTime)
		else
			Blackout(true, callback)
		end

	end
end

--[[AutoDoc
usage: luaFadeIn([callback] [,msg])
category: Mission
shortdesc: felfadel
desc: Blackout fv segitsegevel felfadel es opcionalisan nem kapcsolja vissza a message systemet
callback: string, a fv neve amit meghivunk blackout eseten
msg: bool, true eseten nem kapcsolja vissza a message systemet, false es nil eseten igen
]]
function luaFadeIn(callback, msg)
-- RELEASE_LOGOFF  	luaHelperLog("Fading in to light")

	if not msg then
		--luaLog("Fadein called, messages true "..debug.traceback())
		EnableMessages(true)
	end

	SoundFade(1, "", 2)
	MusicFade(1)

	if callback == nil or type(callback) ~= "string" then
		Blackout(false, "")
	else
-- RELEASE_LOGOFF  		luaHelperLog("Param: "..tostring(callback))
		Blackout(false, callback)
	end
end

--[[AutoDoc
usage: luaFadeIn(cb1, cb2)
category: Mission
shortdesc: le es felfade
desc: Blackout fv segitsegevel lefadel  majd felfadel es meghivja minden fade utan az adott callbakc fv-t
cb1: function, a lefade utan meghivando fv neve
cb2: function, a felfade utan meghivando fv neve
]]
function luaCrossFade(cb1, cb2)
-- RELEASE_LOGOFF  	luaLog("Crossfade started")
	luaFadeAway("luaCrossFade1")	-- itt volt kikapcsolva a zene
	if Mission.Helpers == nil then
		Mission.Helpers = {}
	end
	Mission.Helpers.CrossfadeCB1 = cb1
	Mission.Helpers.CrossfadeCB2 = cb2
end

function luaCrossFade1()
	if Mission.Helpers.CrossfadeCB1 then
		Mission.Helpers.CrossfadeCB1()
	end
	luaFadeIn("luaCrossFade2")
end

function luaCrossFade2()
	if Mission.Helpers.CrossfadeCB2 then
		Mission.Helpers.CrossfadeCB2()
	end
	Mission.Helpers.CrossfadeCB1 = nil
	Mission.Helpers.CrossfadeCB2 = nil
end

--[[AutoDoc
usage: luaMissionFailed_FailText()
category: Mission
shortdesc: a luaMissionFailed()-ben megadott szoveget irja ki
desc: a luaMissionFailed()-ben meghivott szovegirast vezerlo fv
]]
function luaMissionFailed_FailText()			-- failtext fv
	if Mission.MissionFailParams.Movie == nil then
		--MissionNarrative(Mission.MissionFailParams.Text, "EndScene")
		MissionNarrative(Mission.MissionFailParams.Text)
		luaDelay(EndScene, 12)

	else
		--MissionNarrative(Mission.MissionFailParams.Text, "luaMissionCompleted_FailMovie")
		MissionNarrative(Mission.MissionFailParams.Text)
		luaDelay(luaMissionFailed_FailMovie, 12)
	end
end

--[[AutoDoc
usage: luaMissionFailed_FailMovie()
category: Mission
shortdesc: a luaMissionFailed()-ben megadott moviet hivja meg
desc: a luaMissionFailed()-ben meghivott movie vezerlo fv
]]
function luaMissionFailed_FailMovie()
	PlayBinkMovie(Mission.MissionFailParams.Movie, "", true)
end

-- Multi mission complete eseten kell meghivni
--[[AutoDoc
usage: luaMultiMissionCompleted(winnerParty, complEnt)
category: Mission
shortdesc: megnyeri az adott partynak a multi missziot
desc: adott 'winnerParty'-ra beallitja a misszio sikeresseget es ramozgatja a kamerat a 'complEnt'-re
winnerParty: enum, a gyoztes party (PARTY_ALLIED, PARTY_JAPANESE)
complEnt: table, az entity this tablaja amire a kamera mozogni fog
]]
function luaMultiMissionCompleted(winnerParty, complEnt)
-- RELEASE_LOGOFF  	luaHelperLog("luaMultiMissionCompleted called...")

-- RELEASE_LOGOFF  	Assert(winnerParty == PARTY_ALLIED or winnerParty == PARTY_JAPANESE, "***ERROR: luaMultiMissionCompleted requires a valid party!\n"..debug.traceback())
	--Assert(luaIsEntityTable({complEnt}), "***ERROR: luaMultiMissionCompleted requires an entity as 'complEnt'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Mission ~= nil, "***ERROR: luaMultiMissionCompleted requires a Mission running!\n"..debug.traceback())


	Mission.MissionStatus = true

	local MPlayers = Multi_GetPlayers()
	for playerID, PartyID  in pairs (MPlayers) do
		if PartyID == winnerParty then
			Scoring_SetMissionCompleted(playerID, true)
		else
			Scoring_SetMissionCompleted(playerID, false)
		end
	end

	Blackout(true, "", false, 0.25)
	EnableInput(false)

	if not complEnt then
		complEnt = luaPickRnd(luaGetOwnUnits(nil, winnerParty))
	end

	Blackout(true, "", false, 0.25)
	MissionNarrative("missionglobals.obj_compl", "luaMissionEnd_CamOnEnt")


--	Mission.MissionComplParams = {}
--	Mission.MissionComplParams.Ent = complEnt
--	luaMissionCompleted_CamOnComplEnt()
end

-- Mission complete eseten kell meghivni
--[[AutoDoc
usage: luaMissionCompleted(complEnt, complText, movie, noRanking, onlymovie)
category: Mission
shortdesc: megnyri az adott missziot
desc: megnyeri a missziot, ramozgatja a kamerat a 'complEnt' entityre, kiirja a 'complText'-et es opcionalisan kihagyja a pontozast, estleg csak .bik moviet jatszik le ingame kamera mozgas kihagyasaval
complEnt: table, az entity this tablaja amire a kamera mozogni fog
complText: string, ezt a szoveget irjuk ki
movie: tring, a .bik movie neve amit lejatszunk ha lefut a fv
noRanking: bool, true eseten kihagyjuk a pontozast (medal)
onlymovie: bool, true esten nincsen kamera, fade utan egybol a .bik movie kovetkezik
]]
function luaMissionCompleted(complEnt, complText, movie, noRanking, onlymovie)
	--local cLog = "MissionComp.log"
-- RELEASE_LOGOFF  	luaHelperLog("luaMissionCompleted called...")

-- RELEASE_LOGOFF  	Assert(type(complText) == "string", "***ERROR: luaMissionCompleted requires a string as 'complText'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({complEnt}), "***ERROR: luaMissionCompleted requires an entity as 'complEnt'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Mission ~= nil, "***ERROR: luaMissionCompleted requires a Mission running!\n"..debug.traceback())

	Mission.MissionStatus = true

	-- letiltunk minden warningot
	EnableMessages(false)

	-- inputtiltas
	EnableInput(false)

	-- Countdown letiltasa
	CountdownCancel()
	-- atadjuk az iranyitast az AI-nak
	if not complEnt.Dead then
		local uType = luaGetType(complEnt)

		if uType == "plane" then
			SetRoleAvailable(complEnt, EROLF_ALL, PLAYER_AI)
		elseif uType == "ship" then
			SetRoleAvailable(complEnt, EROLF_ALL, PLAYER_AI)
			NavigatorMoveToRange(complEnt, GetClosestBorderZone(GetPosition(complEnt)))
		end
	end

	-- mindenkit serthetetlenne teszunk
	for key, value in pairs(luaGetOwnUnits(nil, PARTY_ALLIED)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible allied units: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, true)
		end
	end

	for key, value in pairs(luaGetOwnUnits(nil, PARTY_JAPANESE)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible Japanese units: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, true)
		end
	end

	for key, value in pairs(luaGetOwnUnits(nil, PARTY_NEUTRAL)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible neutral units: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, true)
		end
	end

	HideHint("all")
	Music_Control_SetLevel(MUSIC_VICTORY)
	Scoring_SetMissionCompleted(true)
	MissionNarrativeClear()
	--ezzel csinnyan kell banni mert lehet hogy kellenek zarodialogusok, szoval inkabb akkor hivjuk ha ures a queue
	luaClearDialogs()

	--luaLog("kakas4")
	if noRanking then
-- RELEASE_LOGOFF  		luaHelperLog("Ranking forbidden")
	else
		local medal = luaGetMedalReward()
		if type(medal) == "number" then
			Scoring_SetRanking(medal)
		else
-- RELEASE_LOGOFF  			luaHelperLog("Wrong medal return value, setting it to bronze")
			Scoring_SetRanking(MEDAL_BRONZE)
		end
	end

	Mission.MissionComplParams = {}
	Mission.MissionComplParams.Text = complText
	Mission.MissionComplParams.Ent = complEnt
	Mission.MissionComplParams.Movie = movie

	if onlymovie then
		Blackout(true, "luaMissionCompleted_ComplMovie")
	else
		Blackout(true, "", false, 0.25)
		MissionNarrative("Mission completed", "luaMissionCompleted_CamOnComplEnt")
	end
end

--[[AutoDoc
usage: luaMissionCompleted_CamOnComplEnt()
category: Mission
shortdesc: a luaMissionCompleted() fv kamera fv-e
desc: a luaMissionCompleted()-ben meghivott kameramozgast vezerlo fv
]]
function luaMissionCompleted_CamOnComplEnt()
	local ent = Mission.MissionComplParams.Ent
	if TrulyDead(ent) then
		--luaLog("kakas2")
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is cold dead, getting last position")
		local pos = ent.LastPosition
		if pos.y < 2 then
			pos.y = 2
		end
		MovCam_PathWalkPathPointPropertyPotlekokkal({ { ["pos"] = pos, }, }, 1, false, 4)
	else
--[[
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is just deadmeat yet")
		MovCam_SetDeviationFactor(0)
		MovCam_RefPos_Radius(Mission.MissionComplParams.Ent, 100, false, 4)
		luaDelay(luaMissionCompleted_CamRound, 3)
]]
		MovCam_SetDeviationFactor(0)

		local size = ent.Class.Length*1.15
		Mission.MissionComplParams.Size = size
		local uType = luaGetType(ent)
-- RELEASE_LOGOFF  		luaLog("<< _CamOnComplEnt type: "..tostring(uType)..", size: "..tostring(size).." >>")

		--luaLog("kakas")

		-- iranybaallitas szamitasai
		local camPos = GetCameraState().Position
		local entDir = luaGetRotation(ent)
		local entPos = GetPosition(ent)
		local fakePos = luaMoveCoordinate(entPos, 1000, entDir)
		local angle = luaGetAngle(camPos, entPos, fakePos)

-- RELEASE_LOGOFF  		luaLog("Angle: "..tostring(angle))

		if uType == "sub" then
			--MovCam_RefPos_Polar(ent, size, -math.pi/8, -math.pi/12, false, 2)
			MovCam_RefPos_Polar(ent, size, math.rad(angle), -math.pi/12, false, 2)
		elseif uType == "plane" then
			--MovCam_RefPos_Polar(ent, size*1.2, math.pi/4, math.pi/12, false, 2)
			MovCam_RefPos_Polar(ent, size*1.2, math.rad(angle), math.pi/12, false, 2)
		else
			--MovCam_RefPos_Polar(ent, size, math.pi/4, math.pi/12, false, 2)
			MovCam_RefPos_Polar(ent, size, math.rad(angle), math.pi/12, false, 2)
		end

		luaDelay(luaMissionCompleted_CamRound, 2)
	end

	luaDelay(luaMissionCompleted_ComplText, 2)
	luaDelay(luaFadeAway, 12)
end

--[[AutoDoc
usage: luaMissionCompleted_CamRound()
category: Mission
shortdesc: a luaMissionCompleted() fv kamera fv-e
desc: a luaMissionCompleted()-ben meghivott kameramozgast vezerlo fv
]]
function luaMissionCompleted_CamRound()
	if not TrulyDead(Mission.MissionComplParams.Ent) then
--[[ old timer
		MovCam_HandMode_Targeted(Mission.MissionComplParams.Ent)
		MovCam_AddInterpolator("walkHInput", 0.5, 0.5, 0, 30)
]]
		MovCam_HandMode_Targeted(Mission.MissionComplParams.Ent, true)

		-- visszaallitjuk az eredeti sebesseget es gyorsulast
		MovCam_ResetSpeedLimits()
		MovCam_ResetAccelTime()

		local size = Mission.MissionComplParams.Size
-- RELEASE_LOGOFF  		luaLog("<< _CamRound type: "..tostring(uType)..", size: "..tostring(size).." >>")
		luaMissionEndCamRound_ext(uType, size)

		if Mission.MissionComplParams.Ent.Dead and (uType == "plane" or uType == "sub" or uType == "ship") then
			luaDelay(luaMissionFailed_CamDown, 0.3)
		end
	end
end

--[[AutoDoc
usage: luaMissionCompleted_ComplText()
category: Mission
shortdesc: a luaMissionCompleted()-ben megadott szoveget irja ki
desc: a luaMissionCompleted()-ben meghivott szovegirast vezerlo fv
]]
function luaMissionCompleted_ComplText()
	if Mission.MissionComplParams.Text ~= nil then
		MissionNarrative(Mission.MissionComplParams.Text)
	end
	if Mission.MissionComplParams.Movie == nil then
		--MissionNarrative(Mission.MissionComplParams.Text, "EndScene")
		luaDelay(EndScene, 12)
	else
		--MissionNarrative(Mission.MissionComplParams.Text, "luaMissionCompleted_ComplMovie")
		luaDelay(luaMissionCompleted_ComplMovie, 12)
	end
end

--[[AutoDoc
usage: luaMissionCompleted_ComplText()
category: Mission
shortdesc: a luaMissionCompleted()-ben megadott moviet jatsza le
desc: a luaMissionCompleted()-ben meghivott movie-t vezerlo fv
]]
function luaMissionCompleted_ComplMovie()
	PlayBinkMovie(Mission.MissionComplParams.Movie, "", true)
end

--[[
-- Mission fail eseten kell meghivni / uj movcam cucc
function luaMissionFailedNew(failEnt, failText, movie, noRanking, onlymovie)
-- RELEASE_LOGOFF  	luaHelperLog("luaMissionFailed NEW called...")

-- RELEASE_LOGOFF  	Assert(type(failText) == "string", "***ERROR: luaMissionFailed requires a string as 'failText'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({failEnt}), "***ERROR: luaMissionFailed requires an entity as 'failEnt'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Mission ~= nil, "***ERROR: luaMissionFailed requires a Mission running!\n"..debug.traceback())

	Mission.MissionStatus = false

	-- letiltunk minden warningot
	EnableMessages(false)

	-- inputtiltas
	EnableInput(false)

	-- Countdown letiltasa
	CountdownCancel()
	-- atadjuk az iranyitast az AI-nak
	if not failEnt.Dead then
		local uType = luaGetType(failEnt)

		if uType == "plane" then
			SetRoleAvailable(failEnt, EROLF_ALL, PLAYER_AI)
		elseif uType == "ship" then
			SetRoleAvailable(failEnt, EROLF_ALL, PLAYER_AI)
			NavigatorMoveToRange(failEnt, GetClosestBorderZone(GetPosition(failEnt)))
		end
	end

	-- mindenkit serthetetlenne teszunk
	for key, value in pairs(luaGetOwnUnits(nil, PARTY_ALLIED)) do
		--luaLog(" Setting invincible allied units: "..value.Name)	-- tmp
		SetInvincible(value, true)
	end

	for key, value in pairs(luaGetOwnUnits(nil, PARTY_JAPANESE)) do
		--luaLog(" Setting invincible Japanese units: "..value.Name)	-- tmp
		SetInvincible(value, true)
	end

	for key, value in pairs(luaGetOwnUnits(nil, PARTY_NEUTRAL)) do
		--luaLog(" Setting invincible neutral units: "..value.Name)	-- tmp
		SetInvincible(value, true)
	end

	Music_Control_SetLevel(MUSIC_DEFEAT)
	Scoring_SetMissionCompleted(false)
	MissionNarrativeClear()

	-- aktualis dialogusok kiirtasa
	-- ezzel csinnyan kell banni mert lehet hogy kellenek zarodialogusok, szoval inkabb akkor hivjuk a completedet, ha ures a queue
	luaClearDialogs()

	Mission.MissionFailParams = {}
	Mission.MissionFailParams.Text = failText
	Mission.MissionFailParams.Ent = failEnt
	Mission.MissionFailParams.Movie = movie

	if onlymovie then
		Blackout(true, "luaMissionFailed_FailMovie")
	else
		Blackout(true, "", false, 0.3)
		--MissionNarrative("Mission completed", "luaMissionCompleted_CamOnComplEnt")
		MissionNarrative("missionglobals.obj_fail", "luaMissionFailedNew_CamOnFailEnt")
	end
end
]]
--[[AutoDoc
usage: luaMissionFailedNew_CamOnFailEnt()
category: Mission
shortdesc: a luaMissionFailedNew() fv kamera fv-e
desc: a luaMissionFailedNew()-ben meghivott kameramozgast vezerlo fv
]]
function luaMissionFailedNew_CamOnFailEnt()
	local ent = Mission.MissionFailParams.Ent
	if TrulyDead(ent) then
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is cold dead, getting last position")
		local pos = ent.LastPosition
		if pos.y < 2 then
			pos.y = 2
		end
		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {pos.x, pos.y, pos.z}
				},
				["starttime"] = 0,
				["blendtime"] = 4,
				["nonlinearblend"] = 1,
				["transformtype"] = "keepy",
			}
--		MovCamNew_AddPosition(campos)
	else

		local size = ent.Class.Length*1.15
		Mission.MissionFailParams.Size = size
		local uType = luaGetType(ent)
-- RELEASE_LOGOFF  		luaLog("<< _CamOnComplEnt type: "..tostring(uType)..", size: "..tostring(size).." >>")

		-- iranybaallitas szamitasai
		local camPos = GetCameraState().Position
		local entDir = luaGetRotation(ent)
		local entPos = GetPosition(ent)
		local fakePos = luaMoveCoordinate(entPos, 1000, entDir)
		local angle = luaGetAngle(camPos, entPos, fakePos)

		local cam = GetCameraState().Position
		local campos, vertAngle

		if uType == "sub" then
			vertAngle = -15
		elseif uType == "plane" then
			vertAngle = 15
		else
			vertAngle = 15
		end

		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {cam.x, cam.y, cam.z}
				},
				["starttime"] = 0,
				["blendtime"] = 0,
				["transformtype"] = "keepy",
			}
--		MovCamNew_AddPosition(campos)

		campos =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = ent,
				},
				["starttime"] = 0,
				["blendtime"] = 1,
				["transformtype"] = "keepy",
				["nonlinearblend"] = 0.1,
			}
		MovCamNew_AddPosition(campos)

		Mission.MissionFailParams.Angle = angle
		Mission.MissionFailParams.VertAngle = vertAngle

		if not TrulyDead(ent) then
			--luaLog(" MC : size "..tostring(size))
			--luaLog(" MC : type "..tostring(uType))
			--luaLog(" MC : angle "..tostring(Mission.MissionComplParams.Angle))
			--luaLog(" MC : vertangle "..tostring(Mission.MissionComplParams.VertAngle))

			if ent.Dead and (uType == "plane" or uType == "ship") then
				--MissionNarrativeUrgent("cam init")
				--luaLog("MC : right in, going down")
				local campos =
					{
						["postype"] = "cameraandtarget",
						["position"] =
						{
							["parent"] = ent,
							["modifier"] =
							{
								["name"] = "goaround",
								["radius"] = {size},
								["rho"] = {Mission.MissionFailParams.Angle, 30, Mission.MissionFailParams.Angle+60},
								["theta"] = {Mission.MissionFailParams.VertAngle, 9, -7},
							},
						},
						["starttime"] = 0,
						["blendtime"] = 4,
						["flyalt"] = 1000,
						["maxcamspeed"] = 2000,
						["transformtype"] = "keepy",
						["nonlinearblend"] = 2.4,
						["wanderer"] = true
					}
				MovCamNew_AddPosition(campos)
			else
				--luaLog("MC : will not go down")
				local campos =
					{
						["postype"] = "cameraandtarget",
						["position"] =
						{
							["parent"] = ent,
							["modifier"] =
							{
								["name"] = "goaround",
								["radius"] = {size},
								["rho"] = {Mission.MissionFailParams.Angle, 30, Mission.MissionFailParams.Angle+360},
								["theta"] = {Mission.MissionFailParams.VertAngle},
							},
						},
						["starttime"] = 0,
						["blendtime"] = 4,
						["transformtype"] = "keepy",
						["flyalt"] = 1000,
						["maxcamspeed"] = 2000,
						["nonlinearblend"] = 2.4,
						["wanderer"] = true
					}
				MovCamNew_AddPosition(campos)
			end
		end
	end

	luaDelay(luaMissionFailedNew_FailText, 2)
	luaDelay(luaFadeAway, 16)
end

--[[AutoDoc
usage: luaMissionFailedNew_FailText()
category: Mission
shortdesc: a luaMissionFailedNew() fv szovegkiiro fv-e
desc: a luaMissionFailedNew()-ben meghivott szovegkiirast vezerlo fv
]]
function luaMissionFailedNew_FailText()
	if Mission.MissionFailParams.Text ~= nil then
		MissionNarrative(Mission.MissionFailParams.Text)
	end
	if Mission.MissionFailParams.Movie == nil then
		luaDelay(EndScene, 16)
	else
		luaDelay(luaMissionFailed_FailMovie, 16)
	end
end

-- Mission failed eseten kell meghivni / uj movie-kameras cucc
--[[AutoDoc
usage: luaMissionFailedNew(endEnt, endText, movie, noRanking, onlymovie, ignoreCollision)
category: Mission
shortdesc: elbuktatja az adott missziot
desc: elbuktatja a missziot, ramozgatja a kamerat a 'endEnt' entityre, kiirja a 'endText'-et es lejatsza a 'movie'-t, opcionalisan kikapcsolja a navigator AI elkerules vezerleset, estelegesen kihagyja az ingame kamerat
endEnt: table, entity, amelyre a kamerat dobjuk
endText: string, ezt az uzenetet irjuk ki warningkent
movie: string, a .bik file neve amit lejatszunk a kameramozgas utan
noRanking: bool, true eseten kihagyja a medal osztast
onlymovie: bool, true eseten csak a movie hivodik meg az ingame kamera nem
ignoreCollision: bool, true eseten kiiktatja a navigator AI elkerulo rutinjait
]]
function luaMissionFailedNew(endEnt, endText, movie, noRanking, onlymovie, ignoreCollision)
-- RELEASE_LOGOFF  	luaHelperLog("luaMissionFailed NEW-NEW called...")

-- RELEASE_LOGOFF  	Assert(type(endText) == "string", "***ERROR: luaMissionFailed requires a string as 'endText'!\n"..debug.traceback())
	--Assert(luaIsEntityTable({endEnt}), "***ERROR: luaMissionFailed requires an entity as 'endEnt'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Mission ~= nil, "***ERROR: luaMissionFailed requires a Mission running!\n"..debug.traceback())

	luaInitMissionEnd(endEnt, endText, movie, noRanking, onlymovie, ignoreCollision)
	luaObj_FailedAll(true)
	Mission.MissionStatus = false
	Music_Control_SetLevel(MUSIC_DEFEAT)
	Mission.MusicEndTime = GameTime()+40
	Scoring_SetMissionCompleted(false)

	BannSupportmanager()

	--luaMedalCheck()

	if onlymovie then
-- RELEASE_LOGOFF  		luaHelperLog("Blackout with onlymovie")
		Blackout(true, "luaMissionEnd_Movie")
	else
-- RELEASE_LOGOFF  		luaHelperLog("Blackout")
		Blackout(true, "", false, 0.25)
-- RELEASE_LOGOFF  		luaHelperLog("Narrative")
		MissionNarrative("missionglobals.obj_fail", "luaMissionEnd_CamOnEnt")
	end
end

-- Mission complete eseten kell meghivni / uj movie-kameras cucc
-- multiban is ezt hasznaljuk (es csak ezt, nincs failed!)
--[[AutoDoc
usage: luaMissionCompletedNew(endEnt, endText, movie, noRanking, onlymovie, winnerParty, ignoreCollision)
category: Mission
shortdesc: megnyeri az adott missziot
desc: megnyeri a missziot, ramozgatja a kamerat a 'endEnt' entityre, kiirja a 'endText'-et es lejatsza a 'movie'-t, opcionalisan kikapcsolja a navigator AI elkerules vezerleset, estelegesen kihagyja az ingame kamerat
endEnt: table, entity, amelyre a kamerat dobjuk
endText: string, ezt az uzenetet irjuk ki warningkent
movie: string, a .bik file neve amit lejatszunk a kameramozgas utan
noRanking: bool, true eseten kihagyja a medal osztast
onlymovie: bool, true eseten csak a movie hivodik meg az ingame kamera nem
winnerParty: enum, a gyoztes party-ja, PARTY_ALLIED, PARTY_JAPANESE
ignoreCollision: bool, true eseten kiiktatja a navigator AI elkerulo rutinjait
]]
function luaMissionCompletedNew(endEnt, endText, movie, noRanking, onlymovie, winnerParty, ignoreCollision)
-- RELEASE_LOGOFF  	luaHelperLog("luaMissionCompleted NEW-NEW called...")

-- RELEASE_LOGOFF  	Assert(type(endText) == "string", "***ERROR: luaMissionCompleted requires a string as 'endText'!\n"..debug.traceback())
	--Assert(luaIsEntityTable({endEnt}), "***ERROR: luaMissionCompleted requires an entity as 'endEnt'!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(Mission ~= nil, "***ERROR: luaMissionCompleted requires a Mission running!\n"..debug.traceback())

	luaInitMissionEnd(endEnt, endText, movie, noRanking, onlymovie, ignoreCollision)

	Mission.MissionWinnerParty = winnerParty -- kell az escort frontendes kiirasahoz

	BannSupportmanager()

	-----------------------------------------------------------------------------------
	-- missionkiiras elbiralasa
	--		siker/bukas a partykra multiban
	--		siker single-ben
	---------------------------------------

	Mission.MissionStatus = true
	if not Mission.Multiplayer then
		if not onlymovie then
			Music_Control_SetLevel(MUSIC_VICTORY)
			Mission.MusicEndTime = GameTime()+35
		end
		Scoring_SetMissionCompleted(true)
--[[
	elseif Mission.MultiplayerType == "Competitive" and Mission.SpecialType == "PTBoatRace" then
		Scoring_SetMissionCompleted(Mission.WinnerPlayer, true)
		-- todo: zenet lehet allitani partyra?
		Mission.MusicEndTime = GameTime()+45
]]
	elseif Mission.MultiplayerType == "Competitive" then
		if winnerParty == Mission.CompetitiveParty then
			local MPlayers = GetPlayerDetails()
			local actplayerscore = 0
			local highestplayerscore = 0
			local highestindex = 0
			for slotID, value in pairs (MPlayers) do
				actplayerscore = Scoring_GetTotalMissionScore(slotID)
-- RELEASE_LOGOFF  				luaHelperLog(" playerindex: "..slotID.." | score: "..actplayerscore)
				if actplayerscore > highestplayerscore then
					highestplayerscore = actplayerscore
					highestindex = slotID
				end
			end
-- RELEASE_LOGOFF  			luaHelperLog(" player "..highestindex.." won")
			Scoring_SetMissionCompleted(highestindex, true)
			-- todo: zenet lehet allitani partyra?
			Mission.CompetitiveWinnerPlayer = highestindex
			Mission.MusicEndTime = GameTime() + 10
		else
			local MPlayers = Multi_GetPlayers()
			for playerID, PartyID in pairs (MPlayers) do
				Scoring_SetMissionCompleted(playerID, false)
			end
			Mission.MusicEndTime = GameTime() + 10
		end
	else
		local MPlayers = Multi_GetPlayers()
		for playerID, PartyID in pairs (MPlayers) do
			if PartyID == winnerParty then
				Scoring_SetMissionCompleted(playerID, true)
			else
				Scoring_SetMissionCompleted(playerID, false)
			end
		end
		-- todo: zenet lehet allitani partyra?
		Mission.MusicEndTime = GameTime() + 10
	end

	if Mission.Multiplayer then
		if LobbySettings.GameMode ~= "globals.gamemode_competitive" then
			if winnerParty == PARTY_ALLIED then
-- RELEASE_LOGOFF  				luaHelperLog("-- "..tostring(LobbySettings.GameMode).." playing Allied victory voice-over --")
				for i = 1, 8 do
					local slotID = i - 1
					DisplayMessage(slotID, "scoremulti_allies_win")
				end
			else
-- RELEASE_LOGOFF  				luaHelperLog("-- "..tostring(LobbySettings.GameMode).." playing Japanese victory voice-over --")
				for i = 1, 8 do
					local slotID = i - 1
					DisplayMessage(slotID, "scoremulti_japanese_win")
				end
			end
		end
	end

	if Mission.Multiplayer then
		if LobbySettings.Map == "mp08.name" then
			if LobbySettings.GameMode == "globals.gamemode_competitive" then
				if winnerParty == Mission.CompetitiveParty and Mission.CompetitiveWinnerPlayer ~= nil then
					SetAchievements(Mission.CompetitiveWinnerPlayer, "MA_FD")
				end
			elseif winnerParty == PARTY_ALLIED then
				for i = 0, 3 do
					SetAchievements(i, "MA_FD")
				end
			else
				for i = 4, 7 do
					SetAchievements(i, "MA_FD")
				end
			end
		end
	end

	-----------------------------------------------------------------------------------
	-- player medal kiertekeles single-ben
	-- ranking, medalosztas multiban
	---------------------------------------

	if noRanking then
-- RELEASE_LOGOFF  		luaHelperLog("Ranking forbidden")
	else
		if not Mission.Multiplayer then
			local medal = luaGetMedalReward()
			if type(medal) == "number" then
				Scoring_SetRanking(medal)
				local medalName
				if medal == 3 then
					medalName = "gold"
				elseif medal == 2 then
					medalName = "silver"
				else
					medalName = "bronze"
				end
				local unlockName = Mission.Name.."_"..medalName
				Scoring_GrantUnlock(unlockName)
-- RELEASE_LOGOFF  				luaHelperLog("Unlock granted: "..unlockName)
			else
-- RELEASE_LOGOFF  				luaHelperLog("Wrong medal return value, setting it to bronze")
				Scoring_SetRanking(MEDAL_BRONZE)
				Scoring_GrantUnlock(Mission.Name.."_bronze")
			end
		else
			-- todo: ranking, score, lofaszjoskamedalok

		end



	end

	if not Mission.Tutorial then
-- RELEASE_LOGOFF  	luaLog("Medal Check is running")
	--luaMedalCheck()
	end
	-----------------------------------------------------------------------------------
	-- Missionnarrativa Party szerint multiban
	-- narrativa completed single-ben
	---------------------------------------

	if onlymovie then
		Blackout(true, "luaMissionEnd_Movie")
	else
		Blackout(true, "", false, 0.25)
		if not Mission.Multiplayer and not Mission.Tutorial then
			luaMissionEnd_CamOnEnt()
		elseif not Mission.Tutorial then

			if Mission.MultiplayerType == "Competitive" and winnerParty == Mission.CompetitiveParty then
				if Mission.WinnerPlayer == "mp.nar_comp_skirmish_ai" then
					for i = 0, 7 do
						MissionNarrativePlayer(i, "missionglobals.obj_fail")
					end
				else
					for i = 0, 7 do
						if i == Mission.WinnerPlayer then
							MissionNarrativePlayer(i, "missionglobals.obj_compl")
						else
							MissionNarrativePlayer(i, "missionglobals.obj_fail")
						end
					end
				end
			elseif Mission.MultiplayerType == "Competitive" then
				for i = 0, 7 do
					MissionNarrativePlayer(i, "missionglobals.obj_fail")
				end
			elseif winnerParty == PARTY_JAPANESE then
				MissionNarrativeParty(PARTY_JAPANESE, "missionglobals.obj_compl")
				MissionNarrativeParty(PARTY_ALLIED, "missionglobals.obj_fail")
			else
				MissionNarrativeParty(PARTY_JAPANESE, "missionglobals.obj_fail")
				MissionNarrativeParty(PARTY_ALLIED, "missionglobals.obj_compl")
			end

			luaMissionEnd_CamOnEnt()
		else
			luaMissionEnd_CamOnEnt()
		end
	end

	EndSCore()
--[[
todo for multi:
- medalkiertekeles multiban maskeppen
- winnerparty multiban completedre/failre allitson, akit kell
- kameradobas maskeppen, single-style:
	kotelezo celpont kameraentnek
	kotelezo a text
]]
end

--[[AutoDoc
usage: luaMissionEnd_CamOnEnt()
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek kamera fv-e
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() meghivott kameramozgast vezerlo fv
]]
function luaMissionEnd_CamOnEnt()
	if not Mission.Multiplayer then
		SetSkipMovie("luaMissionEndSkipMovie")
	end
	BlackBars(true)
	local ent = Mission.MissionEndParams.Ent
	if ent == nil then
		luaDelay(luaMissionEnd_FadeAway, Mission.MusicEndTime-GameTime()-2.5)
	elseif TrulyDead(ent) then
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is cold dead, getting last position")
		local pos = ent.LastPosition
		if pos.y < 2 then
			pos.y = 2
		end
		local camPos = GetCameraState().Position
		local entDir = GetCameraState().Rotation.y
		local fakePos = luaMoveCoordinate(pos, 1000, entDir)
		local angle = luaGetAngle(camPos, pos, fakePos)
--[[
		-- iranybaallas start
		local movcampos =
			{
				["postype"] = "camera",
				["position"] =
				{
					["pos"] = {camPos.x, camPos.y, camPos.z},
					["terrainavoid"] = true,
				},
				["starttime"] = 0,
				["blendtime"] = 3,
				["transformtype"] = "keepy",
			}
--		MovCamNew_AddPosition(movcampos)

-- RELEASE_LOGOFF  		luaLog("posx - "..pos.x)
-- RELEASE_LOGOFF  		luaLog("posy - "..pos.y)
-- RELEASE_LOGOFF  		luaLog("posz - "..pos.z)

		movcampos =
			{
				["postype"] = "target",
				["position"] =
				{
					["pos"] = {pos.x, pos.y, pos.z},
					["terrainavoid"] = true,
				},
				["starttime"] = 0,
				["blendtime"] = 3,
				["transformtype"] = "keepy",
				["maxcamspeed"] = 2000,
				["nonlinearblend"] = 1.1,
			}
		MovCamNew_AddPosition(movcampos)
		-- iranybaallas end
]]
		local camradius
		if Mission.Multiplayer then
			camradius = 650
		else
			camradius = 400
		end
		movcampos =
			{
				["postype"] = "camera",
				["position"] =
				{
					["pos"] = {pos.x, pos.y, pos.z},
					["modifier"] =
					{
						["name"] = "goaround",
						--["radius"] = {400, 5, 200},
						["radius"] = {camradius},
						["rho"] = {angle, 35, angle+360},
						["theta"] = {15},
					},
					["terrainavoid"] = true,
				},
				["starttime"] = 0,
				["blendtime"] = 4,
				["nonlinearblend"] = 3.0,
				["flyalt"] = 1000,
				["maxcamspeed"] = 2000,
				["transformtype"] = "keepy",
			}
		MovCamNew_AddPosition(movcampos)

		luaDelay(luaMissionEnd_FadeAway, 8)

	else

		local size
		if ent.Class.Name == "globals.unitclass_shipyard" and Mission.Multiplayer then
			size = ent.Class.Length*12
		elseif Mission.Multiplayer then
			size = ent.Class.Length*3
		else
			size = ent.Class.Length*1.15
		end

		Mission.MissionEndParams.Size = size
		local uType = luaGetType(ent)
-- RELEASE_LOGOFF  --		luaLog("<< _CamOnEnt type: "..tostring(uType)..", size: "..tostring(size).." >>")

		-- iranybaallitas szamitasai
		local camPos = GetCameraState().Position
		local entDir = luaGetRotation(ent)
		local entPos = GetPosition(ent)
		local fakePos = luaMoveCoordinate(entPos, 1000, entDir)
		local angle = luaGetAngle(camPos, entPos, fakePos)

		local cam = GetCameraState().Position
		local campos, vertAngle

		if uType == "sub" and not ent.Dead and entPos.y >= -2 then
			vertAngle = 15
		elseif uType == "sub" then
			vertAngle = -15
		elseif uType == "plane" then
			vertAngle = 15
		else
			vertAngle = 15
		end

		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {cam.x, cam.y, cam.z},
					["terrainavoid"] = true,
				},
				["starttime"] = 0,
				["blendtime"] = 3,
				["transformtype"] = "keepy",
			}
--		MovCamNew_AddPosition(campos)

		campos =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = ent,
					["terrainavoid"] = true,
				},
				["starttime"] = 0,
				["blendtime"] = 3,
				["maxcamspeed"] = 2000,
				["transformtype"] = "keepy",
				["nonlinearblend"] = 1.1,
			}
		MovCamNew_AddPosition(campos)

		Mission.MissionEndParams.Angle = angle
		Mission.MissionEndParams.VertAngle = vertAngle

-- RELEASE_LOGOFF  --		luaLog(" MC : size "..tostring(size))
-- RELEASE_LOGOFF  --		luaLog(" MC : type "..tostring(uType))
		--luaLog(" MC : angle "..angle)
		--luaLog(" MC : vertangle "..vertAngle)

		if Mission.MissionEndParams.Ent.Dead and (uType == "plane" or uType == "ship") then
			--MissionNarrativeUrgent("cam init")
			--luaLog("MC : right in, going down")
			campos =
				{
					["postype"] = "cameraandtarget",
					["position"] =
					{
						["parent"] = ent,
						["terrainavoid"] = true,
						["modifier"] =
						{
							["name"] = "goaround",
							["radius"] = {size, 13, size/1.15},
							["rho"] = {Mission.MissionEndParams.Angle, 45, Mission.MissionEndParams.Angle+360},
							["theta"] = {Mission.MissionEndParams.VertAngle, 45, -10},
						},
					},
					["event"] =
					{
						["type"] = "sunk",
						["function"] = "luaMissionEnd_FadeAway",
						["depth"] = -100
					},
					["starttime"] = 0,
					["blendtime"] = 4,
					["flyalt"] = 1000,
					["maxcamspeed"] = 2000,
					["transformtype"] = "keepy",
					["nonlinearblend"] = 3.0,
					["wanderer"] = false
				}
			MovCamNew_AddPosition(campos)
-- RELEASE_LOGOFF  			luaLog("Timer stuff calling")
			Mission.MissionEndParams.EndTimer = luaDelay(luaMissionEnd_FadeAway, Mission.MusicEndTime-GameTime()-2.5, "scriptcall", true)
-- RELEASE_LOGOFF  			luaLog("Timer ID "..Mission.MissionEndParams.EndTimer.ID)
		else
			--luaLog("MC : will not go down")
			if Mission.Multiplayer then
				size = 650
			elseif uType == "landfort" then
				size = 300
			end

			campos =
				{
					["postype"] = "cameraandtarget",
					["position"] =
					{
						["parent"] = ent,
						["terrainavoid"] = true,
						["modifier"] =
						{
							["name"] = "goaround",
							["radius"] = {size},
							["rho"] = {Mission.MissionEndParams.Angle, 45, Mission.MissionEndParams.Angle+360},
							["theta"] = {Mission.MissionEndParams.VertAngle},
						},
					},
					["starttime"] = 0,
					["blendtime"] = 4,
					["flyalt"] = 1000,
					["maxcamspeed"] = 2000,
					["transformtype"] = "keepy",
					["nonlinearblend"] = 3.0,
					["wanderer"] = true
				}
			MovCamNew_AddPosition(campos)
			luaDelay(luaMissionEnd_FadeAway, Mission.MusicEndTime-GameTime()-2.5)
		end
	end
	if not Mission.Multiplayer then
		luaDelay(luaMissionEnd_Text, 2)
	end
end

--[[AutoDoc
usage: luaMissionEnd_Text()
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek szoveg kiiro fv-e
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() meghivott szoveg kiirast vezerlo fv
]]
function luaMissionEnd_Text()
	MissionNarrative(Mission.MissionEndParams.Text)
end

--[[AutoDoc
usage: luaMissionEnd_FadeAway(timerthis)
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek idozito fv-e
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() meghivott fadelest vezerlo fv
]]
function luaMissionEnd_FadeAway(timerthis)
-- RELEASE_LOGOFF  	luaLog("Fadeaway called!")
	BlackBars(false)
	if not Mission.MissionEndParams.FadeCalled then
		Mission.MissionEndParams.FadeCalled = true
		luaFadeAway("luaMissionEnd_Finale")
	end

	if Mission.MissionEndParams.EndTimer ~= nil and not Mission.MissionEndParams.EndTimer.Dead and timerthis and not timerthis.ParamTable.scriptcall then
-- RELEASE_LOGOFF  		luaLog("Clearing delay "..Mission.MissionEndParams.EndTimer.ID)
		luaClearDelay(Mission.MissionEndParams.EndTimer)
	end
end

--[[AutoDoc
usage: luaMissionEndSkipMovie()
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek movie fv-e
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() meghivott movie-t vezerlo fv
]]
function luaMissionEndSkipMovie()
	luaFadeAway("luaMissionEnd_Finale")
end

--[[AutoDoc
usage: luaMissionEnd_Finale()
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek lezaro fv-e
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() idozitett scenet terminalo fv
]]
function luaMissionEnd_Finale()
-- RELEASE_LOGOFF  	luaLog("Final end called...")
	SetSkipMovie()	-- gomblenyomas figyelesenek vege
	if Mission.MissionEndParams == nil or Mission.MissionEndParams.Movie == nil then
		luaDelay(luaMissionEnd_EndScene, 2)
	else
		luaDelay(luaMissionEnd_Movie, 1)
	end
end

--[[AutoDoc
usage: luaMissionEnd_EndScene()
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek scene terminalasa
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() scenet terminalo fv
]]
function luaMissionEnd_EndScene()
	EndScene()
end

--[[AutoDoc
usage: usage: EndSkipMovie()
category: Mission
shortdesc: a luaMissionFailedNew() es luaMissionCompletedNew() fv-ek movie fv-e
desc: a luaMissionFailed()-ben vagy a luaMissionCompletedNew() meghivott movie-t vezerlo fv
]]
function luaMissionEnd_Movie()
	PlayBinkMovie(Mission.MissionEndParams.Movie, "", true)
end

-- new ver end

--[[
function luaMissionCompletedNew_CamOnComplEnt()
	local ent = Mission.MissionComplParams.Ent
	if TrulyDead(ent) then
-- RELEASE_LOGOFF  		luaHelperLog(" Target entity is cold dead, getting last position")
		local pos = ent.LastPosition
		if pos.y < 2 then
			pos.y = 2
		end
		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {pos.x, pos.y, pos.z}
				},
				["starttime"] = 0,
				["blendtime"] = 4,
				["flyalt"] = 1000,
				["maxcamspeed"] = 2000,
				["nonlinearblend"] = 2,
				["transformtype"] = "keepy",
			}
--		MovCamNew_AddPosition(campos)
	else

		local size = ent.Class.Length*1.15
		Mission.MissionComplParams.Size = size
		local uType = luaGetType(ent)
-- RELEASE_LOGOFF  		luaLog("<< _CamOnComplEnt type: "..tostring(uType)..", size: "..tostring(size).." >>")

		-- iranybaallitas szamitasai
		local camPos = GetCameraState().Position
		local entDir = luaGetRotation(ent)
		local entPos = GetPosition(ent)
		local fakePos = luaMoveCoordinate(entPos, 1000, entDir)
		local angle = luaGetAngle(camPos, entPos, fakePos)

		local cam = GetCameraState().Position
		local campos, vertAngle

		if uType == "sub" then
			vertAngle = -15
		elseif uType == "plane" then
			vertAngle = 15
		else
			vertAngle = 15
		end

		campos =
			{
				["postype"] = "cameraandtarget",
				["position"] =
				{
					["pos"] = {cam.x, cam.y, cam.z}
				},
				["starttime"] = 0,
				["blendtime"] = 0,
				["transformtype"] = "keepy",
			}
--		MovCamNew_AddPosition(campos)

		campos =
			{
				["postype"] = "target",
				["position"] =
				{
					["parent"] = ent,
				},
				["starttime"] = 0,
				["blendtime"] = 4,
				["maxcamspeed"] = 2000,
				["transformtype"] = "keepy",
				["nonlinearblend"] = 0.1,
			}
		MovCamNew_AddPosition(campos)

		Mission.MissionComplParams.Angle = angle
		Mission.MissionComplParams.VertAngle = vertAngle

		if not TrulyDead(ent) then
			--luaLog(" MC : size "..tostring(size))
			--luaLog(" MC : type "..tostring(uType))
			--luaLog(" MC : angle "..tostring(Mission.MissionComplParams.Angle))
			--luaLog(" MC : vertangle "..tostring(Mission.MissionComplParams.VertAngle))

			if Mission.MissionComplParams.Ent.Dead and (uType == "plane" or uType == "ship") then
				--MissionNarrativeUrgent("cam init")
				--luaLog("MC : right in, going down")
				local campos =
					{
						["postype"] = "cameraandtarget",
						["position"] =
						{
							["parent"] = ent,
							["modifier"] =
							{
								["name"] = "goaround",
								["radius"] = {size},
								["rho"] = {Mission.MissionComplParams.Angle, 45, Mission.MissionComplParams.Angle+360},
								["theta"] = {Mission.MissionComplParams.VertAngle, 9, -7},
							},
							["event"] =
							{
								["type"] = "sunk",
								["function"] = "luaMissionCompletedNew_FadeAway",
								["depth"] = 70
							}
						},
						["starttime"] = 0,
						["blendtime"] = 4,
						["transformtype"] = "keepy",
						["maxcamspeed"] = 2000,
						["flyalt"] = 1000,
						["nonlinearblend"] = 3.0,
						["wanderer"] = true
					}
				MovCamNew_AddPosition(campos)
-- RELEASE_LOGOFF  				luaLog("Timer stuff calling")
				Mission.MissionComplParams.EndTimer = luaDelay(luaMissionCompletedNew_FadeAway, 20, "scriptcall", true)
-- RELEASE_LOGOFF  				luaLog("Timer ID "..Mission.MissionComplParams.EndTimer.ID)
			else
				--luaLog("MC : will not go down")
				local campos =
					{
						["postype"] = "cameraandtarget",
						["position"] =
						{
							["parent"] = ent,
							["modifier"] =
							{
								["name"] = "goaround",
								["radius"] = {size},
								["rho"] = {Mission.MissionComplParams.Angle, 45, Mission.MissionComplParams.Angle+360},
								["theta"] = {Mission.MissionComplParams.VertAngle},
							},
						},
						["starttime"] = 0,
						["blendtime"] = 4,
						["transformtype"] = "keepy",
						["flyalt"] = 1000,
						["maxcamspeed"] = 2000,
						["nonlinearblend"] = 3.0,
						["wanderer"] = true
					}
				MovCamNew_AddPosition(campos)
				luaDelay(luaMissionCompletedNew_FadeAway, 16)
			end
		end
	end

	luaDelay(luaMissionCompletedNew_ComplText, 2)
	--luaDelay(luaFadeAway, 16)	-- tmp out
end

function luaMissionCompletedNew_FadeAway(timerthis)
-- RELEASE_LOGOFF  	luaLog("Fadeaway called!")

	luaFadeAway(luaMissionCompletedNew_End)

	if Mission.MissionComplParams.EndTimer ~= nil and not Mission.MissionComplParams.EndTimer.Dead and timerthis and not timerthis.ParamTable.scriptcall then
-- RELEASE_LOGOFF  		luaLog("Clearing delay "..Mission.MissionComplParams.EndTimer.ID)
		luaClearDelay(Mission.MissionComplParams.EndTimer)
	end
end

function luaMissionCompletedNew_End()
-- RELEASE_LOGOFF  	luaLog("Final end called...")
	if Mission.MissionComplParams.Movie == nil then
		EndScene()
	else
		luaMissionCompleted_ComplMovie()
	end
end
]]

--[[

function luaMissionCompletedNew_CamRound()
-- RELEASE_LOGOFF  	luaLog("MC : Camround, camround!")
	if not TrulyDead(Mission.MissionComplParams.Ent) then
		--MovCam_HandMode_Targeted(Mission.MissionComplParams.Ent, true)

		-- visszaallitjuk az eredeti sebesseget es gyorsulast

		--MovCam_ResetSpeedLimits()
		--MovCam_ResetAccelTime()

		local size = Mission.MissionComplParams.Size
		local uType = luaGetType(ent)
		--luaLog("<< _CamRound type: "..tostring(uType)..", size: "..tostring(size).." >>")
		--luaMissionEndCamRound_ext(uType, size)
-- RELEASE_LOGOFF  		luaLog(" MC : size "..tostring(size))
-- RELEASE_LOGOFF  		luaLog(" MC : type "..tostring(uType))
-- RELEASE_LOGOFF  		luaLog(" MC : angle "..tostring(Mission.MissionComplParams.Angle))
-- RELEASE_LOGOFF  		luaLog(" MC : vertangle "..tostring(Mission.MissionComplParams.VertAngle))

		if Mission.MissionComplParams.Ent.Dead and (uType == "plane" or uType == "sub" or uType == "ship") then
			--luaDelay(luaMissionFailedNew_CamDown, 0.3)
			MissionNarrativeUrgent("cam init")
-- RELEASE_LOGOFF  			luaLog("MC : right in, going down")
			local campos =
				{
					["postype"] = "cameraandtarget",
					["position"] =
					{
						["parent"] = ent,
						["modifier"] =
						{
							["name"] = "goaround",
							["radius"] = {size},
							["rho"] = {Mission.MissionComplParams.Angle},
							["theta"] = {Mission.MissionComplParams.VertAngle, 4, Mission.MissionComplParams.VertAngle-20},
						},
					},
					["starttime"] = 0,
					["blendtime"] = 14,
					["maxcamspeed"] = 2000,
					["transformtype"] = "keepy",
					["nonlinearblend"] = 0.5,
					["wanderer"] = true
				}
			MovCamNew_AddPosition(campos)
		else
-- RELEASE_LOGOFF  			luaLog("MC : will not go down")
			local campos =
				{
					["postype"] = "cameraandtarget",
					["position"] =
					{
						["parent"] = ent,
						["modifier"] =
						{
							["name"] = "goaround",
							["radius"] = {size},
							["rho"] = {Mission.MissionComplParams.Angle},
							["theta"] = {Mission.MissionComplParams.VertAngle},
						},
					},
					["starttime"] = 0,
					["blendtime"] = 14,
					["maxcamspeed"] = 2000,
					["transformtype"] = "keepy",
					["nonlinearblend"] = 0.5,
					["wanderer"] = true
				}
			MovCamNew_AddPosition(campos)
		end
	end
end
]]

--[[AutoDoc
usage: luaMissionCompletedNew_ComplText()
category: Mission
shortdesc: a luaMissionFailedNew() fv szovegkiiro fv-e
desc: a luaMissionCompletedNew() meghivott szoveg kiirast vezerlo fv
]]
function luaMissionCompletedNew_ComplText()
	if Mission.MissionComplParams.Text ~= nil then
		MissionNarrative(Mission.MissionComplParams.Text)
	end
	--[[ tmp test out
	if Mission.MissionComplParams.Movie == nil then
		luaDelay(EndScene, 16)
	else
		luaDelay(luaMissionCompleted_ComplMovie, 16)
	end
	]]
end

function luaMultiQuit(serverParty, serverQuit, opposingClients)
-- RELEASE_LOGOFF  	luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "luaMultiQuit called in "..tostring(LobbySettings.GameMode).." mode...","u")
-- RELEASE_LOGOFF  	luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " serverParty: "..tostring(serverParty).." | serverQuit: "..tostring(serverQuit).." | opposingClients: "..tostring(opposingClients))

	if not serverQuit and LobbySettings.GameMode == "globals.gamemode_competitive" then
		luaSetMultiMessages(false, false, true)
	elseif not serverQuit and opposingClients then
		luaSetMultiMessages(false, true, false)
	elseif serverQuit then
		luaSetMultiMessages(true, false, false)
	end

	BannSupportmanager()

	if LobbySettings.Map == "mp08.name" then
		if serverParty == PARTY_ALLIED then
			for i = 4, 7 do
				SetAchievements(i, "MA_FD")
			end
		else
			for i = 0, 3 do
				SetAchievements(i, "MA_FD")
			end
		end
	end

	if LobbySettings.GameMode == "globals.gamemode_competitive" then
		--COMPETITIVE objektiva pontszamitashoz a kovetkezok kellenek--
		--Mission.Objectives.primary[index].ScoreCompleted
		--Mission.Objectives.primary[index].ScoreFailed
		--Mission.PointLimit
		--------------------------------------------------------
		if Mission.PointLimit ~= 0 then
			local MPlayers = GetPlayerDetails()
			local actplayerscore = 0
			local highestplayerscore = 0
			Mission.CompetitiveWinnerIndex = 0
			local objindex = 0
			for slotID, value in pairs (MPlayers) do
				if serverQuit and not value.ai and value.playerindex == 0 then
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " calling ClearPlayerScore for player 0")
					ClearPlayerScore(slotID)
				elseif value.ai and value.playerName ~= "" then
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " calling ClearPlayerScore for player "..tostring(slotID))
					ClearPlayerScore(slotID)
				end
				actplayerscore = Scoring_GetTotalMissionScore(slotID)
				objindex = slotID + 1
				if actplayerscore > highestplayerscore then
					highestplayerscore = actplayerscore
					Mission.CompetitiveWinnerIndex = slotID
				end
				if Mission.Objectives ~= nil then
					if actplayerscore > 0 then
						Mission.Objectives.primary[objindex].ScoreFailed = ( Mission.Objectives.primary[objindex].ScoreCompleted / Mission.PointLimit ) * actplayerscore
					else
						Mission.Objectives.primary[objindex].ScoreFailed = 0
					end
					if Mission.Objectives.primary[objindex].ScoreFailed ~= 0 then
						Mission.Objectives.primary[objindex].ScoreFailed = luaRound(Mission.Objectives.primary[objindex].ScoreFailed)
					end
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  slot ID: "..tostring(slotID).." | score: "..tostring(Mission.Objectives.primary[objindex].ScoreFailed))
				else
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  Mission.Objectives == nil")
				end
			end
		else
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  ERROR! Mission.PointLimit == 0! ")
		end
		if Mission.Objectives ~= nil then
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							local winnerObjID = Mission.CompetitiveWinnerIndex + 1
							if index == winnerObjID then
								luaObj_Completed("primary", index)
							else
								luaObj_Failed("primary", index)
							end
						end
					end
				elseif objtable == Mission.Objectives.secondary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("secondary", index)
						end
					end
				elseif objtable == Mission.Objectives.hidden then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("hidden", index)
						end
					end
				end
			end
		end
	elseif LobbySettings.GameMode == "globals.gamemode_duel" then
		--DUEL objektiva pontszamitashoz a kovetkezok kellenek--
		--Mission.Objectives.primary[index].ScoreCompleted
		--Mission.Objectives.primary[index].ScoreFailed
		--Mission.RoundLimit
		--Mission.AlliedRoundWon
		--Mission.JapaneseRoundWon
		--------------------------------------------------------
		if Mission.Objectives ~= nil then
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
							if Mission.RoundLimit ~= 0 then
								if objective.Party == PARTY_ALLIED then
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.RoundLimit ) * Mission.AlliedRoundWon
								else
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.RoundLimit ) * Mission.JapaneseRoundWon
								end
							else
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  ERROR! Mission.RoundLimit == 0! ")
							end
							if objective.ScoreFailed ~= 0 then
								objective.ScoreFailed = luaRound(objective.ScoreFailed)
							end
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed | score: "..tostring(objective.ScoreFailed))
							if objective.Party == serverParty then
								luaObj_Failed("primary", index)
							else
								luaObj_Completed("primary", index)
							end
						end
					end
				elseif objtable == Mission.Objectives.secondary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("secondary", index)
						end
					end
				elseif objtable == Mission.Objectives.hidden then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("hidden", index)
						end
					end
				end
			end
		else
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  Mission.Objectives == nil")
		end
	elseif LobbySettings.GameMode == "globals.gamemode_escort" then
		--ESCORT objektiva pontszamitashoz a kovetkezok kellenek--
		--Mission.Objectives.primary[index].ScoreCompleted
		--Mission.Objectives.primary[index].ScoreFailed
		--------------------------------------------------------
		local MPlayers = GetPlayerDetails()
		local usplayersscore = 0
		local japplayersscore = 0
		local allplayersscore = 0
		if GameTime() > 300 then
			for slotID, value in pairs (MPlayers) do
				if serverQuit and not value.ai and value.playerindex == 0 then
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " calling ClearPlayerScore for player 0")
					ClearPlayerScore(slotID)
				elseif value.ai and value.playerName ~= "" then
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " calling ClearPlayerScore for player "..tostring(slotID))
					ClearPlayerScore(slotID)
				end
				if slotID <= 3 then
					if Scoring_GetTotalMissionScore(slotID) > 0 then
						usplayersscore = usplayersscore + Scoring_GetTotalMissionScore(slotID)
					end
				else
					if Scoring_GetTotalMissionScore(slotID) > 0 then
						japplayersscore = japplayersscore + Scoring_GetTotalMissionScore(slotID)
					end
				end
			end
		end
		allplayersscore = usplayersscore + japplayersscore
		if Mission.Objectives ~= nil then
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
							if allplayersscore ~= 0 then
								if objective.Party == PARTY_ALLIED then
									objective.ScoreFailed = ( objective.ScoreCompleted / allplayersscore ) * usplayersscore
								else
									objective.ScoreFailed = ( objective.ScoreCompleted / allplayersscore ) * japplayersscore
								end
							else
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  ERROR! allplayersscore == 0 or GameTime() < 300! ")
							end
							if objective.ScoreFailed ~= 0 then
								objective.ScoreFailed = luaRound(objective.ScoreFailed)
							end
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed | score: "..tostring(objective.ScoreFailed))
							if objective.Party == serverParty then
								luaObj_Failed("primary", index)
							else
								luaObj_Completed("primary", index)
							end
						end
					end
				elseif objtable == Mission.Objectives.secondary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("secondary", index)
						end
					end
				elseif objtable == Mission.Objectives.hidden then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("hidden", index)
						end
					end
				end
			end
		else
-- RELEASE_LOGOFF  			luaHelperLog("  Mission.Objectives == nil")
		end
	elseif LobbySettings.GameMode == "globals.gamemode_islandcapture" then
		--ISLAND CAPTURE objektiva pontszamitashoz a kovetkezok kellenek--
		--Mission.Objectives.primary[index].ScoreCompleted
		--Mission.Objectives.primary[index].ScoreFailed
		--Mission.CapturePointLimit
		--Mission.AlliedCapturePoints
		--Mission.JapaneseCapturePoints
		--------------------------------------------------------
		if Mission.Objectives ~= nil then
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
							if Mission.CapturePointLimit ~= 0 then
								if objective.Party == PARTY_ALLIED then
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.CapturePointLimit ) * Mission.AlliedCapturePoints
								else
									objective.ScoreFailed = ( objective.ScoreCompleted / Mission.CapturePointLimit ) * Mission.JapaneseCapturePoints
								end
							elseif GameTime() > 300 then
								if objective.Party == PARTY_ALLIED then
									objective.ScoreFailed = ( objective.ScoreCompleted / ( Mission.AlliedCapturePoints + Mission.JapaneseCapturePoints ) ) * Mission.AlliedCapturePoints
								else
									objective.ScoreFailed = ( objective.ScoreCompleted / ( Mission.AlliedCapturePoints + Mission.JapaneseCapturePoints ) ) * Mission.JapaneseCapturePoints
								end
							end
							if objective.ScoreFailed ~= 0 then
								objective.ScoreFailed = luaRound(objective.ScoreFailed)
							end
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." | score: "..tostring(objective.ScoreFailed))
							if objective.Party == serverParty then
								luaObj_Failed("primary", index)
							else
								luaObj_Completed("primary", index)
							end
						end
					end
				elseif objtable == Mission.Objectives.secondary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("secondary", index)
						end
					end
				elseif objtable == Mission.Objectives.hidden then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("hidden", index)
						end
					end
				end
			end
		else
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  Mission.Objectives == nil")
		end
	elseif LobbySettings.GameMode == "globals.gamemode_siege" then
		--SIEGE objektiva pontszamitashoz a kovetkezok kellenek--
		--Mission.Objectives.primary[index].ScoreCompleted
		--Mission.Objectives.primary[index].ScoreFailed
		--Mission.ResourcePoolBase
		--Mission.ResourceUSPool
		--Mission.ResourceJapPool
		--------------------------------------------------------
		if Mission.Objectives ~= nil then
			for index, objtable in pairs (Mission.Objectives) do
				if objtable == Mission.Objectives.primary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
							local scoremultiplier = objective.ScoreCompleted / Mission.ResourcePoolBase
							if objective.Party == PARTY_ALLIED then
								objective.ScoreFailed = ( Mission.ResourcePoolBase - Mission.ResourceJapPool ) * scoremultiplier
							else
								objective.ScoreFailed = ( Mission.ResourcePoolBase - Mission.ResourceUSPool ) * scoremultiplier
							end
							if objective.ScoreFailed ~= 0 then
								objective.ScoreFailed = luaRound(objective.ScoreFailed)
							end
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed | score: "..tostring(objective.ScoreFailed))
							if objective.Party == serverParty then
								luaObj_Failed("primary", index)
							else
								luaObj_Completed("primary", index)
							end
						end
					end
				elseif objtable == Mission.Objectives.secondary then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("secondary", index)
						end
					end
				elseif objtable == Mission.Objectives.hidden then
					for index, objective in pairs (objtable) do
						if objective.Active and objective.Success == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  objective ID: "..objective.ID.." failed ")
							luaObj_Failed("hidden", index)
						end
					end
				end
			end
		else
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "  Mission.Objectives == nil")
		end
	end

	local MPlayers = Multi_GetPlayers()
	for playerID, PartyID in pairs (MPlayers) do
-- RELEASE_LOGOFF  		luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
		for priority, ptable in pairs(Mission.Objectives) do
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Checking "..priority.." objectives...")
			for num, obj in pairs(ptable) do
-- RELEASE_LOGOFF  				luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " PartyID: "..tostring(PartyID).." | obj.Party: "..tostring(obj.Party))
				if obj.Party == PartyID then
					if luaObj_GetSuccess(priority, num) then
						if Mission.CompetitiveWinnerIndex == nil or Mission.CompetitiveWinnerIndex ~= nil and obj.PlayerIndex == nil then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
							Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
						elseif Mission.CompetitiveWinnerIndex ~= nil then
							local objID = Mission.CompetitiveWinnerIndex + 1
							local playerObjID = playerID + 1
							if playerID == Mission.CompetitiveWinnerIndex then
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
								Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
							elseif num == playerObjID then
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
								Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
							else
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by 0")
								Scoring_SetMissionScore(playerID, obj.ID, 0)
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
							end
						end
					elseif num == playerID + 1 then
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
						Scoring_SetMissionScore(playerID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  						luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Index: "..playerID..", "..tostring(PartyID))
					end
				end
			end
		end
		if LobbySettings.GameMode == "globals.gamemode_competitive" then
			Scoring_SetMissionCompleted(playerID, false)
		elseif PartyID == serverParty and not serverQuit then
			Scoring_SetMissionCompleted(playerID, true)
		elseif PartyID ~= serverParty and serverQuit then
			Scoring_SetMissionCompleted(playerID, true)
		else
			Scoring_SetMissionCompleted(playerID, false)
		end
	end

	local MPlayers = GetPlayerDetails()
	for slotID, value in pairs (MPlayers) do
		if value.ai == true then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
			for priority, ptable in pairs(Mission.Objectives) do
-- RELEASE_LOGOFF  				luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Checking "..priority.." objectives...")
				for num, obj in pairs(ptable) do
-- RELEASE_LOGOFF  					luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " value.party: "..tostring(value.party).." | obj.Party: "..tostring(obj.Party))
					if obj.Party == value.party then
						if luaObj_GetSuccess(priority, num) then
							if Mission.CompetitiveWinnerIndex == nil or Mission.CompetitiveWinnerIndex ~= nil and obj.PlayerIndex == nil then
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
								Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  								luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
							elseif Mission.CompetitiveWinnerIndex ~= nil then
								local objID = Mission.CompetitiveWinnerIndex + 1
								local playerObjID = slotID + 1
								if slotID == Mission.CompetitiveWinnerIndex then
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is completed, rewarding by "..obj.ScoreCompleted)
									Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreCompleted))
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
								elseif num == playerObjID then
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
									Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
								else
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by 0")
									Scoring_SetMissionScore(slotID, obj.ID, 0)
-- RELEASE_LOGOFF  									luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
								end
							end
						elseif num == slotID + 1 then
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " Objective "..priority..num.."("..obj.ID..") is failed, rewarding by "..obj.ScoreFailed)
							Scoring_SetMissionScore(slotID, obj.ID, luaRound(obj.ScoreFailed))
-- RELEASE_LOGOFF  							luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "Skirmish AI Index: "..slotID..", "..tostring(value.party))
						end
					end
				end
			end
		end
	end

	local MPlayers = GetPlayerDetails()
	for slotID, value in pairs (MPlayers) do
-- RELEASE_LOGOFF  		luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " slotID: "..slotID.." | value.ai: "..tostring(value.ai).." | value.playerName: "..tostring(value.playerName))
		if serverQuit and not value.ai and value.playerindex == 0 then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " calling ClearPlayerScore for player 0")
			ClearPlayerScore(slotID)
		elseif value.ai and value.playerName ~= "" then
-- RELEASE_LOGOFF  			luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " calling ClearPlayerScore for player "..tostring(slotID))
			ClearPlayerScore(slotID)
		end
	end
end

function luaSetMultiMessages(quit, clientsQuit, competitiveClientQuit)
	if not Mission.Multiplayer then
		return
	end

-- RELEASE_LOGOFF  	luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", "luaSetMultiMessages called in "..tostring(LobbySettings.GameMode).." mode...")
	if LobbySettings.GameMode == "globals.gamemode_competitive" then
		if quit then
			luaSetMultiMessagesQuit(true, false, false)
		elseif competitiveClientQuit then
			luaSetMultiMessagesQuit(false, false, true)
		elseif Mission.Surrender then
			for i = 1, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_surrender_lost")
			end
		elseif Mission.MissionFailed then
			for i = 1, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_comp_mission_failed")
			end
		elseif Mission.PointLimitReached then
			for i = 1, 8 do
				local slotID = i - 1
				if Mission.WinnerPlayer == "mp.nar_comp_skirmish_ai" then
					if Mission.WinnerPlayerAILevel == 3 then
						Scoring_SetConditionMessage(slotID, "FE.easy| |mp01.nar_comp_player_won")
					elseif Mission.WinnerPlayerAILevel == 4 then
						Scoring_SetConditionMessage(slotID, "FE.normal| |mp01.nar_comp_player_won")
					elseif Mission.WinnerPlayerAILevel == 5 then
						Scoring_SetConditionMessage(slotID, "FE.hard| |mp01.nar_comp_player_won")
					end
				else
					Scoring_SetConditionMessage(slotID, tostring(Mission.WinnerPlayer).."| |mp01.nar_comp_player_won")
				end
			end
		elseif Mission.TimeIsUp then
			for i = 1, 8 do
				local slotID = i - 1
				if Mission.WinnerPlayer == "mp.nar_comp_skirmish_ai" then
					if Mission.WinnerPlayerAILevel == 3 then
						Scoring_SetConditionMessage(slotID, "FE.vcondition_comp_timelimit_winner| |FE.easy")
					elseif Mission.WinnerPlayerAILevel == 4 then
						Scoring_SetConditionMessage(slotID, "FE.vcondition_comp_timelimit_winner| |FE.normal")
					elseif Mission.WinnerPlayerAILevel == 5 then
						Scoring_SetConditionMessage(slotID, "FE.vcondition_comp_timelimit_winner| |FE.hard")
					end
				else
				Scoring_SetConditionMessage(slotID, "FE.vcondition_comp_timelimit_winner| |"..tostring(Mission.WinnerPlayer))
				end
			end
		end
	elseif LobbySettings.GameMode == "globals.gamemode_duel" then
		if quit then
			luaSetMultiMessagesQuit(true, false, false)
		elseif clientsQuit then
			luaSetMultiMessagesQuit(false, true, false)
		elseif Mission.Surrender then
			luaSetMultiMessagesSurrender()
		elseif Mission.AlliedRoundWon > Mission.JapaneseRoundWon then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_duel_won")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_duel_lost")
			end
		elseif Mission.JapaneseRoundWon > Mission.AlliedRoundWon then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_duel_lost")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_duel_won")
			end
		end
		Scoring_SetVictoryMessage("mp.score_duel| "..tostring(Mission.AlliedRoundWon), "mp.score_duel| "..tostring(Mission.JapaneseRoundWon))
	elseif LobbySettings.GameMode == "globals.gamemode_escort" then
		if Mission.Keyunits ~= nil then
			Mission.Keyunits = luaRemoveDeadsFromTable(Mission.Keyunits)
		end
		if quit then
			luaSetMultiMessagesQuit(true, false, false)
		elseif clientsQuit then
			luaSetMultiMessagesQuit(false, true, false)
		elseif Mission.Surrender then
			luaSetMultiMessagesSurrender()
		elseif Mission.Name == "Escort06" then
			if Mission.Akagi.Dead then
				for i = 1, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort6_akagi")
				end
			elseif Mission.Lexington.Dead then
				for i = 1, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort6_lexington")
				end
			end
		elseif Mission.Name == "Escort08" then
			if Mission.Yamato.Dead then
				for i = 1, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort8_yamato")
				end
			elseif Mission.Iowa.Dead then
				for i = 1, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort8_iowa")
				end
			end
		elseif table.getn(Mission.Keyunits) == 0 then
			if Mission.MissionWinnerParty == PARTY_ALLIED then
				for i = 1, 4 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_done")
				end
				for i = 5, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_fail")
				end
			elseif Mission.MissionWinnerParty == PARTY_JAPANESE then
				for i = 1, 4 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_fail")
				end
				for i = 5, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_done")
				end
			end
		elseif table.getn(Mission.Keyunits) ~= 0 then
			if Mission.MissionWinnerParty == PARTY_ALLIED then
				for i = 1, 4 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_done")
				end
				for i = 5, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_fail")
				end
			elseif Mission.MissionWinnerParty == PARTY_JAPANESE then
				for i = 1, 4 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_fail")
				end
				for i = 5, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_escort_key_obj_done")
				end
			end
		end
	elseif LobbySettings.GameMode == "globals.gamemode_islandcapture" then
		local counterA = 0
		local counterJ = 0
		for index, unit in pairs (Mission.CommandBuildings) do
			if unit.Party == PARTY_ALLIED then
				counterA = counterA + 1
			end
		end
		for index, unit in pairs (Mission.CommandBuildings) do
			if unit.Party == PARTY_JAPANESE then
				counterJ = counterJ + 1
			end
		end
		if quit then
			luaSetMultiMessagesQuit(true, false, false)
		elseif clientsQuit then
			luaSetMultiMessagesQuit(false, true, false)
		elseif Mission.Surrender then
			luaSetMultiMessagesSurrender()
		elseif Mission.TimeLimitReached then
			if Mission.AlliedCapturePoints > Mission.JapaneseCapturePoints then
				for i = 1, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_timelimit_us_won")
				end
			else
				for i = 1, 8 do
					local slotID = i - 1
					Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_timelimit_jap_won")
				end
			end
		elseif counterA == 0 then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_annihilation_lost")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_annihilation_won")
			end
		elseif counterJ == 0 then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_annihilation_won")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_annihilation_lost")
			end
		elseif Mission.AlliedCapturePoints > Mission.JapaneseCapturePoints then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_overpower_won")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_overpower_lost")
			end
		elseif Mission.AlliedCapturePoints < Mission.JapaneseCapturePoints then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_overpower_lost")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_ic_overpower_won")
			end
		end
		Scoring_SetVictoryMessage("mp.score_ic_points| "..tostring(Mission.AlliedCapturePoints), "mp.score_ic_points| "..tostring(Mission.JapaneseCapturePoints))
	elseif LobbySettings.GameMode == "globals.gamemode_siege" then
		if quit then
			luaSetMultiMessagesQuit(true, false, false)
		elseif clientsQuit then
			luaSetMultiMessagesQuit(false, true, false)
		elseif Mission.Surrender then
			luaSetMultiMessagesSurrender()
		elseif Mission.ResourceJapPool <= 0 then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_siege_resource_won")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_siege_resource_lost")
			end
		elseif Mission.ResourceUSPool <= 0 then
			for i = 1, 4 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_siege_resource_lost")
			end
			for i = 5, 8 do
				local slotID = i - 1
				Scoring_SetConditionMessage(slotID, "FE.vcondition_siege_resource_won")
			end
		end
		if Mission.ResourceUSPool < 0 then
			Mission.ResourceUSPool = 0
		end
		if Mission.ResourceJapPool < 0 then
			Mission.ResourceJapPool = 0
		end
		Scoring_SetVictoryMessage("mp01.score_siege_resource| "..tostring(Mission.ResourceUSPool), "mp01.score_siege_resource| "..tostring(Mission.ResourceJapPool))
	end
end

function luaSetMultiMessagesQuit(server, opposingClient, competitive)
-- RELEASE_LOGOFF  	luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " server: "..tostring(server).." | opposingClient: "..tostring(opposingClient).." | competitive: "..tostring(competitive))

	if server then
		--luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " server")
		for i = 1, 8 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_server_quit")
		end
	elseif opposingClient then
		--luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " opposingClient")
		for i = 1, 8 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_opposing_client_quit")
		end
	elseif competitive then
		--luaDoCustomLog("luaObj_scoring_"..Mission.Name..".log", " competitive")
		for i = 1, 8 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_competitive_client_quit")
		end
	end
end

function luaSetMultiMessagesSurrender()
	if Mission.SurrendererParty == PARTY_ALLIED then
		for i = 1, 4 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_surrender_lost")
		end
		for i = 5, 8 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_surrender_won")
		end
	else
		for i = 1, 4 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_surrender_won")
		end
		for i = 5, 8 do
			local slotID = i - 1
			Scoring_SetConditionMessage(slotID, "FE.vcondition_surrender_lost")
		end
	end
end

function luaMultiVoiceOverHandler()
	if LobbySettings.GameMode == "globals.gamemode_competitive" then
		if not Mission.LeaderInitVO then
			Mission.LeaderIndexVO = 8
			Mission.LeaderInitVO = true
		end
		if GameTime() > 20 then
			local MPlayers = GetPlayerDetails()
			local actplayerscore = 0
			local highestplayerscore = 0
			local highestindex = 0
			for slotID, value in pairs (MPlayers) do
				actplayerscore = Scoring_GetTotalMissionScore(slotID)
				if actplayerscore > highestplayerscore then
					highestplayerscore = actplayerscore
					highestindex = slotID
				end
			end
			if highestplayerscore ~= 0 then
				if highestindex ~= Mission.LeaderIndexVO then
					if Mission.CompetitiveParty == PARTY_ALLIED then
-- RELEASE_LOGOFF  						luaHelperLog("-- Competitive playing Allied voice-over for new leader: "..tostring(highestindex).." --")
						DisplayMessage(highestindex, "scoremulti_score_lead_gained")
-- RELEASE_LOGOFF  						luaHelperLog("-- Competitive playing Allied voice-over for previous leader: "..tostring(Mission.LeaderIndexVO).." --")
						if Mission.LeaderIndexVO ~= 8 then
							DisplayMessage(Mission.LeaderIndexVO, "scoremulti_score_lead_lost")
						end
					else
-- RELEASE_LOGOFF  						luaHelperLog("-- Competitive playing Japanese voice-over for new leader: "..tostring(highestindex).." --")
						DisplayMessage(highestindex, "scoremulti_score_lead_gained") -- egyelore nem kulonboztetjuk meg
-- RELEASE_LOGOFF  						luaHelperLog("-- Competitive playing Japanese voice-over for previous leader: "..tostring(Mission.LeaderIndexVO).." --")
						if Mission.LeaderIndexVO ~= 8 then
							DisplayMessage(Mission.LeaderIndexVO, "scoremulti_score_lead_lost") -- egyelore nem kulonboztetjuk meg
						end
					end
					Mission.LeaderIndexVO = highestindex
				end
			end
		end
	elseif LobbySettings.GameMode == "globals.gamemode_islandcapture" then
		if Mission.CapturePointLimit ~= 0 then
			local thresholdVP = Mission.CapturePointLimit * 0.85
			if Mission.AlliedCapturePoints > thresholdVP and not Mission.AlliedVoiceOverPlayed then
-- RELEASE_LOGOFF  				luaHelperLog("-- IC playing Allied voice-over --")
				for i = 1, 8 do
					local slotID = i - 1
					DisplayMessage(slotID, "scoremulti_allies_to_win")
				end
				Mission.AlliedVoiceOverPlayed = true
			end
			if Mission.JapaneseCapturePoints > thresholdVP and not Mission.JapaneseVoiceOverPlayed then
-- RELEASE_LOGOFF  				luaHelperLog("-- IC playing Japanese voice-over --")
				for i = 1, 8 do
					local slotID = i - 1
					DisplayMessage(slotID, "scoremulti_japanese_to_win")
				end
				Mission.JapaneseVoiceOverPlayed = true
			end
		end
	elseif LobbySettings.GameMode == "globals.gamemode_siege" then
		local thresholdRP = Mission.ResourcePoolBase * 0.15
		if Mission.ResourceUSPool < thresholdRP and not Mission.AlliedVoiceOverPlayed then
-- RELEASE_LOGOFF  			luaHelperLog("-- Siege playing Allied voice-over --")
			for i = 1, 8 do
				local slotID = i - 1
				DisplayMessage(slotID, "scoremulti_japanese_to_win")
			end
			Mission.AlliedVoiceOverPlayed = true
		end
		if Mission.ResourceJapPool < thresholdRP and not Mission.JapaneseVoiceOverPlayed then
-- RELEASE_LOGOFF  			luaHelperLog("-- Siege playing Japanese voice-over --")
			for i = 1, 8 do
				local slotID = i - 1
				DisplayMessage(slotID, "scoremulti_allies_to_win")
			end
			Mission.JapaneseVoiceOverPlayed = true
		end
	end
	luaDelay(luaMultiVoiceOverHandler, 1)
end

function luaGetICSkirmishAIParty()
	local MPlayers = GetPlayerDetails()
	local skirmishAIParty
	for index, value in pairs (MPlayers) do
		if value.ai then
			if index < 4 then
				skirmishAIParty = PARTY_ALLIED
			else
				skirmishAIParty = PARTY_JAPANESE
			end
		end
	end
	return skirmishAIParty
end

function luaUnitRedistribution()

	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("-- START PLAYERTABLE CHECK --")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("-- END PLAYERTABLE CHECK --")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("----- START UNIT TABLE CHECK -----")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("US UNIT TABLE")
-- RELEASE_LOGOFF  	luaHelperLog(Mission.USCB)
	if luaCountTable(Mission.USCB) == 0 then
-- RELEASE_LOGOFF  		luaHelperLog("WARNING Mission.USCB IS EMPTY")
	end
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("JP UNIT TABLE")
-- RELEASE_LOGOFF  	luaHelperLog(Mission.JPCB)
	if luaCountTable(Mission.JPCB) == 0 then
-- RELEASE_LOGOFF  		luaHelperLog("WARNING Mission.JPCB IS EMPTY")
	end
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("----- START UNIT TABLE CHECK -----")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("----- START AI CHECK -----")
-- RELEASE_LOGOFF  	luaHelperLog("")

	Mission.USAI = false
	Mission.JPAI = false
	Mission.NOAI = false

	if Mission.PlayersTable[0] ~= nil then
		if Mission.PlayersTable[0]["ai"] == true then
			Mission.USAI = true
-- RELEASE_LOGOFF  			luaHelperLog("US is AI")
		end
	end

	if Mission.PlayersTable[4] ~= nil then
		if Mission.PlayersTable[4]["ai"] == true then
			Mission.JPAI = true
-- RELEASE_LOGOFF  			luaHelperLog("JP is AI")
		end
	end

	if Mission.USAI == false and Mission.JPAI == false then
		Mission.NOAI = true
-- RELEASE_LOGOFF  		luaHelperLog("NO AI")
	end

-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("----- END AI CHECK -----")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("")
-- RELEASE_LOGOFF  	luaHelperLog("----- START CB DISTRIBUTUIN -----")


	if Mission.JPAI == true then
		local cbnum = 1
		local run = luaCountTable(Mission.USCB)
-- RELEASE_LOGOFF  --		luaHelperLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaHelperLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaHelperLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaHelperLog("Player Slot "..player.playerslot)
				if player.party == 0 then
					if Mission.USCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.USCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.USCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaHelperLog(Mission.USCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaHelperLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  						luaHelperLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  				luaHelperLog("----- BREAK from CB Cycle -----")
				break
			end
		end
	end

	if Mission.USAI == true then
		local cbnum = 1
		local run = luaCountTable(Mission.JPCB)
-- RELEASE_LOGOFF  --		luaHelperLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaHelperLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaHelperLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaHelperLog("Player Slot "..player.playerslot)
				if player.party == 1 then
					if Mission.JPCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.JPCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.JPCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaHelperLog(Mission.JPCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaHelperLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  						luaHelperLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  				luaHelperLog("----- BREAK from CB Cycle -----")
				break
			end
		end
	end

	if Mission.NOAI == true then
		local cbnum = 1
		local run = luaCountTable(Mission.USCB)
-- RELEASE_LOGOFF  --		luaHelperLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaHelperLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaHelperLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaHelperLog("Player Slot "..player.playerslot)
				if player.party == 0 then
					if Mission.USCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.USCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.USCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaHelperLog(Mission.USCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaHelperLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  						luaHelperLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.USCB) then
-- RELEASE_LOGOFF  				luaHelperLog("----- BREAK from CB Cycle -----")
				break
			end
		end
		local cbnum = 1
		local run = luaCountTable(Mission.JPCB)
-- RELEASE_LOGOFF  --		luaHelperLog("CB Number "..cbnum)
-- RELEASE_LOGOFF  --		luaHelperLog("RUN Number "..run)
		for i = 1, run do
			for idx, player in pairs(Mission.PlayersTable) do
-- RELEASE_LOGOFF  --				luaHelperLog("Player Party "..player.party)
-- RELEASE_LOGOFF  --				luaHelperLog("Player Slot "..player.playerslot)
				if player.party == 1 then
					if Mission.JPCB[cbnum].Type == "COMMANDBUILDING" then
						SetCommandBuildingOwnerPlayer(Mission.JPCB[cbnum], player.playerslot)
					else
						SetRoleAvailable(Mission.JPCB[cbnum], EROLF_ALL, player.playerslot)
					end
-- RELEASE_LOGOFF  					luaHelperLog(Mission.JPCB[cbnum].Name.." assigned to player "..player.playerslot)
					cbnum = cbnum + 1
-- RELEASE_LOGOFF  --					luaHelperLog("CB Number "..cbnum)
					if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  						luaHelperLog("----- BREAK From Player Cycle -----")
						break
					end
--					cbnum = cbnum + 1
				end
			end
			if cbnum > luaCountTable(Mission.JPCB) then
-- RELEASE_LOGOFF  				luaHelperLog("----- BREAK from CB Cycle -----")
				break
			end
		end
	end

-- RELEASE_LOGOFF  	luaHelperLog("----- END CB DISTRIBUTUIN -----")


end

--[[AutoDoc
usage: notLanded, num = luaRemoveLandedUnitsFromTable(entTable, trg, dist)
category: Mission
shortdesc:
desc:
entTable:
trg:
dist:
notLanded:
num:
]]
function luaRemoveLandedUnitsFromTable(entTable, trg, dist)
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable(entTable), "***ERROR: luaRemoveLandedUnitsFromTable requires an entitylist as argument!"..debug.traceback())

	local notLanded = {}

	for key, value in pairs(entTable) do

		if trg ~= nil then
--[[
			-- tmp
			local x
			if value.LandingStarted and luaGetDistance(value, trg) < dist then
				x = true
			else
				x = false
			end
-- RELEASE_LOGOFF  			luaLog("tmp "..value.Name..", dist: "..luaGetDistance(value, trg)..", landed: "..tostring(value.LandingStarted)..", OK? - "..tostring(x))
			-- tmp end
]]
			if value.LandingStarted and luaGetDistance(value, trg) < dist then
-- RELEASE_LOGOFF  				luaHelperLog("unit "..value.Name.." landed")
			else
				table.insert(notLanded, value)
			end
		else
			if not value.LandingStarted then
				table.insert(notLanded, value)
			end
		end
	end

	return notLanded, luaCountTable(entTable) - luaCountTable(notLanded)
end

--[[AutoDoc
usage: units = luaGetOwnUnits([unittype] [,mParty])
category: Mission
shortdesc: visszaadja a sajat egysegeinket
desc: 'mParty'-hoz tartozo, 'unittype' tipusu unitok this tablait adja vissza egy listaban
unittype: string, a kerestt egysegek tipusai
mParty: enum, a keresett party, (PARTY_ALLIED, PARTY_JAPANESE, PARTY_NEUTRAL)
units: table, lista melyeben a keresett unitok this tbalai vannak
]]
function luaGetOwnUnits(unittype, mParty)
-- RELEASE_LOGOFF  	luaHelperLog("Getting own units...")

	local lParty

	if mParty ~= nil then
-- RELEASE_LOGOFF  		Assert(mParty == PARTY_ALLIED or mParty == PARTY_JAPANESE or mParty == PARTY_NEUTRAL, "***ERROR: luaGetOwnUnits party must be PARTY_ALLIED, PARTY_JAPANESE or NIL!"..debug.traceback())
		lParty = mParty
	else
		lParty = Mission.Party
	end

	local units = {}
	for key, value in pairs(recon[lParty].own) do
		for key2, value2 in pairs(value) do
			if unittype ~= nil then
				if unittype == luaGetType(value2) and not value2.Dead then
					table.insert(units, value2)
				end
			elseif not value2.Dead then
				table.insert(units, value2)
			end
		end
	end

	return units
end

-- proximity triggerekkel valo convoy-kezeles
--[[AutoDoc
usage: luaStartConvoy(convoy, path, stoppoints, walktype, callback)
category: Vehicle
shortdesc:
desc:
convoy:
path:
stoppoints:
walktype:
callback:
]]
function luaStartConvoy(convoy, path, stoppoints, walktype, callback)
-- RELEASE_LOGOFF  	luaHelperLog("luaStartConvoyOnPath initiated...")
-- RELEASE_LOGOFF  	Assert(convoy ~= nil and luaIsEntityTable({convoy}) and luaGetType(convoy) == "vehicle", "***ERROR: luaStartConvoyOnPath needs a convoy as first argument!"..debug.traceback())
	if stoppoints ~= nil then
-- RELEASE_LOGOFF  		Assert(type(stoppoints) == "table", "***ERROR: luaStartConvoyOnPath' stoppoint argument needs to be a table!"..debug.traceback())
-- RELEASE_LOGOFF  		Assert(luaCountTable(stoppoints) <= luaCountTable(FillPathPoints(path)), "***ERROR: luaStartConvoyOnPath' stoppoints must be less than or equal to the elements of the path!"..debug.traceback())
	end

-- RELEASE_LOGOFF  	luaHelperLog(" Convoy name: "..convoy.Name)

	LandConvoySetPath(convoy, path)
	LandConvoySetSpeed(convoy, luaRnd(7, 10))
	LandConvoyStart(convoy)

	if stoppoints ~= nil then
--			Mission.Helper_ConvoyParams.Convoy = convoy
--			Mission.Helper_ConvoyParams.Path = path
--			Mission.Helper_ConvoyParams.Mode = mode
--			Mission.Helper_ConvoyParams.StopPoints = stoppoints
		local pathPoints = FillPathPoints(path)

		for key, value in pairs(stoppoints) do
-- RELEASE_LOGOFF  			luaHelperLog("  Setting stoppoint trigger: "..value)
			AddProximityTrigger(convoy, "landconvstop"..convoy.Name..value, "luaStopAndGoConvoy", pathPoints[value], 10)
			convoy["Triggers"] = {}
			convoy.Triggers["landconvstop"..convoy.Name..value] = true
		end
	end

	if walktype == "once" then
		--local lastpos = luaGetPathPoint(path, "last")
		local lastpos = luaGetPathPoint(path, luaCountTable(FillPathPoints(path))-1)	-- valojaban uccso elotti

		AddProximityTrigger(convoy, "convoymove_"..convoy.Name, "luaStopConvoy", lastpos, 10)
		convoy.MoveCB = callback
	end
end

--[[AutoDoc
usage: luaStopConvoy(convoy)
category: Vehicle
shortdesc:
desc:
convoy:
]]
function luaStopConvoy(convoy)
	LandConvoyStop(convoy)
	convoy.Stopped = true
	if convoy.MoveCB then
		convoy.MoveCB(convoy)
	end
end

-- az elozo fv kiegeszitese
--[[AutoDoc
usage: luaStopAndGoConvoy(ent, proxID)
category: Vehicle
shortdesc:
desc:
ent:
proxID:
]]
function luaStopAndGoConvoy(ent, proxID)
	ent.Triggers[proxID] = nil	-- toroljuk a bejegyzest a unitbol

	LandConvoyStop(ent)
	luaDelay(luaContinueConvoyMove, luaRnd(4, 12), "conv", ent)
end

--[[AutoDoc
usage: luaContinueConvoyMove(timerthis)
category: Vehicle
shortdesc:
desc:
timerthis:
]]
function luaContinueConvoyMove(timerthis)
	LandConvoyStart(timerthis.ParamTable.conv)
	LandConvoySetSpeed(timerthis.ParamTable.conv, luaRnd(7, 11))
end

-- minden proximity-bejegyzest torlunk
--[[AutoDoc
usage: luaClearConvoyTriggers(convoy)
category: Vehicle
shortdesc:
desc:
convoy:
]]
function luaClearConvoyTriggers(convoy)
-- RELEASE_LOGOFF  	luaHelperLog("Clearing triggers on "..convoy.Name)

	for key, value in pairs(convoy.Triggers) do
		RemoveTrigger(convoy, key)
	end
	convoy.Triggers = nil
end

--[[
-- nehezsegi szintek beallitasa
function luaSetDifficulty(dif)
-- RELEASE_LOGOFF  	luaHelperLog("Setting difficulty to "..tostring(dif))

	if Mission.Party == PARTY_JAPANESE then
		for key, value in pairs(recon[PARTY_ALLIED].own) do
			for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  				Log("Difficulty level set on unit: ", unit.Name)
				if dif == DIFF_ROOKIE then
					SetCrewLevel(unit, 0)
				elseif dif == DIFF_REGULAR then
					SetCrewLevel(unit, 1)
				end
			end
		end
	else
		for key, value in pairs(recon[PARTY_JAPANESE].own) do
			for key2, unit in pairs(value) do
-- RELEASE_LOGOFF  				Log("Difficulty level set on unit: ", unit.Name)

			end
		end
	end

end
]]
--[[AutoDoc
usage: diff = luaGetDifficultyScoreMultiplier()
category: Mission
shortdesc: visszadja a misszio nehezsegi fok szorzojat
desc: a mission initben beallitott diifculty level alapjan visszaadja a scrore systemben hasznalt szorzot
diff: number, a szoro erteke
]]
function luaGetDifficultyScoreMultiplier()
-- RELEASE_LOGOFF  	luaHelperLog("Getting difficulty multiplier")

	local diff = GetDifficulty()

	if diff == DIFF_ROOKIE then
		return 0.75
	elseif diff == DIFF_REGULAR then
		return 1
	elseif diff == DIFF_VETERAN then
		return 1.25
	end
end

--[[AutoDoc
usage: luaFirstEnter(unit [,dist])
category: Mission
shortdesc: a jatekba valo belepese elotti fade-eles es kameradobas
desc: a mission kezedtekor hasznalt fv, mely a 'unit'-ra dobja a kamerat 'dist' tavolsagbol
unit: table, entity this tablaja amelyre a kamerat dobjuk
dist: number, ilyen messzirol indul a kamera, m.
]]
function luaFirstEnter(unit, dist)
	local lDist
	if dist == nil then
		lDist = 5000
	else
		lDist = dist
	end

	Blackout(true, "", true)
	EnableInput(false)
	Mission.FreeToGo = false
	MovCam_RefPos_Polar(unit, lDist, 3.1415, 0.25, true)

	luaDelay(luaFirstEnter2, 0.5, "unit", unit)
end

--[[AutoDoc
usage: luaFirstEnter2(timerthis)
category: Mission
shortdesc: a luaFirstEnter() idozito fv-e
desc: a luaFirstEnter()-ben beallitott parmaeterek alapjan felfadel es beallitja a 'FreeToGo' valtozot
timerthis: table, a luFirstEnter() altal atadott parameterek osszessege
]]
function luaFirstEnter2(timerthis)
	luaCamOnTarget(timerthis.ParamTable.unit)
	Blackout(false, "", 1.5)
	luaDelaySet("FreeToGo", true, 4)
end

--[[AutoDoc
usage: luaFirstEnterInstant(unit)
category: Mission
shortdesc: a jatekba valo belepese elotti instant fade-eles es kameradobas
desc:  a mission kezedtekor hasznalt fv, mely a 'unit'-ra dobja a kamerat
unit: table, a kamera erre a unitra mozog ra
]]
function luaFirstEnterInstant(unit)
	EnableInput(false)
	Blackout(true, "", true)
	Mission.FreeToGo = false
	luaDelay(luaFirstEnterInstant2, 0.5, "unit", unit)
end

--[[AutoDoc
usage: luaFirstEnterInstant2(timerthis)
category: Mission
shortdesc: a luaFirstEnterInstant() idozito fv-e
desc: a luaFirstEnterInstant()-ben beallitott parmaeterek alapjan felfadel es beallitja a 'FreeToGo' valtozot
timerthis: table, a luFirstEnter() altal atadott parameterek osszessege
]]
function luaFirstEnterInstant2(timerthis)
	SetSelectedUnit(timerthis.ParamTable.unit)
	Blackout(false, "", 1.5)
	luaDelaySet("FreeToGo", true, 2)
	luaDelay(luaFirstEnterInstant3, 2)
end

--[[AutoDoc
usage: luaFirstEnterInstant3(timerthis)
category: Mission
shortdesc: a luaFirstEnterInstant2() idozito fv-e
desc: megadja az inputot a jatekosnak
timerthis: table, a luFirstEnterInstant2() altal atadott parameterek osszessege
]]
function luaFirstEnterInstant3()
	EnableInput(true)
end

--[[AutoDoc
usage: medal = luaGetMedalReward()
category: Mission
shortdesc: visszaadja adott misszio medaljat
desc: a this.Objectives tabla alapjan megmondja, hogy adott misszio milyen medalertekkel bir
medal: enmum, a misszio medalja, MEDAL_GOLD, MEDAL_SILVER, MEDAL_BRONZE
]]
function luaGetMedalReward()

-- RELEASE_LOGOFF  	Assert(Mission.Objectives ~= nil, "ERROR: in luaGetMedalReward, Mission.Objectives is not defined!")
-- RELEASE_LOGOFF  	Assert(type(Mission.Objectives) == "table", "ERROR: in luaGetMedalReward, Mission.Objectives is not a table!")
-- RELEASE_LOGOFF  	Assert(Mission.Objectives.primary ~= nil, "ERROR: in luaGetMedalReward, Mission.Objectives has no 'primary' index!")
-- RELEASE_LOGOFF  	Assert(Mission.Objectives.secondary ~= nil, "ERROR: in luaGetMedalReward, Mission.Objectives has no 'secondary' index!")
-- RELEASE_LOGOFF  	Assert(Mission.Objectives.hidden ~= nil, "ERROR: in luaGetMedalReward, Mission.Objectives has no 'hidden' index!")

	local secondary = true
	local hidden = true

	for idx,objtbl in pairs(Mission.Objectives.primary) do
		if not objtbl.Success then
-- RELEASE_LOGOFF  			luaHelperLog("Primary obj "..tostring(idx).." is not completed!")
			return false
		end
	end
	for idx, objtbl in pairs(Mission.Objectives.secondary) do
		if not objtbl.Success then
-- RELEASE_LOGOFF  			luaHelperLog("Secondary obj "..tostring(idx).." is not completed")
			secondary = false
			break
		end
	end
	for idx, objtbl in pairs(Mission.Objectives.hidden) do
		if not objtbl.Success then
-- RELEASE_LOGOFF  			luaHelperLog("Hidden obj "..tostring(idx).." is not completed")
			hidden = false
			break
		end
	end

-- RELEASE_LOGOFF  	luaLog("Objectives: "..tostring(secondary)..", "..tostring(hidden))

	if secondary and hidden then
		--luaHelperLog("returning MEDAL_GOLD")
		--luaHelperLog("return val type "..type(MEDAL_GOLD))
		--luaHelperLog(MEDAL_GOLD)
		SetAchievements("GA_MP")
		return MEDAL_GOLD
	elseif (secondary and not hidden) or (not secondary and hidden) then
		--luaHelperLog("returning MEDAL_SILVER")
		--luaHelperLog("return val type "..type(MEDAL_SILVER))
		--luaHelperLog(MEDAL_SILVER)
		return MEDAL_SILVER
	elseif not secondary and not hidden then
		--luaHelperLog("returning MEDAL_BRONZE")
		--luaHelperLog("return val type "..type(MEDAL_BRONZE))
		--luaHelperLog(MEDAL_BRONZE)
		return MEDAL_BRONZE
	end
end

--[[
function luaMissionHint()
-- RELEASE_LOGOFF  	luaLog("+ Checking hints...")

	if Mission.MissionStatus ~= nil or Mission.Dead then
		HideHint("")
		return
	end

	if Mission.Hints == nil then
-- RELEASE_LOGOFF  		luaLog("+  Creating Hint table")
		Mission.Hints = {}
		Mission.Hints.PrevUnitType = ""
		Mission.Hints.PrevShowTime = 0
		Mission.Hints.ShowTime = 30
		Mission.Hints.FadeTime = 10
		Mission.Hints.Cycle = 1

-- RELEASE_LOGOFF  		AddWatch("Mission.Hints.Cycle")
	end

	local unit = GetSelectedUnit()
	if unit ~= nil then
		local unittype = unit.Class.Type
		local gTime = GameTime()
		if unittype ~= Mission.Hints.PrevUnitType then
			if gTime - Mission.Hints.PrevShowTime <= Mission.Hints.FadeTime then
				luaMissionHint_Hide(Mission.Hints.PrevUnitType)	-- figyelem, felkeszulni az ures stringre!
			end
			Mission.Hints.Cycle = 1
			luaMissionHint_Show(unittype)	-- figyelem, felkeszulni az ures stringre!
			Mission.Hints.PrevUnitType = unittype
			Mission.Hints.PrevShowTime = gTime
		elseif gTime - Mission.Hints.PrevShowTime > Mission.Hints.ShowTime then
			Mission.Hints.PrevShowTime = gTime
			luaMissionHint_Show(unittype)
		end
	end

	Mission.Hints.Timer = luaDelay(luaMissionHint, 0.9)	-- warning: visszahivja magat!
end

----------------------------------------------------
-- Figyelem! Minden ebben a fuggvenyben vegrehajtott valtoztatas igenyli a _Hide fv-ben tortent valtoztatasokat
--	a megjelenites/eltuntetes miatt!
----------------------------------------------------
function luaMissionHint_Show(unittype)
-- RELEASE_LOGOFF  	luaLog("+  Showing hint for "..unittype)

	if unittype == "BattleShip" then
		local hintNum = 1

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("LeftTrigger_Icon", "Left trigger changes weapon", Mission.Hints.FadeTime)
				ShowHint("RightTrigger_Icon", "Right trigger fires weapon", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Left trigger changes weapon", Mission.Hints.FadeTime, "LeftTrigger_Icon")
				ShowHint("PCHint_Icon", "Right trigger fires weapon", Mission.Hints.FadeTime, "RightTrigger_Icon")
			end
		end

		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	elseif unittype == "Destroyer" or unittype == "Cruiser" then
		local hintNum = 1

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("LeftTrigger_Icon", "Left trigger changes weapon", Mission.Hints.FadeTime)
				ShowHint("RightTrigger_Icon", "Right trigger fires weapon", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Left trigger changes weapon", Mission.Hints.FadeTime, "LeftTrigger_Icon")
				ShowHint("PCHint_Icon", "Right trigger fires weapon", Mission.Hints.FadeTime, "RightTrigger_Icon")
			end
		end

		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	elseif unittype == "DiveBomber" then
		local hintNum = 1

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("RightTrigger_Icon", "Right trigger releases bomb", Mission.Hints.FadeTime)
				ShowHint("LeftTrigger_Icon", "Press and hold left trigger to arm bomb", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Right trigger releases bomb", Mission.Hints.FadeTime, "RightTrigger_Icon")
				ShowHint("PCHint_Icon", "Press and hold left trigger to arm bomb", Mission.Hints.FadeTime, "LeftTrigger_Icon")
			end
		end

		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	elseif unittype == "TorpedoBomber" then
		local hintNum = 1

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("RightTrigger_Icon", "Right trigger releases torpedo", Mission.Hints.FadeTime)
				ShowHint("LeftTrigger_Icon", "Press and hold left trigger to arm torpedo", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Right trigger releases torpedo", Mission.Hints.FadeTime, "RightTrigger_Icon")
				ShowHint("PCHint_Icon", "Press and hold left trigger to arm torpedo", Mission.Hints.FadeTime, "LeftTrigger_Icon")
			end
		end
		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	elseif unittype == "MotherShip" then
		local hintNum = 1

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("LeftTrigger_Icon", "Left trigger enters/exits flight deck", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Left trigger enters/exits flight deck", Mission.Hints.FadeTime, "LeftTrigger_Icon")
			end
		end

		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	elseif unittype == "Submarine" then
		local hintNum = 1

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("DPadUpDown_Icon", "Use the 8D-Pad to dive or emerge", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Use the 8D-Pad to dive or emerge", Mission.Hints.FadeTime, "DPadUpDown_Icon")
			end
		end

		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	elseif unittype == "TorpedoBoat" then
		local hintNum = 2

		if Mission.Hints.Cycle > hintNum then
			Mission.Hints.Cycle = 1
		end

		if Mission.Hints.Cycle == 1 then
			if XBOX then
				ShowHint("LeftStick_Icon", "Use the left stick to drive", Mission.Hints.FadeTime)
				ShowHint("RightStick_Icon", "Use the right stick to look around", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Use the left stick to drive", Mission.Hints.FadeTime, "LeftStick_Icon")
				ShowHint("PCHint_Icon", "Use the right stick to look around", Mission.Hints.FadeTime, "RightStick_Icon")
			end
		elseif Mission.Hints.Cycle == 2 then
			if XBOX then
				ShowHint("LeftTrigger_Icon", "Left trigger changes weapon", Mission.Hints.FadeTime)
				ShowHint("RightTrigger_Icon", "Right trigger fires weapon", Mission.Hints.FadeTime)
			elseif PC then
				ShowHint("PCHint_Icon", "Left trigger changes weapon", Mission.Hints.FadeTime, "LeftTrigger_Icon")
				ShowHint("PCHint_Icon", "Right trigger fires weapon", Mission.Hints.FadeTime, "RightTrigger_Icon")
			end
		end

		Mission.Hints.Cycle = Mission.Hints.Cycle + 1
	end
end

function luaMissionHint_Hide(unittype)
-- RELEASE_LOGOFF  	luaLog("+  Hiding hint for "..unittype)

	if unittype == "BattleShip" then
		local cycle = Mission.Hints.Cycle - 1
		if cycle == 1 then
			if XBOX then
				HideHint("LeftTrigger_Icon")
				HideHint("RightTrigger_Icon")
			elseif PC then
				HideHint("LeftTrigger_Icon", true)
				HideHint("RightTrigger_Icon", true)
			end
		end
	elseif unittype == "Destroyer" or unittype == "Cruiser" then
		if cycle == 1 then
			if XBOX then
				HideHint("LeftTrigger_Icon")
				HideHint("RightTrigger_Icon")
			elseif PC then
				HideHint("LeftTrigger_Icon", true)
				HideHint("RightTrigger_Icon", true)
			end
		end
	elseif unittype == "DiveBomber" then
		if cycle == 1 then
			if XBOX then
				HideHint("RightTrigger_Icon")
				HideHint("LeftTrigger_Icon")
			elseif PC then
				HideHint("RightTrigger_Icon", true)
				HideHint("LeftTrigger_Icon", true)
			end
		end
	elseif unittype == "TorpedoBomber" then
		if cycle == 1 then
			if XBOX then
				HideHint("RightTrigger_Icon")
				HideHint("LeftTrigger_Icon")
			elseif PC then
				HideHint("RightTrigger_Icon", true)
				HideHint("LeftTrigger_Icon", true)
			end
		end
	elseif unittype == "MotherShip" then
		if cycle == 1 then
			if XBOX then
				HideHint("LeftTrigger_Icon")
			elseif PC then
				HideHint("LeftTrigger_Icon", true)
			end
		end
	elseif unittype == "Submarine" then
		if cycle == 1 then
			if XBOX then
				HideHint("DPadUpDown_Icon")
			elseif PC then
				HideHint("DPadUpDown_Icon", true)
			end
		end
	elseif unittype == "TorpedoBoat" then
		if cycle == 1 then
			if XBOX then
				HideHint("LeftStick_Icon")
				HideHint("RightStick_Icon")
			elseif PC then
				HideHint("LeftStick_Icon", true)
				HideHint("RightStick_Icon", true)
			end
		elseif cycle == 2 then
			if XBOX then
				HideHint("LeftTrigger_Icon")
				HideHint("RightTrigger_Icon")
			elseif PC then
				HideHint("LeftTrigger_Icon", true)
				HideHint("RightTrigger_Icon", true)
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog("+   Empty or unhandled hide...")
	end
end
]]

--[[AutoDoc
usage: luaWriteCamState()
category: Debug
shortdesc: beirja a logba a kamera poziciojat
desc: beirja a CameraState.Log-ba a kamera poziciojat, forgasi iranyat
]]
function luaWriteCamState()
	local firstLog = false
	local date = os.date()
	local mode

	local lgfile = "CameraState.log"

	if Mission ~= nil then
		-- first logging --
		if Mission.CamLog == nil then
			Mission.CamLog = {}
			mode = "u"
		end
	else
		return
	end

	-- file opening --
	if mode == "a" or mode == nil then
		mode = "a+"
	elseif mode == "u" then
		mode = "w+"
	else
		mode = "a+"
	end
	local log = io.open(lgfile, mode)

	local camState = GetCameraState()
	table.insert(Mission.CamLog, camState)

	local target = luaGetCamTargetEnt()
	local relpos
	if target then
		relpos = luaGetCamRelPos(target)
	end

	log:write("CAM STATE "..table.getn(Mission.CamLog), "  (", date, ")", "\n")
	log:write(" - POS X ", camState.Position.x, "\n")
	log:write(" - POS Y ", camState.Position.y, "\n")
	log:write(" - POS Z ", camState.Position.z, "\n")
	log:write("\n")
	log:write(" - ROT X ", camState.Rotation.x, "\n")
	log:write(" - ROT Y ", camState.Rotation.y, "\n")
	log:write(" - ROT Z ", camState.Rotation.z, "\n")
	log:write("\n")
	log:write(" - ACT ZOOM : ", camState.Zoom, "\n\n")

	if target then
		log:write("\tRelative pos to target: ", target.Name, "\n")
		log:write("\t - POS X ", relpos.x, "\n")
		log:write("\t - POS Y ", relpos.y, "\n")
		log:write("\t - POS Z ", relpos.z, "\n\n\n")
	end

	-- closing file --
	log:close()
end

--[[AutoDoc
usage: luaCamGoRound(ent, camTime [,callback])
category: Camera
shortdesc: kamera korbeforditasa a unit meretetol fuggoen
desc: korbemozgatja a kamerat 'camTime' ido alatt, 'ent' korul es meghivja a 'callback' fv-t
ent: table, az entity this tablaja amely korul a kamerat forgatjuk
camTime: number, ennyi ido alatt forog korbe a kamera
callback: function, ezt a fv-t hivjuk meg
]]
function luaCamGoRound(ent, camTime, callback)
-- RELEASE_LOGOFF  	Assert(ent ~= nil and luaIsEntityTable({ent}), "***ERROR:luaCamGoRound needs an entity (1st param)!\n"..debug.traceback())
-- RELEASE_LOGOFF  	Assert(type(camTime) == "number", "***ERROR:luaCamGoRound's timer (2nd param) must be a number!\n"..debug.traceback())
-- RELEASE_LOGOFF  --	Assert(callback ~= nil, "***ERROR:luaCamGoRound must have a callback function (3rd param)!\n"..debug.traceback())

	MovCam_SetDeviationFactor(0)

	local size = ent.Class.Length*2

	local uType = luaGetType(ent)
	if uType == "sub" then
		MovCam_RefPos_Polar(ent, size*0.55, -math.pi/8, -math.pi/12, true)	-- vagassal megyunk a unitra
	elseif uType == "plane" then
		MovCam_RefPos_Polar(ent, size*1.2, math.pi/4, math.pi/12, true)	-- vagassal megyunk a unitra
	else
		MovCam_RefPos_Polar(ent, size, math.pi/4, math.pi/12, true)	-- vagassal megyunk a unitra
	end

	MovCam_HandMode_Targeted(ent)	-- innentol kezimodba valtunk

	if uType == "plane" then
		MovCam_AddInterpolator("walkHInput", size/1100, size/1100, 0, camTime*1.2)	-- es korbemegyunk a merettol fuggo sebesseggel
	else
		MovCam_AddInterpolator("walkHInput", size/1200, size/1200, 0, camTime*1.2)	-- es korbemegyunk a merettol fuggo sebesseggel
	end

	if callback then
		return luaDelay(callback, camTime)
	end
end

--[[AutoDoc
usage: units = luaGetClassUnits(cID)
category: Mission
shortdesc: minden ID-hez tartozo egyseget visszaad, ami bent van a scene-ben
desc: adott 'cID' hez tartozo minden egyseget visszaad egy listaban
cID: number, a VehicleClasses.lua-ban talahato unithoz tartozo key
units: table, lista a sceneben levo osszes 'cID'-u unit this tablaival
]]
function luaGetClassUnits(cID)
	--Assert(type(uID) == "string", "***ERROR: luaGetClassUnits must get a string 'ID' parameter!\n"..debug.traceback())

	local units = {}

	for key, rParty in pairs(recon) do
		for key2, ownUnits in pairs(rParty.own) do
			for uID, unit in pairs(ownUnits) do
				if unit.Class.ID == cID then
-- RELEASE_LOGOFF  					luaHelperLog("Found a unit with class ID "..cID)
					table.insert(units, unit)
				end
			end
		end
	end

	return units
end

--[[
Visszaad egy tablat numberikus indexel, amelyben fel vannak sorolva az ent damage sekcioi es indexei:
 { [1] = {["Category"] = DAM_ENGINEROOM, ["Index"] = 0},
   [2] = {["Category"] = DAM_FUELTANK, ["Index"] = 0},
   [3] = {["Category"] = DAM_FUELTANK, ["Index"] = 1},
   ...
 }
]]
--[[AutoDoc
usage: damSections = luaGetDamageSections(ent)
category: Unit
shortdesc: visszaadja a dmage szekciokat
desc: adott 'ent'-hez tartozo minden damage szekciot visszaad egy listaban
ent: table, a vizsgalt entity this tablaja
damSections: table, lista melynek kulcsai 'Category' ehhez tartoznak a damage szekciok, illetve 'Index' amihez adott szekcio indexe tartozik
]]
function luaGetDamageSections(ent)
	if ent.ID == nil or ent.Dead then
-- RELEASE_LOGOFF  		luaHelperLog("Bad entity param in luaGetDamageSections")
		return
	end
	if luaGetType(ent) ~= "ship" then
-- RELEASE_LOGOFF  		luaHelperLog("Entity is not a ship in luaGetDamageSections")
		return
	end

	local damSections = {}
	for idx,secType in pairs(ent.Class.Damage.Sections) do
		local cat = nil
		if secType.MshCategory == "engineroom" then
			cat = DAM_ENGINEROOM
		elseif secType.MshCategory == "fueltank" then
			cat = DAM_FUELTANK
		elseif secType.MshCategory == "underwater" then
			cat = DAM_UNDERWATER
		elseif secType.MshCategory == "magazine" then
			cat = DAM_MAGAZINE
		elseif secType.MshCategory == "hangar" then
			cat = DAM_HANGAR
		elseif secType.MshCategory == "steering" then
			cat = DAM_STEERING
		elseif secType.MshCategory == "runway" then
			cat = DAM_RUNWAY
		elseif secType.MshCategory == "body" then
			cat = DAM_BODY
		end

		if cat ~= nil then --nilt nem teszunk bele
			local newSection = {["Category"] = cat, ["Index"] = secType.Index}
			if next(newSection) ~= nil then
				table.insert(damSections, newSection)
			end
		end
	end
	--if next(damSections) ~= nil then
		return damSections
	--else
-- RELEASE_LOGOFF  	--	luaHelperLog("ERROR: no damage section found in luaGetDamageSections on entity "..ent.Name)
	--	return nil
	--end
end

--[[AutoDoc
usage: luaJumpToUnitDelay(timerthis)
category: Mission
shortdesc:
desc:
timerthis:
]]
function luaJumpToUnitDelay(timerthis)
	luaJumpToUnit(thisTable[timerthis.ParamTable.unitID], timerthis.ParamTable.CB)
end

--[[AutoDoc
usage: luaJumpToUnit(unit [,cb] [,delayTime])
category: Mission
shortdesc:  blackouttal unitra valtas
desc: lefadeli a kepernyot, majd 'unit'-ba teszi a jatekost, felfadel, meghivja a 'cb' fv-t, 'delayTime' sec alatt
unit: table, a kivalaszotott entity this tablaja
cb: function, a meghivando callback fv
delayTime: number, ennyi sec. alatt fut le a fv
]]
function luaJumpToUnit(unit, cb, delayTime)
-- RELEASE_LOGOFF  	Assert(luaIsEntityTable({unit}), "***ERROR: luaJumpToUnit got a non-ent parameter!"..debug.traceback())

	if delayTime then
		return luaDelay(luaJumpToUnitDelay, delayTime, "unitID", unit.ID, "CB", cb)
	end

	Blackout(true, "luaJumpToUnit2")
	if Mission.Tmp == nil then
		Mission.Tmp = {}
	end
	Mission.Tmp.UnitJump = {}
	if cb then
-- RELEASE_LOGOFF  		Assert(type(cb) == "string", "***ERROR: luaJumpToUnit must get a string as callback!"..debug.traceback())
		Mission.Tmp.UnitJump.CB = cb
	end

	Mission.Tmp.UnitJump.Unit = unit
end

--[[AutoDoc
usage: luaJumpToUnit2()
category: Mission
shortdesc:  luaJumpUnit() idozitoje
desc: a luaJumpUnit() indozitest vezerlo fv-e
]]
function luaJumpToUnit2()
	SetSelectedUnit(Mission.Tmp.UnitJump.Unit)

	if Mission.Tmp.UnitJump.CB then
		Blackout(false, Mission.Tmp.UnitJump.CB)
	else
		Blackout(false, "")
	end
end

--[[AutoDoc
usage: luaCheckMusic(unit, [,dist] [,customMusic])
category: Mission
shortdesc:  zenet valto fv
desc: minden hivaskor ellenorzi unitra, hogy van-e a kozeleben ellenseges egyseg. Ha van, akkor action zenere valt, ha nincs, akkor tensionre
unit: table, a unit this tablaja, amelyet vizsgalunk
dist: number, ilyen tavolsagra vizsgalunk maximum, m. default: 3500 m.
customMusic: enum, ezt a zenefilet jatszuk le, default MUSIC_TENSION, MUSIC_ACTION
]]
--
function luaCheckMusic(unit, dist, customMusic)
-- RELEASE_LOGOFF  	luaHelperLog("-- MUSIC: Checking music change...")

	--CustomMusic
	if customMusic then
		Mission.SuspendMusicCheck = true
		if customMusic == "MinorVictory" and Mission.CurrentMusic ~= MUSIC_CUSTOM1 and Mission.CurrentMusic ~= MUSIC_CUSTOM2 then
-- RELEASE_LOGOFF  			luaHelperLog("-- MUSIC:  Setting to MinorVictory")
			Music_Control_SetLevel(MUSIC_CUSTOM1)
			Mission.CurrentMusic = MUSIC_CUSTOM1
			if Mission.MusicChangeTimer1 then
				if not Mission.MusicChangeTimer1.Dead then
					luaClearDelay(Mission.MusicChangeTimer1)
				end
			end
			if Mission.MusicChangeTimer2 then
				if not Mission.MusicChangeTimer2.Dead then
					luaClearDelay(Mission.MusicChangeTimer2)
				end
			end
			if Mission.MusicChangeTimer3 then
				if not Mission.MusicChangeTimer3.Dead then
					luaClearDelay(Mission.MusicChangeTimer3)
				end
			end
			if Mission.Party == PARTY_ALLIED then
				Mission.MusicChangeTimer1 = luaDelaySet("SuspendMusicCheck", false, 29.90)
				Mission.MusicChangeTimer2 = luaDelay(luaCheckMusicExt, 29.95)
				Mission.MusicChangeTimer3 = luaDelaySet("MusicChangeOnMap", true, 29.90)
			elseif Mission.Party == PARTY_JAPANESE then
				Mission.MusicChangeTimer1 = luaDelaySet("SuspendMusicCheck", false, 24.30)
				Mission.MusicChangeTimer2 = luaDelay(luaCheckMusicExt, 24.35)
				Mission.MusicChangeTimer3 = luaDelaySet("MusicChangeOnMap", true, 24.30)
			end
		elseif customMusic == "MinorVictory" and Mission.CurrentMusic == MUSIC_CUSTOM1 then
-- RELEASE_LOGOFF  			luaHelperLog(" << Change of music to MinorVictory denied, MinorVictory is already playing.")
		elseif customMusic == "MinorVictory" and Mission.CurrentMusic == MUSIC_CUSTOM2 then
-- RELEASE_LOGOFF  			luaHelperLog(" << Change of music to MinorVictory denied, MinorDefeat is playing.")
		elseif customMusic == "MinorDefeat" and Mission.CurrentMusic ~= MUSIC_CUSTOM2 then
-- RELEASE_LOGOFF  			luaHelperLog("-- MUSIC:  Setting to MinorDefeat")
			Music_Control_SetLevel(MUSIC_CUSTOM2)
			Mission.CurrentMusic = MUSIC_CUSTOM2
			if Mission.MusicChangeTimer1 then
				if not Mission.MusicChangeTimer1.Dead then
					luaClearDelay(Mission.MusicChangeTimer1)
				end
			end
			if Mission.MusicChangeTimer2 then
				if not Mission.MusicChangeTimer2.Dead then
					luaClearDelay(Mission.MusicChangeTimer2)
				end
			end
			if Mission.MusicChangeTimer3 then
				if not Mission.MusicChangeTimer3.Dead then
					luaClearDelay(Mission.MusicChangeTimer3)
				end
			end
			if Mission.Party == PARTY_ALLIED then
				Mission.MusicChangeTimer1 = luaDelaySet("SuspendMusicCheck", false, 24.50)
				Mission.MusicChangeTimer2 = luaDelay(luaCheckMusicExt, 24.55)
				Mission.MusicChangeTimer3 = luaDelaySet("MusicChangeOnMap", true, 24.50)
			elseif Mission.Party == PARTY_JAPANESE then
				Mission.MusicChangeTimer1 = luaDelaySet("SuspendMusicCheck", false, 25.40)
				Mission.MusicChangeTimer2 = luaDelay(luaCheckMusicExt, 25.45)
				Mission.MusicChangeTimer3 = luaDelaySet("MusicChangeOnMap", true, 25.40)
			end
		elseif customMusic == "MinorDefeat" then
-- RELEASE_LOGOFF  			luaHelperLog(" << Change of music to MinorDefeat denied, MinorDefeat is already playing.")
		end
	end

	if Mission.SuspendMusicCheck then
-- RELEASE_LOGOFF  		luaHelperLog(" << Change of music denied, custom music is playing.")
		return
	end

	if unit == nil then
		if not customMusic then
			Mission.MusicChangeLastUnit = nil
		end
		unit = GetSelectedUnit()
		if unit == nil then
-- RELEASE_LOGOFF  			luaHelperLog("-- MUSIC: no unit selectable, check denied")
			return
		end
	else
		Mission.MusicChangeLastUnit = unit
	end

	if unit.Dead then
-- RELEASE_LOGOFF  		luaHelperLog("-- MUSIC:  Music unit is DEAD, check denied")
		return
	end

	local map = IsGUIActive("GUI_map") -- ha a terkepen vagyunk, nem valtunk zenet
	if map and not Mission.MusicChangeOnMap then
-- RELEASE_LOGOFF  		luaHelperLog("-- MUSIC: On map, check denied")
		return
	end

	if dist == nil then
		if not customMusic then
			Mission.MusicChangeLastDist = nil
		end
		dist = 3500
	else
		Mission.MusicChangeLastDist = dist
	end

	--[[
		zenehatarok, valtasok:

		Calm: dist*1.2-tol
		Tension: dist*1.2 es dist*0.9 kozott
		Action: dist*0.9 alatt
	]]
	local calmDist, actionDist = dist*1.2, dist*0.9

	local ships = luaGetShipsAround(unit, calmDist, "enemy")
	local planes = luaGetPlanesAround(unit, calmDist, "enemy")

	-- ezek a tabladefiniciok mutatjak elore nem gondolkodasunk problematikus meretet
	if planes == nil then
		planes = {}
	end

	if ships == nil then
		ships = {}
	end

	local calmReq, tensionReq, actionReq
	if next(planes) ==  nil and next(ships) == nil then	-- ha nincs senki a kozelben, calm
		calmReq = true
	else
		local dummy, nearestDist = luaSortByDistance(unit, luaSumTablesIndex(ships, planes), true)	-- leszurjuk a legkozelebbi unitot

		-- check: melyik zene legyen?
		if nearestDist >= calmDist then	-- calm
			calmReq = true
		elseif nearestDist < calmDist and nearestDist >= actionDist then	-- tension
			tensionReq = true
		elseif nearestDist < actionDist then	-- action
			actionReq = true
		end
	end

	-- minimalis feszultsegi szint
	if not Mission.MusicChangeMinLevel then
		Mission.MusicChangeMinLevel = MUSIC_CALM
	end
	if Mission.MusicChangeMinLevel == MUSIC_ACTION then
		calmReq = false
		tensionReq = false
		actionReq = true
	elseif Mission.MusicChangeMinLevel == MUSIC_TENSION then
		if not actionReq then
			calmReq = false
			tensionReq = true
		end
	end

	-- adott idon belul nem valtunk megint zenet
	if not Mission.MusicChangeTime then
		Mission.MusicChangedAtTime = -5
		Mission.MusicChangeTime = 5
	end

	if calmReq and Mission.CurrentMusic ~= MUSIC_CALM and GameTime()-Mission.MusicChangedAtTime > Mission.MusicChangeTime then
-- RELEASE_LOGOFF  		luaHelperLog("-- MUSIC:  Setting to calm")
		Music_Control_SetLevel(MUSIC_CALM)
		Mission.CurrentMusic = MUSIC_CALM
		Mission.MusicChangedAtTime = GameTime()
		Mission.MusicChangeOnMap = nil
	elseif tensionReq and Mission.CurrentMusic ~= MUSIC_TENSION and GameTime()-Mission.MusicChangedAtTime > Mission.MusicChangeTime then
-- RELEASE_LOGOFF  		luaHelperLog("-- MUSIC:  Setting to tension")
		Music_Control_SetLevel(MUSIC_TENSION)
		Mission.CurrentMusic = MUSIC_TENSION
		Mission.MusicChangedAtTime = GameTime()
		Mission.MusicChangeOnMap = nil
	elseif actionReq and Mission.CurrentMusic ~= MUSIC_ACTION and GameTime()-Mission.MusicChangedAtTime > Mission.MusicChangeTime then
-- RELEASE_LOGOFF  		luaHelperLog("-- MUSIC:  Setting to action")
		Music_Control_SetLevel(MUSIC_ACTION)
		Mission.CurrentMusic = MUSIC_ACTION
		Mission.MusicChangedAtTime = GameTime()
		Mission.MusicChangeOnMap = nil
	end
end

--[[AutoDoc
usage: luaCheckMusicExt()
category: Mission
shortdesc: luaCheckMusic() idozitett fv-e
desc: luaCheckMusic() idozitett fv-e, mely folyamatosan vizsgalja a zenet
]]
function luaCheckMusicExt()
	luaCheckMusic(Mission.MusicChangeLastUnit, Mission.MusicChangeLastDist)
end

--[[AutoDoc
usage: luaCheckMusicSetMinLevel(musicLevel)
category: Mission
shortdesc:
desc:
musicLevel:
]]
function luaCheckMusicSetMinLevel(musicLevel)
	if not musicLevel then
		Mission.MusicChangeMinLevel = MUSIC_CALM
	else
		Mission.MusicChangeMinLevel = musicLevel
	end
end

--[[AutoDoc
usage: luaGenerateFishSchool(coordTbl, schoolCount [,trgEnt])
category: Mission
shortdesc: haliskolat general
desc: 'coordTbl'-ben megadott koordinatakon belul, 'schoolCount' mennyisegu haliskolat general a 'trgEnt'-hez kepest
coordTbl: table, koordinatatable elso es masodik ertekei a min es max koordinatak melyek meghataroznak egy teglatestet
schoolCount: number, ennyi iskolat general, min 1, max 40, ellenkezo esetben 5
trgEnt: table, egy entity this tablaja amelyhez kozel rakunk nehany haliskolat
]]
function luaGenerateFishSchool(coordTbl, schoolCount, trgEnt)
-- RELEASE_LOGOFF  	luaHelperLog("luaGenerateFishSchool called")
	if coordTbl == nil or type(coordTbl) ~= "table" then
-- RELEASE_LOGOFF  		luaHelperLog("Wrong coordTbl param is luaGenerateFishSChool, setting it to default")
		coordTbl = 	{
			[1] = {["x"] = -7000, ["y"] = 0, ["z"] = -9000},
			[2] = {["x"] = 7000, ["y"] = 0, ["z"] = 9000},
		}
	end

	if schoolCount < 1 or schoolCount > 40 then
-- RELEASE_LOGOFF  		luaLog("Wrong count param is luaGenerateFishSChool, setting it to 5")
		schoolCount = 5
	end

	if trgEnt ~= nil and not luaIsEntityTable({trgEnt}, false) then
-- RELEASE_LOGOFF  		luaHelperLog("Wrong entity given as param in luaGenerateFishSChool, setting it to nil")
		trgEnt = nil
	end

	local schools = {}
	local dist = 1500
	local i = 0

	for count = 1,schoolCount do

		i = i + 1
		if i == schoolCount * 1.5 then
-- RELEASE_LOGOFF  			luaHelperLog("Hmm ez lehet hogy vegtelenbe futna.")
			break
		end

		local schoolOK = true
		local pos = {}
			pos.x = luaRnd(coordTbl[1].x, coordTbl[2].x)
			--pos.y = luaRnd(coordTbl[1].y, coordTbl[2].y)
			if trgEnt ~= nil then
				local height = trgEnt.Class.Height
				pos.y = (luaRnd(1,4) * 20)+ height * -1.5
			else
					pos.y = (luaRnd(1,4) * -20) + 7
			end
			pos.z = luaRnd(coordTbl[1].z, coordTbl[2].z)

		for idx,schoolPos in pairs(schools) do
			local diffX = schoolPos.x - pos.x
			local diffY = schoolPos.y - pos.y
			local diffZ = schoolPos.z - pos.z
			local schoolDist = math.sqrt(math.pow(diffX, 2) + math.pow(diffY, 2) + math.pow(diffZ, 2))

-- RELEASE_LOGOFF  			luaHelperLog("sDist "..tostring(schoolDist).." dist "..tostring(dist))


			if schoolDist < dist then
				schoolOK = false
-- RELEASE_LOGOFF  				luaHelperLog("School too close")
				count = count - 1
				break
			end
			_island = IsLandscape(schoolPos)
			if  _island~= nil then
				schoolOK = false
-- RELEASE_LOGOFF  				luaHelperLog("School on island close")
				count = count - 1
				break
			end
		end

-- RELEASE_LOGOFF  		luaHelperLog("schoolOK "..tostring(schoolOK))
		if schoolOK then
			table.insert(schools, pos)
		end

	end	--schoolCount

	--luaHelperLog("schools Table")
	--luaHelperLog(schools)

	for idx,pos in pairs(schools) do
			InsertFishSchool(luaRnd(1,5),pos)
	end

-- RELEASE_LOGOFF  	luaHelperLog("Inserted "..tostring(table.getn(schools)).." schools")

	if trgEnt ~= nil then
		local pos = GetPosition(trgEnt)
			pos.x = pos.x + math.floor((luaRnd(- trgEnt.Class.Width * 1.5, trgEnt.Class.Width * 1.5)))
			pos.y = pos.y + (luaRnd(-15,-10))
			pos.z = pos.z + math.floor((luaRnd(- trgEnt.Class.Length * 1.5, trgEnt.Class.Length * 1.5)))
			InsertFishSchool(luaRnd(1,5),pos)
	end

	--return schools
end

--[[
Letrehoz egy Control.ControlFunctionNames tablat melynek indexei inputID-k,
ertekei pedig vagy control funkcionevek (pl. Map Set Target), vagy pedig egy tabla
ami control funkcioneveket tartalmaz.
]]
--[[AutoDoc
usage: luaLoadControlFunctionNames()
category: Mission
shortdesc: Control.ControlFunctionNames tabla letrehozasa
desc: Letrehoz egy Control.ControlFunctionNames tablat melynek indexei inputID-k, ertekei pedig vagy control funkcionevek (pl. Map Set Target), vagy pedig egy tabla ami control funkcioneveket tartalmaz.
]]
function luaLoadControlFunctionNames()
	if PC then
		DoFile("Scripts/datatables/KeyboardSetup.lua")
		Conflicts = nil
		InputNames = nil
		local controlFunctionNames = {}
		for groupIndex, group in pairs (KeyboardSetup) do
			for propertyIndex, property in pairs (group) do
				if propertyIndex == "Inputs" then
					for key, inputDef in pairs (property) do
						if type(inputDef) == "table" then
							for key, inputID in pairs (inputDef[2]) do
								if not controlFunctionNames[inputID] then
									controlFunctionNames[inputID] = inputDef[1]
								else
									local tempTable = {}
									if type(controlFunctionNames[inputID]) ~= "table" then
										table.insert(tempTable, controlFunctionNames[inputID])
										table.insert(tempTable, inputDef[1])
									else
										for i, functionName in pairs (controlFunctionNames[inputID]) do
	 										table.insert(tempTable, functionName)
										end
										table.insert(tempTable, inputDef[1])
									end
									controlFunctionNames[inputID] = tempTable
								end
							end
						end
					end
				end
			end
		end
		KeyboardSetup = nil
		if not Control then
			Control = {}
		end
		Control.ControlFunctionNames = controlFunctionNames
	end
end

--[[
Beallitja a Control[NarrativeParam..paramExtension] valtozot az adott inputID-hez tartozo elso bind-olt
gombra, vagy az optionsben hozza tartozo funkcio nevere.
A paramExtension opcionalis.
Ha Control.ControlFunctionNamesDebug igaz, akkor minden esetben az optionsben talalhato funkcio nevet
irja be a valtozoba (ez szukseges a pcs verzio tesztelesehez).
]]
--[[AutoDoc
usage: luaSetNarrativeParam(inputID [,paramExtension] [,secondAxis])
category: Mission
shortdesc: beallitja a Control[NarrativeParam..paramExtension] valtozot
desc: Beallitja a Control[NarrativeParam..paramExtension] valtozot az adott inputID-hez tartozo elso bind-olt gombra, vagy az optionsben hozza tartozo funkcio nevere. Ha Control.ControlFunctionNamesDebug igaz, akkor minden esetben az optionsben talalhato funkcio nevet irja be a valtozoba (ez szukseges a pcs verzio tesztelesehez).
inputID: number, a kerdeses inputID, lsd. Inputs.lua
paramExtension: number,
]]
function luaSetNarrativeParam(inputID, paramExtension, secondAxis)
	if PC and not X360COMP then
-- RELEASE_LOGOFF  		Assert(inputID ~= nil and type(inputID) == "number", "***ERROR: luaSetNarrativeParam needs an InputID as first param!"..debug.traceback())
		if paramExtension then
-- RELEASE_LOGOFF  			Assert(type(paramExtension) == "number", "***ERROR: luaSetNarrativeParam needs a number as second param!"..debug.traceback())
		else
			paramExtension = ""
		end

-- RELEASE_LOGOFF  		Assert(Control ~= nil and type(Control) == "table" and Control.ControlFunctionNames ~= nil, "***ERROR: luaSetNarrativeParam requires the use of luaLoadControlFunctionNames!"..debug.traceback())
		if not Control then
			Control = {}
		end
		if not Control.ControlFunctionNames then
			luaLoadControlFunctionNames()
		end

		local configuredInputs
		if secondAxis then
			local temp
			temp, configuredInputs = GetConfiguredInput(inputID)
		else
			configuredInputs = GetConfiguredInput(inputID)
		end

		if table.getn(configuredInputs) == 0 or Control.ControlFunctionNamesDebug then
			if type(Control.ControlFunctionNames[inputID]) == "table" then
				if secondAxis then
					Control["NarrativeParam"..paramExtension] = Control.ControlFunctionNames[inputID][2]
				else
					Control["NarrativeParam"..paramExtension] = Control.ControlFunctionNames[inputID][1]
				end
			else
				Control["NarrativeParam"..paramExtension] = Control.ControlFunctionNames[inputID]
			end
		else
			Control["NarrativeParam"..paramExtension] = configuredInputs[1]
		end
	end
end

--[[AutoDoc
usage: luaSetNarrativeSticks()
category: Mission
shortdesc: Beallitja a hintekben hasznalatos stick hivatkozasokat.
desc: Beallitja a hintekben hasznalatos stick hivatkozasokat az optionsben swap stick opcioinak megfeleloen (Control.MoveStick, Control.MoveStickClick, Control.CameraStick, Control.CameraStickClick)
]]
function luaSetNarrativeSticks()
	if XENON or X360COMP then
		if not Control then
			Control = {}
		end

		Control.SwapSticksEnabled = IsSwapSticksEnabled()

		if Control.SwapSticksEnabled then
			Control.MoveStick = "globals.narrative_left_stick"
			Control.MoveStickClick = "globals.narrative_left_stick_click"
			Control.CameraStick = "globals.narrative_right_stick"
			Control.CameraStickClick = "globals.narrative_right_stick_click"
		else
			Control.MoveStick = "globals.narrative_right_stick"
			Control.MoveStickClick = "globals.narrative_right_stick_click"
			Control.CameraStick = "globals.narrative_left_stick"
			Control.CameraStickClick = "globals.narrative_left_stick_click"
		end
	end
end

--[[AutoDoc
usage: luaInitMissionEnd(endEnt, endText, movie, noRanking, onlymovie, ignoreCollision)
category: Mission
shortdesc: a luMissionFailedNew() es a luaMissionCompletedNew() altal hivott inicializalo fv
desc: serthetetlenne teszi a unitokat, es beallitja a mission terminalasahoz szukseges valtozokat
endEnt: table, entity, amelyre a kamerat dobjuk
endText: string, ezt az uzenetet irjuk ki warningkent
movie: string, a .bik file neve amit lejatszunk a kameramozgas utan
noRanking: bool, true eseten kihagyja a medal osztast
onlymovie: bool, true eseten csak a movie hivodik meg az ingame kamera nem
ignoreCollision: bool, true eseten kiiktatja a navigator AI elkerulo rutinjait
]]
function luaInitMissionEnd(endEnt, endText, movie, noRanking, onlymovie, ignoreCollision)
	-- scoring timer leallitasa
	Scoring_RealPlayTimeRunning(false)

	-- letiltunk minden warningot
	if Mission.Multiplayer == nil then
		EnableMessages(false)
-- RELEASE_LOGOFF  		luaHelperLog("Messages false")
	end

	-- inputtiltas
	EnableInput(false)
-- RELEASE_LOGOFF  	luaHelperLog("Input false")

	-- Countdown letiltasa
	CountdownCancel()
-- RELEASE_LOGOFF  	luaHelperLog("Countdown false")

--	HideUnitHP()
--	for i = 1,10 do
--		HideScoreDisplay(i,0)
--	end

	-- mindenkit serthetetlenne teszunk
	for key, value in pairs(luaGetOwnUnits(nil, PARTY_ALLIED)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible allied units: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, 0.1)
		end
	end

	for key, value in pairs(luaGetOwnUnits(nil, PARTY_JAPANESE)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible Japanese units: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, 0.1)
		end
	end

	for key, value in pairs(luaGetOwnUnits(nil, PARTY_NEUTRAL)) do
-- RELEASE_LOGOFF  		luaLog(" Setting invincible neutral units: "..value.Name)	-- tmp
		if not value.Dead then
			SetInvincible(value, 0.1)
		end
	end

	MissionNarrativeClear()
-- RELEASE_LOGOFF  	luaHelperLog("Narrativeclear")

	-- aktualis dialogusok kiirtasa
	-- ezzel csinnyan kell banni mert lehet hogy kellenek zarodialogusok, szoval inkabb akkor hivjuk a completedet, ha ures a queue
	luaClearDialogs()

	-- atadjuk az iranyitast az AI-nak
	if endEnt then
		if not endEnt.Dead then
			local uType = luaGetType(endEnt)

			if uType == "plane" then
				SetRoleAvailable(endEnt, EROLF_ALL, PLAYER_AI)
			elseif uType == "ship" then
				SetRoleAvailable(endEnt, EROLF_ALL, PLAYER_AI)
				if not ignoreCollision then
					NavigatorMoveToRange(endEnt, GetClosestBorderZone(GetPosition(endEnt)))
				end
			end
		end
	end

	Mission.MissionEndParams = {}
	Mission.MissionEndParams.Text = endText
	Mission.MissionEndParams.Ent = endEnt
	Mission.MissionEndParams.Movie = movie
-- RELEASE_LOGOFF  	luaHelperLog("end of init end")
end

--[[
function luaCamTeszt()
-- RELEASE_LOGOFF  	luaLog("Cam test")
	if Mission.CamTest == nil then
		Mission.CamTest = 0
	else
		Mission.CamTest = Mission.CamTest + 1
	end

	local cam = GetCameraState().Position

-- RELEASE_LOGOFF  	luaLog("-------- CAM POS "..Mission.CamTest.." --------")
-- RELEASE_LOGOFF  	luaLog("Cam X: "..cam.x)
-- RELEASE_LOGOFF  	luaLog("Cam Y: "..cam.y)
-- RELEASE_LOGOFF  	luaLog("Cam Z: "..cam.z)
-- RELEASE_LOGOFF  	luaLog("\n")

	if Mission.CamTest < 40 then
		luaDelay(luaCamTeszt, 0.3)
	end
end

function luaSoundFadeTestCB()
	MissionNarrativeClear()
	MissionNarrative("Sound fade done")
end
]]
--[[AutoDoc
usage: luaSquadronSupply(unittemplate, num, CB, filter, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1)
category: Mission
shortdesc:
desc:
]]
function luaSquadronSupply(unittemplate, num, CB, filter, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1)
-- RELEASE_LOGOFF  	luaLog("-- SquadronSupply: called")
	if Mission["SquadronSupply"..unittemplate.Name] == nil then
		Mission["SquadronSupply"..unittemplate.Name] = {}
	else
		Mission["SquadronSupply"..unittemplate.Name] = luaRemoveDeadsFromTable(Mission["SquadronSupply"..unittemplate.Name])
		if filter == "ammo" then
			Mission["SquadronSupply"..unittemplate.Name] = luaRemoveEmptyPlanes(Mission["SquadronSupply"..unittemplate.Name])
		end
	end

	if luaCountTable(Mission["SquadronSupply"..unittemplate.Name]) < num then
-- RELEASE_LOGOFF  		luaLog("-- SquadronSupply: spawning squad "..unittemplate.Name)

		local unit
		if spawnType == nil then
			unit = GenerateObject(unittemplate.Name)
		else
			--Assert(CB ~= nil, "***ERROR: luaSquadronSupply requires a callback function if spawning!"..debug.traceback())
			unit = luaSpawn(unittemplate.Name, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1)
			--luaSpawnDelayed({unittemplate}, spawnType, targetEntOrPos, minDist, maxDist, height, angle0, angle1, CB)
		end

		table.insert(Mission["SquadronSupply"..unittemplate.Name], unit)

		if CB then
			CB(unit)
		end
	else
-- RELEASE_LOGOFF  		luaLog("-- SquadronSupply: limit reached, spawning denied! +")
	end
end

--[[AutoDoc
usage: luaKillDelayed(unit, delaytime)
category: Mission
shortdesc: idozitetten megol egy egyseget
desc: kiterminalja a scenebol adott 'unit'-ot, 'delaytime' sec elteltevel
unit: table, a halalraitel egyseg this tablaja
delaytime: number, ennyi sec utan oli meg a fv az entitast
]]
function luaKillDelayed(unit, delaytime)
-- RELEASE_LOGOFF  	luaLog("-- luaKillDelayed: initiated")

	if Mission.MissionStatus ~= nil then
		return
	end

	luaDelay(luaKillDelayed_ext, delaytime, "unit", unit)
end

--[[AutoDoc
usage: luaKillDelayed_ext(timerthis)
category: Mission
shortdesc: a luaKillDelayed() idozito fv-e
desc: a luaKillDelayed() idozito fv-e amely tenylegesen vegrehajtja a Kill() fv hivast
timerthis: table, a luaKillDelayed() atadott valtozok osszesege
]]
function luaKillDelayed_ext(timerthis)
-- RELEASE_LOGOFF  	luaLog("-- luaKillDelayed: timer called")
	if not TrulyDead(timerthis.ParamTable.unit) then
-- RELEASE_LOGOFF  		luaLog(" -- luaKillDelayed: Kill allowed, Rambo-san: wipe them out!")
		Kill(timerthis.ParamTable.unit, true)
	end
end

--[[AutoDoc
usage: luaMedalCheck()
category: Mission
shortdesc:
desc:
]]
function luaMedalCheck()

-- RELEASE_LOGOFF  	Assert(type(Scoring) == "table", "***ERROR: luaMPMedalCheck() requires Scoring table!\n"..debug.traceback())

	local players = Multi_GetPlayers()

	local planeUsageMax = 0
	local shipUsageMax = 0
	local subUsageMax = 0

	local planeUsage = 0
	local shipUsage = 0
	local subUsage = 0

	local playerplaneID = 0
	local playersubID = 0
	local playershipID = 0

	local playerAAID = 0
	local playerARID = 0
	local playerTID = 0
	local playerPID = 0
	local playerID = 0

	local AAenemyhitsMax = 0
	local ArtilleryenemyhitsMax  = 0
	local TorpedoenemyhitsMax  = 0
	local WorstKillLossRatio = 0
	local KillLossRatio3 = 0
	local Ratio = 0

	local FirstKillLossRatio = false

	for player, pParty in pairs (players) do
-- RELEASE_LOGOFF  		luaLog("Checking player: "..player)
		Scoring_ForceRefreshScoringTable(player)	-- befrissitjuk a scoring tablat a playerre

		local score = scoring.action_score
		local shot = score.player_shots
		local loss = scoring.mission_score.losses

		local planeKills = 0
		local shipKills = 0
		local unitKills = 1
		local partyKill = 0
		local partyLoss = 0

		local AAenemyhits = 0
		local Artilleryenemyhits  = 0
		local Torpedoenemyhits  = 0


	-- Partykill es Partylosshoz kapcsolodo vizsgalatok

		if loss then
			if loss.OWN then
				for number, n in pairs (loss.OWN) do
-- RELEASE_LOGOFF  					luaLog("number of losses: " ..tostring(number))
					partyLoss = partyLoss + n
-- RELEASE_LOGOFF  					luaLog("Sum Party losses: " ..tostring(partyLoss))
				end
			end
			if loss.ENEMY then
				for number, k in pairs (loss.ENEMY) do
-- RELEASE_LOGOFF  					luaLog("number of losses: " ..tostring(number))
					partyKill = partyKill + k
-- RELEASE_LOGOFF  					luaLog("Sum Party kills: " ..tostring(partyLoss))
				end
			end
		end

	-- Talalati pontossagon alapulo medalok

		if shot then
-- RELEASE_LOGOFF  			luaLog("Shots: ")
			for unitType, t in pairs (shot) do
-- RELEASE_LOGOFF  				luaLog("UnitType: " ..tostring(unitType))

				-- Ha Cruiser-el lott a jatekos

				if unitType == "cruiser" then
					for weaponType, w in pairs (shot.cruiser) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott AA-val
						if weaponType == "AAMACHINEGUN" then
							for fshots, s in pairs (shot.cruiser.AAMACHINEGUN) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.cruiser.AAMACHINEGUN.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.cruiser.AAMACHINEGUN.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy planes: " ..tostring(unitType))
-- RELEASE_LOGOFF  												luaLog("value"..tostring(t))
												if unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "fighter" then
													AAenemyhits = AAenemyhits +t
-- RELEASE_LOGOFF  													luaLog("value"..tostring(t))
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy planes: " ..tostring(AAenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott HeavyArtillery-vel
						elseif weaponType == "HEAVYARTILLERY" then
							for fshots, s in pairs (shot.cruiser.HEAVYARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.cruiser.HEAVYARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.cruiser.HEAVYARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												 if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott MediumArtillery-vel
						elseif weaponType == "MEDIUMARTILLERY" then
							for fshots, s in pairs (shot.cruiser.MEDIUMARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.cruiser.MEDIUMARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.cruiser.MEDIUMARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott LightArtillery-vel
						elseif weaponType == "LIGHTARTILLERY" then
							for fshots, s in pairs (shot.cruiser.LIGHTARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.cruiser.LIGHTARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.cruiser.LIGHTARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott Torepedo-val
						elseif weaponType == "TORPEDO" then
							for fshots, s in pairs (shot.cruiser.TORPEDO) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.cruiser.TORPEDO.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.cruiser.TORPEDO.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "battleship" or unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Torpedoenemyhits = Torpedoenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Torpedoenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				-- Ha Destroyer-el lott a jatekos
				elseif unitType == "destroyer" then
					for weaponType, w in pairs (shot.destroyer) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott AA-val a jatekos
						if weaponType == "AAMACHINEGUN" then
							for fshots, s in pairs (shot.destroyer.AAMACHINEGUN) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.destroyer.AAMACHINEGUN.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.destroyer.AAMACHINEGUN.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy planes: " ..tostring(unitType))
												if unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "fighter" then
													AAenemyhits = AAenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy planes" ..tostring(AAenemyhits))
												end
											end
										end
									end
								end
							end
							-- Ha lott MediumArtillery-vel
						elseif weaponType == "MEDIUMARTILLERY" then
							for fshots, s in pairs (shot.destroyer.MEDIUMARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.destroyer.MEDIUMARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.destroyer.MEDIUMARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships" ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
							-- Ha lott LightArtillery-vel
						elseif weaponType == "LIGHTARTILLERY" then
							for fshots, s in pairs (shot.destroyer.LIGHTARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.destroyer.LIGHTARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.destroyer.LIGHTARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships" ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott Torepedo-val
						elseif weaponType == "TORPEDO" then
							for fshots, s in pairs (shot.destroyer.TORPEDO) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.destroyer.TORPEDO.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.destroyer.TORPEDO.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "battleship" or unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Torpedoenemyhits = Torpedoenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Torpedoenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				-- Ha Battleshipel lott  a jatekos
				elseif unitType == "battleship" then
					for weaponType, w in pairs (shot.battleship) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott AA-val
						if weaponType == "AAMACHINEGUN" then
							for fshots, s in pairs (shot.battleship.AAMACHINEGUN) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.battleship.AAMACHINEGUN.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.battleship.AAMACHINEGUN.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy planes: " ..tostring(unitType))
												if unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "fighter" then
													AAenemyhits = AAenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy planes: " ..tostring(AAenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott HeavyArtillery-vel
						elseif weaponType == "HEAVYARTILLERY" then
							for fshots, s in pairs (shot.battleship.HEAVYARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.battleship.HEAVYARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.battleship.HEAVYARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott MediumArtillery-vel
						elseif weaponType == "MEDIUMARTILLERY" then
							for fshots, s in pairs (shot.battleship.MEDIUMARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.battleship.MEDIUMARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.battleship.MEDIUMARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott LightArtillery-vel
						elseif weaponType == "LIGHTARTILLERY" then
							for fshots, s in pairs (shot.battleship.LIGHTARTILLERY) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.battleship.LIGHTARTILLERY.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.battleship.LIGHTARTILLERY.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Artilleryenemyhits = Artilleryenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Artilleryenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				-- Ha Torpedoboat-al lott  a jatekos
				elseif unitType == "torpedoboat" then
					for weaponType, w in pairs (shot.torpedoboat) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott AA-val
						if weaponType == "AAMACHINEGUN" then
							for fshots, s in pairs (shot.torpedoboat.AAMACHINEGUN) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.torpedoboat.AAMACHINEGUN.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.torpedoboat.AAMACHINEGUN.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy planes: " ..tostring(unitType))
												if unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "fighter" then
													AAenemyhits = AAenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy planes: " ..tostring(AAenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott Torepedo-val
						elseif weaponType == "TORPEDO" then
							for fshots, s in pairs (shot.torpedoboat.TORPEDO) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.torpedoboat.TORPEDO.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.torpedoboat.TORPEDO.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "battleship" or unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Torpedoenemyhits = Torpedoenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Torpedoenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				-- Ha Tengeralattjaroval-al lott  a jatekos
				elseif unitType == "submarine" then
					for weaponType, w in pairs (shot.submarine) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott AA-val
						if weaponType == "AAMACHINEGUN" then
							for fshots, s in pairs (shot.submarine.AAMACHINEGUN) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.submarine.AAMACHINEGUN.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.submarine.AAMACHINEGUN.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy planes: " ..tostring(unitType))
												if unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "fighter" then
													AAenemyhits = AAenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy planes: " ..tostring(AAenemyhits))
												end
											end
										end
									end
								end
							end
						-- Ha lott Torepedo-val
						elseif weaponType == "TORPEDO" then
							for fshots, s in pairs (shot.submarine.TORPEDO) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.submarine.TORPEDO.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.submarine.TORPEDO.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "battleship" or unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "cargo" then
													Torpedoenemyhits = Torpedoenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Torpedoenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				--reconplane
				elseif unitType == "reconplane" then
					for weaponType, w in pairs (shot.reconplane) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott Torepedo-val
						if weaponType == "TORPEDO" then
							for fshots, s in pairs (shot.reconplane.TORPEDO) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.reconplane.TORPEDO.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.reconplane.TORPEDO.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" 	 or unitType == "cargo" then
													Torpedoenemyhits = Torpedoenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Torpedoenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				-- torpedobomber
				elseif unitType == "torpedobomber" then
					for weaponType, w in pairs (shot.torpedobomber) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott Torepedo-val
						if weaponType == "TORPEDO" then
							for fshots, s in pairs (shot.torpedobomber.TORPEDO) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.torpedobomber.TORPEDO.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.torpedobomber.TORPEDO.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy ships: " ..tostring(unitType))
												if unitType == "battleship" or unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "cargo" then
													Torpedoenemyhits = Torpedoenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy ships: " ..tostring(Torpedoenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
					-- Ha Mothership-el lott  a jatekos
				elseif unitType == "mothership" then
					for weaponType, w in pairs (shot.mothership) do
-- RELEASE_LOGOFF  						luaLog("WeaponType: " ..tostring(weaponType))
-- RELEASE_LOGOFF  						luaLog("Player Shots: ")
						-- Ha lott AA-val
						if weaponType == "AAMACHINEGUN" then
							for fshots, s in pairs (shot.mothership.AAMACHINEGUN) do
-- RELEASE_LOGOFF  								luaLog("FiredShots: " ..tostring(fshots))
								if fshots == "hits" then
									for enemyhits, h in pairs (shot.mothership.AAMACHINEGUN.hits) do
-- RELEASE_LOGOFF  										luaLog("Hits on enemy units: " ..tostring(enemyhits))
										if enemyhits == "ENEMY" then
											for unitType, t in pairs (shot.mothership.AAMACHINEGUN.hits.ENEMY) do
-- RELEASE_LOGOFF  												luaLog("Hits on enemy planes: " ..tostring(unitType))
												if unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "fighter" then
													AAenemyhits = AAenemyhits +t
-- RELEASE_LOGOFF  													luaLog("Sum hits on enemy planes: " ..tostring(AAenemyhits))
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		if score.player_kills and score.player_kills.ENEMY then
			for unitType, n in pairs (score.player_kills.ENEMY) do
			-- osszes Killre
				if  unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" or unitType == "fighter" or unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "reconplane" then
						unitKills = unitKills + n
-- RELEASE_LOGOFF  						luaLog("Unitkills: "..tostring(unitKills))
				end
			end
		end

		if partyLoss > 0 then
			KillLossRatio3 = unitKills / partyLoss
-- RELEASE_LOGOFF  			luaLog("KillLossRatio3:" ..tostring(KillLossRatio3))
-- RELEASE_LOGOFF  			luaLog("unitKills:" ..tostring(unitKills))
-- RELEASE_LOGOFF  			luaLog("partyLoss:" ..tostring(partyLoss))
		else
			KillLossRatio3 = unitKills
-- RELEASE_LOGOFF  			luaLog("KillLossRatio3:" ..tostring(KillLossRatio3))
-- RELEASE_LOGOFF  			luaLog("unitKills:" ..tostring(unitKills))
-- RELEASE_LOGOFF  			luaLog("partyLoss:" ..tostring(partyLoss))
		end
		-- Ha magasabb ertek mint az elozo player osszesitett  maximuma akkor felulirja

		if AAenemyhitsMax < AAenemyhits then
			AAenemyhitsMax = AAenemyhits
-- RELEASE_LOGOFF  			luaLog("AA hit: "..tostring(AAenemyhits))
-- RELEASE_LOGOFF  			luaLog("New AA hit max: "..tostring(AAenemyhits))
			playerAAID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayerAAID: " ..tostring(playerAAID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end

		if ArtilleryenemyhitsMax < Artilleryenemyhits then
			ArtilleryenemyhitsMax = Artilleryenemyhits
-- RELEASE_LOGOFF  			luaLog("Artillery hit: "..tostring(Artilleryenemyhits))
-- RELEASE_LOGOFF  			luaLog("New Artillery hit max: "..tostring(Artilleryenemyhits))
			playerARID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayerARID: " ..tostring(playerARID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end

		if TorpedoenemyhitsMax < Torpedoenemyhits then
			TorpedoenemyhitsMax = Torpedoenemyhits
-- RELEASE_LOGOFF  			luaLog("Torpedo hit: "..tostring(Torpedoenemyhits))
-- RELEASE_LOGOFF  			luaLog("New Torpedo hit max: "..tostring(Torpedoenemyhits))
			playerTID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayerTID: " ..tostring(playerTID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end

		if not FirstKillLossRatio then
			FirstKillLossRatio = true
			WorstKillLossRatio = KillLossRatio3
-- RELEASE_LOGOFF  			luaLog("FirstKillLossRatio")
-- RELEASE_LOGOFF  			luaLog("value: "..tostring(WorstKillLossRatio))
			playerPID = player
-- RELEASE_LOGOFF  			luaLog("FirstPlayerPID: " ..tostring(playerPID))
-- RELEASE_LOGOFF  			luaLog("FirstPlayer: " ..tostring(player))
		end

		if KillLossRatio3 < WorstKillLossRatio then
			WorstKillLossRatio = KillLossRatio3
-- RELEASE_LOGOFF  			luaLog("WorstKillLossRation: "..tostring(WorstKillLossRatio))
-- RELEASE_LOGOFF  			luaLog("New WorstKillLossRation: "..tostring(KillLossRatio3))
			playerPID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayerPID: " ..tostring(playerPID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end

	-- Unit usage-n alapulo medalok

		-- Hajoban (osszes tipus) eltoltott time alapjan

		if score.unit_usage then
			shipUsage = 0
			subUsage = 0
			planeUsage = 0
-- RELEASE_LOGOFF  			luaLog("Unit_Usage: ")
			for unitType, u in pairs (score.unit_usage) do
-- RELEASE_LOGOFF  				luaLog("unitype:"..tostring(unitType))
-- RELEASE_LOGOFF  				luaLog("value"..tostring(u))
-- RELEASE_LOGOFF  				luaLog("Usage: "..unitType..", "..tostring(u))
				if unitType == "torpedoboat" or  unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "battleship" or unitType == "cargo" then
					shipUsage = shipUsage + u
-- RELEASE_LOGOFF  					luaLog("SumUsage: " ..tostring(shipUsage))
				end

				if unitType == "submarine"  then
-- RELEASE_LOGOFF  					luaLog("unitype:"..tostring(unitType))
-- RELEASE_LOGOFF  					luaLog("value"..tostring(u))
					subUsage = subUsage + u
-- RELEASE_LOGOFF  					luaLog("SumUsage: " ..tostring(subUsage))
				end

				if unitType == "fighter" or unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "reconplane" then
					planeUsage = planeUsage + u
-- RELEASE_LOGOFF  					luaLog("SumUsage: " ..tostring(planeUsage))
				end
			end
		end

--[[
		-- Ha magasabb mint az elozo akkor folulirja
		if shipUsageMax < shipUsage then
			shipUsageMax = shipUsage
-- RELEASE_LOGOFF  			luaLog("ShipUsage: " ..tostring(shipUsage))
-- RELEASE_LOGOFF  			luaLog("NewMaxUsage: " ..tostring(shipUsageMax))
			playershipID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayershipID: " ..tostring(playershipID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end
		if subUsageMax < subUsage then
			subUsageMax = subUsage
-- RELEASE_LOGOFF  			luaLog("subUsage: " ..tostring(subUsage))
-- RELEASE_LOGOFF  			luaLog("NewMaxUsage: " ..tostring(subUsageMax))
			playersubID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayersubID: " ..tostring(playersubID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end
		if planeUsageMax < planeUsage then
			planeUsageMax = planeUsage
-- RELEASE_LOGOFF  			luaLog("planeUsage: " ..tostring(planeUsage))
-- RELEASE_LOGOFF  			luaLog("NewMaxUsage: " ..tostring(planeUsageMax))
			playerplaneID = player
-- RELEASE_LOGOFF  			luaLog("NewPlayerplaneID: " ..tostring(playerplaneID))
-- RELEASE_LOGOFF  			luaLog("Player: " ..tostring(player))
		end
--]]
	-- Air 1
	--  Megnezni, mennyit pusztitott a jatekos repuloben ulve
	--  ha az elert egy bizonyos pontot, akkor adjuk a medalt


		if score.player_kills and score.player_kills.ENEMY then
			for unitType, v in pairs (score.player_kills.ENEMY) do
				-- ha repulotipus
				if unitType == "fighter" or unitType == "divebomber" or unitType == "torpedobomber" or unitType == "levelbomber" or unitType == "reconplane" then
					planeKills = planeKills + v
				end
			end
			if planeKills > Scoring.AirMedalLimit and planeUsage > Scoring.AirMedalPlaneUsageLimit then
				if scoring.playerIndex ~= nil then
					--Scoring_SetActionMedal(player, "AM")
				else
					Scoring_SetActionMedal("AM")
-- RELEASE_LOGOFF  					luaLog("Air medal")
				end
			end
		end

	-- Air 2
	--  Megnezni, mennyit pusztitott a jatekos repuloben ulve
	--  ha az elert egy bizonyos pontot (magasabb, mint az Air 1), akkor adjuk a medalt, Air 1-et pedig nem
		if planeKills > Scoring.DistinguishedFlyingCrossLimit and planeUsage > Scoring.DFCPlaneUsageLimit then
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "AM", false)
			else
				--Scoring_SetActionMedal("AM", false)
			end
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "DFC")
			else
				Scoring_SetActionMedal("DFC")
-- RELEASE_LOGOFF  				luaLog("D. Flying Cross")
			end
		end

	-- Naval 1
	-- Megnezni mennyit olt a jatekos hajoban ulve
	-- Ha elert egy bizonyos mennyiseget akkor kapja

		if score.player_kills and score.player_kills.ENEMY then
			for unitType, n in pairs (score.player_kills.ENEMY) do
			-- ha hajotipus
				if  unitType == "destroyer" or unitType == "cruiser"  or unitType == "mothership" or unitType == "submarine" or unitType == "battleship" or unitType == "cargo" then
					shipKills = shipKills + n
				end
			end
			if shipKills >= Scoring.NavyDistinguishedServiceMedalLimit and shipUsage > Scoring.NDSMShipUsageLimit then
				if scoring.playerIndex ~= nil then
					--Scoring_SetActionMedal(player, "DSM")
					--luaLog("Navy_Distinguished_Service_Medal")
				else
					Scoring_SetActionMedal("DSM")
-- RELEASE_LOGOFF  						luaLog("Navy_Distinguished_Service_Medal")
				end
			end
		end


	-- Naval 2
	-- Megnezni mennyit olt a jatekos hajoban ulve
	-- Ha elert egy bizonyos mennyiseget akkor kapja(magassabbat mint a Naval 1)

		if shipKills >= Scoring.NavyCrossLimit and shipUsage >= Scoring.NavyCrossShipUsageLimit then
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "DSM", false)
			else
				--Scoring_SetActionMedal("DSM", false)
			end
 			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "NC")
				--luaLog("Navy_Cross")
			else
				Scoring_SetActionMedal("NC")
-- RELEASE_LOGOFF  				luaLog("Navy_Cross")
			end
		end

		-- Global 1
		-- Ha elert egy bizonyos mennyiseget hajot es repulot Killezve akkor kapja

		if planeKills >= Scoring.SilverStarplaneLimit and shipKills >= Scoring.SilverStarshipLimit then
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "DSM", false)
				--Scoring_SetActionMedal(player, "AM", false)
			else
				--Scoring_SetActionMedal("DSM", false)
				--Scoring_SetActionMedal("AM", false)
			end
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "SS")
-- RELEASE_LOGOFF  					luaLog("Silver_Star")
			else
				--Scoring_SetActionMedal("SS")
-- RELEASE_LOGOFF  					luaLog("Silver_Star")
			end
		end

		-- Global 2
		-- Ha elert egy bizonyos mennyiseget hajot es repulot Killezve akkor kapja(tobbet mint)

		if planeKills >= Scoring.DistinguishedServiceCrossPlaneLimit and shipKills >= Scoring.DistinguishedServiceCrossShipLimit then
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "DFC", false)
				--Scoring_SetActionMedal(player, "NC", false)
			else
				--Scoring_SetActionMedal("DFC", false)
				--Scoring_SetActionMedal("NC", false)
			end
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "SS", false)
			else
				--Scoring_SetActionMedal("SS", false)
			end
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "DSC")
-- RELEASE_LOGOFF  				luaLog("Distinguished_Service_Cross")
			else
				--Scoring_SetActionMedal("DFC")
				--luaLog("Distinguished_Service_Cross")
			end
		end

		-- Group 1
		-- Ha elert 1 bizonyos (Kill/loss) aranyt a csapat akkor mindenki megkapja

		if partyKill / partyLoss > Scoring.KillLossRatio1 then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "BS")
-- RELEASE_LOGOFF  				luaLog("Bronze Star")
			else
				--Scoring_SetActionMedal("BS")
			end
		end

		-- Group 2
		-- Ha elert 1 bizonyos (Kill/loss) aranyt a csapat akkor mindenki megkapja

		if partyKill / partyLoss > Scoring.KillLossRatio2 then
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(playerID, "BS", false)
			else
				--Scoring_SetActionMedal("BS", false)
			end
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "LoM")
-- RELEASE_LOGOFF  				luaLog("Legion of Merit")
			else
				--Scoring_SetActionMedal("LoM")
			end
		end

			-- MoH
		-- Ha mindent elert akkor kapja


		if Torpedoenemyhits >= Scoring.THitLimit and Artilleryenemyhits >= Scoring.ARHitLimit and AAenemyhits >= Scoring.AAHitLimit and subUsage >= Scoring.SubmarineUsageLimit and shipUsage >= Scoring.ShipUsageLimit and planeUsage >= Scoring.PlaneUsageLimit then
			if scoring.playerIndex ~= nil then
				--Scoring_SetActionMedal(player, "DFC", false)
				--Scoring_SetActionMedal(player, "NC", false)
				--Scoring_SetActionMedal(player, "Lom", false)
			else
				--Scoring_SetActionMedal("DFC", false)
				--Scoring_SetActionMedal("NC", false)
				--Scoring_SetActionMedal("LoM", false)
			end
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "MoH")
-- RELEASE_LOGOFF  				luaLog("Medal of Honor")
			else
				--Scoring_SetActionMedal("MoH")
			end
		end

-- RELEASE_LOGOFF  		luaLog("ShipUsage: " ..tostring(shipUsage))
-- RELEASE_LOGOFF  		luaLog("ShipUsageLimit: " ..tostring(Scoring.ShipUsageLimit))
-- RELEASE_LOGOFF  		luaLog("playerID: "..tostring(playerID))

		if shipUsage >= Scoring.ShipUsageLimit and shipUsage > subUsage and shipUsage > planeUsage then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "SUSM")
-- RELEASE_LOGOFF  				luaLog("Sea Unit Service Medal")
			else
				Scoring_SetActionMedal("SUSM")
-- RELEASE_LOGOFF  				luaLog("Sea Unit Service Medal")
			end
		end

				-- Submarine hasznalat alapjan

-- RELEASE_LOGOFF  		luaLog("SubUsage: " ..tostring(subUsage))
-- RELEASE_LOGOFF  		luaLog("SubmarineUsageLimit: " ..tostring(Scoring.SubmarineUsageLimit))
-- RELEASE_LOGOFF  		luaLog("playerID: "..tostring(playersID))

		if subUsage >= Scoring.SubmarineUsageLimit and subUsage > shipUsage and subUsage > planeUsage then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "SSM")
-- RELEASE_LOGOFF  					luaLog("Submarine Service Medal")
			else
				Scoring_SetActionMedal("SSM")
-- RELEASE_LOGOFF  					luaLog("Submarine Service Medal")
			end
		end

				-- Plane hasznalat alapjan

-- RELEASE_LOGOFF  		luaLog("PlaneUsage: " ..tostring(PlaneUsage))
-- RELEASE_LOGOFF  		luaLog("PlaneUsageLimit: " ..tostring(Scoring.PlaneUsageLimit))
-- RELEASE_LOGOFF  		luaLog("playerID: "..tostring(playerpID))

		if planeUsage >= Scoring.PlaneUsageLimit and planeUsage > shipUsage and planeUsage > subUsage then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(player, "AUSM")
-- RELEASE_LOGOFF  				luaLog("Air Unit Service Medal")
			else
				Scoring_SetActionMedal("AUSM")
-- RELEASE_LOGOFF  				luaLog("Air Unit Service Medal")
			end
		end
	end

	-- Medal osztas player indexre (adott player aki a legtobbet ulte az adott unitban vagy adott fegyverrel a legtobb talalatot vitte be)
	-- Hit Fegyvertipus alapjan

-- RELEASE_LOGOFF  		luaLog("AAMaxhit: " ..tostring(AAenemyhitsMax))
-- RELEASE_LOGOFF  		luaLog("AAhitLimit: " ..tostring(Scoring.AAHitLimit))
-- RELEASE_LOGOFF  		luaLog("playerID: "..tostring(playerAAID))

				--Air to Air gun

		if AAenemyhitsMax >= Scoring.AAHitLimit then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(playerAAID, "AAMS")
-- RELEASE_LOGOFF  				luaLog("AA Marksmanship")
			else
				Scoring_SetActionMedal("AAMS")
-- RELEASE_LOGOFF  				luaLog("AA Marksmanship")
			end
		end

-- RELEASE_LOGOFF  		luaLog("ArtilleryMaxhit: " ..tostring(ArtilleryenemyhitsMax))
-- RELEASE_LOGOFF  		luaLog("ArtilleryHitLimit: " ..tostring(Scoring.ARHitLimit))
-- RELEASE_LOGOFF  		luaLog("playerID: "..tostring(playerARID))

				-- Artillery(light, medium, heavy egyben)

		if ArtilleryenemyhitsMax >= Scoring.ARHitLimit then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(playerARID, "AMS")
-- RELEASE_LOGOFF  				luaLog("Artillery Marksmanship")
			else
				Scoring_SetActionMedal("AMS")
-- RELEASE_LOGOFF  				luaLog("Artillery Marksmanship")
			end
		end

-- RELEASE_LOGOFF  		luaLog("TorpedohitsMax: " ..tostring(TorpedoenemyhitsMax))
-- RELEASE_LOGOFF  		luaLog("THITLimit: " ..tostring(Scoring.THitLimit))
-- RELEASE_LOGOFF  		luaLog("playerID: "..tostring(playerTID))

		if TorpedoenemyhitsMax >=  Scoring.THitLimit then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(playerTID, "TMS")
-- RELEASE_LOGOFF  				luaLog("Torpedo Marksmanship")
			else
				Scoring_SetActionMedal("TMS")
-- RELEASE_LOGOFF  				luaLog("Torpedo Marksmanship")
			end
		end

		-- Ph
		-- A legnagyobb veszteseget elszenvedo jatekos kapja meg (legrosszabb egyeniKill/partyloss arany)

		if WorstKillLossRatio > 0 then
			if scoring.playerIndex ~= nil then
				Scoring_SetActionMedal(playerPID, "PH")
-- RELEASE_LOGOFF  				luaLog("Purple Heart")
-- RELEASE_LOGOFF  				luaLog("Player ID: " ..tostring(playerPID))
			else
				--Scoring_SetActionMedal("PH")
			end
		end

		-- Osszesitett maximum ertek es az ehhez kapcsolodo player index  kiiratas

-- RELEASE_LOGOFF  		luaLog("Player indexre vonatkozo adatok: ")

-- RELEASE_LOGOFF  		luaLog("Legtobb AA fegyverrel bevitt ertekelheto talalat: "..tostring(AAenemyhitsMax))
-- RELEASE_LOGOFF  		luaLog("Player: "..tostring(playerAAID))

-- RELEASE_LOGOFF  		luaLog("Legtobb tuzerseggel bevitt ertekelheto talalat: "..tostring(ArtilleryenemyhitsMax))
-- RELEASE_LOGOFF  		luaLog("Player: "..tostring(playerARID))

-- RELEASE_LOGOFF  		luaLog("Legtobb torpedoval bevitt talalat: "..tostring(TorpedoenemyhitsMax))
-- RELEASE_LOGOFF  		luaLog("Player: "..tostring(playerTID))

end

--[[AutoDoc
usage: luaAutomaticReloader(unit)
category: Mission
shortdesc: visszatolti az ammot
desc: adott 'unit'-on visszatolti a bombakat, torpedokat
unit: table, az entitas this tablaja
]]
function luaAutomaticReloader(unit)
	luaDelay(luaAutomaticReloaderDelayed, 1.1, "unit", unit)
end

--[[AutoDoc
usage: luaAutomaticReloaderDelayed(timerthis)
category: Mission
shortdesc: luaAutomaticReloader() idozito fv-e
desc: luaAutomaticReloader() idozito fv-e, mely beallitja a unitre a reloadert
timerthis: table, luaAutomaticReloader() altal atadott valtozok osszessege
]]
function luaAutomaticReloaderDelayed(timerthis)
	local unit = timerthis.ParamTable.unit
	if not unit.Dead then
		if luaGetType(unit) == "plane" then
			PlaneReloadBombPlatforms(unit)
-- RELEASE_LOGOFF  			luaLog("CHEAT: Ammo reloaded on "..unit.Name)
			AddSquadOrdnanceDroppedTrigger(unit, "Reloader_"..tostring(unit), "luaAutomaticReloader")
		else
-- RELEASE_LOGOFF  			luaLog("CHEAT: Torpedo reloaded on "..unit.Name)
			ShipSetTorpedoStock(unit, 20)
			ReloadTorpedoes(unit)
			luaAutomaticReloader(unit)
		end
	end
end

--[[AutoDoc
usage: luaShipyardManagerInit(shipyardtable [,reloaddist])
category: Mission
shortdesc: shipyardmanager inicializalo fv-e
desc: shipyard manager (torpedo feltoltes) valtozoit allitja be, es letrhoz egy uj script entitast neki
shipyardtable: table, lista a shipyardok this tablaival
reloaddist: number, ilyen messzirol kezdi el a feltoltest, default 350 m
]]
function luaShipyardManagerInit(shipyardtable, reloaddist)
-- RELEASE_LOGOFF  	Assert(type(shipyardtable) == "table", "Error: shipyardtable must be table not "..tostring(type(shipyardtable)))
	Mission.SManager = CreateScript("luaShipyardManager",shipyardtable, reloaddist)
end

--[[AutoDoc
usage: luaShipyardManager(this, shipyardtable [,reloaddist])
category: Mission
shortdesc: shipyardmanager inittime fv-e
desc: shipyard manager (torpedo feltoltes) inittime fv-e, beallitja a thinkja
this: luaShipyardManagerInit() altal letrehozott script entity this tablaja
shipyardtable: table, lista a shipyardok this tablaival
reloaddist: number, ilyen messzirol kezdi el a feltoltest, default 350 m
]]
function luaShipyardManager(this, shipyardtable, reloaddist)
	SETLOG(this, true)
	this.Logfile = "SMlog.txt"
-- RELEASE_LOGOFF  	luaDoCustomLog(this.Logfile,"","u")
-- RELEASE_LOGOFF  	luaDoCustomLog(this.Logfile,"Initiating luaShipyardManager")

	if reloaddist == nil then
		this.ReloadDistance = 350
	else
		this.ReloadDistance = reloaddist
	end

	this.Shipyards = shipyardtable
	--this.ReconPlanes = {}
	this.PtBoats = {}

	--log
	--luaDoCustomLog(this.Logfile,"Shipyards")
	--luaDoCustomLog(this.Logfile,this.Shipyards)

	SetThink(this, "luaShipyardManager_think")
end

--[[AutoDoc
usage: luaShipyardManagerGetUnits(this)
category: Mission
shortdesc: shipyardmanager seged fv-e
desc: shipyard manager (torpedo feltoltes) altal hasznalhato unitokat gyujti tablakba
this: luaShipyardManagerInit() altal letrehozott script entity this tablaja
]]
function luaShipyardManagerGetUnits(this)

	--log
	--luaDoCustomLog(this.Logfile,"recon")
	--luaDoCustomLog(this.Logfile,recon[Mission.Party])

-- RELEASE_LOGOFF  	luaDoCustomLog(this.Logfile,"Party")
-- RELEASE_LOGOFF  	luaDoCustomLog(this.Logfile,Mission.Party)

	--luaDoCustomLog(this.Logfile,"reconplane")
	--luaDoCustomLog(this.Logfile,recon[Mission.Party].own.reconplane)

-- RELEASE_LOGOFF  	luaDoCustomLog(this.Logfile,"torpedoboat")
-- RELEASE_LOGOFF  	luaDoCustomLog(this.Logfile,recon[Mission.Party].own.torpedoboat)

	--reconplanes
--[[
	for i = 0, 1 do
		for idx,unit in pairs(recon[i].own.reconplane) do
			if not unit.Dead and not luaIsInside(unit, this.ReconPlanes) then
				table.insert(this.ReconPlanes, unit)
-- RELEASE_LOGOFF  				luaDoCustomLog(this.Logfile,"Found unit "..unit.Name)
			end
		end
	end

	this.ReconPlanes = luaRemoveDeadsFromTable(this.ReconPlanes)
--]]
	--ptboats
	for i = 0, 1 do
		for idx,unit in pairs(recon[i].own.torpedoboat) do
			if not unit.Dead and not luaIsInside(unit, this.PtBoats) then
				table.insert(this.PtBoats, unit)
-- RELEASE_LOGOFF  				luaDoCustomLog(this.Logfile,"Found unit "..unit.Name)
			end
		end
	end

	this.PtBoats = luaRemoveDeadsFromTable(this.PtBoats)
end

--[[AutoDoc
usage: luaShipyardManager_think(this, msg)
category: Mission
shortdesc: shipyardmanager vezerlo fv-e
desc: shipyard manager (torpedo feltoltes) vezerlo fv-e, mely vegrehajtja a szukseges vizsgalatokat es feltolti a torpedostockot, avagy terminalja onmagat valid shipyard hianyaban
this: luaShipyardManagerInit() altal letrehozott script entity this tablaja
msg: string, a script entitynek atadott message
]]
function luaShipyardManager_think(this, msg)
	if luaMessageHandler(this, msg) == "killed" then
-- RELEASE_LOGOFF  		luaDoCustomLog(this.Logfile,"luaShipyardManager_think killed")
		return
	end

	--log
	--luaDoCustomLog(this.Logfile,"Shipyards")
	--luaDoCustomLog(this.Logfile,this.Shipyards)

	--check
	--luaDoCustomLog(this.Logfile,"Checking for dead shipyards")
	this.Shipyards = luaRemoveDeadsFromTable(this.Shipyards)
	if not next(this.Shipyards) then
-- RELEASE_LOGOFF  		luaDoCustomLog(this.Logfile,"No more shipyards, quitting")
		DeleteScript(Mission.SManager)
		return
	end

	--fill up tables
	luaShipyardManagerGetUnits(this)

	--log
	--luaDoCustomLog(this.Logfile,"Ptboats")
	--luaDoCustomLog(this.Logfile,this.PtBoats)
	--luaDoCustomLog(this.Logfile,"ReconPlanes")
	--luaDoCustomLog(this.Logfile,this.ReconPlanes)

	for idx,shipyard in pairs(this.Shipyards) do
--[[
		--checking torpedoload for recons
		for ridx,reconplane in pairs(this.ReconPlanes) do
			if not reconplane.Dead and shipyard.Party == reconplane.Party then
				reconplane.ammo = GetProperty(reconplane, "ammoType")
				if reconplane.ammo == 0 then
-- RELEASE_LOGOFF  					luaDoCustomLog(this.Logfile,reconplane.Name.." has no ammo")
					if luaGetDistance(shipyard,reconplane) <= this.ReloadDistance then
-- RELEASE_LOGOFF  						luaDoCustomLog(this.Logfile,reconplane.Name.." is in reloadrange")
						if GetPosition(reconplane).y < 10 and GetEntitySpeed(reconplane) < 35 then
							PlaneReloadBombPlatforms(reconplane)
-- RELEASE_LOGOFF  							luaDoCustomLog(this.Logfile,reconplane.Name.." is reloaded")
						end --position and speed
					end --distance
				end --ammo
			end -- Dead
		end --reconplanes
--]]
		--checking torpedoload for pts
		for ridx,ptboat in pairs(this.PtBoats) do
			if not ptboat.Dead and shipyard.Party == ptboat.Party then
				ptboat.TorpedoStock = GetProperty(ptboat, "TorpedoStock")
				if ptboat.TorpedoStock < ptboat.Class.MaxTorpedoStock then
-- RELEASE_LOGOFF  					luaDoCustomLog(this.Logfile,ptboat.Name.." has fewer torps than maximum, checking for reload conditions")
					if luaGetDistance(shipyard,ptboat) <= this.ReloadDistance then
-- RELEASE_LOGOFF  						luaDoCustomLog(this.Logfile,ptboat.Name.." is in reloadrange")
						if GetEntitySpeed(ptboat) < 3 then
							ShipSetTorpedoStock(ptboat, ptboat.Class.MaxTorpedoStock)
-- RELEASE_LOGOFF  							luaDoCustomLog(this.Logfile,ptboat.Name.." is reloaded")
						end--position and speed
					end --distance
				end --torpedostock
			end -- Dead
		end --ptboats

	end -- shipyards
end

--[[AutoDoc
usage: luaPlayerAirbaseInit(airbases)
category: Mission
shortdesc:
desc:
airbases:
]]
function luaPlayerAirbaseInit(airbases)
	local playerAirbasePlanePreferences = {
		[PARTY_ALLIED] = {
			["Fighter"] = {
				[1] = {
					["ClassID"] = 111, --lightning
					["EquipmentID"] = 0,
				},
				[2] = {
					["ClassID"] = 101, --wildcat
					["EquipmentID"] = 0,
				},
				[3] = {
					["ClassID"] = 135, --warhawk
					["EquipmentID"] = 0,
				},
				[4] = {
					["ClassID"] = 134, --hurricane
					["EquipmentID"] = 0,
				},
				[5] = {
					["ClassID"] = 133, --buffalo
					["EquipmentID"] = 0,
				},
				[6] = {
					["ClassID"] = 108, --dauntless
					["EquipmentID"] = 0,
				},
				[7] = {
					["ClassID"] = 113, --avanger
					["EquipmentID"] = 0,
				},
				[8] = {
					["ClassID"] = 112, --devastator
					["EquipmentID"] = 0,
				},
				[9] = {
					["ClassID"] = 109, --swordfish
					["EquipmentID"] = 0,
				},
			},
			["LevelBomber"] = {
				[1] = {
					["ClassID"] = 116, --flying fortress
					["EquipmentID"] = 1,
				},
				[2] = {
					["ClassID"] = 118, --mitchell
					["EquipmentID"] = 1,
				},
			},
			["DiveBomber"] = {
				[1] = {
					["ClassID"] = 108, --dauntless
					["EquipmentID"] = 1,
				},
				[2] = {
					["ClassID"] = 113, --avanger
					["EquipmentID"] = 2,
				},
				[3] = {
					["ClassID"] = 133, --buffalo
					["EquipmentID"] = 1,
				},
				[4] = {
					["ClassID"] = 134, --hurricane
					["EquipmentID"] = 1,
				},
				[5] = {
					["ClassID"] = 135, --warhawk
					["EquipmentID"] = 1,
				},
				[6] = {
					["ClassID"] = 101, --wildcat
					["EquipmentID"] = 1,
				},
				[7] = {
					["ClassID"] = 109, --swordfish
					["EquipmentID"] = 2,
				},
			},
			["TorpedoBomber"] = {
				[1] = {
					["ClassID"] = 113, --avanger
					["EquipmentID"] = 1,
				},
				[2] = {
					["ClassID"] = 112, --devastator
					["EquipmentID"] = 1,
				},
			},
			["DC"] = {
				[1] = {
					["ClassID"] = 108, --dauntless
					["EquipmentID"] = 2,
				},
				[2] = {
					["ClassID"] = 113, --avanger
					["EquipmentID"] = 3,
				},
				[3] = {
					["ClassID"] = 109, --swordfish
					["EquipmentID"] = 3,
				},
			},
		},
		[PARTY_JAPANESE] = {
			["Fighter"] = {
				[1] = {
					["ClassID"] = 155, --gekko
					["EquipmentID"] = 0,
				},
				[2] = {
					["ClassID"] = 150, --zero
					["EquipmentID"] = 0,
				},
				[3] = {
					["ClassID"] = 154, --oscar
					["EquipmentID"] = 0,
				},
				[4] = {
					["ClassID"] = 159, --judy
					["EquipmentID"] = 0,
				},
				[5] = {
					["ClassID"] = 162, --kate
					["EquipmentID"] = 0,
				},
				[6] = {
					["ClassID"] = 158, --val
					["EquipmentID"] = 0,
				},
			},
			["LevelBomber"] = {
				[1] = {
					["ClassID"] = 167, --betty
					["EquipmentID"] = 1,
				},
				[2] = {
					["ClassID"] = 166, --nell
					["EquipmentID"] = 1,
				},
			},
			["DiveBomber"] = {
				[1] = {
					["ClassID"] = 158, --val
					["EquipmentID"] = 1,
				},
				[2] = {
					["ClassID"] = 159, --judy
					["EquipmentID"] = 1,
				},
				[3] = {
					["ClassID"] = 154, --oscar
					["EquipmentID"] = 1,
				},
				[4] = {
					["ClassID"] = 150, --zero
					["EquipmentID"] = 1,
				},
			},
			["TorpedoBomber"] = {
				[1] = {
					["ClassID"] = 162, --kate
					["EquipmentID"] = 1,
				},
				[2] = {
					["ClassID"] = 167, --betty
					["EquipmentID"] = 2,
				},
				[3] = {
					["ClassID"] = 166, --nell
					["EquipmentID"] = 2,
				},
			},
			["DC"] = {
				[1] = {
					["ClassID"] = 159, --judy
					["EquipmentID"] = 2,
				},
			},
		},
	}

	Mission.PlayerAirbaseTacticalPreferences = { --TorpedoBomber, DiveBomber, LevelBomber
		["MotherShip"] = { 30, 30, 50, },
		["BattleShip"] = { 50, 20, 1, },
		["Cruiser"] = { 40, 60, 20, },
		["Cargo"] = { 20, 50, 20, },
		["Destroyer"] = { 10, 70, 30, },
		["LandFort"] = { 0, 30, 100, },
		["Shipyard"] = { 0, 30, 100, },
		["AirField"] = { 0, 30, 100, },
	}

	--Az airbasekbe bele tolti a felkuldheto repuloket prioritas sorrendjeben
	airbases = luaRemoveDeadsFromTable(airbases)
-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable(airbases, true), "***ERROR: luaPlayerAirbaseInit needs an airfield/carrier table as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaLog("luaPlayerAirbaseInit Called!")
	for i, airbase in pairs (airbases) do
		local stock = {}
		airbase.planes = GetProperty(airbase, "planes")
		for key, value in pairs(airbase.planes) do
			if stock[value.classid] == nil then
				stock[value.classid] = value.count
			else
				stock[value.classid] = stock[value.classid] + value.count
			end
		end
		for partyID, partyPlanePreferences in pairs (playerAirbasePlanePreferences) do
			if partyID == airbase.Party then
				airbase.PlayerAirbasePlanePreferences = {}
				for attackMode, planePreferences in pairs (partyPlanePreferences) do
					for k, planeTemplate in pairs (planePreferences) do
						if stock[planeTemplate.ClassID] ~= nil then
							if not airbase.PlayerAirbasePlanePreferences[tostring(attackMode)] then
								airbase.PlayerAirbasePlanePreferences[tostring(attackMode)] = {}
							end
							table.insert(airbase.PlayerAirbasePlanePreferences[tostring(attackMode)], planeTemplate)
						end
					end
				end
			end
		end
-- RELEASE_LOGOFF  		luaLog(airbase.Name.." preference table:")
-- RELEASE_LOGOFF  		luaLog(airbase.PlayerAirbasePlanePreferences)
	end
-- RELEASE_LOGOFF  	luaLog("luaPlayerAirbaseInit Finished!")
end

--[[AutoDoc
usage: luaPlayerAirbaseManager(airbases)
category: Mission
shortdesc:
desc:
airbases:
]]
function luaPlayerAirbaseManager(airbases)
	airbases = luaRemoveDeadsFromTable(airbases)
-- RELEASE_LOGOFF  	Assert(luaIsAirfieldTable(airbases, true), "***ERROR: luaPlayerAirbaseManager needs an airfield/carrier table as first param!"..debug.traceback())
-- RELEASE_LOGOFF  	luaLog("luaPlayerAirbaseManager Called!")
	for i, airbase in pairs (airbases) do
-- RELEASE_LOGOFF  		luaLog("========================================")
-- RELEASE_LOGOFF  		luaLog("Airbase: "..airbase.Name)
		airbase.planes = GetProperty(airbase, "planes")
		airbase.slots = GetProperty(airbase, "slots")
		local airbaseMan, airstrikeMode, maxCapNum = GetAirbaseOrders(airbase)
		if airbaseMan then
			if not airbase.PlayerAirbasePreviousDCNum then
				airbase.PlayerAirbasePreviousDCNum = 0
			end
			if not airbase.PlayerAirbasePreviousDCNum2 then
				airbase.PlayerAirbasePreviousDCNum2 = 0
			end

			local maxPlanes = GetAirBasePlaneLimit(airbase)
			local maxSlots = 0

			local activePlanes = 0
			local activeSlots = 0
			local activeCapNum = 0
			local activeLevelBombNum = 0
			local activeBombNum = 0
			local activeTorpedoNum = 0
			local activeDCNum = 0
			local activePlayerNum = 0

			local freeSlotTable = {}

			local planeEntTable = {}
			local pendingPlaneEntTable = {}

			local capTable = {}
			local capInLandTable = {}
			local attackersTable = {}
			local attackersInLandTable = {}

			local landingInProgress = false

			local groupDistance = 4000

-- RELEASE_LOGOFF  			luaLog("Checking status...")
			for idx, slotNum in pairs(airbase.slots) do
				if slotNum.squadron ~= nil then
					activePlanes = activePlanes + slotNum.count
					activeSlots = activeSlots + 1

					local planeEnt = thisTable[tostring(slotNum.squadron)]
					planeEnt.ammo = GetProperty(planeEnt, "ammoType")
					local tempTable = {}
					tempTable.Count = slotNum.count
					tempTable.Ent = planeEnt
					tempTable.Target = GetPrimaryTarget(planeEnt)
					tempTable.SlotNum = idx

					if planeEnt.PlayerAirbaseCap then
						if slotNum.state == 4 then
							if not GetSquadronLanded(planeEnt) then
								table.insert(capInLandTable, tempTable)
							end
						else
							activeCapNum = activeCapNum + 1
							table.insert(capTable, tempTable)
						end
					elseif planeEnt.PlayerAirbaseAttacker then
						if slotNum.state == 4 then
							if not GetSquadronLanded(planeEnt) then
								table.insert(attackersInLandTable, tempTable)
							else
								landingInProgress = true
							end
						else
							table.insert(attackersTable, tempTable)
						end
						if planeEnt.ammo == AMMO_BOMB and planeEnt.Class.Type == "LevelBomber" then
							activeLevelBombNum = activeLevelBombNum + 1
						elseif planeEnt.ammo == AMMO_BOMB then
							activeBombNum = activeBombNum + 1
						elseif planeEnt.ammo == AMMO_TORPEDO then
							activeTorpedoNum = activeTorpedoNum + 1
						elseif planeEnt.ammo == AMMO_DEPTHCHARGE then
							activeDCNum = activeDCNum + 1
						end
					else
						activePlayerNum = activePlayerNum + 1
						if planeEnt.ammo == AMMO_BOMB and planeEnt.Class.Type == "LevelBomber" then
							activeLevelBombNum = activeLevelBombNum + 1
						elseif planeEnt.ammo == AMMO_BOMB then
							activeBombNum = activeBombNum + 1
						elseif planeEnt.ammo == AMMO_TORPEDO then
							activeTorpedoNum = activeTorpedoNum + 1
						elseif planeEnt.ammo == AMMO_DEPTHCHARGE then
							activeDCNum = activeDCNum + 1
						end
					end
					table.insert(planeEntTable, planeEnt)
				elseif slotNum.state == 1 or slotNum.state == 5 then
					--[[
					PLANES_ASSIGNED = 1, // semmi
					PLANES_READY    = 2, // minnya indulnak
					PLANES_SENT     = 3, // el vannak kuldve
					PLANES_RETURN   = 4, // mindenki mennyen haza
					PLANES_KILLED   = 5, // ua mint assigned, csak ez meghalas utan van
					PLANES_FAKEAIR  = 6  // magikus nem valtoztathato dolog, levegoben levo repulokre vonatkozik
					]]
					table.insert(freeSlotTable, idx)
				end
				maxSlots = idx
			end

			local stock = {}
			for key, value in pairs(airbase.planes) do
				if stock[value.classid] == nil then
					stock[value.classid] = value.count
				else
					stock[value.classid] = stock[value.classid] + value.count
				end
			end
			airbase.PlayerAirbaseOutOfFighters = true
			for classID, number in pairs (stock) do
				if VehicleClass[classID].Type == "Fighter" then
					airbase.PlayerAirbaseOutOfFighters = nil
					break
				end
			end

-- RELEASE_LOGOFF  			luaLog("----------------------------------------")
-- RELEASE_LOGOFF  			luaLog("stock:")
-- RELEASE_LOGOFF  			luaLog(stock)
-- RELEASE_LOGOFF  			luaLog("airbase.PlayerAirbaseOutOfFighters: "..tostring(airbase.PlayerAirbaseOutOfFighters))

			local _, nextFreeSlot = next(freeSlotTable)
			local freePlanes = maxPlanes - activePlanes

-- RELEASE_LOGOFF  			luaLog("----------------------------------------")
-- RELEASE_LOGOFF  			luaLog("airstrikeMode: "..tostring(airstrikeMode))
-- RELEASE_LOGOFF  			luaLog("maxPlanes: "..tostring(maxPlanes))
-- RELEASE_LOGOFF  			luaLog("activePlanes: "..tostring(activePlanes))
-- RELEASE_LOGOFF  			luaLog("freePlanes: "..tostring(freePlanes))
-- RELEASE_LOGOFF  			luaLog("maxSlots: "..tostring(maxSlots))
-- RELEASE_LOGOFF  			luaLog("activeSlots: "..tostring(activeSlots))
-- RELEASE_LOGOFF  			luaLog("freeSlotTable:")
-- RELEASE_LOGOFF  			luaLog(freeSlotTable)
-- RELEASE_LOGOFF  			luaLog("nextFreeSlot: "..tostring(nextFreeSlot))
-- RELEASE_LOGOFF  			luaLog("maxCapNum: "..tostring(maxCapNum))
-- RELEASE_LOGOFF  			luaLog("activeCapNum: "..tostring(activeCapNum))
-- RELEASE_LOGOFF  			luaLog("activeBombNum: "..tostring(activeBombNum))
-- RELEASE_LOGOFF  			luaLog("activeLevelBombNum: "..tostring(activeLevelBombNum))
-- RELEASE_LOGOFF  			luaLog("activeTorpedoNum: "..tostring(activeTorpedoNum))
-- RELEASE_LOGOFF  			luaLog("activeDCNum: "..tostring(activeDCNum))
-- RELEASE_LOGOFF  			luaLog("activePlayerNum: "..tostring(activePlayerNum))

			local airbaseTarget = UnitGetAttackTarget(airbase)
			if airbaseTarget then
				if airbaseTarget.Dead then
					airbaseTarget = nil
				end
			end

-- RELEASE_LOGOFF  			luaLog("----------------------------------------")
			if airbase.PlayerAirbasePreviousTarget then
-- RELEASE_LOGOFF  				luaLog("airbase.PlayerAirbasePreviousTarget: "..tostring(airbase.PlayerAirbasePreviousTarget.Name))
			else
-- RELEASE_LOGOFF  				luaLog("airbase.PlayerAirbasePreviousTarget: "..tostring(airbase.PlayerAirbasePreviousTarget))
			end
			if airbaseTarget then
-- RELEASE_LOGOFF  				luaLog("airbaseTarget: "..tostring(airbaseTarget.Name))
-- RELEASE_LOGOFF  				luaLog("airbaseTarget.Class.Type: "..airbaseTarget.Class.Type)
-- RELEASE_LOGOFF  				luaLog("luaGetType(airbaseTarget): "..tostring(luaGetType(airbaseTarget)))
			else
-- RELEASE_LOGOFF  				luaLog("airbaseTarget:"..tostring(airbaseTarget))
			end

			if activeCapNum < maxCapNum and table.getn(capInLandTable) ~= 0 then
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering capInLand - > cap")
				local sortedCapInLandTable = {}
				for index, slot in pairs (capInLandTable) do
					if table.getn(sortedCapInLandTable) == 0 then
						table.insert(sortedCapInLandTable, slot)
					else
						for sortedIndex, sortedSlot in pairs (sortedCapInLandTable) do
							if slot.Count > sortedCapInLandTable[sortedIndex].Count then
								table.insert(sortedCapInLandTable, sortedIndex, slot)
								break
							elseif table.getn(sortedCapInLandTable) == sortedIndex then
								table.insert(sortedCapInLandTable, slot)
								break
							end
						end
					end
				end
				for index, slot in pairs (sortedCapInLandTable) do
					if not IsPlayerControlled(slot.Ent) then
-- RELEASE_LOGOFF  						luaLog("Success, move orders received")
						PilotMoveTo(slot.Ent, airbase)
						UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
						activeCapNum = activeCapNum + 1
						table.insert(capTable, slot)
						if activeCapNum == maxCapNum then
-- RELEASE_LOGOFF  							luaLog("Break, maxCapNum reached")
							break
						end
					else
-- RELEASE_LOGOFF  						luaLog("Skip, slot player controlled")
					end
				end

			end

			--TODO: leellenorizni, hogy jo-e
			if activeCapNum < maxCapNum and table.getn(attackersInLandTable) ~= 0 then
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering attackersInLand -> cap")
				local sortedAttackersInLandTable = {}
				local sortedIndexTable = {}
				for index, slot in pairs (attackersInLandTable) do
					if table.getn(sortedAttackersInLandTable) == 0 then
						table.insert(sortedAttackersInLandTable, slot)
						table.insert(sortedIndexTable, index)
					else
						for sortedIndex, sortedSlot in pairs (sortedAttackersInLandTable) do
							if luaGetDistance(slot.Ent, airbase) < luaGetDistance(sortedAttackersInLandTable[sortedIndex].Ent, airbase) then
								table.insert(sortedAttackersInLandTable, sortedIndex, slot)
								table.insert(sortedIndexTable, sortedIndex, index)
								break
							elseif table.getn(sortedAttackersInLandTable) == sortedIndex then
								table.insert(sortedAttackersInLandTable, slot)
								table.insert(sortedIndexTable, index)
								break
							end
						end
					end
				end
				for index, slot in pairs (sortedAttackersInLandTable) do
					if not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_NONE and (slot.Ent.Class.Type == "Fighter" or airbase.PlayerAirbaseOutOfFighters) then
-- RELEASE_LOGOFF  						luaLog("Succes, "..slot.Ent.Class.Type.." without ammo received move orders")
						PilotMoveTo(slot.Ent, airbase)
						UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
						slot.Ent.PlayerAirbaseCap = true
						activeCapNum = activeCapNum + 1
						table.insert(capTable, slot)
						table.remove(attackersInLandTable, sortedIndexTable[index])
						if activeCapNum == maxCapNum then
-- RELEASE_LOGOFF  							luaLog("Break, maxCapNum reached")
							break
						end
					elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_BOMB and (slot.Ent.Class.Type == "Fighter") then
-- RELEASE_LOGOFF  						luaLog("Succes, Fighter dropped ordnance and received move orders")
						SquadronForceRelease(slot.Ent)
						PilotMoveTo(slot.Ent, airbase)
						UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
						slot.Ent.PlayerAirbaseCap = true
						activeCapNum = activeCapNum + 1
						table.insert(capTable, slot)
						table.remove(attackersInLandTable, sortedIndexTable[index])
						if activeCapNum == maxCapNum then
-- RELEASE_LOGOFF  							luaLog("Break, maxCapNum reached")
							break
						end
					elseif slot.Ent.Class.Type ~= "Fighter" then
-- RELEASE_LOGOFF  						luaLog("Skip, "..slot.Ent.Class.Type.." class")
					elseif IsPlayerControlled(slot.Ent) then
-- RELEASE_LOGOFF  						luaLog("Skip, slot player controlled")
					end
				end
			end

			--TODO: leellenorizni, hogy jo-e
			if activeCapNum < maxCapNum and table.getn(attackersTable) ~= 0 and airbase.PlayerAirbasePreviousTarget == airbaseTarget and not airbaseTarget then
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering attackers -> cap")
				local sortedAttackersTable = {}
				local sortedIndexTable = {}
				for index, slot in pairs (attackersTable) do
					if table.getn(sortedAttackersTable) == 0 then
						table.insert(sortedAttackersTable, slot)
						table.insert(sortedIndexTable, index)
					else
						for sortedIndex, sortedSlot in pairs (sortedAttackersTable) do
							if GetSquadFlyTime(slot.Ent) < 10 or luaGetDistance(slot.Ent, airbase) < luaGetDistance(sortedAttackersTable[sortedIndex].Ent, airbase) then
								table.insert(sortedAttackersTable, sortedIndex, slot)
								table.insert(sortedIndexTable, sortedIndex, index)
								break
							elseif table.getn(sortedAttackersTable) == sortedIndex then
								table.insert(sortedAttackersTable, slot)
								table.insert(sortedIndexTable, index)
								break
							end
						end
					end
				end
				for index, slot in pairs (sortedAttackersTable) do
					if not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_NONE and (slot.Ent.Class.Type == "Fighter" or airbase.PlayerAirbaseOutOfFighters) then
-- RELEASE_LOGOFF  						luaLog("Succes, "..slot.Ent.Class.Type.." without ammo received move orders")
						PilotMoveTo(slot.Ent, airbase)
						UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
						slot.Ent.PlayerAirbaseCap = true
						activeCapNum = activeCapNum + 1
						table.insert(capTable, slot)
						table.remove(attackersTable, sortedIndexTable[index])
						if activeCapNum == maxCapNum then
-- RELEASE_LOGOFF  							luaLog("Break, maxCapNum reached")
							break
						end
					elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_BOMB and (slot.Ent.Class.Type == "Fighter") then
-- RELEASE_LOGOFF  						luaLog("Succes, Fighter dropped ordnance and received move orders")
						SquadronForceRelease(slot.Ent)
						PilotMoveTo(slot.Ent, airbase)
						UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
						slot.Ent.PlayerAirbaseCap = true
						activeCapNum = activeCapNum + 1
						table.insert(capTable, slot)
						table.remove(attackersTable, sortedIndexTable[index])
						if activeCapNum == maxCapNum then
-- RELEASE_LOGOFF  							luaLog("Break, maxCapNum reached")
							break
						end
					elseif slot.Ent.Class.Type ~= "Fighter" then
-- RELEASE_LOGOFF  						luaLog("Skip, "..slot.Ent.Class.Type.." class")
					elseif IsPlayerControlled(slot.Ent) then
-- RELEASE_LOGOFF  						luaLog("Skip, slot player controlled")
					end
				end
			end

			if IsReadyToSendPlanes(airbase) and activeCapNum < maxCapNum and nextFreeSlot and freePlanes > 0 and airbase.PlayerAirbasePlanePreferences.Fighter then
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering cap launch")
				for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences.Fighter) do
					if stock[planeTemplate.ClassID] ~= nil then
						if stock[planeTemplate.ClassID] > 0 then
							local availablePlanes = math.min(math.min(3, stock[planeTemplate.ClassID]), freePlanes)
-- RELEASE_LOGOFF  							luaLog("planeTemplate.ClassID: "..tostring(planeTemplate.ClassID))
-- RELEASE_LOGOFF  							luaLog("availablePlanes: "..tostring(availablePlanes))
-- RELEASE_LOGOFF  							luaLog("planeTemplate.EquipmentID: "..tostring(planeTemplate.EquipmentID))
							SetAirBaseSlot(airbase, nextFreeSlot, planeTemplate.ClassID, availablePlanes, planeTemplate.EquipmentID)
							local planeEnt = LaunchAirBaseSlot(airbase, nextFreeSlot)
-- RELEASE_LOGOFF  							luaLog("Success, launched")
							planeEnt.PlayerAirbaseCap = true
							--[[
							STANCE_HOLD_FIRE   = 0, // hold fire, hold move
							STANCE_FREE_FIRE   = 1, // free fire, hold move
							STANCE_FREE_ATTACK = 2, // free fire, free move
							STANCE_MOVE_ONLY   = 3,  // hold fire, free move
							]]
							UnitSetFireStance(planeEnt, STANCE_FREE_FIRE)
							activePlanes = activePlanes + availablePlanes
							freePlanes = maxPlanes - activePlanes
							activeCapNum = activeCapNum + 1
							table.remove(freeSlotTable, 1)
							_, nextFreeSlot = next(freeSlotTable)
							break
						end
					end
				end
			end

			if activeCapNum > maxCapNum then
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering cap land")
				local sortedCapTable = {}
				for index, slot in pairs (capTable) do
					if table.getn(sortedCapTable) == 0 then
						table.insert(sortedCapTable, slot)
					else
						for sortedIndex, sortedSlot in pairs (sortedCapTable) do
							if slot.Count < sortedCapTable[sortedIndex].Count then
								table.insert(sortedCapTable, sortedIndex, slot)
								break
							elseif table.getn(sortedCapTable) == sortedIndex then
								table.insert(sortedCapTable, slot)
								break
							end
						end
					end
				end
				--TODO: atirni slot.Target -rol home targetre ha van ido.
				for index, slot in pairs (sortedCapTable) do
					if slot.Target and not IsPlayerControlled(slot.Ent) then
						if slot.Target.ID == airbase.ID then
							PilotLand(slot.Ent, airbase)
							UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
							table.insert(capInLandTable, slot)
							activeCapNum = activeCapNum - 1
							if activeCapNum == maxCapNum then
-- RELEASE_LOGOFF  								luaLog("Break, maxCapNum reached")
								break
							end
						else
-- RELEASE_LOGOFF  							luaLog("Skip, cap target is selected by player")
						end
					elseif not slot.Target then
-- RELEASE_LOGOFF  							luaLog("Skip, cap target is selected by player")
					else
-- RELEASE_LOGOFF  							luaLog("Skip, slot player controlled")
					end
				end
			end

			local planeCommand = function(planeEnt, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
				if not airstrikeMode then
-- RELEASE_LOGOFF  					luaLog("Success, target set")
					luaSetScriptTarget(planeEnt, airbaseTarget)
					UnitSetFireStance(planeEnt, STANCE_HOLD_FIRE)
				elseif GetSquadFlyTime(planeEnt) < 15 then
-- RELEASE_LOGOFF  					luaLog("Skip, newborn slot")
					--Skip
				elseif luaGetDistance(planeEnt, airbase) >= groupDistance then
-- RELEASE_LOGOFF  					luaLog("Success, squad is away, target set")
					luaSetScriptTarget(planeEnt, airbaseTarget)
					UnitSetFireStance(planeEnt, STANCE_HOLD_FIRE)
				elseif luaGetDistance(planeEnt, airbase) < groupDistance then
-- RELEASE_LOGOFF  					luaLog("Skip, squad is in range, pending")
					table.insert(pendingPlaneEntTable, planeEnt)
				end
			end
			if airbase.PlayerAirbasePreviousTarget == airbaseTarget and airbaseTarget then
				if table.getn(capInLandTable) ~= 0 then
-- RELEASE_LOGOFF  					luaLog("----------------------------------------")
-- RELEASE_LOGOFF  					luaLog("Ordering capInLand -> attackersInLand")
					for index, slot in pairs (capInLandTable) do
						if not IsPlayerControlled(slot.Ent) then
							if tostring(luaGetType(airbaseTarget)) == "plane" or airbaseTarget.Class.Type == "TorpedoBoat" or airbaseTarget.Class.Type == "LandingShip" or airbaseTarget.Class.Type == "Cargo" then
-- RELEASE_LOGOFF  								luaLog("Success, target is vulnerable for machinegun")
								slot.Ent.PlayerAirbaseCap = false
								slot.Ent.PlayerAirbaseAttacker = true
								table.insert(attackersInLandTable, slot)
							else
-- RELEASE_LOGOFF  								luaLog("Skip, target is invulnerable for machinegun")
							end
						else
-- RELEASE_LOGOFF  							luaLog("Skip, slot player controlled")
						end
					end
				end
				if table.getn(attackersInLandTable) ~= 0 then
-- RELEASE_LOGOFF  					luaLog("----------------------------------------")
-- RELEASE_LOGOFF  					luaLog("Ordering attackersInLand to attack")
					for index, slot in pairs (attackersInLandTable) do
-- RELEASE_LOGOFF  						luaLog("slot.Ent.Class.Type: "..tostring(slot.Ent.Class.Type))
-- RELEASE_LOGOFF  						luaLog("slot.Ent.ammo: "..tostring(slot.Ent.ammo))
						if not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_NONE then
							if slot.Ent.Class.Type == "Fighter" and (tostring(luaGetType(airbaseTarget)) == "plane" or airbaseTarget.Class.Type == "TorpedoBoat" or airbaseTarget.Class.Type == "LandingShip" or airbaseTarget.Class.Type == "Cargo") then
								planeCommand(slot.Ent, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
							end
						elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_BOMB then
							if airbaseTarget.Class.Type == "MotherShip" or airbaseTarget.Class.Type == "BattleShip" or airbaseTarget.Class.Type == "Cruiser" or airbaseTarget.Class.Type == "Cargo" or airbaseTarget.Class.Type == "Destroyer" or airbaseTarget.Class.Type == "LandFort" or airbaseTarget.Class.Type == "Shipyard" or airbaseTarget.Class.Type == "AirField" then
								planeCommand(slot.Ent, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
							end
						elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_TORPEDO then
							if airbaseTarget.Class.Type == "MotherShip" or airbaseTarget.Class.Type == "BattleShip" or airbaseTarget.Class.Type == "Cruiser" or airbaseTarget.Class.Type == "Cargo" or airbaseTarget.Class.Type == "Destroyer" then
								planeCommand(slot.Ent, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
							end
						elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_DEPTHCHARGE then
							if tostring(luaGetType(airbaseTarget)) == "sub" then
-- RELEASE_LOGOFF  								luaLog("Success, target set")
								luaSetScriptTarget(slot.Ent, airbaseTarget)
								UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
							end
						elseif IsPlayerControlled(slot.Ent) then
-- RELEASE_LOGOFF  							luaLog("Skip, slot player controlled")
						end
					end
				end
				if table.getn(attackersTable) ~= 0 then
-- RELEASE_LOGOFF  					luaLog("----------------------------------------")
-- RELEASE_LOGOFF  					luaLog("Ordering attackers to attack")
					local landTable = {}
					for index, slot in pairs (attackersTable) do
-- RELEASE_LOGOFF  						luaLog("slot.Ent.Class.Type: "..tostring(slot.Ent.Class.Type))
-- RELEASE_LOGOFF  						luaLog("slot.Ent.ammo: "..tostring(slot.Ent.ammo))
						local attackerTargetID = luaGetScriptTarget(slot.Ent)
						if attackerTargetID then
							attackerTargetID = attackerTargetID.ID
						end
						if not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_NONE and attackerTargetID ~= airbaseTarget.ID then
							if slot.Ent.Class.Type == "Fighter" and (tostring(luaGetType(airbaseTarget)) == "plane" or airbaseTarget.Class.Type == "TorpedoBoat" or airbaseTarget.Class.Type == "LandingShip" or airbaseTarget.Class.Type == "Cargo") then
								planeCommand(slot.Ent, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
							elseif tostring(luaGetType(airbaseTarget)) == "sub" then
								if not luaGetScriptTarget(slot.Ent) then
-- RELEASE_LOGOFF  									luaLog("Skip, target is a sub, regrouping at the base")
									--TODO: csak egyszer kene kiadni
									PilotMoveTo(slot.Ent, airbase)
									UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
								else
-- RELEASE_LOGOFF  									luaLog("Skip, target is a sub, executing previous orders")
								end
								table.insert(landTable, slot.Ent)
							else
-- RELEASE_LOGOFF  								luaLog("Land, squadron is unable to attack target")
								PilotLand(slot.Ent, airbase)
								UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
							end
						elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_BOMB and attackerTargetID ~= airbaseTarget.ID then
							if airbaseTarget.Class.Type == "MotherShip" or airbaseTarget.Class.Type == "BattleShip" or airbaseTarget.Class.Type == "Cruiser" or airbaseTarget.Class.Type == "Cargo" or airbaseTarget.Class.Type == "Destroyer" or airbaseTarget.Class.Type == "LandFort" or airbaseTarget.Class.Type == "Shipyard" or airbaseTarget.Class.Type == "AirField" then
								planeCommand(slot.Ent, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
							elseif tostring(luaGetType(airbaseTarget)) == "sub" then
								if not luaGetScriptTarget(slot.Ent) then
-- RELEASE_LOGOFF  									luaLog("Skip, target is a sub, regrouping at the base")
									--TODO: csak egyszer kene kiadni
									PilotMoveTo(slot.Ent, airbase)
									UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
								else
-- RELEASE_LOGOFF  									luaLog("Skip, target is a sub, executing previous orders")
								end
								table.insert(landTable, slot.Ent)
							else
-- RELEASE_LOGOFF  								luaLog("Land, squadron is unable to attack target")
								PilotLand(slot.Ent, airbase)
								UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
							end
						elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_TORPEDO and attackerTargetID ~= airbaseTarget.ID then
							if airbaseTarget.Class.Type == "MotherShip" or airbaseTarget.Class.Type == "BattleShip" or airbaseTarget.Class.Type == "Cruiser" or airbaseTarget.Class.Type == "Cargo" or airbaseTarget.Class.Type == "Destroyer" then
								planeCommand(slot.Ent, airbase, airbaseTarget, groupDistance, pendingPlaneEntTable)
							elseif tostring(luaGetType(airbaseTarget)) == "sub" then
								if not luaGetScriptTarget(slot.Ent) then
-- RELEASE_LOGOFF  									luaLog("Skip, target is a sub, regrouping at the base")
									--TODO: csak egyszer kene kiadni
									PilotMoveTo(slot.Ent, airbase)
									UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
								else
-- RELEASE_LOGOFF  									luaLog("Skip, target is a sub, executing previous orders")
								end
								table.insert(landTable, slot.Ent)
							else
-- RELEASE_LOGOFF  								luaLog("Land, squadron is unable to attack target")
								PilotLand(slot.Ent, airbase)
								UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
							end
						elseif not IsPlayerControlled(slot.Ent) and slot.Ent.ammo == AMMO_DEPTHCHARGE and attackerTargetID ~= airbaseTarget.ID then
							if tostring(luaGetType(airbaseTarget)) == "sub" then
-- RELEASE_LOGOFF  								luaLog("Success, target set")
								luaSetScriptTarget(slot.Ent, airbaseTarget)
								UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
								landTable = {}
							else
-- RELEASE_LOGOFF  								luaLog("Land, squadron is unable to attack target")
								PilotLand(slot.Ent, airbase)
								UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
							end
						elseif IsPlayerControlled(slot.Ent) then
-- RELEASE_LOGOFF  							luaLog("Skip, slot player controlled")
						elseif attackerTargetID ~= airbaseTarget.ID then
-- RELEASE_LOGOFF  							luaLog("Skip, target remains the same")
						end
					end
					if table.getn(attackersInLandTable) == 0 and not landingInProgress and activeDCNum < 1 and (not nextFreeSlot or freePlanes < 1) then
						local landingEnt
						for i, planeEnt in pairs (landTable) do
							if landingEnt then
								if luaGetDistance(planeEnt, airbase) < luaGetDistance(landingEnt, airbase) then
									landingEnt = planeEnt
								end
							else
								landingEnt = planeEnt
							end
						end
						if landingEnt then
-- RELEASE_LOGOFF  							luaLog("Land command received: "..landingEnt.Name)
							PilotLand(landingEnt, airbase)
							UnitSetFireStance(landingEnt, STANCE_HOLD_FIRE)
						end
					end
				end
				if IsReadyToSendPlanes(airbase) and nextFreeSlot and freePlanes > 0 and (tostring(luaGetType(airbaseTarget)) == "plane" or airbaseTarget.Class.Type == "TorpedoBoat" or airbaseTarget.Class.Type == "LandingShip") and airbase.PlayerAirbasePlanePreferences.Fighter then
-- RELEASE_LOGOFF  					luaLog("----------------------------------------")
-- RELEASE_LOGOFF  					luaLog("Ordering the launch of a fighter")
					for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences.Fighter) do
						if stock[planeTemplate.ClassID] ~= nil then
							if stock[planeTemplate.ClassID] > 0 then
								local availablePlanes = math.min(math.min(3, stock[planeTemplate.ClassID]), freePlanes)
-- RELEASE_LOGOFF  								luaLog("planeTemplate.ClassID: "..tostring(planeTemplate.ClassID))
-- RELEASE_LOGOFF  								luaLog("availablePlanes: "..tostring(availablePlanes))
-- RELEASE_LOGOFF  								luaLog("planeTemplate.EquipmentID: "..tostring(planeTemplate.EquipmentID))
								SetAirBaseSlot(airbase, nextFreeSlot, planeTemplate.ClassID, availablePlanes, planeTemplate.EquipmentID)
								local planeEnt = LaunchAirBaseSlot(airbase, nextFreeSlot)
-- RELEASE_LOGOFF  								luaLog("Success, launched")
								planeEnt.PlayerAirbaseAttacker = true
								--[[
								STANCE_HOLD_FIRE   = 0, // hold fire, hold move
								STANCE_FREE_FIRE   = 1, // free fire, hold move
								STANCE_FREE_ATTACK = 2, // free fire, free move
								STANCE_MOVE_ONLY   = 3,  // hold fire, free move
								]]
								if not airstrikeMode then
-- RELEASE_LOGOFF  									luaLog("Success, target set")
									luaSetScriptTarget(planeEnt, airbaseTarget)
									UnitSetFireStance(planeEnt, STANCE_HOLD_FIRE)
								elseif airstrikeMode then
-- RELEASE_LOGOFF  									luaLog("Skip, airstrikeMode waiting for successful take off")
									--table.insert(pendingPlaneEntTable, planeEnt)
								end
								activePlanes = activePlanes + availablePlanes
								freePlanes = maxPlanes - activePlanes
								table.remove(freeSlotTable, 1)
								_, nextFreeSlot = next(freeSlotTable)
								break
							end
						end
					end
				end
				if IsReadyToSendPlanes(airbase) and nextFreeSlot and freePlanes > 0 and tostring(luaGetType(airbaseTarget)) == "sub" and airbase.PlayerAirbasePlanePreferences.DC and activeDCNum < 1 and airbase.PlayerAirbasePreviousDCNum2 < 1 then
-- RELEASE_LOGOFF  					luaLog("----------------------------------------")
-- RELEASE_LOGOFF  					luaLog("Ordering the launch of a DC squad")
					for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences.DC) do
						if stock[planeTemplate.ClassID] ~= nil then
							if stock[planeTemplate.ClassID] > 0 then
								local availablePlanes = math.min(math.min(2, stock[planeTemplate.ClassID]), freePlanes)
-- RELEASE_LOGOFF  								luaLog("planeTemplate.ClassID: "..tostring(planeTemplate.ClassID))
-- RELEASE_LOGOFF  								luaLog("availablePlanes: "..tostring(availablePlanes))
-- RELEASE_LOGOFF  								luaLog("planeTemplate.EquipmentID: "..tostring(planeTemplate.EquipmentID))
								SetAirBaseSlot(airbase, nextFreeSlot, planeTemplate.ClassID, availablePlanes, planeTemplate.EquipmentID)
								local planeEnt = LaunchAirBaseSlot(airbase, nextFreeSlot)
-- RELEASE_LOGOFF  								luaLog("Success, launched")
								planeEnt.PlayerAirbaseAttacker = true
								--[[
								STANCE_HOLD_FIRE   = 0, // hold fire, hold move
								STANCE_FREE_FIRE   = 1, // free fire, hold move
								STANCE_FREE_ATTACK = 2, // free fire, free move
								STANCE_MOVE_ONLY   = 3,  // hold fire, free move
								]]
-- RELEASE_LOGOFF  								luaLog("Succes, target set")
								luaSetScriptTarget(planeEnt, airbaseTarget)
								UnitSetFireStance(planeEnt, STANCE_HOLD_FIRE)
								activePlanes = activePlanes + availablePlanes
								activeDCNum = activeDCNum + 1
								freePlanes = maxPlanes - activePlanes
								table.remove(freeSlotTable, 1)
								_, nextFreeSlot = next(freeSlotTable)
								break
							end
						end
					end
				end
				if IsReadyToSendPlanes(airbase) and nextFreeSlot and freePlanes > 0 and (tostring(luaGetType(airbaseTarget)) == "ship" or tostring(luaGetType(airbaseTarget)) == "landfort" or airbaseTarget.Class.Type == "AirField" or airbaseTarget.Class.Type == "Shipyard") and (airbase.PlayerAirbasePlanePreferences.TorpedoBomber or airbase.PlayerAirbasePlanePreferences.DiveBomber or airbase.PlayerAirbasePlanePreferences.LevelBomber) then
-- RELEASE_LOGOFF  					luaLog("----------------------------------------")
-- RELEASE_LOGOFF  					luaLog("Ordering the launch of an attack squad")
					local availableTorpedoBombers = 0
					local availableDiveBombers = 0
					local availableLevelBombers = 0
					if airbase.PlayerAirbasePlanePreferences.TorpedoBomber then
						for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences.TorpedoBomber) do
							if stock[planeTemplate.ClassID] ~= nil then
								if stock[planeTemplate.ClassID] > 0 then
									availableTorpedoBombers = availableTorpedoBombers + stock[planeTemplate.ClassID]
								end
							end
						end
					end
					if airbase.PlayerAirbasePlanePreferences.DiveBomber then
						for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences.DiveBomber) do
							if stock[planeTemplate.ClassID] ~= nil then
								if stock[planeTemplate.ClassID] > 0 then
									availableDiveBombers = availableDiveBombers + stock[planeTemplate.ClassID]
								end
							end
						end
					end
					if airbase.PlayerAirbasePlanePreferences.LevelBomber then
						for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences.LevelBomber) do
							if stock[planeTemplate.ClassID] ~= nil then
								if stock[planeTemplate.ClassID] > 0 then
									availableLevelBombers = availableLevelBombers + stock[planeTemplate.ClassID]
								end
							end
						end
					end

-- RELEASE_LOGOFF  					luaLog("availableTorpedoBombers: "..tostring(availableTorpedoBombers))
-- RELEASE_LOGOFF  					luaLog("availableDiveBombers: "..tostring(availableDiveBombers))
-- RELEASE_LOGOFF  					luaLog("availableLevelBombers: "..tostring(availableLevelBombers))

					local calculateWeight = function(classType)
-- RELEASE_LOGOFF  						luaLog("Calculating weight...")
						local torpedoBomberWeight = 0
						local diveBomberWeight = 0
						local levelBomberWeight = 0
						if availableTorpedoBombers > 0 then
							torpedoBomberWeight = Mission.PlayerAirbaseTacticalPreferences[classType][1]
						end
						if availableDiveBombers > 0 then
							diveBomberWeight = Mission.PlayerAirbaseTacticalPreferences[classType][2]
						end
						if availableLevelBombers > 0 then
							levelBomberWeight = Mission.PlayerAirbaseTacticalPreferences[classType][3]
						end
						if torpedoBomberWeight == 1 and (diveBomberWeight ~= 0 or levelBomberWeight ~= 0) then
-- RELEASE_LOGOFF  							luaLog("torpedoBomberWeight reduced to 0")
							torpedoBomberWeight = 0
						end
						if diveBomberWeight == 1 and (torpedoBomberWeight ~= 0 or levelBomberWeight ~= 0) then
-- RELEASE_LOGOFF  							luaLog("diveBomberWeight reduced to 0")
							diveBomberWeight = 0
						end
						if levelBomberWeight == 1 and (torpedoBomberWeight ~= 0 or levelBomberWeight ~= 0) then
-- RELEASE_LOGOFF  							luaLog("levelBomberWeight reduced to 0")
							levelBomberWeight = 0
						end
						return torpedoBomberWeight, diveBomberWeight, levelBomberWeight
					end

					--[[
					["MotherShip"] = { 30, 30, 50, },
					["BattleShip"] = { 50, 20, 1, },
					["Cruiser"] = { 40, 60, 20, },
					["Cargo"] = { 20, 50, 20, },
					["Destroyer"] = { 10, 70, 30, },
					["LandFort"] = { 0, 30, 100, },
					["Shipyard"] = { 0, 30, 100, },
					["AirField"] = { 0, 30, 100, },
					]]

					if airbaseTarget.Class.Type == "MotherShip" or airbaseTarget.Class.Type == "BattleShip" or airbaseTarget.Class.Type == "Cruiser" or airbaseTarget.Class.Type == "Cargo" or airbaseTarget.Class.Type == "Destroyer" or airbaseTarget.Class.Type == "LandFort" or airbaseTarget.Class.Type == "Shipyard" or airbaseTarget.Class.Type == "AirField" then
						local torpedoBomberWeight, diveBomberWeight, levelBomberWeight = calculateWeight(airbaseTarget.Class.Type)
						--TODO: opcionalisan figyelembe venni az eddigi tamadokat a sulyozasnal
-- RELEASE_LOGOFF  						luaLog("TypeWeight: "..torpedoBomberWeight..", "..diveBomberWeight..", "..levelBomberWeight)
						if torpedoBomberWeight + diveBomberWeight + levelBomberWeight > 0 then
							local attackType = luaPickInRange("TorpedoBomber", torpedoBomberWeight, "DiveBomber", diveBomberWeight, "LevelBomber", levelBomberWeight)
-- RELEASE_LOGOFF  							luaLog("ChosenTypet: "..attackType)
							for idx, planeTemplate in pairs (airbase.PlayerAirbasePlanePreferences[attackType]) do
								if stock[planeTemplate.ClassID] ~= nil then
									if stock[planeTemplate.ClassID] > 0 then
										local availablePlanes = math.min(math.min(3, stock[planeTemplate.ClassID]), freePlanes)
-- RELEASE_LOGOFF  										luaLog("planeTemplate.ClassID: "..tostring(planeTemplate.ClassID))
-- RELEASE_LOGOFF  										luaLog("availablePlanes: "..tostring(availablePlanes))
-- RELEASE_LOGOFF  										luaLog("planeTemplate.EquipmentID: "..tostring(planeTemplate.EquipmentID))
										SetAirBaseSlot(airbase, nextFreeSlot, planeTemplate.ClassID, availablePlanes, planeTemplate.EquipmentID)
										local planeEnt = LaunchAirBaseSlot(airbase, nextFreeSlot)
-- RELEASE_LOGOFF  										luaLog("Success, launched")
										planeEnt.PlayerAirbaseAttacker = true
										--[[
										STANCE_HOLD_FIRE   = 0, // hold fire, hold move
										STANCE_FREE_FIRE   = 1, // free fire, hold move
										STANCE_FREE_ATTACK = 2, // free fire, free move
										STANCE_MOVE_ONLY   = 3,  // hold fire, free move
										]]
										if not airstrikeMode then
-- RELEASE_LOGOFF  											luaLog("Success, target set")
											luaSetScriptTarget(planeEnt, airbaseTarget)
											UnitSetFireStance(planeEnt, STANCE_HOLD_FIRE)
										elseif airstrikeMode then
-- RELEASE_LOGOFF  											luaLog("Skip, airstrikeMode waiting for successful take off")
											--table.insert(pendingPlaneEntTable, planeEnt)
										end
										activePlanes = activePlanes + availablePlanes
										if attackType == "TorpedoBomber" then
											activeTorpedoNum = activeTorpedoNum + 1
										elseif attackType == "DiveBomber" then
											activeBombNum = activeBombNum + 1
										elseif attackType == "LevelBomber" then
											activeLevelBombNum = activeLevelBombNum + 1
										end
										freePlanes = maxPlanes - activePlanes
										table.remove(freeSlotTable, 1)
										_, nextFreeSlot = next(freeSlotTable)
										break
									end
								end
							end
						else
-- RELEASE_LOGOFF  							luaLog("Warning! No attack planes in stock")
						end
					else
-- RELEASE_LOGOFF  						luaLog("Warning! Invalid type: "..tostring(airbaseTarget.Class.Type))
					end
				end
				--TODO: ezt finomitani, hogy ha tobb attacker van a levegoben mint amennyi maradna Cap noveles miatt akkor azok ne menjenek el attackolni.
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering pending units")
-- RELEASE_LOGOFF  				luaLog("table.getn(pendingPlaneEntTable): "..tostring(table.getn(pendingPlaneEntTable)))
-- RELEASE_LOGOFF  				luaLog("maxSlots: "..tostring(maxSlots))
-- RELEASE_LOGOFF  				luaLog("activeCapNum: "..tostring(activeCapNum))
-- RELEASE_LOGOFF  				luaLog("activePlayerNum: "..tostring(activePlayerNum))
				if (table.getn(pendingPlaneEntTable) >= (maxSlots - activeCapNum - activePlayerNum)) or (nextFreeSlot and IsReadyToSendPlanes(airbase)) then
-- RELEASE_LOGOFF  					luaLog("Initiating Attack...")
					for idx, planeEnt in pairs (pendingPlaneEntTable) do
-- RELEASE_LOGOFF  						luaLog("Success, target set")
						luaSetScriptTarget(planeEnt, airbaseTarget)
						UnitSetFireStance(planeEnt, STANCE_HOLD_FIRE)
					end
				elseif table.getn(pendingPlaneEntTable) > 0 then
-- RELEASE_LOGOFF  					luaLog("Waiting for more before attack...")
				else
-- RELEASE_LOGOFF  					luaLog("No pending units")
				end
			elseif airbase.PlayerAirbasePreviousTarget == airbaseTarget then
-- RELEASE_LOGOFF  				luaLog("----------------------------------------")
-- RELEASE_LOGOFF  				luaLog("Ordering squads to regroup")
				airbase.slots = GetProperty(airbase, "slots")
				for index, slot in pairs (attackersTable) do
					if not IsPlayerControlled(slot.Ent) then
						if airbase.slots[slot.SlotNum].state ~= PLANES_RETURN then
							if not slot.Ent.TargetIsHome then
-- RELEASE_LOGOFF  								luaLog("Success, move orders received")
								PilotMoveTo(slot.Ent, airbase)
								if slot.Ent.ammo == AMMO_NONE then
									UnitSetFireStance(slot.Ent, STANCE_FREE_FIRE)
								else
									UnitSetFireStance(slot.Ent, STANCE_HOLD_FIRE)
								end
							else
-- RELEASE_LOGOFF  								luaLog("Skip, slot already got move orders")
							end
						else
-- RELEASE_LOGOFF  							luaLog("Skip, slot in land state")
						end
					else
-- RELEASE_LOGOFF  						luaLog("Skip, slot player controlled")
					end
				end
			end

			airbase.PlayerAirbasePreviousTarget = airbaseTarget
			airbase.PlayerAirbasePreviousDCNum2 = airbase.PlayerAirbasePreviousDCNum
			airbase.PlayerAirbasePreviousDCNum = activeDCNum
		end
	end
-- RELEASE_LOGOFF  	luaLog("luaPlayerAirbaseManager Finished!")
end

--[[AutoDoc
usage: luaReloadHelpers()
category: Mission
shortdesc: a global script lib ujratoltese
desc: on the fly ujratolti a commandhelpers.lua-t
]]
function luaReloadHelpers()
	DoFileOutsideMPAK("scripts/global/commandhelpers.lua")
	--DoFile("scripts/global/checkpointsystem.lua")
	--DoFile("scripts/global/missionhelpers.lua")
-- RELEASE_LOGOFF  	LogToConsole("Success: Helper scripts are reloaded.")
end

--[[AutoDoc
usage: luaReloadHelpers()
category: Mission
shortdesc: a missionscript ujratoltese
desc: on the fly ujratolti a missionscriptet
]]
function luaReloadMission()
	if Mission.ScriptFile then
		if type(Mission.ScriptFile) == "string" then
			local scriptFile = io.open(Mission.ScriptFile, "r")
			if scriptFile == nil then
-- RELEASE_LOGOFF  				LogToConsole("Error: "..tostring(Mission.ScriptFile).." doesn't exists!")
			else
				scriptFile:close()
				DoFileOutsideMPAK(Mission.ScriptFile)
-- RELEASE_LOGOFF  				LogToConsole("Success: "..Mission.ScriptFile.." is reloaded.")
			end
		else
-- RELEASE_LOGOFF  			LogToConsole("Error: ScriptFile is not a string!")
		end
	else
-- RELEASE_LOGOFF  		LogToConsole("Error: ScriptFile is not defined!")
	end
end

--[[AutoDoc
usage: luaDumpLocals([useLogFile])
category: Debug
shortdesc: Lokalis valtozok lekerdezese.
desc: Egy aktiv debug ciklusban a fuggveny kiirja a kulonbozo szinteken definialt local valtozokat alapertelmezesbol a consolera. Tablak logolasa maximum 3-as melysegig tortenik.
-- RELEASE_LOGOFF  useLogFile: Ha nem nil, akkor luaLog-ot hasznal egyebkent logToConsole-t.
]]
function luaDumpLocals(useLogFile)
	if not useLogFile then
-- RELEASE_LOGOFF  		LogToConsole("================================================================================")
-- RELEASE_LOGOFF  		LogToConsole("***Dump Locals***")
-- RELEASE_LOGOFF  		LogToConsole("================================================================================")
		local level = 4
		while debug.getinfo(level) do
-- RELEASE_LOGOFF  			LogToConsole("***Name: "..tostring(debug.getinfo(level, "n").name)..", Source: "..tostring(debug.getinfo(level).source)..", Current Line: "..tostring(debug.getinfo(level).currentline).."***")
			local varIndex = 1
			local headingPrinted
			while true do
				local varKey, varValue = debug.getlocal(level, varIndex)
				if varKey then
					if varKey:sub(1, 1) ~= "(" then
						if not headingPrinted then
-- RELEASE_LOGOFF  							LogToConsole("================================================================================")
							headingPrinted = true
						end
-- RELEASE_LOGOFF  						LogToConsole("local "..tostring(varKey))
-- RELEASE_LOGOFF  						LogToConsole("------------------------------------------------------------------------------------------")
-- RELEASE_LOGOFF  						LogToConsole(varValue)
-- RELEASE_LOGOFF  						LogToConsole("================================================================================")
					end
				else
					break
				end
				varIndex = varIndex + 1
			end
			level = level + 1
		end
	else
-- RELEASE_LOGOFF  		LogToConsole("***Dump Locals***")
-- RELEASE_LOGOFF  		luaLog("================================================================================")
-- RELEASE_LOGOFF  		luaLog("***Dump Locals***")
-- RELEASE_LOGOFF  		luaLog("================================================================================")
		local level = 4
		while debug.getinfo(level) do
-- RELEASE_LOGOFF  			luaLog("***Name: "..tostring(debug.getinfo(level, "n").name)..", Source: "..tostring(debug.getinfo(level).source)..", Current Line: "..tostring(debug.getinfo(level).currentline).."***")
			--luaLog(debug.getinfo(level))
			local varIndex = 1
			local headingPrinted
			while true do
				local varKey, varValue = debug.getlocal(level, varIndex)
				if varKey then
					if varKey:sub(1, 1) ~= "(" then
						if not headingPrinted then
-- RELEASE_LOGOFF  							luaLog("================================================================================")
							headingPrinted = true
						end
-- RELEASE_LOGOFF  						luaLog("local "..tostring(varKey))
-- RELEASE_LOGOFF  						luaLog("--------------------------------------------------------------------------------")
-- RELEASE_LOGOFF  						luaLog(varValue)
-- RELEASE_LOGOFF  						luaLog("================================================================================")
					end
				else
					break
				end
				varIndex = varIndex + 1
			end
			level = level + 1
		end
	end
end

--UNLOCK HANDLING
function luaSetUnlockLvl(num)
	if type(num) == "number" and (num >=1 and num <=3) then
		Mission.UnlockLvl = num
	else
-- RELEASE_LOGOFF  		luaHelperLog("SetUnlockLvl got a wrong param")
	end
end

function luaGetMovieOption()
	return true
end

function luaSetPartyInvincible(...)
--[[
	luaSetPartyInvincible(InvincibleState, [Party])
	Paramterek:
		InvincibleState	:	0 - Korabbi Invincible allapot visszatoltese
											1 - Invincible rarakasa
		Party						:	PARTY_ALLIED
											PARTY_JAPANESE
											ha a masodik parameter nincs megadva, akkor mind a ket party-ra allitja)
]]--

	--luaLog("------ luaSetPartyInvincible Start -------")
	if (arg[1] == nil) then
-- RELEASE_LOGOFF  		luaHelperLog("(luaSetAllInvincible): The first parameter is a nil. Function terminated.")
		return 1
	elseif (arg[1] ~= 0) and (arg[1] ~= 1) then
-- RELEASE_LOGOFF  		luaHelperLog("(luaSetAllInvincible): The first paramater must be 0 or 1. Function terminated.")
		return 2
	end
	if (arg[2] ~= nil) and (arg[2] ~= PARTY_ALLIED) and (arg[2] ~= PARTY_JAPANESE) then
-- RELEASE_LOGOFF  		luaHelperLog("The second parameter must be nil, PARTY_ALLIED or PARTY_JAPANESE. Function terminated.")
		return 3
	end
	--luaLog("arg[1] = "..arg[1])
	if (Mission.InvincibleState == nil) then
		Mission.InvincibleState = {}
	end
	if (arg[2] == nil) or (arg[2] == PARTY_ALLIED) then
		--luaLog("*****PARTY_ALLIED*******")
		local tUSNUnits = luaGetOwnUnits(nil, PARTY_ALLIED)
		for i, pUnit in pairs (tUSNUnits) do
			local nNewInvincibleState = arg[1]
			--luaLog("==== Name = "..pUnit.Name..", UnitID = "..pUnit.ID)
			if (arg[1] == 1) then
				local nInvincibleState = 0
				if (IsInvincible(pUnit)) then
					nInvincibleState = 1
				end
				--luaLog("Elmentett Invincible State = "..nInvincibleState)
				table.insert(Mission.InvincibleState, {pUnit.ID, nInvincibleState})
			elseif (arg[1] == 0)  then
				local nIndex = luaFindUnitForSetPartyInvincible(pUnit.ID)
				if (nIndex > 0) then
					nNewInvincibleState = Mission.InvincibleState[nIndex][2]
					table.remove(Mission.InvincibleState, nIndex)
				end
				--luaLog("Visszatoltott Invincible State = "..nNewInvincibleState)
			end
			SetInvincible(pUnit, nNewInvincibleState)
		end
	end
	if (arg[2] == nil) or (arg[2] == PARTY_JAPANESE) then
		--luaLog("*****PARTY_JAPANESE*******")
		local tJAPUnits = luaGetOwnUnits(nil, PARTY_JAPANESE)
		for i, pUnit in pairs (tJAPUnits) do
			local nNewInvincibleState = arg[1]
			--luaLog("==== Name = "..pUnit.Name..", UnitID = "..pUnit.ID)
			if (arg[1] == 1) then
				local nInvincibleState = 0
				if (IsInvincible(pUnit)) then
					nInvincibleState = 1
				end
				--luaLog("Elmentett Invincible State = "..nInvincibleState)
				table.insert(Mission.InvincibleState, {pUnit.ID, nInvincibleState})
			elseif (arg[1] == 0)  then
				local nIndex = luaFindUnitForSetPartyInvincible(pUnit.ID)
				if (nIndex > 0) then
					nNewInvincibleState = Mission.InvincibleState[nIndex][2]
					table.remove(Mission.InvincibleState, nIndex)
				end
				--luaLog("Visszatoltott Invincible State = "..nNewInvincibleState)
			end
			SetInvincible(pUnit, nNewInvincibleState)
		end
	end
	--luaLog("------ luaSetPartyInvincible End -------")
end

function luaFindUnitForSetPartyInvincible(nID)
	local i = table.getn(Mission.InvincibleState)
	local nIndex = 0
	while (i > 0) do
		if (Mission.InvincibleState[i][1] == nID) then
			nIndex = i
		end
		i = i - 1
	end
	return nIndex
end
function luaPutToRecon(unit, relativeto, degree)
	local pos = GetPosition(relativeto)
	local dist
	if ReconClass[unit.Class.ReconClass].Details.ObserverAir then
		dist = ReconClass[unit.Class.ReconClass].Details.ObserverAir.GUIRange[1].Range
	else
		if ReconClass[unit.Class.ReconClass].Details.ObserverSurface.GUIRange[2] then
			dist = ReconClass[unit.Class.ReconClass].Details.ObserverSurface.GUIRange[2].Range
		else
			dist = ReconClass[unit.Class.ReconClass].Details.ObserverSurface.GUIRange[1].Range
		end
	end
	dist = dist * GetSimplifiedReconMultiplier()
	local rot = math.pi * degree /180
	pos.x = pos.x + math.sin(rot) * dist
	pos.z = pos.z + math.cos(rot) * dist
	pos.y = GetPosition(unit).y
	PutTo(unit, pos)
end

----------------------------------------CHECKPOINT-----------------------------------------------
function luaInitCheckpointSystem(capID)
	Mission.ChckLogPrefix = "Checkpoint system: \t"
	Mission.Checkpoint = {}
end

function luaWriteCheckpointData()
	--[[
	local filename = Mission.Name.."Checkpoint.lua"
	file = io.open(filename, "w+")

	luaChkLog("Mission.Checkpoint =", true)
	luaChkLog("{", true)
	luaChkDumpSortedTable(Mission.Checkpoint, 1)
	luaChkLog("}", true)
	file:close()
	]]
	local x = SaveCheckpoint(Mission.Checkpoint)
	if x then
		MissionNarrativeUrgent("globals.checkpoint_r")
	end
end

function luaRegisterCheckpointData(category, tablename, data)

	if not Mission.Checkpoint[category] then
		Mission.Checkpoint[category] = {}
-- RELEASE_LOGOFF  		luaLog(Mission.ChckLogPrefix.."Registering category: "..category)
	end
	if not Mission.Checkpoint[category][tablename] then
		Mission.Checkpoint[category][tablename] = {}
-- RELEASE_LOGOFF  		luaLog(Mission.ChckLogPrefix.."Registering table: "..tablename.." under category: "..category)
	end

	table.insert(Mission.Checkpoint[category][tablename], data)

-- RELEASE_LOGOFF  	luaLog("\n")
end

function luaGetCheckpointData(category, tablename)

	if tablename == nil then
		if Mission.Checkpoint[category] then
			return Mission.Checkpoint[category]
		end
	else
		if Mission.Checkpoint[category] and Mission.Checkpoint[category][tablename] then
			return Mission.Checkpoint[category][tablename]
		end
	end

	return {}
end

function luaCheckpoint(chckNum,capID)
--[[

	MAPTILTAST VISSZARAKNI!!!!!!!!!!!!!!!!

le kell tarolni:

	ONTEST:
		unitszam (player, jap ai, us ai)
		stock (player, ai)	GetCatapultStock(ship) és SetCatapultStock(ship,stock)
		objektivak
		event data
		putto
		landfort data: party, halott landfortok? -> adddamage
		powerups
		landconvoy: pos, dead flag
		checkpoint automatikus load (ha van ilyen file toltse be)
		kiszedni a missionspec fv-k loadbol savebol, oszt beleirni mashova

	IZE:
		scoring -> grave
		hintek: show, reset (AddStoredHint)		na most mi van, nem removeolhatom, ad add lofasz nem megy, aktiv statuszat kene figyelni

	REMOVED:
		powerups: mivan az ellott ill. cooldown --nemszamit
		function hivast faszan leellenorizni, meg kene oldani h tudjon parametert kapni, bah, talan mint luadelaynel

	ISSUE:
		kiba airfield letarolodik stockkal 3x
		trafficot nem tudom megfogni

]]
	luaInitCheckpointSystem()

	if capID then
		Mission.Checkpoint.CapID = capID
	end

	ForceRecon()

	luaRegisterCheckpointData("CheckPoint", "Num", chckNum)
	luaRegisterCheckpointData("Phase", "MissionPhase", Mission.MissionPhase)
	luaRegisterCheckpointData("Powerups", "PowerupTable", GetAvailablePowerups(PLAYER_1))

	--objectives
	--local tmp = copy_table(Mission.Objectives)
	local Objs = {["Active"] = {}, ["Completed"] = {}, ["Failed"] = {},}
	for idx,objTbl in pairs(Mission.Objectives) do
		--luaLog(idx)
		for idx2,objTbl2 in pairs(objTbl) do
			--luaLog(idx2)
			if luaObj_IsActive(idx,idx2) then
				table.insert(Objs["Active"],{idx,idx2})
			end
			if luaObj_GetSuccess(idx,idx2) then
				table.insert(Objs["Completed"],{idx,idx2})
			end
			if luaObj_GetSuccess(idx,idx2) == false then
				table.insert(Objs["Failed"],{idx,idx2})
			end
		end
	end
	luaRegisterCheckpointData("Objectives", "ObjectiveTable", Objs)

	--unitnumber
	local JapUnits = luaGetJapUnits()
	local USUnits = luaGetAlliedUnits()
	local NUnits = luaGetNeutralUnits()

	luaRegisterCheckpointData("Units", "JapUnits", JapUnits)
	luaRegisterCheckpointData("Units", "USUnits", USUnits)
	luaRegisterCheckpointData("Units", "NUnits", NUnits)

	--hints
	luaRegisterCheckpointData("Hints", "HintTbl", Mission.HintsShowed)

	--stock
	for idx,unitTbl in pairs(luaSumTablesIndex(JapUnits, USUnits, NUnits)) do
		local unit = FindEntity(unitTbl[1])

		if unit and luaIsAirfieldTable({unit}) and luaIsRegisteredAirfield(unit) == false and not unit.Dead then

			local AFTable = {["Stock"] = {}}
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Found an airfield unit: "..unit.Name.." "..tostring(unit.Party))
			local slot,squad = luaGetSlotsAndSquads(unit)
			local stock = GetProperty(unit, "Stock")

			if squad and stock then
				local i = 1
				local tbl = {}
				for idx2,squadron in pairs(squad) do
					local classID = squadron.Class.ID
					--local tbl = {} -- mit erdemel... :))

-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."classID "..classID)

					for idx3,stockTbl in pairs(stock) do
						--luaLog(Mission.ChckLogPrefix.."classTBL")
						--luaLog(stockTbl)
						if stockTbl.classid == classID then
-- RELEASE_LOGOFF  							luaLog(Mission.ChckLogPrefix.."Found a stock with same class ID")
							table.insert(tbl, idx3)
						end
					end

					--luaLog(Mission.ChckLogPrefix.."Stock tbl")
					--luaLog(tbl)

					if table.getn(tbl) >= 1 then
						if i < table.getn(tbl) then
							stock[tbl[i]].count = stock[tbl[i]].count + 3
-- RELEASE_LOGOFF  							luaLog(Mission.ChckLogPrefix.."Adding plane to airfield stock "..unit.Name.." to stock "..tbl[1])
							i = i + 1
						elseif table.getn(tbl) == 1 then
							i = 1
							stock[tbl[i]].count = stock[tbl[i]].count + 3
-- RELEASE_LOGOFF  							luaLog(Mission.ChckLogPrefix.."Adding plane to airfield stock "..unit.Name.." to stock "..tbl[i])
						end
					elseif table.getn(tbl) == 0 then
-- RELEASE_LOGOFF  						luaLog(Mission.ChckLogPrefix.."No such class, perhaps ai scripted airfield?")
					end

				end
			end

			AFTable["Stock"] = stock
			AFTable["Name"] = unit.Name
			luaRegisterCheckpointData("Airfields", "Stock", AFTable)
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Writing airfield data")
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."registering airfield "..unit.Name.." with party "..tostring(unit.Party))

		elseif unit and (luaGetType(unit) == "ship" or luaGetType(unit) == "sub") then

			-- reconplanestock
			if GetCatapultStock(unit)> 0 then
				local shipTbl = {["Name"] = unit.Name, ["Stock"] = GetCatapultStock(unit)}
				luaRegisterCheckpointData("Reconstock", "Stock", shipTbl)
			end

		end
	end

-- RELEASE_LOGOFF  	luaLog("\n")

	luaCheckSaveFunctions()

	luaWriteCheckpointData()

end

function luaIsRegisteredAirfield(unit)
	local AFTbl = luaGetCheckpointData("Airfields", "Stock")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."luaIsRegisteredAirfield")
-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Checking "..unit.Name)

	if not AFTbl then
-- RELEASE_LOGOFF  		luaLog(Mission.ChckLogPrefix.."AFTable is not registered yet")
		return false
	end

	for idx,af in pairs(AFTbl) do
-- RELEASE_LOGOFF  		luaLog(Mission.ChckLogPrefix.."Registered unit "..af.Name)
		if unit.Name == af.Name then
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."AF is already registered")
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."valami el van baszva megen a recontablaban")
-- RELEASE_LOGOFF  			luaLog("\n")
			return true
		end
	end
-- RELEASE_LOGOFF  	luaLog("\n")
	return false
end

function luaGetJapUnits()
	local z = {}
	for idx,x in pairs(recon[PARTY_JAPANESE].own) do
		for idx2,unit in pairs(x) do
			if not unit.Dead and luaGetType(unit) ~= "plane" then
				local leader = GetFormationLeader(unit)
				if leader then
					--luaLog("LEADER: "..leader.Name)
					--luaLog("POSITION: ")
					--luaLog(GetPosition(leader))
					table.insert(z, {unit.Name, GetGuiName(unit), unit.Class.ID, GetProperty(unit, "TorpedoStock"), leader.Name, GetPosition(leader)})
				else
					table.insert(z, {unit.Name, GetGuiName(unit), unit.Class.ID, GetProperty(unit, "TorpedoStock"), nil})
				end
			end
		end
	end
-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Getting jap units")
-- RELEASE_LOGOFF  	luaLog("\n")
	return z
end

function luaGetAlliedUnits()
	local z = {}
	for idx,x in pairs(recon[PARTY_ALLIED].own) do
		for idx2,unit in pairs(x) do
			if not unit.Dead and luaGetType(unit) ~= "plane" then
				local leader = GetFormationLeader(unit)
				if leader then
					table.insert(z, {unit.Name, GetGuiName(unit), unit.Class.ID, GetProperty(unit, "TorpedoStock"), leader.Name, GetPosition(leader)})
				else
					table.insert(z, {unit.Name, GetGuiName(unit), unit.Class.ID, GetProperty(unit, "TorpedoStock"), nil})
				end
			end
		end
	end
-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Getting usn units")
-- RELEASE_LOGOFF  	luaLog("\n")
	return z
end

function luaGetNeutralUnits()
	local z = {}
	for idx,x in pairs(recon[PARTY_NEUTRAL].own) do
		for idx2,unit in pairs(x) do
			if not unit.Dead and luaGetType(unit) ~= "plane" then
				local leader = GetFormationLeader(unit)
				if leader then
					table.insert(z, {unit.Name, GetGuiName(unit), unit.Class.ID, GetProperty(unit, "TorpedoStock"), leader.Name, GetPosition(leader)})
				else
					table.insert(z, {unit.Name, GetGuiName(unit), unit.Class.ID, GetProperty(unit, "TorpedoStock"), nil})
				end
			end
		end
	end
-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Getting neutral units")
-- RELEASE_LOGOFF  	luaLog("\n")
	return z
end

--load checkpoint
function luaLoadCheckpoint()
	--local filename = Mission.Name.."Checkpoint.lua"
	--DoFile(filename)

	Mission.Checkpoint = LoadCheckpoint()

	Mission.ChckLogPrefix = "Checkpoint system: \t"

	ForceRecon()

	if Mission.Checkpoint == nil or next(Mission.Checkpoint) == nil then
		return
	end

	local num = luaGetCheckpointData("CheckPoint", "Num")

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.." loading checkpoint "..tostring(num[1]))

	--phase
	local phaseTbl = luaGetCheckpointData("Phase", "MissionPhase")

	--powerups
	local pwupTbl = luaGetCheckpointData("Powerups", "PowerupTable")[1]
	if pwupTbl then
-- RELEASE_LOGOFF  		luaLog("-----------PWUP----------------")
		for idx,tbl in pairs(pwupTbl) do
-- RELEASE_LOGOFF  			luaLog(tbl)
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Adding powerup "..tbl)
			AddPowerup({
				["classID"] = tbl,
				["useLimit"] = 1,
			})
		end
	end

	--objectives
	local objTable = luaGetCheckpointData("Objectives", "ObjectiveTable")
	for idx,tbl in pairs(objTable[1])	do

		--luaLog(tbl)

		if idx == "Active" then

			for idx2,tbl2 in pairs(tbl)	do
				if not luaObj_IsActive(tbl2[1], tbl2[2]) then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting objective "..tbl2[1].." "..tbl2[2].." to active")
					---oh faszom
					--[[
					if tbl2[1] == "primary" then
						if tbl2[2] == 1 then
							luaJM5AddObjP1(true)
						elseif tbl2[2] == 2 then
							luaJM5AddObjP2(true)
						elseif tbl2[2] == 3 then
							luaJM5AddObjP3(true)
						elseif tbl2[2] == 4 then
							luaJM5AddObjP4(true)
						end
					elseif tbl2[1] == "secondary" then
						luaJM5AddObjS1(true)
					elseif tbl2[1] == "marker2" then
						luaJM5AddMarkerObj()
					end
					]]
					luaObj_Add(tbl2[1],tbl2[2],nil,true)
				else
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Objective "..tbl2[1].." "..tbl2[2].." is already active")
				end
			end

		elseif idx == "Completed" then

			for idx2,tbl2 in pairs(tbl) do
				if not luaObj_IsActive(tbl2[1], tbl2[2]) then
					luaObj_Add(tbl2[1], tbl2[2], nil, true)
					luaObj_Completed(tbl2[1], tbl2[2], nil, true)
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting objective "..tbl2[1].." "..tbl2[2].." to completed")
				else
					if luaObj_GetSuccess(tbl2[1], tbl2[2]) == nil then
						luaObj_Completed(tbl2[1], tbl2[2], nil, true)
-- RELEASE_LOGOFF  						luaLog(Mission.ChckLogPrefix.."Setting objective "..tbl2[1].." "..tbl2[2].." to completed")
					end
				end
			end

		elseif idx == "Failed" then

			for idx2,tbl2 in pairs(tbl) do
				if not luaObj_IsActive(tbl2[1], tbl2[2]) then
					luaObj_Add(tbl2[1], tbl2[2], nil, true)
					luaObj_Failed(tbl2[1], tbl2[2], nil, true)
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Setting objective "..tbl2[1].." "..tbl2[2].." to failed")
				else
					if luaObj_GetSuccess(tbl2[1], tbl2[2]) == nil then
						luaObj_Failed(tbl2[1], tbl2[2], nil, true)
-- RELEASE_LOGOFF  						luaLog(Mission.ChckLogPrefix.."Setting objective "..tbl2[1].." "..tbl2[2].." to failed")
					end
				end
			end

		end
	end

-- RELEASE_LOGOFF  	luaLog("\n")
	luaRestoreLandforts()

	ForceRecon() --hgy meglegyen a sok SetParty a reconban

	luaDelay(luaRestorePlanesAndStocks,1)
	luaRestoreHints()

	Mission.MissionPhase = phaseTbl[1]
-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."Missionphase: "..tostring(Mission.MissionPhase))

	luaCheckLoadFunctions()

	Mission.CheckpointLoaded = true
end

function luaRestoreHints()
	local hintTbl = luaGetCheckpointData("Hints", "HintTbl", Mission.HintsShowed)
	if hintTbl[1] == nil then
		return
	end
	for idx,str in pairs(hintTbl[1]) do
		if str == nil then
			break
		end
		if type(str) == "string" then
			--RemoveStoredHint(tbl[1])
			AddStoredHint(str)
-- RELEASE_LOGOFF  			luaLog("\n")
-- RELEASE_LOGOFF  			luaLog(Mission.ChckLogPrefix.."Hint found setting it to inactive"..str)
		end
	end
end

function luaCheckSaveFunctions()
	local chckNum = luaGetCheckpointData("CheckPoint", "Num", chckNum)

	for idx,func in pairs(Mission.CheckpointSaveFunctions[chckNum[1]]) do
		if type(func) == "function" then
			func()
		end
	end

end

function luaCheckLoadFunctions()
	local chckNum = luaGetCheckpointData("CheckPoint", "Num", chckNum)

	for idx,func in pairs(Mission.CheckpointLoadFunctions[chckNum[1]]) do
		if type(func) == "function" then
			func()
		end
	end

end

function luaRestorePlanesAndStocks()

-- RELEASE_LOGOFF  	luaLog(Mission.ChckLogPrefix.."luaRestorePlanesAndStocks")
	--bespawnolni a repterek fole egy vadasz squadot
	local AFTbl = luaGetCheckpointData("Airfields", "Stock")

	if not AFTbl then
		return
	end

	for idx,tbl in pairs(AFTbl) do
		local unit = FindEntity(tbl.Name)
		if unit and not unit.Dead then
			local stock = tbl.Stock

			RemoveAllAirBasePlanes(unit)

			for idx2,stockTbl in pairs(stock) do
				AddAirBasePlanes(unit, stockTbl.classid, stockTbl.count)
			end

			if Mission.Checkpoint.CapID and unit.Party == luaGetNmiParty() then
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.." spawning fighter cap to AF "..unit.Name)
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix..unit.Name.." party "..tostring(unit.Party))
-- RELEASE_LOGOFF  				luaLog(Mission.ChckLogPrefix.."enemy party "..tostring(luaGetNmiParty()))
				luaAddFighter(unit, Mission.Checkpoint.CapID)
			end

		end
	end

	local reconunits = luaGetCheckpointData("Reconstock", "Stock")
	for idx,unitTbl in pairs(reconunits) do
		local unit = FindEntity(unitTbl.Name)
		if unit and not unit.Dead then
			SetCatapultStock(unit, unitTbl.Stock)
		end
	end

-- RELEASE_LOGOFF  	luaLog("\n")
end

function luaGetNmiParty()
	if Mission.Party == PARTY_JAPANESE then
		return PARTY_ALLIED
	else
		return PARTY_JAPANESE
	end
end

function luaGetNmiRace()
	if Mission.Party == PARTY_JAPANESE then
		return JAPANESE
	else
		return ALLIED
	end
end

function luaAddFighter(unit, classID)
	local AF = unit

	local spawnPoint = GetPosition(AF)
	spawnPoint.y = 250

	local lookAt = GetPosition(AF)
	lookAt.z = lookAt.z + 500

	SpawnNew({
		["party"] = luaGetNmiParty(),
		["groupMembers"] = {
				{
					["Type"] = classID,
					["Name"] = "checkpoint fighter",
					["Crew"] = 1,
					["Race"] = luaGetNmiRace(),
					["WingCount"] = 3,
					["Equipment"] = 0,
				},
			},
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 50,
			["enemyHorizontal"] = 200,
			["ownVertical"] = 75,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		["area"] = {
			["refPos"] = spawnPoint,
			["angleRange"] = { 180 *  0.0174532925, 270 *  0.0174532925},
			["lookAt"] = lookAt,
		},
		["callback"] = "luaCheckpointSpawned",
		["id"] = AF.Name.."Req",
	})
end

function luaCheckpointSpawned(unit)
	local homebase
	local dist = 10000000000
	local AFTbl = luaGetCheckpointData("Airfields", "Stock")

	for idx,tbl in pairs(AFTbl) do
		local AF = FindEntity(tbl.Name)
		if AF and luaGetDistance(AF, unit) < dist then
			dist = luaGetDistance(AF, unit)
			homebase = AF
		end
	end

	SquadronSetHomeBase(unit, homebase)
end

function luaRestoreLandforts()

	local japUnits = luaGetCheckpointData("Units", "JapUnits")
	local usUnits = luaGetCheckpointData("Units", "USUnits")
	local nUnits = luaGetCheckpointData("Units", "NUnits")

	local allAirfields = luaSumTablesIndex(recon[PARTY_JAPANESE].own.airfield, recon[PARTY_ALLIED].own.airfield, recon[PARTY_NEUTRAL].own.airfield)
	local allLandforts = luaSumTablesIndex(recon[PARTY_JAPANESE].own.landfort, recon[PARTY_ALLIED].own.landfort, recon[PARTY_NEUTRAL].own.landfort)
	local allLandvehicle = luaSumTablesIndex(recon[PARTY_JAPANESE].own.landvehicle, recon[PARTY_ALLIED].own.landvehicle, recon[PARTY_NEUTRAL].own.landvehicle)
	local allShipyard = luaSumTablesIndex(recon[PARTY_JAPANESE].own.shipyard, recon[PARTY_ALLIED].own.shipyard, recon[PARTY_NEUTRAL].own.shipyard)

	for idx,unit in pairs(luaSumTablesIndex(allAirfields, allLandforts, allLandvehicle, allShipyard)) do

		if not unit.Dead then	--mi a picsae vannak benne Dead unitok??

			--if luaGetType(unit) ~= "ship" and luaGetType(unit) ~= "plane" and luaGetType(unit) ~= "sub" then

				local found = false
-- RELEASE_LOGOFF  				luaLog(unit.Name.." "..tostring(unit.Dead))

				for idx2,unitTbl in pairs(japUnits[1]) do
					unit2 = FindEntity(unitTbl[1])
					--if unit2 and not unit2.Dead and (luaGetType(unit2) == "vehicle" or luaGetType(unit2) == "landfort" or luaGetType(unit2) == "commandbuilding" or luaGetType(unit2) == "airfield" or luaGetType(unit2) == "shipyard" ) then
					if unit2 and not unit2.Dead and (luaGetType(unit2) ~= "ship" and luaGetType(unit2) ~= "plane" and luaGetType(unit2) ~= "sub") then
						if unit.Name == unit2.Name then
-- RELEASE_LOGOFF  							luaLog(Mission.ChckLogPrefix.."Landfort found in jap units checking party: "..unit.Name)
							if unit.Party ~= PARTY_JAPANESE then
								SetParty(unit, PARTY_JAPANESE)
-- RELEASE_LOGOFF  								luaLog(Mission.ChckLogPrefix.."Party doesnt match, setting it to japanese: "..unit.Name)
-- RELEASE_LOGOFF  								luaLog(Mission.ChckLogPrefix.."Party is now: "..unit.Party)
-- RELEASE_LOGOFF  								luaLog("\n")
							end
							found = true
							break
						end
					end
				end

				if not found then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Landfort not found in japanese saved data: "..unit.Name)
-- RELEASE_LOGOFF  					luaLog("\n")
				end

				if not found then --megnezzuk usaban
					for idx2,unitTbl in pairs(usUnits[1]) do
						unit2 = FindEntity(unitTbl[1])
						--if unit2 and not unit2.Dead and (luaGetType(unit2) == "vehicle" or luaGetType(unit2) == "landfort" or luaGetType(unit2) == "commandbuilding" or luaGetType(unit2) == "airfield" or luaGetType(unit2) == "shipyard" ) then
						if unit2 and not unit2.Dead and (luaGetType(unit2) ~= "ship" and luaGetType(unit2) ~= "plane" and luaGetType(unit2) ~= "sub") then
							if unit.Name == unit2.Name then
-- RELEASE_LOGOFF  								luaLog(Mission.ChckLogPrefix.."Landfort found in usn units checking party: "..unit.Name)
								if unit.Party ~= PARTY_ALLIED then
									SetParty(unit, PARTY_ALLIED)
-- RELEASE_LOGOFF  									luaLog(Mission.ChckLogPrefix.."Party is now: "..unit.Party)
-- RELEASE_LOGOFF  									luaLog(Mission.ChckLogPrefix.."Party doesnt match, setting it to allied: "..unit.Name)
-- RELEASE_LOGOFF  									luaLog("\n")
								end
								found = true
								break
							end
						end
					end
				end

				if not found then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Landfort not found in usn saved data: "..unit.Name)
-- RELEASE_LOGOFF  					luaLog("\n")
				end

				if not found then --megnezzuk neutralban
					for idx2,unitTbl in pairs(nUnits[1]) do
						unit2 = FindEntity(unitTbl[1])
						--if unit2 and not unit2.Dead and (luaGetType(unit2) == "vehicle" or luaGetType(unit2) == "landfort" or luaGetType(unit2) == "commandbuilding" or luaGetType(unit2) == "airfield" or luaGetType(unit2) == "shipyard" ) then
						if unit2 and not unit2.Dead and (luaGetType(unit2) ~= "ship" and luaGetType(unit2) ~= "plane" and luaGetType(unit2) ~= "sub") then
							if unit.Name == unit2.Name then
-- RELEASE_LOGOFF  								luaLog(Mission.ChckLogPrefix.."Landfort found in neutral units checking party: "..unit.Name)
								if unit.Party ~= PARTY_NEUTRAL then
									SetParty(unit, PARTY_NEUTRAL)
-- RELEASE_LOGOFF  									luaLog(Mission.ChckLogPrefix.."Party doesnt match, setting it to neutral: "..unit.Name)
-- RELEASE_LOGOFF  									luaLog(Mission.ChckLogPrefix.."Party is now: "..unit.Party)
-- RELEASE_LOGOFF  									luaLog("\n")
								end
								found = true
								break
							end
						end
					end
				end

				if not found then
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Landfort not found in neutral saved data: "..unit.Name)
-- RELEASE_LOGOFF  					luaLog("\n")
				end

				if not found then
					if luaGetType(unit) ~= "vehicle" then
						AddDamage(unit, 100000000)
					else
						Kill(unit, true)
					end
-- RELEASE_LOGOFF  					luaLog(Mission.ChckLogPrefix.."Landfort not found, killing: "..unit.Name)
-- RELEASE_LOGOFF  					luaLog("\n")
				end

			else
-- RELEASE_LOGOFF  				luaLog("Dead unit "..unit.Name)
-- RELEASE_LOGOFF  				luaLog("\n")
			end

		--end

	end
-- RELEASE_LOGOFF  	luaLog("\n")
end

function luaCheckSavedCheckpoint()
	Mission.SavedCheckpoint = LoadCheckpoint()
	if Mission.SavedCheckpoint then
-- RELEASE_LOGOFF  		luaLog("Checkpoint system: \tCheckpoint found, loading")
		luaLoadCheckpoint()
	else
-- RELEASE_LOGOFF  		luaLog("Checkpoint system: \tCheckpoint not found")
	end
end

--[[
function luaCheckCheckpointLoad()

	local filename = Mission.Name.."Checkpoint.lua"
	local chckpointfile = io.open(filename, "r")

	if chckpointfile then
-- RELEASE_LOGOFF  		luaLog("Checkpoint system: \tCheckpoint found, loading")
		io.close(chckpointfile)
		luaLoadCheckpoint()
	else
-- RELEASE_LOGOFF  		luaLog("Checkpoint system: \tCheckpoint not found")
	end
-- RELEASE_LOGOFF  	luaLog("\n")

	if Mission.SavedCheckpoint then
-- RELEASE_LOGOFF  		luaLog("Checkpoint system: \tCheckpoint found, loading")
		luaLoadCheckpoint()
	else
-- RELEASE_LOGOFF  		luaLog("Checkpoint system: \tCheckpoint not found")
	end
end
]]
------------------------------table DUMP FUNCTIONS--------------------------------------------------

function luaChkLog(logstr, newline)
	if newline == nil then
		file:write(logstr)
	else
		file:write(logstr, "\n")
	end
end

function luaChkIndent(level)
	local indent

	for i = 1, level do
		if indent == nil then
			indent = "\t"
		else
			indent = indent.."\t"
		end
	end

	if indent == nil then
		indent = ""
	end

	return indent
end

function luaChkSortTable(origTable)
	local sortedKeyTable = {}
	for key, value in pairs (origTable) do
		local place
		for index, origTableKey in pairs (sortedKeyTable) do
			if type(origTableKey) == "number" and type(key) == "number" then
				if origTableKey > key then
					place = index
					break
				end
			else
				if string.lower(tostring(origTableKey)) > string.lower(tostring(key)) then
					place = index
					break
				end
			end
		end
		if place then
			table.insert(sortedKeyTable, place, key)
		else
			table.insert(sortedKeyTable, key)
		end
	end
	return sortedKeyTable
end

function luaChkDumpSortedTable(origTable, actlevel)
	local sortedKeyTable = luaChkSortTable(origTable)
	for index, sortedKey in pairs (sortedKeyTable) do
		local value = origTable[sortedKey]
		local key = sortedKey
		if type(value) == "table" then
			if type(key) == "number" then
				luaChkLog(luaChkIndent(actlevel).."["..key.."] =", 1)
				luaChkLog(luaChkIndent(actlevel).."{", 1)
			else
				luaChkLog(luaChkIndent(actlevel).."[\""..key.."\"] =", 1)
				luaChkLog(luaChkIndent(actlevel).."{", 1)
			end
			luaChkDumpSortedTable(value, actlevel + 1)
			luaChkLog(luaChkIndent(actlevel).."},", 1)
		else
			if type(key) == "number" then
				luaChkLog(luaChkIndent(actlevel).."["..key.."] = ")
			else
				luaChkLog(luaChkIndent(actlevel).."[\""..key.."\"] = ")
			end

			if type(value) == "boolean" then
				luaChkLog(tostring(value))
			elseif type(value) == "number" then
				luaChkLog(value)
			--elseif type(value) == "function" then
				--luaLog(value)
			else
				luaChkLog(string.format("%q", value))
			end

			luaChkLog(",", 1)
		end
	end
end

--siraly es egyeb anim
function luaAddSeagulls()
	Mission.SeagullPos = {}
	Mission.SharkPos = {}

	local i = 1
	local gullsDone = false
	local sharksDone = false


	while true do
		local gullPoint = FindEntity("Siraly_"..tostring(i))
		local sharkPoint = FindEntity("Capa_"..tostring(i))

		if sharksDone and gullsDone then
			break
		end

		if not gullsDone then
			if gullPoint then
				table.insert(Mission.SeagullPos, GetPosition(gullPoint))
			else
				gullsDone = true
			end
		end

		if not sharksDone then
			if sharkPoint then
				table.insert(Mission.SharkPos, GetPosition(sharkPoint))
			else
				sharksDone = true
			end
		end

		i = i + 1
	end

	for idx,pos in pairs(Mission.SeagullPos) do
		TempAddAnim({
			["AnimClassName"] = "Siralyok",
			["Position"] = pos,
		})
	end
-- RELEASE_LOGOFF  	luaLog("Added "..tostring(idx).." seagull anims")
end

function luaShot(target, relative)

	Mission.CamShotTarget = target
	Mission.CamShotType = relative

	if not target then
		if IsListenerActive("input", "targetListener") then
			RemoveListener("input", "targetListener")
		else
			AddListener("input", "targetListener", {
				["callback"] = "luaCamShotTargetCB",  -- callback fuggveny
				["inputID"] = {IC_CHEAT_F11}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
				["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
			})
		end
	end

	if IsListenerActive("input", "shotListener") then
		RemoveListener("input", "shotListener")
	else

		AddListener("input", "shotListener", {
			["callback"] = "luaCamShotCB",  -- callback fuggveny
			["inputID"] = {IC_CHEAT_F12}, -- Inputs.lua-bol vett input ID. Nem lehet ures!
			["inputValue"] = {}, -- nem kell megadni, mert csak arra szolgal, hogy a callbacknek atadjon egy value parametert
		})
	end
end

function luaCamShotTargetCB()
	Mission.CamShotTarget = luaGetCamTargetEnt()
	MissionNarrativeUrgent("SHARPSHOOTER TARGET: "..GetGuiName(Mission.CamShotTarget))
end

function luaCamShotCB()
	local camType

	if not Mission.CamShotType then
		camType = "keepnone"
	else
		camType = "keepz"
	end

	if not Mission.CamShotTarget then
		Mission.CamShotTarget = GetSelectedUnit()
	else
		if Mission.CamShotTarget.Dead then
-- RELEASE_LOGOFF  			luaLog("SHOOTER: ERROR: Halott a target, ebbol meg baj lehet")
		else

			if not Mission.CamShotType then
				Mission.CamShotPos = GetCameraRelPosW(Mission.CamShotTarget)
			else
				Mission.CamShotPos = GetCameraRelPosL(Mission.CamShotTarget)
			end

			Mission.CamTargetPos = {
				["postype"] = "cameraandtarget",
				["position"] =
					{
						["pos"] = Mission.CamShotPos,
						["parent"] = Mission.CamShotTarget,
					},
				["transformtype"] = camType,
				["moveTime"] = 0,
			}

		end
	end

-- RELEASE_LOGOFF  	luaLog("---------------SHARPSHOOTER-------------")
-- RELEASE_LOGOFF  	luaLog("{[\"postype\"] = \"cameraandtarget\",[\"position\"] = {[\"pos\"] = {[\"x\"]="..tostring(Mission.CamShotPos.x)..",[\"y\"]="..tostring(Mission.CamShotPos.y)..",[\"z\"]="..tostring(Mission.CamShotPos.z).."},[\"parent\"] = FindEntity(\""..Mission.CamShotTarget.Name.."\"),},[\"moveTime\"] = 0,[\"transformtype\"] = \""..camType.."\",},")
-- RELEASE_LOGOFF  	luaLog("-----------SHARPSHOOTER END--------------")
end


