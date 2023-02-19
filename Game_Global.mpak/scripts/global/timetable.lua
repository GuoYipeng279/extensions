function luaDoTimeTable(this, timetable, paramTable)
	SETLOG(this, true)
	this.TimeTable={}
	this.TimeTable.Table = timetable
	this.TimeTable.Index=1
	this.ParamTable = paramTable
	SetThink(this, "luaTimetable")
-- RELEASE_LOGOFF  	Log("Given TimeTable: ", this.TimeTable.Table)
	--luaLog("-- -- Timetable called "..this.ID)
	luaTimetable(this, msg)
end

function luaTimetable(this, msg)

	if msg ~= nil or this.Dead then
		return
	end

	--luaLog("-- -- Timer "..this.ID.." is ongoing")
	--luaLog("-- -- Index: "..this.TimeTable.Index)
	
	local tt=this.TimeTable;
	local ttt=this.TimeTable.Table;

	if ttt[tt.Index] == nil then
		DeleteScript(this)
		return
	end

	--luaLog("-- -- Calling "..tostring(ttt[tt.Index][1]))
	if ttt[tt.Index][1] then
		ttt[tt.Index][1](this)
	end
	
	if this.Dead then	-- a callback terminalhatja magat a timert!
		return
	end
	
	if ttt[tt.Index][2] == 0 then
-- RELEASE_LOGOFF  --		luaLog("Is TIMER this available?")
-- RELEASE_LOGOFF  --		luaLog(this)
		DeleteScript(this)
		return
	end
	
	--luaLog("-- -- Waiting "..tostring(ttt[tt.Index][2]))
	SetWait(this, ttt[tt.Index][2])
	tt.Index = tt.Index+1
end
