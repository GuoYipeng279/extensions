-- Platform specifikus fv.

function Platform(_pc,_xenon)
	if PC then 
		return _pc
	elseif XENON then
		return _xenon
	else
-- RELEASE_LOGOFF  		Assert(false, "no platform defined")
	end
end

function PlatformCompatibility(_pc,_xenon)
	if XENON or X360COMP then
		return _xenon
	elseif PC then 
		return _pc
	else
-- RELEASE_LOGOFF  		Assert(false, "no platform defined")
	end
end

function PlatformPcxboxOnly(_pcxbox)
	if PC or XBOX then
		return _pcxbox
	end
end

function PlatformPs2xboxOnly(_ps2xbox)
	if PS2 or XBOX then
		return _ps2xbox
	end
end

function PlatformPcOnly(_pc)
	if PC then
		return _pc
	end
end
