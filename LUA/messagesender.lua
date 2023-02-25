function luaInitMessageSender(this)
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating MessageSender...")
	
	this.Arrivals = {}		-- adott unitok elertek-e a vegpontjukat
	this.ArrivalsDone = {}		-- azok a unitok, amik mar elertek a celt es arra varnak, hogy kitakaritsuk innen oket
	
	this.Diers = {}			-- doglesre varo unitok
	
	this.AmmoCheckers = {}		-- azok a unitok, amiknel az ammo valtozasait nezzuk
	
	this.DistanceCheckers = {}	-- adott tavolsag figyelesere tett unitok
	
	this.ReconCheckers = {}		-- adott reconstate bekovetkezesenek figyelesere tett unitok

	this.Exiters = {}		-- a kilepesre figyelo unitok listaja
	
	SetThink(this, "luaMessageSender_think")
end

function luaMessageSender_think(this, msg)
-- RELEASE_LOGOFF  	Log("Beware! MessageSender is thinkin' !")
	
	if luaMessageHandler (this, msg) == "killed" then
-- RELEASE_LOGOFF  		Log("MessageSender terminated!")
		return
	end

	------------------------------------------------------------------------------------------------------
	-- Arrivals ------------------------------------------------------
-- RELEASE_LOGOFF  	Log("Checking arrivals")
	local furtherArrivals = {}
-- RELEASE_LOGOFF  	luaLogElementNames(this.Arrivals, "\tArrivals: ")
	
	for key, arrival in pairs (this.Arrivals) do
		local furtherArrival = true
		
		for key2, done in pairs (this.ArrivalsDone) do
			if arrival.Name ~= done.Name then
-- RELEASE_LOGOFF  				Log(" - ", arrival.Name, " has not arrived yet...")
			else
				furtherArrival = false
-- RELEASE_LOGOFF  				Log(" - ", arrival.Name, " has arrived, removing!")
			end
		end
		
		if furtherArrival then
			table.insert(furtherArrivals, arrival)
		end
	end
	this.ArrivalsDone = {}
	this.Arrivals = furtherArrivals
	this.Arrivals = luaRemoveDeadsFromTable(this.Arrivals, "Dead arrival")
	--luaLogElementNames(this.Arrivals, "\tArrival2: ")
	
	for key, value in pairs (this.Arrivals) do
-- RELEASE_LOGOFF  		Log(" Arrival: ", value.Name)
		if luaGetType(value) == "plane" then
			local target = GetPrimaryTarget(value)
			if luaIsCoordinate(target) then
-- RELEASE_LOGOFF  				LogToFile("  TargetCoord: ", target)
			else
-- RELEASE_LOGOFF  				Log("  Target: ", target.Name)
			end

			if luaGetDistance(value, target) < 300 then
-- RELEASE_LOGOFF  				Log("  -> Arrival arrived at position!")
				table.insert(this.ArrivalsDone, value)			-- beillesztjuk a kilependok listajahoz
				value.MsgFunctions.Arrival.Function(value)					-- itt hivjuk meg a teljesuleskor hivando fuggvenyt, ha volt
			end
			-- phase, command check kene inkabb?
		elseif luaGetType(value) == "ship" or luaGetType(value) == "sub" then	-- ha subot el kell kuloniteni, majd meglesz
			if luaIsCoordinate(value.Navigator.Target) then
-- RELEASE_LOGOFF  				LogToFile("  Target: ", value.Navigator.Target)
			else
-- RELEASE_LOGOFF  				Log("  Target: ", value.Navigator.Target.Name)
			end
			
			if luaGetDistance(value, value.Navigator.Target) < 100 then
-- RELEASE_LOGOFF  				Log("  -> Arrival arrived at position!")
				table.insert(this.ArrivalsDone, value)			-- beillesztjuk a kilependok listajahoz
				value.MsgFunctions.Arrival.Function(value)					-- itt hivjuk meg a teljesuleskor hivando fuggvenyt, ha volt
			end
		elseif luaGetType(value) == "vehicle" then	-- todo! hol vizsgaljuk? majd lesz lekero fv.
-- RELEASE_LOGOFF  			Log("  -> Arrival arrived at position!")
			if value.Loops == 1 then	-- nagyon tmp megoldas
				table.insert(this.ArrivalsDone, value)			-- beillesztjuk a kilependok listajahoz
				value.MsgFunctions.Arrival.Function(value)					-- itt hivjuk meg a teljesuleskor hivando fuggvenyt, ha volt
			end
		end
	end
	
	
	---------------------------------------------------------------
	------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
	-- Diers ------------------------------------------------------
	
	local thoseAlive = {}
	for key, value in pairs(this.Diers) do
-- RELEASE_LOGOFF  		Log("Checking to-be-dead unit: ", value.Name, " (", value.Dead, ").")
		if value.Dead then
-- RELEASE_LOGOFF  			Log(" Gosh, it's dead!")
			value.MsgFunctions.Death.Function(value)
		else
-- RELEASE_LOGOFF  			Log(" It's alive yet")
			table.insert(thoseAlive, value)
		end
	end
	
	this.Diers = thoseAlive
	
	---------------------------------------------------------------
	------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
	-- Ammo checkers ------------------------------------------------------

-- RELEASE_LOGOFF  	Log("Checking ammo...")
	
	this.AmmoCheckers = luaRemoveDeadsFromTable(this.AmmoCheckers, "Dead during ammocheck")
	
	local ammoCheckers = {}
	for key, value in pairs(this.AmmoCheckers) do
-- RELEASE_LOGOFF  		Log("Checking ammo for unit ", value.Name, ". Ammo to check: ", value.MsgFunctions.AmmoCheck.AmmoToCheck)
		
		if luaGetType(value) == "plane" then	-- repuloknel
			value.ammo = GetProperty(value, "ammoType")
			if value.ammo == value.MsgFunctions.AmmoCheck.AmmoToCheck then
-- RELEASE_LOGOFF  				Log(" Ammo reached given state (", value.AmmoToCheck, ")")
				value.MsgFunctions.AmmoCheck.Function(value)
			else
				table.insert(ammoCheckers, value)
			end
		else	-- hajoknal es tajnal
			value.TorpedoStock = GetProperty(value, "TorpedoStock")
			if value.TorpedoStock == value.MsgFunctions.AmmoCheck.AmmoToCheck then
-- RELEASE_LOGOFF  				Log(" Ammo reached given state (", value.MsgFunctions.AmmoCheck.AmmoToCheck, ")")
				value.MsgFunctions.AmmoCheck.Function(value)
			else
				table.insert(ammoCheckers, value)
			end
		end
	end
	
	this.AmmoCheckers = ammoCheckers
	
	---------------------------------------------------------------
	------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
	-- Distance checkers ------------------------------------------------------
	
-- RELEASE_LOGOFF  	Log("Checking distances...")
	
-- RELEASE_LOGOFF  	luaLogElementNames(this.DistanceCheckers, "DistanceChecker")
	
	this.DistanceCheckers = luaRemoveDeadsFromTable(this.DistanceCheckers, "Dead distance-checker")
	local furtherDistCheckers = {}
	
	for key, unit in pairs(this.DistanceCheckers) do
-- RELEASE_LOGOFF  		Log(" Checking unit named ", unit.Name)
		
		if unit.MsgFunctions.DistanceCheck == nil then
-- RELEASE_LOGOFF  			Log("  doesn't have distance check, removing.")
			table.remove(this.DistanceCheckers, key)
			break
		end
		
		local furtherTargets = {}
		for distNum, execTable in pairs(unit.MsgFunctions.DistanceCheck) do
			if not luaIsCoordinate(execTable.Target) then
-- RELEASE_LOGOFF  				Log(" - target:", execTable.Target.Name)
			else
-- RELEASE_LOGOFF  				LogToFile(" - target coordinate: ", execTable.Target)
			end
			
			if not execTable.Target.Dead then
				local dist = luaGetDistance(unit, execTable.Target)
-- RELEASE_LOGOFF  				Log(" Check distance: ", execTable.Distance, ", current distance: ", dist)
				
				if dist < execTable.Distance then
-- RELEASE_LOGOFF  					Log("  -> Unit reached defined distance!")
					--SETLOG(this, true)
					execTable.Function(unit)	-- a teljesuleskor hivando fuggveny
					--SETLOG(this, false)
					--table.remove(unit.MsgFunctions.DistanceCheck, distNum)
				else
-- RELEASE_LOGOFF  					Log("  not finished yet.")
					table.insert(furtherTargets, execTable)
				end
			else
-- RELEASE_LOGOFF  				Log("  Target is dead, removing item...")
				--table.remove(unit.MsgFunctions.DistanceCheck, distNum)
			end
		end
		
		unit.MsgFunctions.DistanceCheck = furtherTargets
		--Log(" - further targets: ", unit.MsgFunctions.DistanceCheck)
		if next(unit.MsgFunctions.DistanceCheck) ~= nil then
-- RELEASE_LOGOFF  			Log("We need it further, inserting...")
			table.insert(furtherDistCheckers, unit)
		end
	end
	
	this.DistanceCheckers = furtherDistCheckers
	--luaLogElementNames(this.DistanceCheckers, "DistanceChecker end")	-- tmp
	
	---------------------------------------------------------------
	------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
	-- recon checkers ------------------------------------------------------
	
-- RELEASE_LOGOFF  	Log("Checking recon...")
	
	local furtherReconCheckers = {}
	
	this.ReconCheckers = luaRemoveDeadsFromTable(this.ReconCheckers, "Dead reconchecker ")

	for key, value in pairs(this.ReconCheckers) do
-- RELEASE_LOGOFF  		Log(" Checking reconstate on unit ", value.Name)
		if value.MsgFunctions.ReconCheck == nil then
-- RELEASE_LOGOFF  			Log("  doesn't have recon check, removing.")
			table.remove(this.ReconCheckers, key)
			break
		end

		if luaGetReconLevel(value, luaGetEnemyParty(value)) >= value.MsgFunctions.ReconCheck.ReconState then
-- RELEASE_LOGOFF  			Log(" -> reconstate reached!")
			--SETLOG(this, true)
			value.MsgFunctions.ReconCheck.Function(value)
			--SETLOG(this, false)
		else
-- RELEASE_LOGOFF  			Log(" not reached yet.")
			table.insert(furtherReconCheckers, value)
		end
	end
	
	this.ReconCheckers = furtherReconCheckers
	
	---------------------------------------------------------------
	------------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
	-- Exit checkers ------------------------------------------------------
	
	local furtherExiters = {}
-- RELEASE_LOGOFF  	Log("Checking Exiters...")
	for key, value in pairs(this.Exiters) do
-- RELEASE_LOGOFF  		Log(" on unit ", value.Name)
		if value.Dead and value.KillReason == "exitzone" then
-- RELEASE_LOGOFF  			Log(" -> Exit happened!!")
			value.MsgFunctions.ExitCheck.Function(value)
		else
-- RELEASE_LOGOFF  			Log("  not exited yet.")
			table.insert(furtherExiters, value)
		end
	end
	this.Exiters = luaRemoveDeadsFromTable(furtherExiters, "Dead exitchecker ")
end
