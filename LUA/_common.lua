menuSwitchTracker = 0

function GetMenuGoldColor()
	return { 205/255, 149/255, 84/255, 1 }
end

function GetMenuWhiteColor()
	return { 229/255, 229/255, 229/255, 1 }
end

function GetMenuGrayColor()
	return { 120/255, 120/255, 120/255, 1 }
end

function GetSelectionColor()
	return GetMenuWhiteColor()
end

function GetMISCols()
	return {
		["Normal"] = GetMenuGoldColor(),
		["Focus"] = GetMenuGoldColor(),
		["Selected"] = GetMenuGoldColor(),
		["Disabled"] = GetMenuGrayColor(),
	}
end

function CreateStandardMenu(pos, extra, excludekeys, whitebased, wsalign)
	local menu = {
		["Pos"] = pos,
		["Pivot"] = { 0.5, 0.5 },
		["AutoControl"] = true,
		["CenterVertical"] = true,
		["LineDistance"] = 0.007,
		["HeightPlus"] = 0.005,
		["MainListbox_Text"] =
		{
--			["Size"] = { 0.256250, 0.037500 },
			["Size"] = { 0.75, 0.03 },
			["Pos"] = { 99, 0, -1 },
			["Pivot"] = { 0.5, 0.5 },
			["Color"] = { 0.501961, 0.501961, 0.368627, 0.900000 },
--			["Color"] = { 0.803922, 0.588235, 0.333333, 1.000000 },
			["Font"] = "Viper19",
			["Align"] = "Center",
			["VerticalAlign"] = "Center",
			["ShaderName"] = "GuiFontBilinear.mshd",
			["MouseHit"] = true,
			--workaround amig beizzitasra kerul az uj gui
			["MISColors"] = GetMISCols(),
			["DefaultShadow"] = 0,
			--["MISColors"] = GetMISCols(),
		},
	}

	if wsalign ~= nil then
		menu.WideScreenAlign = wsalign
	end
		
	if extra then
		for key, value in pairs(extra) do
			menu[key] = value
		end
	end
	if excludekeys then
		for key, value in pairs(excludekeys) do
			menu[value] = nil
		end
	end
	if whitebased then
		menu.MainListbox_Text.MISColors = GetMISCols()
		menu.MainListbox_Text.DefaultShadow = 0
	end
	return menu
end

function CreateStandardMenu2(pos, extra, excludekeys, whitebased, wsalign, textcentered, mainMenuSized)
	
	allignment = nil
	sizes = nil
	font = nil
	posDelta = nil
	local menu = nil
	
	if textcentered then
	
		allignment = "Center"
		
	elseif not textcentered then

		allignment = "Left"

	end
	
	if mainMenuSized then
		
		local posx = pos[1]
		local posy = pos[2]
		local stack = pos[3]
		
		sizes = { 0.75, 0.037500 }
		font = "ViperTitle"
		
		menu = {
			["Pos"] = { posx, posy, stack },
			["Pivot"] = { 0.0, 0.5 },
			["AutoControl"] = true,
			["CenterVertical"] = true,
			["LineDistance"] = 0.007,
			["HeightPlus"] = 0.005,
			["MainListbox_Text"] =
			{
				["Size"] = { 0.256250, 0.037500 },
				["Size"] = sizes,
				["Pos"] = { 0.0, 0.0, -1 },
				["Pivot"] = { 0.0, 0.5 },
				["Color"] = { 0.501961, 0.501961, 0.368627, 0.900000 },
				["Color"] = { 0.803922, 0.588235, 0.333333, 1.000000 },
				["Font"] = font,
				["Align"] = allignment,
				["VerticalAlign"] = "top",
				--["HorizontalAlign"] = "Center",
				["ShaderName"] = "GuiFontBilinear.mshd",
				["MouseHit"] = true,
				--["Multiline"] = false,
				--workaround amig beizzitasra kerul az uj gui
				["MISColors"] = GetMISCols(),
				["DefaultShadow"] = 0,
				--["MISColors"] = GetMISCols(),
			},
		}
		
	elseif not mainMenuSized then
	
		sizes = { 0.75, 0.03 }
		font = "Viper19"
		
		menu = {
			["Pos"] = pos,
			["Pivot"] = { 0.0, 0.5 },
			["AutoControl"] = true,
			["CenterVertical"] = true,
			["LineDistance"] = 0.007,
			["HeightPlus"] = 0.005,
			["MainListbox_Text"] =
			{
	--			["Size"] = { 0.256250, 0.037500 },
				["Size"] = sizes,
				["Pos"] = { 0.0, 0, -1 },
				["Pivot"] = { 0.0, 0.5 },
				["Color"] = { 0.501961, 0.501961, 0.368627, 0.900000 },
	--			["Color"] = { 0.803922, 0.588235, 0.333333, 1.000000 },
				["Font"] = font,
				["Align"] = allignment,
				["VerticalAlign"] = "Center",
				--["HorizontalAlign"] = "Center",
				["ShaderName"] = "GuiFontBilinear.mshd",
				["MouseHit"] = true,
				--workaround amig beizzitasra kerul az uj gui
				["MISColors"] = GetMISCols(),
				["DefaultShadow"] = 0,
				--["MISColors"] = GetMISCols(),
			},
		}
		
	end
	
	if wsalign ~= nil then
		menu.WideScreenAlign = wsalign
	end
	if extra then
		for key, value in pairs(extra) do
			menu[key] = value
		end
	end
	if excludekeys then
		for key, value in pairs(excludekeys) do
			menu[value] = nil
		end
	end
	if whitebased then
		menu.MainListbox_Text.MISColors = GetMISCols()
		menu.MainListbox_Text.DefaultShadow = 0
	end
	
	return menu
	
end

function CreateAchievementMenu(pos, extra, excludekeys, whitebased, wsalign)
	local menu = {
		["Pos"] = pos,
		["Pivot"] = { 0.0, 0.5 },
		["AutoControl"] = true,
		["LineDistance"] = 0.002,
		["HeightPlus"] = 0.005,
		["CenterVertical"] = true,
		["Item_Group"] = {
			["Pos"] = { 0.08, 0.000000, -509.000000 },
			["Size"] = { 0.25, 0.035 },
			["Pivot"] = { 0.000000, 0.500000 },
			["Visible"] = false,
			["geOrder"] = 2,
			--["Align"] = "Left",
			["MenuItem_Text"] = {
				["Pos"] = { 0.00, 0.00, -509.000000 },
				["Size"] = { 0.2475, 0.047222 },
				["Pivot"] = { 0.000000, 0.500000 },
				["Color"] = { 0.501961, 0.501961, 0.368627, 0.900000 },
				["Visible"] = false,
				["geOrder"] = 2,
				["MouseHit"] = true,
				["Multiline"] = false,
				["Font"] = "Viper19",
				["DefaultText"] = "WWWWWWWWWWWWWWWW",
				["Align"] = "Left",
				["ShaderName"] = "GuiFontBilinear.mshd",
				["VerticalAlign"] = "Center",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
		},
	}

	if wsalign ~= nil then
		menu.WideScreenAlign = wsalign
	end
		
	if extra then
		for key, value in pairs(extra) do
			menu[key] = value
		end
	end
	if excludekeys then
		for key, value in pairs(excludekeys) do
			menu[value] = nil
		end
	end
	if whitebased then
		menu.Item_Group.MISColors = GetMISCols()
		menu.Item_Group.DefaultShadow = 0
	end
	return menu
end

function CreateOOBMenu(pos, extra, excludekeys, whitebased, wsalign)
	local menu = {
		["Pos"] = pos,
		["Pivot"] = { 0.0, 0.5 },
		["AutoControl"] = true,
		["CenterVertical"] = true,
		["HeightPlus"] = 0.005,
		["Item_Group"] = {
			["Pos"] = { 0.08, 0.000000, -509.000000 },
			["Size"] = { 0.25, 0.032 },
			["Pivot"] = { 0.000000, 0.500000 },
			["Visible"] = false,
			["geOrder"] = 2,
			--["Align"] = "Left",
			["MenuItem_Text"] = {
				["Pos"] = { 0.00, 0.00, -509.000000 },
				["Size"] = { 0.185, 0.047222 },
				["Pivot"] = { 0.000000, 0.500000 },
				["Color"] = { 0.501961, 0.501961, 0.368627, 0.900000 },
				["Visible"] = false,
				["geOrder"] = 2,
				["MouseHit"] = true,
				["Multiline"] = false,
				["Font"] = "Arial18",
				["DefaultText"] = "WWWWWWWWWWWWWWWW",
				["Align"] = "Left",
				["VerticalAlign"] = "Center",
				["ShaderName"] = "GuiFontBilinear.mshd",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
			["NumUnits_Text"] = {
				["Pos"] = { 0.190, -0.005, -509.000000 },
				["Size"] = { 0.062500, 0.047222 },
				["Pivot"] = { 0.000000, 0.500000 },
				["Color"] = { 1.086275, 0.866667, 0.611765, 1.000000 },
				["Visible"] = false,
				["geOrder"] = 3,
				["MouseHit"] = true,
				--["Multiline"] = false,
				["Font"] = "Arial18",
				["DefaultText"] = "20000",
				["Align"] = "Right",
				["VerticalAlign"] = "Center",
				["MISColors"] = {
					["Normal"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Focus"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Selected"] = { 0.803922, 0.584314, 0.329412, 1.000000 },
					["Disabled"] = { 0.470588, 0.470588, 0.470588, 1.000000 },
				},
				["DefaultShadow"] = 0,
			},
		},
	}

	if wsalign ~= nil then
		menu.WideScreenAlign = wsalign
	end
		
	if extra then
		for key, value in pairs(extra) do
			menu[key] = value
		end
	end
	if excludekeys then
		for key, value in pairs(excludekeys) do
			menu[value] = nil
		end
	end
	if whitebased then
		menu.Item_Group.MISColors = GetMISCols()
		menu.Item_Group.DefaultShadow = 0
	end
	return menu
end
