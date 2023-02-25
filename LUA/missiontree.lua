DoFile("scripts/datatables/MultiGlobals.lua")
function luaOverrideMultiLobbySettings(overrideTable)
	--overrideTabla formatuma meg kell egyezzen a MultiGlobals.lua MultiLobbySettings tabla szerkezetevel. Csak a MenuDIS parameter updatelodik!
	local uniqueMultiSettings
	if overrideTable == nil then
		return nil
	else
		if not type(overrideTable)=="table" then
			return nil
		else
			uniqueMultiSettings = {}
		end
	end

	for multiKey, multiValue in pairs (MultiLobbySettings) do
		uniqueMultiSettings[multiKey] = {}
		for paramKey, paramValue in pairs (multiValue) do
			uniqueMultiSettings[multiKey][paramKey] = {}
			local overrideUsed = false
			if overrideTable[multiKey] then
				if overrideTable[multiKey][paramKey] then
					if overrideTable[multiKey][paramKey].MenuDIS ~= nil then
						uniqueMultiSettings[multiKey][paramKey].MenuDIS = overrideTable[multiKey][paramKey].MenuDIS
						overrideUsed = true
					end
				end
			end
			if not overrideUsed and paramValue.MenuDIS ~= nil then
				uniqueMultiSettings[multiKey][paramKey].MenuDIS = paramValue.MenuDIS
			end
		end
	end

	return uniqueMultiSettings
end

---- SETTING GAMEMODE PARAMETERS -----

--DoFile("gamemode.lua") -- Getting the gamemode from "gamemode.lua"

local sceneFilePath
--local sceneFilePathTraining

--[[if GameMode == 1 then -- Realistic

	sceneFilePath = "universe/Scenes/realistic/missions/"
	sceneFilePathTraining = "universe/Scenes/realistic/"

else -- Arcade]]

	sceneFilePath = "universe/Scenes/missions/"
	--sceneFilePathTraining = "universe/Scenes/"

--end

---- MISSION TREES START ----

MissionTree = {}

---- SINGLEPLAYER CAMPAIGN MISSIONS ----

MissionTree["missionGroups"] =
{
	
	{ -- Challenge Missions
		["groupName"] = "Training grounds",
		["helpLine"] = "FE.main_cs_allycamp_help",
		["gratMsg"] = "FE.rewards_congratulations_uscampaign",
		["gratDate"] = { 1940, 09, 08 },
		["missions"] = {
			
			{ -- CHG01 Strike on the Monster
				["id"] = "CHG01",
				["name"] = "Strike on the Monster",
				["helpline"] = "CHALLENGE 01 - SHIP COMBAT\n\nTake control of the Japanese battleship Fuso and run a gauntlet of US Ships as you seek to escape to the open seas. The Yamashiro has been sent to assist you.",
				["sceneFile"] = sceneFilePath.."CHG/chg_1_monster.scn",
				["date"] = { 1942, 02, 28, },
				["Pos"] = { -0.2125, 0.674, 5.000000 },
				--["prerequisites"] = {},
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG01.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"You have a range advantage in the battleship. Use the binoculars and mount your artillery attack early.",
						"Try to avoid torpedoes as soon as you detect them. Reversing your engines might work, too.",
						"Defend the other battleship to maintain a considerable firepower advantage later.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG07 Crucial Cargo
				["id"] = "CHG07",
				["name"] = "Crucial Cargo",
				["helpline"] = "CHALLENGE 02 - UNDERSEA COMBAT\n\nAttack a Japanese merchant convoy with the USS Nautilus, latest addition to the US Submarine fleet. Plan your attack carefully.",
				["sceneFile"] = sceneFilePath.."CHG/chg_7_cargo.scn",
				["date"] = { 1942, 01, 12, },
				["Pos"] = { 0.385416, 0.778472, 5.000000 },
				--["prerequisites"] = { "CHG01" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG07.tga",
				["forcedDifficultyLevel"] = 2,
				["allied"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Use the sub's various depth levels to sneak around the enemy.",
						"You will not be able to fire torpedoes until you have identified the two crucial cargo ships.",
						"To identify a ship, you must first target it.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG02 Battle of the Java Sea
				["id"] = "CHG02",
				["name"] = "Battle of the Java Sea",
				["helpline"] = "CHALLENGE 03 - SHIP COMBAT\n\nCommand a Japanese cruiser division at the Battle of the Java Sea as you try to sink the US Flagship, USS Houston.",
				["sceneFile"] = sceneFilePath.."CHG/chg_2_java.scn",
				["date"] = { 1942, 03, 01, },
				["Pos"] = { -0.155208, 0.615278, 5.000000 },
				--["prerequisites"] = { "CHG07" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG02.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Exploit enemy ships' weaknesses by aiming for the magazines or engine rooms.",
						"Use your destroyers' torpedoes - launch fanned spreads of them against the enemy.",
						"Your cruiser has a tight firing arc, so try to remain broadsides to the enemy.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG05 Saving Tulagi
				["id"] = "CHG05",
				["name"] = "Saving Tulagi",
				["helpline"] = "CHALLENGE 04 - AIR COMBAT\n\nYou have command of the Japanese airfield on Tulagi as the Americans attack. The defence of the island is in your hands!",
				["sceneFile"] = sceneFilePath.."CHG/chg_5_tulagi.scn",
				["date"] = { 1942, 05, 04, },
				["Pos"] = { 0.5915, 0.675, 5.000000 },
				--["prerequisites"] = { "CHG02" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG05.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Keep all your fighters airborne, there is strength in numbers.",
						"Intercept the enemy strike planes before they unleash their deadly cargo.",
						"Attack the decks of the enemy transports to send them to the coral.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG08 Periscopes Threatening
				["id"] = "CHG08",
				["name"] = "Periscopes Threatening",
				["helpline"] = "CHALLENGE 05 - UNDERSEA COMBAT\n\nAttack the retreating Allied forces with a Japanese submarine. Prepare for heavy resistance from escorting destroyers.",
				["sceneFile"] = sceneFilePath.."CHG/chg_8_persicope.scn",
				["date"] = { 1942, 02, 17, },
				["Pos"] = { 0.059375, 0.229861, 5.000000 },
				--["prerequisites"] = { "CHG05" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG08.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Watch out for your periscope when you are near enemy ships. If you move below them with your periscope up, it will be snapped off!",
						"Aim carefully so you don't waste your torpedoes.",
						"Watch out for destroyers. They pose great danger to your sub, whether you're underwater or on the surface.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG03 Hunt for the Cruiser
				["id"] = "CHG03",
 				["name"] = "Hunt for the Cruiser",
 				["helpline"] = "CHALLENGE 06 - SHIP COMBAT\n\nSeek vengance upon the Japanese cruiser Nachi with three American destroyers. Rendezvouz with the seaplane to help you locate your target.",
 				["sceneFile"] = sceneFilePath.."CHG/chg_3_hunt.scn",
				["date"] = { 1942, 06, 11 },
				["Pos"] = { -0.1705, 0.5875, 5.000000 },
				--["prerequisites"] = { "CHG08" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG03.tga",
				["forcedDifficultyLevel"] = 2,
				["MovieName"] = "",
				["allied"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Find the US reconaissance plane! It can help you identify the enemy.", 
						"Use the repair screen wisely and often. It is essential when engaging with numerous enemies at the same time.",
						"Heavier ships may shrug off your artillery fire; try your torpedoes instead.", 
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"] = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG06 Attack on Force Z
				["id"] = "CHG06",
				["name"] = "Attack on Force Z",
				["helpline"] = "CHALLENGE 07 - PLANE COMBAT\n\nThe British have sent a battleship group, Force Z, to reinforce Singapore. Use Japanese land-based bombers to attack and sink the British ships!",
				["sceneFile"] = sceneFilePath.."CHG/chg_6_forcez.scn",
				["date"] = { 1941, 12, 10, },
				["Pos"] = { -0.235417, 0.465278, 5.000000 },
				--["prerequisites"] = { "CHG03" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG06.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Group your attack planes into a single strike force. They are more efficent this way.",
						"Watch out for AA fire.",
						"Use waypoints to launch your surprise attack from another direction.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG09 Coup de Grace
				["id"] = "CHG09",
				["name"] = "Coup de Grace",
				["helpline"] = "CHALLENGE 08 - UNDERSEA COMBAT\n\nWe have located the USS Enterprise in the Philippines, making preparations to sail to Midway. Command a submarine strike force to sink her, but beware - she is heavily defended!",
				["sceneFile"] = sceneFilePath.."CHG/chg_9_coup.scn",
				["date"] = { 1942, 05, 27, },
				["Pos"] = { -0.045833, 0.340972, 5.000000 },
				--["prerequisites"] = { "CHG06" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG09.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Time surfacing to replenish your sub's air supply carefully, so you're not vulnerable to enemy warships.",
						"Use stealth as long as you can. If you hear the sonar's ping, you are detected, so try diving to level 4 to break contact.",
						"Use your deck gun to hasten the enemy carrier's demise.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG04 Might of Yamato
				["id"] = "CHG04",
				["name"] = "Might of Yamato",
				["helpline"] = "CHALLENGE 09 - SHIP COMBAT\n\nIn the aftermath of Midway, take the helm of Admiral Yamamoto's flagship, the awesome Yamato. Take on the might of the US carrier forces with the power of the World's largest battleship.",
				["sceneFile"] = sceneFilePath.."CHG/chg_4_might.scn",
				["date"] = { 1942, 07, 19, },
				["Pos"] = { 0.774, -0.04, 5.000000 },
				--["prerequisites"] = { "CHG09" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG04.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Don't waste time, head straight for the enemy carriers!",
						"Use the repair screen to allocate crew to WATER pumping duties if you are holed by torpedoes.",
						"Customize your fleet's formation to better defend against incoming planes.",
						"Mission imported from Battlestatons: Midway. Good luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG11 Growling Tigers
				["id"] = "CHG11",
				["name"] = "Growling Tigers",
				["helpline"] = "CHALLENGE 10 - COMBINED COMBAT\n\nProtect the sacred Chinese landscape from the Japanese intrusion.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN12.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_15_tigers.scn",
				["date"] = { 1941, 07, 25, },
				["Pos"] = { -0.1, 0.0265, 5.000000 },
				--["prerequisites"] = { "CHG10" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/USN15.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN12",
					["primaryObjectives"] = {
						"Stop the Japanese onslaught!",
						"Protect the village!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Personally shoot down 50 enemy planes!",
					},
					["hiddenHints"] = {
						"50 is da key"
					},
					["hints"] = {
						"Don't fly too steep, or you shall stall your aicraft.",
						"Try to fly higher than the enemy aircraft, that will give you an advantange.",
						"Remain mindful of enemy bomber's rear and side gunners.",
						"Mission made by Team Wolfpack. Thank you for playing!",
					},
					["allunitsid"] = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- CHG10 Operation Ten-Go
				["id"] = "CHG10",
				["name"] = "Operation Ten-Go",
				["helpline"] = "CHALLENGE 11 - COMBINED COMBAT\n\nAs the war comes to a close, the Japanese send a last-ditch suicide attack on the US Invasion forces around Okinawa. Take part in the final battle of the single largest battleship built by man.",
				["sceneFile"] = sceneFilePath.."CHG/chg_10_tengo.scn",
				["date"] = { 1945, 04, 07, },
				["Pos"] = { 0.093125, -0.079027, 5.000000 },
				--["prerequisites"] = { "CHG04" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/CHG10.tga",
				["forcedDifficultyLevel"] = 2,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"",
					},
					["secondaryObjectives"] = {
						"",
					},
					["hiddenObjectives"] = {
						"",
					},
					["hiddenHints"] = {
						"",
					},
					["hints"] = {
						"Prepare for an extreme number of enemy attackers.",
						"After the air attacks, you will need to break through the US battleship blockade.",
						"Customize your fleet's formation to achieve better defensive capabilities.",
						"Best of luck!",
					},
					["allunitsid"]  = {},
					["allunitsnum"] = {},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			--[[{ -- Axis Sandbox
				["id"] = "AxisSandBox",
				["name"] = "Axis Sandbox",
				["helpline"] = "MISSION ## -\n\n",
				["background"] = "bruh",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "",
				["debriefingText"] = "bruh",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_sandbox.scn",
				["date"] = { 2021, 01, 01, },
				["Pos"] = { 0, 0, 5.000000 },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/placeholder.tga",
				["forcedDifficultyLevel"] = 1,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"bruh",
						"bruh",
						"bruh",
						"bruh",
					},
					["allunitsid"]  = {"322","328","159","57","59","67","70","73","93","167"}, -- Reppu, Ryusei, Judy, Zuiho, Yamato, Mogami, Fubuki, Type B, Betty
					["allunitsnum"] = {"99","99","99","1","1","1","1","1","1","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"322","328","159","57","59","67","70","73","93","167"},
				},
			},
			
			{ -- Allied Sandbox
				["id"] = "AlliedSandBox",
				["name"] = "Allied Sandbox",
				["helpline"] = "MISSION ## -\n\n",
				["background"] = "bruh",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "",
				["debriefingText"] = "bruh",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_sandbox.scn",
				["date"] = { 2021, 01, 01, },
				["Pos"] = { 0, 0, 5.000000 },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/placeholder.tga",
				["forcedDifficultyLevel"] = 1,
				["MovieName"] = "",
				["allied"] = {
					["briefingGuiLayer"] = "USN11",
					["primaryObjectives"] = {
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"bruh",
						"bruh",
						"bruh",
						"bruh",
					},
					["allunitsid"]  = {"102","113","108","298","7","19","17","23","31","116"}, -- Corsair, Avenger, Dauntless, Independence, South Dakota, Northampton, Fletcher, Narhwal, Flying Fortress
					["allunitsnum"] = {"99","99","99","1","1","1","1","1","1","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"102","113","108","298","7","19","17","23","31","116"},
				},
			},]]
			
		},
	},
	
	{ -- Kantai Kessen Campaign
		["groupName"] = "IJN campaign",
		["helpLine"] = "FE.main_cs_allycamp_help",
		["gratMsg"] = "FE.rewards_congratulations_uscampaign",
		["gratDate"] = { 1941, 12, 07 },
		["missions"] = {
			
			{ -- IJN01 Attack on Pearl Harbor
				["id"] = "IJN01",
				["name"] = "Attack on Pearl Harbor",
				["helpline"] = "MISSION 01 - AIR COMBAT\n\nDevastate the unprepared American ships in Pearl Harbor.",
				["background"] = "It has come to this;\n\nThe Imperial Japanese Navy faces the mightiest foe in the Pacific.\n\nThe lack of the Washington Naval Treaty (historically signed in 1923) allowed many of the great naval powers of the time to pursue their own respective and personal naval ambitions. Countries such as Imperial Japan or the United States were not limited anymore by the bounds of the treaty, and allowed them to produce and output many preculiar, interesting and downright ridicilous warship designs, that would have historically gotten scrapped by the limits of the treaty. Therefore, both Japan and the United States have expended navies comparatively to the historical timeline. Japan, however, sees America as a threat to it's national stability, as it is one of the only things standing between Japan and the rich oil reserves in Southeast Asia, alongside the United Kingdom. Therefore, Japan believes it can achieve a quick victory in a short war, by forcing the US to capitulate, and allow Japan to control the oil fields it requires in order to bolster it's ever-growing industry. And thus, the Japanese A7M, D4Y and B6N aircraft take off from their carriers, as the Battleship Row is preparing to leave the harbor for their Monday morning firing practice, alongside the carriers Enterprise and Lexington.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN01.bik",
				["debriefingText"] = "The Pearl Harbor attack was a one-sided massacre. The unprepared Americans stood no chance, losing all of their battleships and both of their carriers in port. Further serious damage was sustained, and Pearl Harbor was most definitely left in ruins.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_01_attack_on_pearl_harbor.scn",
				["date"] = { 1941, 12, 08, },
				["Pos"] = { 1.2375, 0.0915, 5.000000 },
				--["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN01.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/jp_intro.bik",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"Launch the first attack wave!",
						"Sink all the capital ships!",
					},
					["secondaryObjectives"] = {
						"Protect the midget submarines!",
						"Shoot down the enemy B-17s!",
					},
					["hiddenObjectives"] = {
						"Detonate the Arizona!",
						"Sink all enemy ships!",
						--"ijn01.obj_h2",							--nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"DETONATION!",
						"Dang that's a lot of ships am I right?",
						--"ijn01.obj_h2_hint",						--hint az 1-es hidden objektiva teljesitesehez
					},
	--				["loadingBackgrounds"] = {
	--					"fe/missions/IJN01.tga",
	--					"fe/missions/IJN02.tga",
	--					"fe/missions/IJN03.tga",
	--				},
					["hints"] = {
						"When dive bombing, don't dive too steeply or the bombs cannot be released.",
						"Don't release torpedoes from a high altitude or they will explode upon contact with water.",
						"Drop down throttle when turnfighting in order to achieve an advantage.",
						"Tora, Tora, Tora!",
					},
					["allunitsid"]  = {"271","52","53","322","159","163",},
					["allunitsnum"] = {"2","1","3","99","99","99",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- IJN02 Strike on Force Z
				["id"] = "IJN02",
				["name"] = "Strike on Force Z",
				["helpline"] = "MISSION 02 - COMBINED COMBAT\n\nDestroy the British invasion force and bring an end to the era of the dreadnought.",
				["background"] = "From the very early ages of colonization, the United Kingdom expressed great interest in the Southeast Asia region of the world. The city of Singapore was always a central hub for activities of the great kingdom, and it had been so for decades prior. However, with the outbreak of war between the United States and Japan, the United Kingdom found itself at high risk of losing it's Asiatic holdings to the ever-growing Japanese Empire. As a result, the UK sent it's most modern battlecruisers, named Force Z, alongside an invasion force to Kota Baru, a current invasion ground for the Japanese Army. They are expected to meet minimal resistance, but they Japanese do have a few tricks up their sleeves...",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN02.bik",
				["debriefingText"] = "Facing what appeared to be overwhelming odds at first, the Japanese used their air superiority assets alongside the few ships they had around to completely wipe out Force Z. They resumed their landings immediately, and Singapore fell a few days later, resulting in total Japanese control of the Indonesian islands.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_02_strike_on_force_z.scn",
				["date"] = { 1941, 12, 12, },
				["Pos"] = { -0.27, 0.465278, 5.000000 },
				--["prerequisites"] = { "IJN01" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN02.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN02",
					["primaryObjectives"] = {
						"Sink the Task Force!",
						"Save your transports!",
					},
					["secondaryObjectives"] = {
						"Don't lose any of your ships!", -- Briefingben nem megjeleno objectiva
					},
					["hiddenObjectives"] = {
						"Don't let any of your transports get hit!", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"Can't touch this!" --hint az 1-es hidden objektiva teljesitesehez
					},
	--				["loadingBackgrounds"] = {
	--					"fe/missions/IJN01.tga",
	--					"fe/missions/IJN02.tga",
	--					"fe/missions/IJN03.tga",
	--				},
					["hints"] = {
						"Level bombers, although slow and unmanouverable, can still pose a big menace to any capital ship.",
						"Don't release torpedoes from a high altitude or they will explode upon contact with water.",
						"Use your destroyers for mass torpedo attacks on enemy battleships.",
						"Beware of enemy air cover.",
					},
					["allunitsid"]  = {"167","166","327","152","268","274","290","77","70","75"},
					["allunitsnum"] = {"99","99","20","10","1","1","4","2","1","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"167","166","327","152","268","274","290","70","75"},
				},
			},
			
			{ -- IJN03 Empires Fall
				["id"] = "IJN03",
				["name"] = "Empires Fall",
				["helpline"] = "MISSION 03 - COMBINED OPERATION\n\nDestroy the remaining British forces and capture Ceylon.",
				["background"] = "Following the destruction of Force Z, the United Kingdom permanently retreated all their remaining forces from their Southeast Asian ports, and recuperated all their available forces in the area to Ceylon (today's Sri Lanka). The British Raj (today's India), aptly named the ''Jewel in the Crown'', was perhaps the most important British colony, and the last thing the UK wanted was to lose that to the Japanese. However, despite the relative large distance of Ceylon compared to other Pacific islands relative to the Japanese mainland, the Japanese deemed it appropriate to launch an invasion of Ceylon, in order to destroy the last remnants of the British resistance in the greater region. Destruction of the British forces here would ensure the UK's absence during the rest of the Pacific war, and would surely make things easier for Japane later down the line.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN03.bik",
				["debriefingText"] = "Having had their entire Ceylon fleet wiped out, the British could no longer offer meaningful naval resistance to the Imperial Japanese Navy. As a result, the Biritsh surrendered Ceylon to the Japanese, and ensure Japan's dominance of the northern Indian Ocean.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_03_emipres_fall.scn",
				["date"] = { 1941, 12, 23, },
				["Pos"] = { -0.6095, 0.395, 5.000000 },
				--["prerequisites"] = { "IJN02" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN03.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Capture all enemy bases in the area!",
					},
					["secondaryObjectives"] = {
						"Destroy the enemy radar station!", -- Briefingben nem megjeleno objectiva
					},
					["hiddenObjectives"] = {
						"Sink the hidden command ship!", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"So trees am I right??" --hint az 1-es hidden objektiva teljesitesehez
					},
	--				["loadingBackgrounds"] = {
	--					"fe/missions/IJN01.tga",
	--					"fe/missions/IJN02.tga",
	--					"fe/missions/IJN03.tga",
	--				},
					["hints"] = {
						"Enemy bases have airfields on them, it would be wise to prioritize those targets first.",
						"Intel reports a big enemy ship on the last island. Take care!",
						"Pay close attention to the surroundings of islands, you may find some interesting things lying around...",
						"Always mantain a few CAP squadrons over your fleet.",
					},
					["allunitsid"]  = {"150","163","159","61","57","293","14","224"},
					["allunitsnum"] = {"9","9","9","1","1","2","5","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"150","163","159","61","57","293","14"},
				},
			},
			
			{ -- IJN04 Cruiser Hunters
				["id"] = "IJN04",
				["name"] = "Cruiser Hunters",
				["helpline"] = "MISSION 04 - SHIP COMBAT\n\nDestroy the ABDACOM cruiser force with your battlecruisers.",
				["background"] = "Having heard of the UK's defeat at Kota Baru, the US Navy, having recovered from the initial shock of the Pearl Harbor attack, sent a large fast cruiser force to Ceylon in order to bolster the UK's defences and in order to delay the Japanese advance into their own holdings in the Pacific. However, having promptly learned of the UK's subsequent loss of Ceylon, the cruiser force was quickly turned around and dispatched to join the ABDACOM (Australian, British, Dutch and American Company). However, the upon the cruiser force approaching the Sunda Strait, they were spotted by a Japanese submarine, and their position was relayed to the Imperial headquarters. The Japanese, eager to destroy as many American ships as early as possible, didn't hesitate to send two of their most modern battlecruisers into the Sunda Strait to intercept and destroy the American force.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN03.bik",
				["debriefingText"] = "The ABDA forces were completely annihilated. Japan's use of the battlecruiser was spot on, and this defeat spelled an premature end to any joint and organized American-Australian-British-Dutch resistance.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_04_cruiser_hunters.scn",
				["date"] = { 1942, 01, 05, },
				["Pos"] = { -0.24, 0.6515, 5.000000 },
				--["prerequisites"] = { "IJN03" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN04.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN03",
					["primaryObjectives"] = {
						"Sink the ABDACOM cruisers!",
						"Destroy the enemy convoy!",
					},
					["secondaryObjectives"] = {
						"Don't lose any battleships!",
					},
					["hiddenObjectives"] = {
						"Sink all enemy ships in the area!",
					},
					["hiddenHints"] = {
						"ABDACOM more like ABDADONE"
					},
					["hints"] = {
						"Use torpedoes to cripple the larger cruisers.",
						"Don't engage a stronger enemy head-on, instead opt for a more sneaky approach.",
						"It would be wise to pick off the convoy escorts first before focusing your attack on the cargo ships.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"60","69","70","276","289"},
					["allunitsnum"] = {"2","1","2","1","1","1","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"60","69","70","276","289"},
				},
			},
			
			{ -- IJN05 Operation Narai
				["id"] = "IJN05",
				["name"] = "Operation Narai",
				["helpline"] = "MISSION 05 - COMBINED OPERATION\n\nBreak American resistance around the Philippines with your invasion fleet.",
				["background"] = "The Philippines had always been a huge thorn in the side of the Japanese High Command. Being in the smack dab middle of the Pacific, and standing right between Japan and Australia, it absolutely had to be conquered before Japan could seriously consider expanding it's Empire in a southern direction. Due to this simple observation, an invasion force was sent to the Philippines in order to break any American resistance in the area, and capture the large island chain.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN04.bik",
				["debriefingText"] = "The American resistance in the area was destroyed, and the most important islands captured. Japan demonstrated capabilites of using land-based air forces in order to support a naval invasion force, and this new experience would benefit the Japanese for battles to come.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_05_operation_narai.scn",
				["date"] = { 1942, 01, 27, },
				["Pos"] = { 0.0325, 0.336, 5.000000 },
				--["prerequisites"] = { "IJN04" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN05.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN05",
					["primaryObjectives"] = {
						"Crush all enemy forces in the area!",
					},
					["secondaryObjectives"] = {
						"Destroy all land installations!",
					},
					["hiddenObjectives"] = {
						"Take out the passing enemy command plane!",
						"The mission must last at least 15 minutes!",
					},
					["hiddenHints"] = {
						"So Skytrains am I right??",
						"Length matters.",
					},
					["hints"] = {
						"The archipelago of islands provides an ideal ambush ground for the enemy, move through the map wisely.",
						"The islands have airfields and shipyards on them, it would be wise to prioritize those targets first.",
						"Minimal resistance is expected, so your fleet is rather small.",
						"Turn broadside with your ships to maximize your AA power.",
					},
					["allunitsid"]  = {"327","328","324","175","60","69","70","275","289","77"},
					["allunitsnum"] = {"40","40","40","5","1","1","1","1","1","1","16",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"327","328","324","175","60","69","70","275","289"},
				},
			},
			
			{ -- IJN06 Taking Port Moresby
				["id"] = "IJN06",
				["name"] = "Taking Port Moresby",
				["helpline"] = "MISSION 06 - COMBINED OPERATION\n\nCrush the American and Australian forces and capture the port.",
				["background"] = "Port Moresby (in today's New Guinea) is Australia's last saving grace. It is the only major Allied port that stands between Japan and the Australian mainland, meaning the Allies had to do everything in their power in order to prevent a Japanese occupation of the port. Both the Australians and Americans sent warship forces to defend the port, however the Japanese gathered a very large invasion force, and are once again preparing the crush the Allied resistance that stands in the way of their occupatory objectives.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN05.bik",
				["debriefingText"] = "After the large naval battle, the Japanese managed to make their way into the Port and capture it, including the surrounding bases. The Australian and American forces were destroyed, and any remainging operational Australian vessels in the Pacific area had to be evacuated to Australia mainland. Australia will now no longer venture out of it's mainland ports with the few ships it has left.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_06_port_moresby.scn",
				["date"] = { 1942, 02, 15, },
				["Pos"] = { 0.395, 0.726389, 5.000000 },
				--["prerequisites"] = { "IJN04" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN06.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN05",
					["primaryObjectives"] = {
						"Capture the port!",
					},
					["secondaryObjectives"] = {
						"Secure the two secondary bases!",
					},
					["hiddenObjectives"] = {
						"Sink the attacking enemy submarine(s)!",
						"Don't lose any of your transports!",
					},
					["hiddenHints"] = {
						"''One hit, and we are going down. Avoid ze depth charges!''",
						"Those marines doe.",
					},
					["hints"] = {
						"The port entrance is heavily defended, a headlong charge would be foolish...",
						"It's important to shoot down enemy bomber squadrons as far away from your ships as possble.",
						"Never leave your transport ships exposed during a landing operation.",
						"Turn broadside with your ships to maximize your AA power.",
					},
					["allunitsid"]  = {"224","322","163","159","271","60","278","70","58","272"},
					["allunitsnum"] = {"4","40","40","40","1","1","1","2","2","2",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"322","163","159","271","60","278","70","58","272"},
				},
			},
			
			{ -- IJN21 Coral Sea Counterstrike
				["id"] = "IJN21",
				["name"] = "Coral Sea Counterstrike",
				["helpline"] = "MISSION 07 - COMBINED COMBAT\n\nDefeat the American counterstrike with your combined force.",
				["background"] = "The Americnas were always famous for their rather impressive intelligence and decoding abilities, and here it is of no exception. The Americans learned of a Japanese carrier force that would be transiting the Coral Sea in preparations of their Invasion of Guadalcanal. Eager to get revenge for their previous defeats and to inflict as much damage as possible on the Japanese, the Americans sent a carrier force to the Coral Sea, in order to destroy the Japanese force. Unbeknownst to the Americans, their force had been spotted earlier in the day by a Japanese recon plane, and the Japanese sent the largest submarine the world had yet seen to intercept and sink the American carriers.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN04.bik",
				["debriefingText"] = "The American attack was a total disaster, having lost their carriers to the I400, the Americans could not effectively protect the rest of their warships, and they were easy pickings for the Japanese carrier.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_21_coral_sea.scn",
				["date"] = { 1942, 03, 01, },
				["Pos"] = { 0.5, 0.785, 5.000000 },
				--["prerequisites"] = { "IJN06" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN21.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN06",
					["primaryObjectives"] = {
						"Find and sink all enemy carriers!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Don't lose any of your submarines!",
					},
					["hiddenHints"] = {
						"''Crash dive, crash dive!''",
					},
					["hints"] = {
						"Always keep an eye on the oxygen meter in the bottom right corner.",
						"You can observe the possible depth levels of your submarine next to your movement controls.",
						"Always make sure to surface your submarine far away from enemy ships.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"322","163","159","8","52","279","270","14"},
					["allunitsnum"] = {"20","20","20","1","1","1","1","2",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"322","163","159","8","52","279","270","14"},
				},
			},
			
			{ -- IJN07 Battle of Midway
				["id"] = "IJN07",
				["name"] = "Battle of Midway",
				["helpline"] = "MISSION 08 - COMBINED OPERATION\n\nConquer the most important atoll in the Pacific Ocean and destroy the American carriers.",
				["background"] = "The largest invasion fleet ever assembled so far is approaching Midway now, as the Japanese are planning to expand their territories once again. This time, the target is far more important than anything before; the island of Midway is perhaps the most strategically important atoll in the entire Pacific Ocean. As the name suggests, it sits exactly halfway between the two nations' mainlands. Whoever exerts effective control over Midway, can dictate the course of the war. Both sides, having realized this very early on in the war, are sending their respective task forces to Midway, and the largest carrier battle of the war so far is about to begin.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN07.bik",
				["debriefingText"] = "Despite the Americans having learned of the Japanese attack, their forces at Midway were not enough to stop the Japanese war machine. With the assistance of the Yamato, the island's defences were cleared, and the surrounding American warships all either destroyed or routed.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_07_battle_of_midway.scn",
				["date"] = { 1942, 05, 27, },
				["Pos"] = { 0.908333, -0.043056, 5.000000 },
				--["prerequisites"] = { "IJN21" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN07.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN07",
					["primaryObjectives"] = {
						"Capture Midway island!",
					},
					["secondaryObjectives"] = {
						"Shoot down 50 enemy planes!",
					},
					["hiddenObjectives"] = {
						"Destroy the airfield fuel tanks!",
						"Sink all enemy ships in the area!",
					},
					["hiddenHints"] = {
						"I like oil.",
						"That's a lot of ships doe, don't you think?",
					},
					["hints"] = {
						"Make sure to attack the enemy bomber squadrons as far away from your ships as possible.",
						"Always keep an eye out for enemy reinforcements.",
						"Always keep a few CAP squadrons over your fleet.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"322","328","159","291","278","59","273","224"},
					["allunitsnum"] = {"99","99","99","3","2","1","4","6",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"322","328","159","291","278","59","273"},
				},
			},
			
			{ -- IJN08 Strike on the Aleutians
				["id"] = "IJN08",
				["name"] = "Strike on the Aleutians",
				["helpline"] = "MISSION 09 - COMBINED OPERATION\n\nDefeat the American forces amongst the frozen peaks of the Aleutians.",
				["background"] = "The Aleutian Islands are the northernmost islands of the Pacific. Having usually very cold and frigid environment conditions, they were never seen of much importance to either side before the war, but, as we all come to realize, war changes things. The Aleutians would provide an ideal flanking ground for the Japanese Navy, as it would give them bases in the northern Pacific Ocean, which could be used to deter any American counterattacks to the Japanese mainland. The Japanese have sent a wave of G4M heavy bombers in order to neutralize the island's largest defences, to make it easier for the invasion fleet that follows to capture the island chain.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN07.bik",
				["debriefingText"] = "Despite very hostile environmental conditions, the Japanese prevailed over the American garisson around the islands. Japan had just ensured it's dominance over the northern Pacific Ocean, and the US Navy retreated all it's available assets from the Aleutians.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_08_aleutians.scn",
				["date"] = { 1942, 06, 06, },
				["Pos"] = { 0.94, -0.525, 5.000000 },
				--["prerequisites"] = { "IJN07" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN08.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Escort the bomber wing to the target!",
					},
					["secondaryObjectives"] = {
						"Don't lose half the bomber wing!",
					},
					["hiddenObjectives"] = {
						"The mission must not last longer than 30 minutes!",
					},
					["hiddenHints"] = {
						"Length doesn't matter.",
					},
					["hints"] = {
						"Use your side and rear gunners when piloting a bomber to fend off any attacking aircraft.",
						"Never leave your troop transports exposed during a landing operation.",
						"Always send your attack planes in groups.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"326","163","159","300","304","270","67","276","224"}, -- N1K2, B6N, D4Y, Ryujo, Fuso, Ise, Zao, Mogami, Kagero, Troop Transport
					["allunitsnum"] = {"20","20","20","1","1","1","1","3","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"326","163","159","300","304","270","67","276"},
				},
			},
			
			{ -- IJN09 Seizing Guadalcanal
				["id"] = "IJN09",
				["name"] = "Seizing Guadalcanal",
				["helpline"] = "MISSION 10 - COMBINED OPERATION\n\nOverwhelm the American defenses on the large island on Guadalcanal.",
				["background"] = "Guadalcanal is one of the most strategically important islands in the South Pacific. It is the easternmost island in the entire Solomons to have a large enough airfield to support many squadrons of aircraft, and it is situated right between American holdings in the South Pacific and the Australian mainland. Having control of this island would mean that Japan would be able to easily send their land-based aircraft to support any invasion of either Australia or any other island in the South Pacific, and therefore it is absolutely crucial for Japan to have control over Guadalcanal.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN08.bik",
				["debriefingText"] = "Once again, the Japanese managed to overwhelm the American resistance in the area. Despite the American counterattack with LSTs, it was not enough to dismantle the powerful IJN fleet, and Guadalcanal was promptly added to Japan's ever-growing list of bases it controls. Now Japan has reach over the Australian mainland and the rest of the Allied holdings in the Pacific.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_09_guadalcanal.scn",
				["date"] = { 1942, 08, 14, },
				["Pos"] = { 0.592, 0.72125, 5.000000 },
				--["prerequisites"] = { "IJN08" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN09.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN06",
					["primaryObjectives"] = {
						"Sink the enemy convoy!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Ensure the survival of LST N. 46!",
					},
					["hiddenHints"] = {
						"(69 * 2) / 3"
					},
					["hints"] = {
						"It takes 2 torpedo hits to sink a cargo ship.",
						"Never leave your troop transports exposed during a landing operation.",
						"Use your LSTs as invasion breacheads to break through enemy defenses.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"93","322","328","159","52","286","305","58","224","91"}, -- Type B, Reppu, Ryusei, Judy, Hiryu, Harima, Miya, Shimakaze, Troop Transport, LST
					["allunitsnum"] = {"1","30","30","30","1","1","2","5","2","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"93","322","328","159","52","286","305","58"},
				},
			},
			
			{ -- IJN10 Attack on the Solomons
				["id"] = "IJN10",
				["name"] = "Attack on the Solomons",
				["helpline"] = "MISSION 11 - COMBINED COMBAT\n\nFollow and destroy the remnants of the fleeing American forces.",
				["background"] = "Following the Japanese seizure of Guadalcanal, the remaining American forces in the area started running directly east. The Japanese, having some cruisers in the area, decided to follow the small fleeing American pickett force, deep into the eastern Solomon Islands...",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN09.bik",
				["debriefingText"] = "The American ambush was a total surprise to the Japanese, and they only barely managed to scrounge up a hastly-organized carrier force. With the attack repelled, and the their forces destroyed, the Americans now permanently withdrew from the Solomon islands.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_10_solomons.scn",
				["date"] = { 1942, 10, 26, },
				["Pos"] = { 0.615, 0.7315, 5.000000 },
				--["prerequisites"] = { "IJN09" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN10.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN09",
					["primaryObjectives"] = {
						"Scout out the area for enemy activity!",
					},
					["secondaryObjectives"] = {
						"Shoot down 30 enemy aircraft!",
					},
					["hiddenObjectives"] = {
						"Ensure the survival of the destroyer Arashi!",
					},
					["hiddenHints"] = {
						".- .-. .- ... .... .."
					},
					["hints"] = {
						"Use your binoculars to spot further targets.",
						"Don't let yourself get swarmed by multiple enemy destroyers.",
						"Don't engage a stronger enemy head-on, instead opt for a more sneaky approach.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"69","71","70","276","322","328","159","291","284","277"}, -- Takao, Agano, Kuma, Kagero, Reppu, Ryusei, Judy, Hakuryu, Izumo, Azuma, Harugumo
					["allunitsnum"] = {"1","1","1","1","30","30","30","1","1","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"69","71","70","276","322","328","159","291","284","277"},
				},
			},
			
			{ -- IJN11 Invasion of New Caledonia
				["id"] = "IJN11",
				["name"] = "Invasion of New Caledonia",
				["helpline"] = "MISSION 12 - COMBINED OPERATION\n\nInvade the heavily-fortified island of New Caledonia.",
				["background"] = "The last connection that the United States had with Australia was through the Fijian islands, a group of islands located directly east of the Australian mainland. Severing this connection would allow the Japanese to completely isolate and cut Australia off from the rest of the world, which Japan hoped would force Australia into surrendering. However, before they could even consider invading the Fijis, the heavily-fortified island of New Caledonia, which stood right between Japan's holdings in the Solomons and the Fijis, had to be taken in order for Japan to have a forward base close enough to the Fijian islands.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN07.bik",
				["debriefingText"] = "While offering hard resistance, the Americans did not possess enough firepower in order to deter the Japanese advance. It was another Japanese victory, however, it is becoming clear to the Japanese that the Americans are slowly learning from their mistakes, and with every subsequent invasion they are using more and more of their available resources. The supply lines are getting longer and longer, and the Japanese officials are unsure of how much longer the IJN could handle this kind of war. Regardless, New Caledonia was captured and the Fijis were now in range of the Japanese naval forces.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_11_caledonia.scn",
				["date"] = { 1942, 12, 11, },
				["Pos"] = { 0.6575, 0.942, 5.000000 },
				--["prerequisites"] = { "IJN10" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN11.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Capture all enemy bases in the area!",
					},
					["secondaryObjectives"] = {
						"bruh",
					},
					["hiddenObjectives"] = {
						"Find and shoot down Admiral Halseys plane!",
					},
					["hiddenHints"] = {
						"''I never trust a fighting man who doesnt smoke or drink.''"
					},
					["hints"] = {
						"Never leave your troop transports exposed during a landing operation.",
						"Use your LSTs as invasion breacheads to break through enemy defenses.",
						"It's important to shoot down enemy bomber squadrons as far away from your ships as possble.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"322","328","163","159","53","59","69","289","224"}, -- Reppu, Ryusei, Jill, Judy, Soryu, Zuiho, Yamato, Takao, Myoko, Shiratsuyu, Troop Transport, LST
					["allunitsnum"] = {"50","30","20","50","1","1","2","2","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"322","328","163","159","53","59","69","289"},
				},
			},
			
			{ -- IJN12 Raid on Sydney
				["id"] = "IJN12",
				["name"] = "Raid on Sydney",
				["helpline"] = "MISSION 13 - COMBINED COMBAT\n\nMount a night raid on the Australian harbor of Sydney.",
				["background"] = "With the recent seizure of the island of New Caledonia, the Australians were now truly aware of how dangerous the situation is. The Japanese anticipated that observation on the part of the Australians, and decided to conduct a pre-emptive strike on the Australian mainland, in order to discourage the remnants of the Royal Australian Navy from doing anything to stop Japan's invasion of the Fijis. In order to avoid comitting any of their own warships for a strike so deep into the enemy's mainland, the Japanese decided to take over the remaining Australian cruisers in the Port of Sydney, and use them to destroy as many ships possible in the port. However, the Australians do have one trick up their sleeve they have not yet used...",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN10.bik",
				["debriefingText"] = "The Raid was a huge success, and all auxiliary supply ships in Sydney harbor were destroyed. The Australians were now well and truly disarmed, their entire navy being destroyed. There was nothing else they could do, but hope for the Americans to defeat the IJN.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_12_sidney.scn",
				["date"] = { 1943, 02, 01, },
				["Pos"] = { 0.456250, 1.232638, 5.000000 },
				--["prerequisites"] = { "IJN11" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN12.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN10",
					["primaryObjectives"] = {
						"Capture the two enemy cruisers!",
					},
					["secondaryObjectives"] = {
						"Sink the enemy rocket ships!",
					},
					["hiddenObjectives"] = {
						"Capture the hidden Radar Station!",
					},
					["hiddenHints"] = {
						"Sekrit Dokuments"
					},
					["hints"] = {
						"Use your side and rear gunners when piloting a bomber to strafe enemy patrol boats.",
						"It takes 2 torpedoes to sink a destroyer.",
						"It would be wise to destroy as many ships as possible during the first phase of the attack.",
						"Use the seaplane carriers to launch air support for your forces.",
					},
					["allunitsid"]  = {"175","333","77","90"}, -- Emily, Rufe, PT, Daihatsu, Ise, Tone
					["allunitsnum"] = {"6","6","99","99","1","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"175","333"},
				},
			},
			
			{ -- IJN22 Invading Tarawa
				["id"] = "IJN22",
				["name"] = "Invading Tarawa",
				["helpline"] = "MISSION 14 - COMBINED OPERATION\n\nStorm the beaches of one of the most well-fortified islands in the entire Pacific.",
				["background"] = "Betio island, Tarawa atoll. Another one of the most crucial islands in the South Pacific, as is the only island of the entire Tarawa atoll to have an airfield, meaning it would serve as an ideal central base for any Japanese operations closer to the US mainland and Hawaii. Once again the Japanese are preparing for a large invasion operation, and sending their best available ships in order to soften the island's defences. However, unbeknownst to the Japanese, the Americans are aware of this attack thanks to their highly-capable intelligence department, and are preparing a surprise for the Japanese...",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN11.bik",
				["debriefingText"] = "For once, the Americans managed to score a small victory. The loss of the Musashi was a huge blow to the IJN, and it signified that the US Navy was still a force to be reckoned with. Regardless of that fact, however, the island of Betio was captured, meaning Japan has yet another naval base they could use at their disposal.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_22_new_zealand.scn",
				["date"] = { 1943, 03, 04, },
				["Pos"] = { 0.792, 0.492, 5.000000 },
				--["prerequisites"] = { "IJN11" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN22.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Capture Tarawa HQ!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Sink both enemy escort carriers!",
					},
					["hiddenHints"] = {
						"CVEs more like CVDs"
					},
					["hints"] = {
						"Never leave your troop transports exposed during a landing operation.",
						"Always ensure to leave a few CAP dedicated squadrons over your fleet.",
						"Use your LSTs as invasion breacheads when conducting a landing operation.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"322","328","324","59","287","67","70","224"}, -- Reppu, Ryusei, Tenrai, Yamato, Hizen, Zuikaku, Mogami, Kuma, Shimakaze, Minekaze, Troop Transport
					["allunitsnum"] = {"99","99","99","1","1","1","1","2","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"322","328","324","59","287","257","67","70"},
				},
			},
			
			{ -- IJN13 Meet the Germans
				["id"] = "IJN13",
				["name"] = "Meet the Germans",
				["helpline"] = "MISSION 15 - UNDERSEA COMBAT\n\nFind and rendezvous with the German submarine and excange crucial war plans.",
				["background"] = "Although the relationship between Germany and Japan had not exactly been the best at times during the war, they were regardless still allies, and the rest of the world saw them as so. Having an ally with a very competent research department brings you a lot of benefits, Japan and Germany were both no strangers to that. Since both nations were currently engaged in a war meant that they were both developing new technologies, however due to the sheer distance between the two natiuons, and due to the Allied nations that sat in bewteen them, they could not effectively share their technologies, and work together for developing them. That is why it is crucial for Japan to try to excange vital blueprints and plans for advanced technologies they could use in the war, and as a result, they sent the submarine I-111 to the South Atlantic in a sneak-mission to RV with a German submarine, and excange the crucial plans to the war effort.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN12.bik",
				["debriefingText"] = "The meeting went less than ideal, since the Hornet's Task Force happened to be in the area unbeknownst to both the Japanese and Germans. Regardless, the American force was destroyed, and both the war blueprints and pleasantries were successfully exchanged between the two submarines.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_13_germans.scn",
				["date"] = { 1943, 06, 18, },
				["Pos"] = { 1.705208, 0.856945, 5.000000 },
				--["prerequisites"] = { "IJN22" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN13.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN12",
					["primaryObjectives"] = {
						"Locate and RV with the German submarine in time!",
						"Excange the crucial blueprints!",
					},
					["secondaryObjectives"] = {
						"Don't lose any battleships!",
					},
					["hiddenObjectives"] = {
						"Sink all enemy ships in the area!",
					},
					["hiddenHints"] = {
						"Dang that's gonna be a hard one!"
					},
					["hints"] = {
						"It takes 2 torpedoes to sink a destroyer or a cargo ship.",
						"Diving to crash depth level will slowly harm your submarines hull.",
						"Always keep an eye on the oxygen meter.",
						"Make good use of both submarines available to you.",
					},
					["allunitsid"]  = {"93","193"}, 
					["allunitsnum"] = {"1","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- IJN14 Strike on the Panama Canal
				["id"] = "IJN14",
				["name"] = "Strike on the Panama Canal",
				["helpline"] = "MISSION 16 - UNDERSEA OPERATION\n\nStrike at vital supplies in the crucial Panama Canal.",
				["background"] = "The Panama canal is the US's most important waterway. It connects the Atlantic to the Pacific ocean, and allows the US to quickly move any ship bewteen the two oceans by simply sailing through the canal. It is the cornerstone to the US's naval strategy, and Japan was well aware of that. Henceforth, they sent a submarine force composed of several large I400 class submarines, configured to carry Midget Submarines and many seaplanes, in order to mount a raid on the canal port, and cause as much destruction as possible.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN10.bik",
				["debriefingText"] = "The raid was a success, the Americans lost all their supplies currently stationed in the Panama Canal, and it definitively showed the US that Japan truly does have the capability to strike anywhere with submarine forces.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_14_panama.scn",
				["date"] = { 1943, 07, 03, },
				["Pos"] = { 2.447, 0.342, 5.000000 },
				--["prerequisites"] = { "IJN22" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN14.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN10",
					["primaryObjectives"] = {
						"Find and sink the enemy radar ship!",
					},
					["secondaryObjectives"] = {
						"Ensure the survival of your midget submarine!",
					},
					["hiddenObjectives"] = {
						"Destroy all enemy factories!",
					},
					["hiddenHints"] = {
						"Factorio",
					},
					["hints"] = {
						"Midget submarines, although very agile, have comparatively low oxygen reserves.",
						"It takes 2 torpedoes to sink a cargo ship.",
						"Group your attacking seaplanes for maximum efficeny.",
						"Try to fly low in order to avoid AA fire.",
					},
					["allunitsid"]  = {"83","333","172","8"},
					["allunitsnum"] = {"1","30","15","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"333","172"},
				},
			},
			
			{ -- IJN15 Ambushed at Betio
				["id"] = "IJN15",
				["name"] = "Ambushed at Betio",
				["helpline"] = "MISSION 17 - COMBINED COMBAT\n\nRun your daily patrols on the recently-captured Betio island.",
				["background"] = "In response to the terrifying pace at which the Japanese were mauling through the Pacific, the US navy devised a counter-attack plan in hopes of finally stopping the Japanese advance. The plan, codenamed ''Operation Thunder'', called for a two-pronged simultaneous same-day attack on two of the most important Japanese holdings in the central Pacific: Midway and Betio.\n\nAs the sun rises on the sandy beaches of Betio island, all that the sparse Betio garrison is expecting today is an inbound Japanese convoy carrying building supplies for the repair work after the first invasion. Nobody is expecting what is to follow...",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN07.bik",
				["debriefingText"] = "The American ambush was a total failure, and, facing overwhelming odds, the Japanese garrison at Betio managed to repell a force multiple their number. It was a heroic effort, and an utter embarassment to the US Navy.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_15_marshalls_ambush.scn",
				["date"] = { 1943, 09, 09, },
				["Pos"] = { 0.799, 0.499, 5.000000 },
				--["prerequisites"] = { "IJN13" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN15.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN09",
					["primaryObjectives"] = {
						"Locate the inbound friendly convoy!",
					},
					["secondaryObjectives"] = {
						"Ensure the survival of all ships in the convoy!",
					},
					["hiddenObjectives"] = {
						"Sink the enemy aircraft carriers!",
					},
					["hiddenHints"] = {
						"Make justice to Taffy 3!"
					},
					["hints"] = {
						"Use torpedoes to cripple the larger capital ships.",
						"Don't engage a stronger enemy head-on, instead opt for a more sneaky approach.",
						"Make the best use of all airplanes you have available.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"151","159","391","87","85"},
					["allunitsnum"] = {"9","9","1","2","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"151","159"},
				},
			},
			
			{ -- IJN16 Defense of Midway
				["id"] = "IJN16",
				["name"] = "Defense of Midway",
				["helpline"] = "MISSION 18 - COMBINED COMBAT\n\nRepel the American invasion on the vital Midway Island.",
				["background"] = "In response to the terrifying pace at which the Japanese were mauling through the Pacific, the US navy devised a counter-attack plan in hopes of finally stopping the Japanese advance. The plan, codenamed ''Operation Thunder'', called for a two-pronged simultaneous same-day attack on two of the most important Japanese holdings in the central Pacific: Midway and Betio.\n\nThe American fleet assembled to attack Midway was far larger than the Betio force, as more resistance was expected from the Japanese. The Japanese have in fact anticipated such an attack, as they had been gathering the invasion force for their planned Invasion of Hawaii at Midway, as it's the closest base they have to Hawaii, and are prepared for the American attack.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN07.bik",
				["debriefingText"] = "The Japanese managed to systematically take apart the American fleet, which came at them from multiple sides. Being more aware of the attack compared to the Betio garisson, they were able to somewhat prepare, and overpower the American formations. Operation Thunder was therefore a complete failure, and the US was once again back on the defensive.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_16_defense_midway.scn",
				["date"] = { 1943, 09, 09, },
				["Pos"] = { 0.91, -0.03, 5.000000 },
				--["prerequisites"] = { "IJN15" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN16.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN07",
					["primaryObjectives"] = {
						"Defend Midway island!",
					},
					["secondaryObjectives"] = {
						"Ensure the survival of at least half of your transport ships!",
					},
					["hiddenObjectives"] = {
						"Sink all enemy ships in the area!",
					},
					["hiddenHints"] = {
						"Dang, this is gonna be a massacre...",
					},
					["hints"] = {
						"Make sure to attack the enemy bomber squadrons as far away from your ships as possible.",
						"Always keep an eye out for enemy reinforcements.",
						"Always keep a few CAP squadrons over your ships.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"334","326","328","167","52","254","68","272","290","224"},
					["allunitsnum"] = {"40","40","40","20","1","1","1","4","2","4"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"334","326","328","167","52","254","68","272","290"},
				},
			},
			
			{ -- IJN17 Taking the Fijis
				["id"] = "IJN17",
				["name"] = "Taking the Fijis",
				["helpline"] = "MISSION 19 - COMBINED OPERATION\n\nSeize the last Allied stronghold in the South Pacific.",
				["background"] = "Due to the recent American counter-attacks, the Invasion of the Fijis had to be delayed, and Australia was bought some extra time by the Americans. However, the time has come for the last Allied stronghold in the South Pacific to fall. The Americans are aware of the imporance of the Fijis, and have sent several large cruiser forces in advance to bolster the defense of the islands. They will not give it up without a fight.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN11.bik",
				["debriefingText"] = "Just like the Japanese predicted, the island fell into Japanese hands, and now the last artery between Australia and the rest of the Allies had been severed. It is only a matter of time before one side gives in.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_17_kantai_kessen.scn",
				["date"] = { 1943, 11, 15, },
				["Pos"] = { 0.885, 0.922, 5.000000 },
				--["prerequisites"] = { "IJN16" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN17.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Capture all enemy bases!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Ensure the survival of LST N. 67!",
					},
					["hiddenHints"] = {
						"(60 + 8) - 1"
					},
					["hints"] = {
						"Never leave your troop transports exposed during a landing operation.",
						"It takes 4 torpedoes to sink a cruiser.",
						"Use your LSTs as invasion breacheads to break through enemy defenses.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"167","322","328","324","291","57","284","69","279","276","289","224","91"},
					["allunitsnum"] = {"18","50","50","50","1","1","1","1","1","3","3","2","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"167","322","328","324","291","57","284","69","279","276","289"},
				},
			},
			
			{ -- IJN18 Prelude to Hawaii
				["id"] = "IJN18",
				["name"] = "Prelude to Hawaii",
				["helpline"] = "MISSION 20 - COMBINED COMBAT\n\nMake your way towards Hawaii by destroying the last few American carrier forces.",
				["background"] = "The American situation was desperate. They could no longer afford to make counter-attacks with their battleships, as they had all been assigned to the defense of the last remaining US stronghold in the Pacific - Pearh Harbor. Hence, the US decided to make a last-ditch attempt at limiting Japan's air power, by attempting to engage the Japanese Kido Butai carriers in the open ocean, as they were gathering off of Hawaii for patrol duties. Their plan was to stay at range, and to use their new aircraft models to get through the Japanese AA, and cause damage. They are comitting most of their remaining operational fleet carriers, and they hope it will pay off.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN13.bik",
				["debriefingText"] = "Once again, it was an unmitigated disaster. From the moment the first carrier and battleship were lost, it was clear to tbe Americans that they had no chance at winning. However, while they were retreating, they got counter-attacked by the Japanese forces, and had lost all their fleet carriers. The US can now no longer effectively challenge the Japanese at the open sea, and instead resorted to the last option they had; desperate protection of their only remaining stronghold. Remarkably however, they have not shown any signs of surreder so far.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_18_prelude_hawaii.scn",
				["date"] = { 1943, 12, 07, },
				["Pos"] = { 1.18, 0.065, 5.000000 },
				--["prerequisites"] = { "IJN17" },
				["sideMission"] = true,
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN18.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN13",
					["primaryObjectives"] = {
						"Sink the enemy capital ships!",
						"Destroy all enemy carriers!",
					},
					["secondaryObjectives"] = {
						"Find and sink the enemy convoy!",
					},
					["hiddenObjectives"] = {
						"Sink the convoys escort!",
					},
					["hiddenHints"] = {
						"They'll be sitting ducks!"
					},
					["hints"] = {
						"Make sure to use all available aircraft slots.",
						"Always send your attack planes in groups.",
						"Use your repair team functions to maximize your ships' survivability.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"291","271","59","284","69","277","322","328","159"}, -- Hakuryu, Taiho, Zuiho, Yamato, Izumo, Takao, Harugumo, A7M, B7A, D4Y
					["allunitsnum"] = {"2","2","1","1","2","6","140","140","140"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"291","271","59","284","69","277","322","328","159"},
				},
			},
			
			{ -- IJN19 Invasion of Hawaii
				["id"] = "IJN19",
				["name"] = "Invasion of Hawaii",
				["helpline"] = "MISSION 21 - COMBINED OPERATION\n\nBreak the American resistance and conquer the last Allied base in the Pacific.",
				["background"] = "Even after the loss of almost all their remaining fleet carriers, the US still did not show any signs of surrendering. There was now only a sinlge American base left in the Pacific, where it all started, the island of Hawaii. Being the single largest American naval base in the Pacific, very heavy resistance is expected, so the Japanese have prepared the largest invasion fleet the world had ever seen before in order to break the last remnants of the American resistance, and take over the last American holding in the Pacific. The Americans have sent a huge force, and unlike their previous encounter at the harbor, have fortified their island to extreme measures and are prepared to face the oncoming Japanese juggernaut.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "The invasion was the largest naval battle to date, with several capital ships having been engaged. The Japanese, through heavy fighting, bravery and sheer brutality, made their way into the port through all the heavy defenses, and crushed all American resistance. However, even in the face of the largest naval defeat to date, the United States still refused to surrender, leaving Japan with only a single option left...",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_19_invasion_hawaii.scn",
				["date"] = { 1943, 12, 20, },
				["Pos"] = { 1.236, 0.105, 5.000000 },
				--["prerequisites"] = { "IJN17" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN19.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"Capture the harbor!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Ensure Yamato's survival!",
					},
					["hiddenHints"] = {
						"''This is Kira Yamato, Freedom Gundam. I will fight!''"
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"324","328","271","59","278","14","224"},
					["allunitsnum"] = {"99","99","2","1","4","7","4"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"324","328","271","59","278","14"},
				},
			},
			
			{ -- IJN20 Finale
				["id"] = "IJN20",
				["name"] = "Invasion of San Francisco",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nMISSION 22 - COMBINED OPERATION\n\nCrush the last remnants of the American resistance and bring an end to the Pacific War!",
				["background"] = "It has come to this;\n\nOnce again, even after the loss of Hawaii, their single largest and only remaining Pacific harbor, the Americans refused to surrender. There was now only a single option left, the most risky and most dangerous one: an invasion of the United States' mainland. While it was definitively not an option that Japan wanted or desired, as such an operation carriers enormous risk, it was now their only available option, as letting the US build up their navies in port while the IJN sat out in the Pacific was inconcievable. Therefore, the IJN prepared for one last push, one final hurdle, and the largest one so far. The final battle that would decide the fate of the two nations.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "Having almost exausted all of their resources, the Japanese had done it. San Francisco was in their hands, and the United States would finally surrender to the Japanese Empire. The Japanese state now extends all the way from China to San Francisco, stretching over 6,000 miles (over 9,500 kilometers). Australia capitulated soon afterwards too, having been disarmed by the Japanese and now having no more allies left. The war in the Pacific was over, and a new, comparatively much darker, age had dawned on the Pacific nations.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/ijn_20_finale.scn",
				["date"] = { 1944, 01, 15, },
				["Pos"] = { 1.7825, -0.2376, 5.000000 },
				--["prerequisites"] = { "IJN19" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/IJN20.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"Capture the bay!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Shoot down 200 enemy aircraft!",
					},
					["hiddenHints"] = {
						":) Good luck!"
					},
					["hints"] = {
						"Good tactical decisions are important for this final battle.",
						"Prepare for a high number of enemy attackers.",
						"Always ensure to have a few CAP squadrons over your fleet.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"183","328","388","291","270","273","224"},
					["allunitsnum"] = {"99","99","1","3","2","3","4",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
	
		},
	},
	
	{ -- United States Campaign
		["groupName"] = "USN campaign",
		["helpLine"] = "FE.main_cs_allycamp_help",
		["gratMsg"] = "FE.rewards_congratulations_uscampaign",
		["gratDate"] = { 1942, 05, 04 },
		["missions"] = {
			
			---- BSM MISSION START ----
			
			{ -- BSM01 Stationed at Pearl (BSM)
				["id"] = "BSM01",
				["name"] = "Stationed at Pearl",
				["helpline"] = "BSM MISSION 01 - COMBINED COMBAT\n\nReport for duty to the USS Phoenix in Pearl Harbor.",
				["background"] = "Pearl Harbour, 7 December 1941. 0745 hours Zulu time.####Lt. Henry Walker, a recent graduate of Annapolis Naval Academy, has spent the night carousing with his old buddy, Major Donald Locklear, ahead of the two of them assuming new postings.####Henry is receiving his first shipboard posting on the cruiser USS Phoenix, while Donald, a veteran of the Sino-Japanese war with the American Volunteer Group 'The Flying Tigers', will soon be en route to Midway Island to join the Marine Fighter Squadron stationed there.####As the sun comes up on another glorious Hawaiian morning, the two friends muse on what is to become of them.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_01_stationed_at_pearl.scn",
				["date"] = { 1941, 12, 07, },
				["Pos"] = { 1.155, 0.135, 5.000000 },
				["prerequisites"] = {},
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM01.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0101.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM01",
					["primaryObjectives"] = {
						"Go to the USS Phoenix!",	
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Shoot down at least 30 planes.",	
					},
					["hiddenHints"] = {
						"The more Japanese are downed, the better.",
					},
					["hints"] = {
						"Check your speed whilst at the helm of the PT boat; these small boats are very fast! A collision with another craft is not a pretty sight.",
						"Focus AA fire on enemy fighters. AA is deadly against units with little or no armor.",
						"Stay in the battle. Leaving the combat area means failure!",
						"PT boats are equipped with Depth Charges (DC). Use them against enemy submarines.",
					},
					["allunitsid"] = {"27","135"}, -- Elco, P40
					["allunitsnum"] = {"1","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM02 Defense of the Philippines (BSM)
				["id"] = "BSM02",
				["name"] = "Defence of the Philippines",
				["helpline"] = "BSM MISSION 02 - NAVAL COMBAT\n\nDefend a vital Philippines naval base against Japanese invasion.",
				["background"] = "December 13th 1941.####Following the devastating Japanese attack on Pearl Harbour and the destruction of his ship, Henry is posted to a Philippines naval base, and the front line of the war against Japan.####It is here that he meets Admiral Thomas Hart, Commander-in-Chief of the Asiatic Fleet, who assigns him command of a PT (Patrol Torpedo) boat, part of a squadron led by a charismatic Lieutenant called John Kennedy.####Shortly afterwards, a Japanese invasion fleet is sighted heading for the base, supported by a large number of aircraft. It's an opportunity for Walker to strike back against the enemy, and to prove his ability... If his boat's temperamental engine will start, of course.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_02_defense_of_the_philippines.scn",
				["date"] = { 1941, 12, 13, },
				["Pos"] = { -0.064, 0.282, 5.000000 },
				--["prerequisites"] = { "BSM01" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM02.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0201.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM02",
					["primaryObjectives"] = {
						"Leave the harbor!",						
						"Stop the Japanese landings!",						
						"Sink the Japanese Troop Transports!",						
					},
					["secondaryObjectives"] = {
						"Completely destroy the first wave of landing boats!",
					},
					["hiddenObjectives"] = {
						"Destroy at least 5 level bombers!",
						"Sink the enemy destroyer!",
					},
					["hiddenHints"] = {
						"The more bombers are downed, the better.",
						"Ensure the sinking of all Japanese ships in the area.",
					},
					["hints"] = {
						"Watch out for Japanese fighters at all times - their gunfire is potentially lethal to your boat.",
						"The enemy destroyer, LSTs and transport ships can only be sunk by torpedoes.",
						"Aim your torpedoes carefully - the enemy will try to evade them so anticipate their next move.",
						"Two torpedo hits will sink a transport ship (AK).",
					},
					["allunitsid"] = {"27"}, -- Elco
					["allunitsnum"] = {"1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM03 Running the Palawan Passage (BSM)
				["id"] = "BSM03",
				["name"] = "Running the Palawan Passage",
				["helpline"] = "BSM MISSION 03 - NAVAL COMBAT\n\nNavigate a Clemson-class destroyer through the heavily-defended enemy-held straits.",
				["background"] = "December 20th 1941.####Henry fought heroically, but it was not enough to hold back the might of the Japanese military. All US ships and personnel are ordered to withdraw, and Henry - newly promoted to Commander, and in charge of a Clemson-class destroyer - is tasked with escorting the convoys as they flee southwards and east.####It's dull, monotonous work, and Henry is quickly frustrated - until he receives mysterious orders to rendezvous with another US ship on the other side of a narrow strait, which is heavily defended by Japanese forces.####His abilities will be tested to the limit as, out-numbered and out-gunned, he attempts to run the Palawan Passage.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_03_running_the_palawan_passage.scn",
				["date"] = { 1941, 12, 20, },
				["Pos"] = { -0.1265, 0.3265, 5.000000 },
				--["prerequisites"] = { "BSM02" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM03.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0301.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM03",
					["primaryObjectives"] = {
						"Reach the other side of the strait!",						
						"Annihilate the enemy destroyer!",						
					},
					["secondaryObjectives"] = {
						"Destroy the Japanese Recon Base!",
						"Destroy the Japanese PT Boat Base!",
					},
					["hiddenObjectives"] = {
						"Meet with the Allied submarine within 17 minutes!",
						"Destroy all cargo ships!",
					},
					["hiddenHints"] = {
						"Time is of the essence.",
						"Downing more cargo ships now means less Japanese to fight off later.",
					},
					["hints"] = {
						"In narrow passages of water, overuse of binoculars can be dangerous. Focus on navigation.",
						"Seek out and destroy mainland artillery; there are hardened emplacements everywhere!",
						"Use AA against small units such as torpedo boats.",
						"Launch spreads of torpedoes to bracket and eliminate the enemy destroyer (DD).",
					},
					["allunitsid"] = {"25"}, -- Clemson
					["allunitsnum"] = {"1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM04 Vengance at Luzon (BSM)
				["id"] = "BSM04",
				["name"] = "Vengance at Luzon",
				["helpline"] = "BSM MISSION 04 - AIR COMBAT\n\nLead a bombing raid against an enemy battleship harbored near Luzon.",
				["background"] = "January 20th 1942.####As Henry rests in Java after his exertions, his friend Major Donald Locklear, now Executive Officer of a fighter squadron onboard the carrier USS Lexington, is heading back into trouble.####A crippled Japanese battleship is harbored near the Philippines island of Luzon, and a daring strike has been planned to sink her.####First, B-17 bombers will attempt to neutralise the Japanese airfield, giving an opportunity for Lexington's strike planes to attack the battleship at anchor, and send her to the bottom.####Donald's role is to provide fighter escort to the attack, and his experience in fighting the Japanese Zero pilots will be essential to the success of the mission.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_04_vengance_at_luzon.scn",
				["date"] = { 1942, 01, 20, },
				["Pos"] = { -0.09, 0.22, 5.000000 },
				--["prerequisites"] = { "BSM03" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM04.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0401.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM04",
					["primaryObjectives"] = {
						"Donald must survive!",						
						"Defend the B-17 bomber squad!",						
						"Sink the anchored Japanese battleship in the harbor!",						
						"Retreat to the navigation point with your squadron!",						
					},
					["secondaryObjectives"] = {
						"Destroy the Japanese oil tanker!",
					},
					["hiddenObjectives"] = {
						"Eliminate all destroyers!",
					},
					["hiddenHints"] = {
						"Hey, destroyers are supposed to be weak, aren't they?...",
					},
					["hints"] = {
						"Donald's plane is an elite unit, and has improved armour, guns and handling.",
						"When piloting dive bombers, don't dive too steeply or the bombs cannot be released.",
						"Don't release torpedoes at high altitude, or they will explode when they hit the water.",
						"Be careful when flying head-to-head with an enemy fighter. Collision means certain death.",
					},
					["allunitsid"] = {"101","108","113","314"}, -- Wildcat, Dauntless, Avenger, Lexington
					["allunitsnum"] = {"99","99","99","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM05 Raid on Balikpapan (BSM)
				["id"] = "BSM05",
				["name"] = "Raid on Balikpapan",
				["helpline"] = "BSM MISSION 05 - NAVAL COMBAT\n\nCommand a destroyer division to attack an enemy merchant convoy.",
				["background"] = "January 24th 1942.####As the Lexington retreats after its success, Henry has received new orders - and new responsibility. A Japanese transport convoy has been located at Balikpapan in Borneo, and Henry has been ordered to attack it.####Now in command of a modern Fletcher-class destroyer, and accompanied by the USS Parrott, Henry leads his division towards the target, knowing that he will have only a short amount of time to wreak destruction among the Japanese cargo ships before enemy reinforcements arrive on the scene.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_05_raid_on_balikpapan.scn",
				["date"] = { 1942, 01, 24, },
				["Pos"] = { -0.1705, 0.5875, 5.000000 },
				--["prerequisites"] = { "BSM04" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM05.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0501.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM05",
					["primaryObjectives"] = {
						"Destroy all Japanese cargo ships!",						
						"The USS John D. Ford must survive!",						
						"Eliminate the enemy reinforcements!",						
					},
					["secondaryObjectives"] = {
						"Destroy the Japanese fortress!",
					},
					["hiddenObjectives"] = {
						"Finish the mission before reinforcements arrive!",
						"Both of your destroyers must survive!",
					},
					["hiddenHints"] = {
						"I'm fast as f**k boiii!",
						"The wives of the crewmen of your destroyers would certainly appreciate them coming home.",
					},
					["hints"] = {
						"Enemy gunners can fire over the land mass, so watch their gunfire!",
						"Check the water's surface for the tell-tale bubbles of a torpedo wake.",
						"Destroy the cargo ships as soon as possible to avoid the attentions of the Japanese main fleet!",
						"Fire torpedoes early to sink the stationary cargo ships.",
					},
					["allunitsid"] = {"23","25"}, -- Fletcher, Clemson
					["allunitsnum"] = {"1","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM06 Holding the Lombok Strait (BSM)
				["id"] = "BSM06",
				["name"] = "Holding the Lombok Strait",
				["helpline"] = "BSM MISSION 06 - COMBINED COMBAT\n\nDefend an island base against air strikes and surface invasion.",
				["background"] = "February 20th 1942.####Singapore has fallen to the relentless onslaught of Japanese aggression, and now the battle is moving to Indonesia and Australia.####Admiral Hart's flagship, the USS Houston, has been drafted into the ABDACOM fleet, a joint effort by the Dutch, Australian, British and American forces to muster enough sea power to challenge the might of the Imperial Fleet.####As Hart prepares himself for battle, Henry is given an important task - to take charge of the defence of the Den Pasar airfield on Bali, a vital link in the Allied defensive line.####As memories of the desperate battle in the Philippines crowd his mind, Henry marshalls the various forces at his disposal, knowing that a single mistake in his planning is all it will take to cede yet another victory to the enemy.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_06_holding_lombok.scn",
				["date"] = { 1942, 02, 20, },
				["Pos"] = { -0.191, 0.736, 5.000000 },
				--["prerequisites"] = { "BSM05" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM06.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0601.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM06",
					["primaryObjectives"] = {
						"Protect the airfield!",						
						"USS John D. Ford must survive!",						
						"Prevent the invasion force from capturing the island!",						
					},
					["secondaryObjectives"] = {
						"Shoot down the Japanese medium bombers!",
						"Launch a preemptive strike at the enemy invasion force!",
					},
					["hiddenObjectives"] = {
						"50% of your air forces must survive!",
						"Sink the landing support ship!",
						"Don't allow any of the bunkers to be captured by the enemy!",
					},
					["hiddenHints"] = {
						"Dang this is gonna be a massacre.",
						"Oil, invented by the Illuminati, is a pretty precious resource, don't you think so?",
						"Dem bunkers doe, gotta say...",
					},
					["hints"] = {
						"To effectively neutralise an enemy air strike, eliminate the fighter escort first then pick off the strike planes.",
						"Always keep the maximum number of planes in the air to keep the airfield secure.",
						"Don't bother pursuing enemy bombers after they've released their bombs. Your objective is to protect the airfield not to obliterate everything!",
						"Transport ships (AK) and landing crafts (LST or LCP) are vulnerable to a fighter's machine guns.",
					},
					["allunitsid"] = {"135","108","112","118","23"}, -- Warhawk, Dauntless, Avenger, Mitchell, Fletcher
					["allunitsnum"] = {"99","99","99","99","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM07 Rendezvous at the Java Sea (BSM)
				["id"] = "BSM07",
				["name"] = "Rendezvous at the Java Sea",
				["helpline"] = "BSM MISSION 07 - NAVAL COMBAT\n\nTake the USS Houston to rendezvous with a British surface fleet.",
				["background"] = "March 24th 1942.####The sweetness of Henry's victory is soon soured by the news that the ABDACOM fleet has suffered a crushing defeat at the Battle of the Java Sea, with many ships lost and scarcely any survivors.####Hart was lucky to escape, but as the Houston limps back into port it is clear that his time in Indonesia has come to an end. Java has fallen, and once again Henry is forced to gather his forces and retreat.####With the Houston now as his flagship, Henry makes a daring bid to link up with the remains of the British Eastern Fleet. The Java Sea is now Japanese territory, however, and he knows that he will be harried every step of the way.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_07_rand_java_sea.scn",
				["date"] = { 1942, 03, 24, },
				["Pos"] = { -0.2125, 0.674, 5.000000 },
				--["prerequisites"] = { "BSM06" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM07.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0701.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM07",
					["primaryObjectives"] = {
						"Meet with Royal Navy forces at the given coordinates ASAP!",						
						"The Houston must not sink!",						
					},
					["secondaryObjectives"] = {
						"Destroy the enemy submarine!",
						"HMS Exeter must survive!",
					},
					["hiddenObjectives"] = {
						"Destroy all enemy ships!",
					},
					["hiddenHints"] = {
						"Cool guys don't look at explosions.",
					},
					["hints"] = {
						"Use your screening force to repel the air strikes and to fend off enemy submarines.",
						"Heavy artillery has a considerable range advantage. Exploit this by staying as far away as possible from enemies.",
						"Launch a swarm of torpedoes against the enemy battleships. Firing torpedoes at the right time can turn a battle's outcome in an instant.",
						"Use the formation screen to your advantage. Make a column of your ships to handle enemies coming from the sides.",
					},
					["allunitsid"] = {"317","21","23","25","31"}, -- Northampton, York, Fletcher, Clemson, Narwhal
					["allunitsnum"] = {"1","1","1","3","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM08 Strike on Tulagi (BSM)
				["id"] = "BSM08",
				["name"] = "Strike on Tulagi",
				["helpline"] = "BSM MISSION 08 - COMBINED COMBAT\n\nCaptain the USS Yorktown in an aerial assault on a Japanese island base.",
				["background"] = "May 3rd 1942.####As Henry's ragtag battlegroup sails for the safety of Australia, it is clear that the powers-that-be have taken notice of Henry's prowess. Summoned back to Pearl, he finds himself promoted to the rank of Captain, and with new orders to join Admiral Frank Fletcher aboard the aircraft carrier USS Yorktown as second-in-command.####Impressed with Fletcher's gruff confidence, and all too aware of the power of the aircraft carrier in modern naval warfare, Henry is keen to take the battle back to the enemy.####He does not have to wait long; the Japanese have overrun the island stronghold of Tulagi in the Solomon islands, and Yorktown is heading out to spearhead the US amphibious assault to take it back.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_08_strike_on_tulagi.scn",
				["date"] = { 1942, 05, 03, },
				["Pos"] = { 0.489583, 0.745139, 5.000000 },
				--["prerequisites"] = { "BSM07" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM08.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0801.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM08",
					["primaryObjectives"] = {
						"Destroy the airfield hangars!",						
						"Destroy the seaplane hangar!",						
						"Yorktown must survive the encounter!",						
						"Make sure at least three landing ships come ashore!",						
					},
					["secondaryObjectives"] = {
						"Destroy the Japanese support to protect the LSTs!",
						"Destroy the fortress protecting the bay!",
					},
					["hiddenObjectives"] = {
						"Sink the Japanese cargo ships!",
					},
					["hiddenHints"] = {
						"Where should the Japs cargos be?",
					},
					["hints"] = {
						"Maintain a Combat Air Patrol, or CAP, around your carrier at all times.",
						"Destroy the Japanese ships around the island ASAP. Given the chance, they'll eliminate your screening force.",
						"Your LSTs are sitting ducks. Destroy everything that gets in range of them.",
						"Watch out for Japanese bombers. They can easily sink your carrier (CV).",
					},
					["allunitsid"] = {"315","23","101","108","113","116"}, -- Yorktown, Fletcher, Wildcat, Dauntless, Avenger, B-17
					["allunitsnum"] = {"1","2","99","99","99","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM09 Battle of the Coral Sea (BSM)
				["id"] = "BSM09",
				["name"] = "Battle of the Coral Sea",
				["helpline"] = "BSM MISSION 09 - COMBINED COMBAT\n\nCommand the USS Yorktown at the Battle of the Coral Sea, the first carrier battle in history.",
				["background"] = "May 8th 1942.####With Tulagi secured, Yorktown is given new orders - to confront a Japanese invasion fleet heading for Port Moresby in New Guinea. Yorktown is joined by the USS Lexington, and Henry is surprised and delighted to discover that his old friend Donald is aboard.####As the two friends renew their acquaintance for the first time since that fateful morning in Pearl Harbor, they prepare for the greatest challenge the US Navy has yet faced - to meet the seemingly invincible Japanese Carrier Striking Force head-on in what will be the first aircraft carrier battle in history.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_09_battle_of_the_coral_sea.scn",
				["date"] = { 1942, 05, 08, },
				["Pos"] = {  0.425000, 0.815, 5.000000 },
				--["prerequisites"] = { "BSM08" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM09.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m0901.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM09",
					["primaryObjectives"] = {
						"Defeat the Japanese carriers!",						
						"Ensure Donald's survival!",						
						"Protect the Yorktown from sinking!",										
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Shoot down 30 Japanese planes!",
					},
					["hiddenHints"] = {
						"I like water splashing sounds.",
					},
					["hints"] = {
						"Donald is a top-notch pilot, so use him to gain an advantage over your enemy.",
						"Always send your attack planes in groups of multiple squadrons. This way, more planes will penetrate the blanket of AA fire and fighter cover.",
						"To increase the effectiveness of torpedo bombers, attack the enemy where they have the fewest AA guns.",
						"Have your fighters patrol the area between US and Japanese carriers; the earlier incoming bombers are attacked, the better.",
					},
					["allunitsid"] = {"315","316","23","101","108","113","125"}, -- Yorktown, Cleveland, Fletcher, Wildcat, Dauntless, Avenger, Catalina
					["allunitsnum"] = {"1","1","2","99","99","99","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM10 Turning Point at Midway (BSM)
				["id"] = "BSM10",
				["name"] = "Turning Point at Midway",
				["helpline"] = "BSM MISSION 10 - COMBINED COMBAT\n\nTake charge of Midway Island as the Battle of Midway commences.",
				["background"] = "May 31st 1942.####Port Moresby has been saved, but the cost has been terribly high. Donald is dead, the Lexington sunk, and Yorktown heavily damaged. There is no time to mourn, however - US Naval Intelligence has discovered a massive Japanese carrier fleet approaching the island of Midway.####Should Midway fall, the Japanese will have a base from which they can mount an attack on Pearl, perhaps even on the West Coast itself. ####As the two remaining US carriers prepare an ambush for the Japanese, Henry is entrusted with the command of Midway's dilapidated and outdated defences, with which he must face the full force of the Imperial Navy.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_10_turning_point_at_midway.scn",
				["date"] = { 1942, 05, 31, },
				["Pos"] = { 0.800000, -0.035000, 5.000000 },
				--["prerequisites"] = { "BSM09" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM10.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m1001.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM10",
					["primaryObjectives"] = {
						"Repel the air raid!",						
						"Destroy the transport ships!",						
						"Locate and destroy the Japanese carriers!",						
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Destroy the transport ships before they launch landing boats!",
					},
					["hiddenHints"] = {
						"I don't like me those landing boats, no bueno senor.",
					},
					["hints"] = {
						"Launch all squadrons ASAP to repel the incoming attack.",
						"Use fighter squadrons and B-17 bombers to swiftly eliminate the invasion forces.",
						"Hold and protect the airfields on the island and use their resources against the carriers.",
						"Your B-17s have considerable firepower against enemy planes.",
					},
					["allunitsid"] = {"133","101","108","113","116","27","315","23"}, -- Buffalo, Wildcat, Dauntless, Avenger, B-17, Elco, Yorktown, Fletcher
					["allunitsnum"] = {"99","99","99","99","99","99","1","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- BSM11 Endgame at Midway (BSM)
				["id"] = "BSM11",
				["name"] = "Endgame at Midway",
				["helpline"] = "BSM MISSION 11 - COMBINED COMBAT\n\nLead the USN Carrier Fleet to victory at the Battle of Midway.",
				["background"] = "June 4th 1942. 1700 hours Zulu time.####Thanks to Yorktown's miraculous arrival, the invasion of Midway has been averted, and two Japanese carriers now lie shattered on the floor of the Pacific Ocean. The battle is far from over, though... Yorktown is mortally wounded, and now it is up to Enterprise and Hornet to finish the job.####Two Japanese carriers remain, and the stage is set for a final showdown. On Fletcher's orders, Henry moves his flag to the Enterprise, and steels himself for a confrontation for which the prize is total domination of the Pacific Theatre.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/BSM_Theme.bik",
				["debriefingText"] = "",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."BSM/bsm_11_endgame_at_midway.scn",
				["date"] = { 1942, 06, 04, },
				["Pos"] = { 0.774, -0.04, 5.000000 },
				--["prerequisites"] = { "BSM10" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/BSM11.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "movies/campaigns/BSM/m1101.bik",
				["allied"] = {
					["briefingGuiLayer"] = "BSM11",
					["primaryObjectives"] = {
						"One of our carriers has to survive the encounter!",						
						"Find the Japanese carriers!",						
					},
					["secondaryObjectives"] = {
						"Destroy the patrolling Japanese cruisers!",
						"Destroy the attacking Japanese submarine!",
					},
					["hiddenObjectives"] = {
						"Launch an air strike on the enemy CVs before our position is reported!",
						"Destroy the Japanese reinforcements!",
					},
					["hiddenHints"] = {
						":) Good luck!",
						":) Good luck!",
					},
					["hints"] = {
						"Equip your bombers with depth charges to give them sub-hunting capability.",
						"Use the terrain to your advantage and hide behind islands to protect your ship from torpedoes.",
						"If the Japanese detect your carriers then they will make them their main target.",
						"Submarines (SS) can damage your ships greviously if they are not destroyed fast.",
					},
					["allunitsid"] = {"315","317","23","101","108","113"}, -- Yorktown, Northampton, Fletcher, Wildcat, Dauntless, Avenger
					["allunitsnum"] = {"2","1","3","99","99","99"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			---- BSM MISSION END ----
			
			---- REGULAR US MISSION START ----
			
			{ -- USN01 Battle of the Eastern Solomons (Vanilla)
				["id"] = "USN01",
				["name"] = "FE.mtree_usn01_name",
				["helpline"] = "MISSION 01 - AIR COMBAT\n\nMaster the art of aerial warfare in the first carrier battle around Guadalcanal.",
				["background"] = "fe.mtree_usn01_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN01.bik",
				["debriefingText"] = "usn01.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_01_Battle_of_Eastern_Solomons.scn",
				["date"] = { 1942, 08, 24, },
				["Pos"] = { 0.502083, 0.670139, 5.000000 },
				--["prerequisites"] = {},
				["description"] = "",
				["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/USN01.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["allied"] = {
					["briefingGuiLayer"] = "USN01",
					["primaryObjectives"] = {
						"usn01.obj_p1",
						"usn01.obj_p2",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"usn01.obj_h1",
					},
					["hiddenHints"] = {
						"usn01.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn01.hint_loadinghint1",
						"usn01.hint_loadinghint2",
						"usn01.hint_loadinghint3",
						"usn01.hint_loadinghint4",
					},
					["allunitsid"] = {"101","113","108"},
					["allunitsnum"] = {"60","60","60"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"101","113","108"}, --Wildcat, Avenger
				},
			},
			
			{ -- USN02 Battle of Cape Esperance (Vanilla)
				["id"] = "USN02",
				["name"] = "FE.mtree_usn02_name",
				["helpline"] = "MISSION 02 - SHIP COMBAT\n\nStop the Japanese attacking under the cover of night.",
				["background"] = "fe.mtree_usn02_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN02.bik",
				["debriefingText"] = "usn02.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_02_Battle_of_Cape_Esperance.scn",
				["date"] = { 1942, 10, 11, },
				["Pos"] = { 0.478125, 0.746528, 5.000000 },
				--["prerequisites"] = { "USN01" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 5, 6, 7, 9, 10, 16, 17, 18, 19, 20, 44, 45, 46, 47},
				["picture"] = "fe/missions/USN02.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN02",
					["primaryObjectives"] = {
						"usn02.obj_p1",
					},
					["secondaryObjectives"] = {
						"usn02.obj_s1",
					},
					["hiddenObjectives"] = {
						"usn02.obj_h1",
					},
					["hiddenHints"] = {
						"usn02.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn02.hint_loadinghint1",
						"usn02.hint_loadinghint2",
						"usn02.hint_loadinghint3",
						"usn02.hint_loadinghint4",
					},
					["allunitsid"] = {"294","252","288","11"},
					["allunitsnum"] = {"1","1","3","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"294","252","288","11"},
				},
			},
			
			{ -- USN03 Battle of Santa Cruz (Vanilla)
				["id"] = "USN03",
				["name"] = "FE.mtree_usn03_name",
				["helpline"] = "MISSION 03 - COMBINED FLEET COMBAT\n\nHold the enemy carrier forces back.",
				["background"] = "fe.mtree_usn03_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN03.bik",
				["debriefingText"] = "usn03.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_03_Battle_of_Santa_Cruz.scn",
				["date"] = { 1942, 10, 26, },
				["Pos"] = { 0.585416, 0.778472, 5.000000 },
				--["prerequisites"] = { "USN02" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 44, 45, 46, 47, 48, 49, 50, 52, 53 },
				["picture"] = "fe/missions/USN03.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN03",
					["primaryObjectives"] = {
						"usn03.obj_p3",
						"usn03.obj_p4",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"usn03.obj_h1",
					},
					["hiddenHints"] = {
						"usn03.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn03.hint_loadinghint1",
						"usn03.hint_loadinghint2",
						"usn03.hint_loadinghint3",
						"usn03.hint_loadinghint4",
					},
					["allunitsid"] = {"2","7","17","317","288","101","113","108"},
					["allunitsnum"] = {"1","1","3","1", "7" ,"20","30","30"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"2","7","17","317","288","101","113","108"},
				},
			},
			
			{ -- USN04 Defense of Henderson Field (Vanilla)
				["id"] = "USN04",
				["name"] = "FE.mtree_usn04_name",
				["helpline"] = "MISSION 04 - COMBINED FLEET OPERATION\n\nHelp to reinforce Guadalcanal's American base.",
				["background"] = "fe.mtree_usn04_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN04.bik",
				["debriefingText"] = "usn04.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_04_Defend_Guadalcanal.scn",
				["date"] = { 1942, 11, 08, },
				["Pos"] = { 0.486458, 0.761805, 5.000000 },
				--["prerequisites"] = { "USN03" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 21, 22, 24, 25, 44, 45, 46, 47, 48, 49, 50, 52, 53},
				["picture"] = "fe/missions/USN04.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN04",
					["primaryObjectives"] = {
						"usn04.obj_p1",
						"usn04.obj_p2",
					},
					["secondaryObjectives"] = {
						"usn04.obj_s1",
					},
					["hiddenObjectives"] = {
						"usn04.obj_h1",
					},
					["hiddenHints"] = {
						"usn04.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn04.hint_loadinghint1",
						"usn04.hint_loadinghint2",
						"usn04.hint_loadinghint3",
						"usn04.hint_loadinghint4",
					},
					["allunitsid"] = {"27", "101"},
					["allunitsnum"] = {"12", "45"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"101"}, --Wildcat
				},
			},
			
			{ -- USN05 1st Battle of Guadalcanal (Vanilla)
				["id"] = "USN05",
				["name"] = "FE.mtree_usn05_name",
				["helpline"] = "MISSION 05 - FLEET OPERATION\n\nFend off the Japanese attempt to neutralize Henderson Field.",
				["background"] = "fe.mtree_usn05_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN05.bik",
				["debriefingText"] = "usn05.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_05_GuadalCanal_1st_Battle.scn ",
				["date"] = { 1942, 11, 13, },
				["Pos"] = { 0.489583, 0.745139, 5.000000 },
				--["prerequisites"] = { "USN04" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 5, 6, 7, 8, 9, 10, 14, 16, 17, 18, 19, 20, 44, 45, 46, 47, 48, 49, 50 },
				["picture"] = "fe/missions/USN05.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN05",
					["primaryObjectives"] = {
						"usn05.obj_p2",
						"usn05.obj_p1",
					},
					["secondaryObjectives"] = {
						"usn05.obj_s1",
					},
					["hiddenObjectives"] = {
						"usn05.obj_h1",
					},
					["hiddenHints"] = {
						"usn05.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn05.hint_loadinghint1",
						"usn05.hint_loadinghint2",
						"usn05.hint_loadinghint3",
						"usn05.hint_loadinghint4",
					},
					["allunitsid"] = {"294","17","288","11","23"},
					["allunitsnum"] = {"1","1","1","1","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"294","17","288","11","23"},
				},
			},
			
			{ -- USN06 2nd Battle of Guadalcanal (Vanilla)
				["id"] = "USN06",
				["name"] = "FE.mtree_usn06_name",
				["helpline"] = "MISSION 06 - COMBINED FLEET OPERATION\n\nEliminate the enemy forces at Guadalcanal.",
				["background"] = "fe.mtree_usn06_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN06.bik",
				["debriefingText"] = "usn06.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_06_Guadalcanal_2nd_battle.scn ",
				["date"] = { 1942, 11, 14, },
				["Pos"] = { 0.500000, 0.756250, 5.000000 },
				--["prerequisites"] = { "USN05" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 25, 34, 35, 36, 37, 38, 39, 40, 44, 45, 46, 47, 48, 49, 50, 51 },
				["picture"] = "fe/missions/USN06.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN06",
					["primaryObjectives"] = {
						"usn06.obj_p1",
					},
					["secondaryObjectives"] = {
						"usn06.obj_s1",
					},
					["hiddenObjectives"] = {
						"usn06.obj_h1",
					},
					["hiddenHints"] = {
						"usn06.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn06.hint_loadinghint1",
						"usn06.hint_loadinghint2",
						"usn06.hint_loadinghint3",
						"usn06.hint_loadinghint4",
					},
					["allunitsid"] = {"31","27","118","135","7","253","288","296"},
					["allunitsnum"] = {"1","6","1","60","1","1","3","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"31","118","135","7","253","288","296"},
				},
			},
			
			{ -- USN07 Invasion of Tarawa (Vanilla)
				["id"] = "USN07",
				["name"] = "FE.mtree_usn07_name",
				["helpline"] = "MISSION 07 - AIR COMBAT\n\nProvide air support in the Battle of Tarawa.",
				["background"] = "fe.mtree_usn07_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN07.bik",
				["debriefingText"] = "usn07.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_07_invasion_of_tarawa.scn",
				["date"] = { 1943, 11, 20, },
				["Pos"] = { 0.690624, 0.513889, 5.000000 },
				--["prerequisites"] = { "USN06" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 21, 22, 25, 26, 30, 44, 45, 46, 47, 48 },
				["picture"] = "fe/missions/USN07.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN07",
					["primaryObjectives"] = {
						"usn07.obj_p1",
						"usn07.obj_p2",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"usn07.obj_h1",
					},
					["hiddenHints"] = {
						"usn07.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn07.hint_loadinghint1",
						"usn07.hint_loadinghint2",
						"usn07.hint_loadinghint3",
						"usn07.hint_loadinghint4",
					},
					["allunitsid"] = {"102", "108"},
					["allunitsnum"] = {"60", "60",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"102", "108"},
				},
			},
			
			{ -- USN08 Battle of the Philippine Sea (Vanilla)
				["id"] = "USN08",
				["name"] = "FE.mtree_usn08_name",
				["helpline"] = "MISSION 08 - COMBINED FLEET OPERATION\n\nJoin the dogfight at the Marianas' Turkey Shoot.",
				["background"] = "fe.mtree_usn08_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN08.bik",
				["debriefingText"] = "usn08.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_08_Battle_of_Philippine_Sea.scn",
				["date"] = { 1944, 06, 19, },
				["Pos"] = { 0.059375, 0.229861, 5.000000 },
				--["prerequisites"] = { "USN07" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 34, 35, 36, 37, 38, 39, 40, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53 },
				["picture"] = "fe/missions/USN08.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN08",
					["primaryObjectives"] = {
						"usn08.obj_p1",
						"usn08.obj_p3",
					},
					["secondaryObjectives"] = {
						"usn08.obj_s1",
					},
					["hiddenObjectives"] = {
						"usn08.obj_h1",
					},
					["hiddenHints"] = {
						"usn08.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn08.hint_loadinghint1",
						"usn08.hint_loadinghint2",
						"usn08.hint_loadinghint3",
						"usn08.hint_loadinghint4",
					},
					["allunitsid"] = {"2","256","17","23","26","113","38","31"},
					["allunitsnum"] = {"1","1","1","3","42","60","36","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"256","17","23","26","113","38","31"},
				},
			},
			
			{ -- USN16 Battle of the Sibuyan Sea (CPC)
				["id"] = "USN16",
				["name"] = "Battle of The Sibuyan Sea",
				["helpline"] = "MISSION 09 - COMBINED FLEET OPERTAION\n\nLead the US Carriers on their task to sink Japan's mightiest battleships.",
				["background"] = "The campaigns of August 1942 to early 1944 had driven Japanese forces from many of their island bases in the south and the central Pacific Ocean, while isolating many of their other bases (most notably in the Solomon Islands, Bismarck Archipelago, Admiralty Islands, New Guinea, Marshall Islands, and Wake Island), and in June 1944, a series of American amphibious landings supported by the Fifth Fleet's Fast Carrier Task Force captured most of the Mariana Islands. As part of the greater Japanese strategy, the Japanese 'Center Force', arguably the strongest of the 3 surface groups, was to head to the San Bernandino Strait, in an attempt to break through and cripple allied supply lines to Leyte. The US High Command anticicpated such an attempt, and on October 24th, surprised the Japanese Center Force as it was steaming through the Sibuyan Sea.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN09.bik",
				["debriefingText"] = "Kurita turned his fleet around to get out of range of the aircraft, passing the crippled Musashi as his force retreated. He waited until 17:15 before turning around again to head for the San Bernardino Strait. After being struck by at least 17 bombs and 19 torpedoes, Musashi finally capsized and sank at about 19:30. In all, U.S. 3rd Fleet flew 259 sorties, mostly by Hellcats, against Center Force on 24 October. This weight of attack was not nearly sufficient to neutralize the threat from Kurita. It contrasts with the 527 sorties flown by 3rd Fleet against Ozawa's much weaker Northern Force on the following day. Moreover, a large proportion of the Sibuyan Sea attack was directed against just one ship, Musashi. This great battleship was sunk, the cruiser Myoko was also crippled by an aerial torpedo; but every other ship in Kurita's force remained battleworthy and able to advance. As a result of a momentous decision about to be taken by Admiral Halsey, Kurita was able to proceed through the San Bernardino Strait during the night, to make an unexpected and dramatic appearance off the coast of Samar on the following morning.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_16_battle_of_sibuyan_sea.scn",
				["date"] = { 1944, 10, 24, },
				["Pos"] = { -0.098958, 0.324305, 5.000000 },
				--["prerequisites"] = { "USN08" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/USN16.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN01",
					["primaryObjectives"] = {
						"Find and stop the Japanese Fleets!",
						"Ensure the survival of at least 4 of your carriers!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Make sure all of your carriers survive the battle!",
					},
					["hiddenHints"] = {
						"It is crucial that we prevent the sinking of our carriers." --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"Try and group your planes when attacking.",
						"Always keep a few CAP planes over your carriers.",
						"Make sure to attack the enemy ships from afar.",
						"Map made by Runsva. Thank you for playing!",
					},
					["allunitsid"] = {"26","38","108","113","31"},
					["allunitsnum"] = {"99","99","99","99","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"26","113","31"},
				},
			},
			
			{ -- USN20 Battle of the Surigao Strait (CPC)
				["id"] = "USN20",
				["name"] = "Battle of The Surigao Strait",
				["helpline"] = "MISSION 10 - SHIP COMBAT\n \n Defeat the Japanese attack with your battleships.",
				["background"] = "Nishimura's ''Southern Force'' consisted of the old battleships Yamashiro and Fuso, the heavy cruiser Mogami, and four destroyers. The four destroyers were Shigure, Michishio, Asagumo and Yamagumo. This task force left Brunei after Kurita at 15:00 on 22 October, turning eastward into the Sulu Sea and then northeasterly past the southern tip of Negros Island into the Mindanao Sea. Nishimura then proceeded northeastward with Mindanao Island to starboard and into the south entrance to the Surigao Strait, intending to exit the north entrance of the Strait into Leyte Gulf where he would add his firepower to that of Kurita's force. The Japanese Second Striking Force was commanded by Vice Admiral Kiyohide Shima and comprised heavy cruisers Nachi (flag) and Ashigara, the light cruiser Abukuma, and the destroyers Akebono, Ushio, Kasumi, and Shiranui. The Japanese Southern Force was attacked by U.S. Navy bombers on 24 October but sustained only minor damage.Nishimura was unable to synchronise his movements with Shima and Kurita because of the strict radio silence imposed on the Center and Southern Forces. When he entered the Surigao Strait at 02:00, Shima was 25 nmi (29 mi; 46 km) behind him and Kurita was still in the Sibuyan Sea, several hours from the beaches at Leyte.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN09.bik",
				["debriefingText"] = "Of Nishimura's seven ships, only Shigure survived long enough to escape the debacle, but eventually succumbed to the American submarine Blackfin on 24 January 1945, which sank her off Kota Bharu, Malaya, with 37 dead. Shima's ships did survive the Battle of Surigao Strait, but they were sunk in further engagements around Leyte. The South force provided no further threat to the Leyte landings.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_20_battle_of_surigao_strait.scn",
				["date"] = { 1944, 10, 24, },
				["Pos"] = { -0.045833, 0.351000, 5.000000 },
				--["prerequisites"] = { "USN08" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/USN20.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN02",
					["primaryObjectives"] = {
						"Stop the Japanese advance!",
					},
					["secondaryObjectives"] = {
						"Ensure the survival of both of your shipyards!",
					},
					["hiddenObjectives"] = {
						"Completely annihilate the enemy forces!",
					},
					["hiddenHints"] = {
						"Show the Japanese the true strength of the US Navy!" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"Night battles are extremely dangerous due to the units' lower visibility.",
						"Fire intermittedly with your artillery for maximum accuracy.",
						"Remember to shoot at your targets broadside.",
						"Mission made by The Wolfpack Team. Thank you for playing!",
					},
					["allunitsid"] = {"259","260","261","296","23","19","294","18","21","252"},
					["allunitsnum"] = {"2","2","2","3","8","1","3","1","1","2"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"259","260","261","296","23","19","294","18","21","252"},
				},
			},
			
			{ -- USN09 Divine Winds of Leyte (Vanilla)
				["id"] = "USN09",
				["name"] = "FE.mtree_usn09_name",
				["helpline"] = "MISSION 11 - COMBINED COMBAT\n\nControl the area for the landings on Leyte.",
				["background"] = "fe.mtree_usn09_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN09.bik",
				["debriefingText"] = "usn09.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_09_Leyte.scn",
				["date"] = { 1944, 10, 24, },
				["Pos"] = { -0.045833, 0.340972, 5.000000 },
				--["prerequisites"] = { "USN08" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/USN09.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN09",
					["primaryObjectives"] = {
						"usn09.obj_p1_briefing",
					},
					["secondaryObjectives"] = {
						"usn09.obj_s1"
					},
					["hiddenObjectives"] = {
						"usn09.obj_h1",
					},
					["hiddenHints"] = {
						"usn09.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn09.hint_loadinghint1",
						"usn09.hint_loadinghint2",
						"usn09.hint_loadinghint3",
						"usn09.hint_loadinghint4",
					},
					["allunitsid"] = {"17","102","38","113"},
					["allunitsnum"] = {"1","99","99","99"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"17","102","38","113"},
				},
			},
			
			{ -- USN10 Battle off Cape Engano (Vanilla)
				["id"] = "USN10",
				["name"] = "FE.mtree_usn10_name",
				["helpline"] = "MISSION 12 - COMBINED FLEET OPERATION\n\nEngage the Japanese carriers with your battleships.",
				["background"] = "fe.mtree_usn10_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN10.bik",
				["debriefingText"] = "usn10.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_10_Battle_of_Cape_Engano.scn",
				["date"] = { 1944, 10, 25, },
				["Pos"] = { -0.072917, 0.197917, 5.000000 },
				--["prerequisites"] = { "USN09" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 44, 45, 46, 47, 48, 49, 50, 52, 53 },
				["picture"] = "fe/missions/USN10.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN10",
					["primaryObjectives"] = {
						"usn10.obj_p1",
						"usn10.obj_p2",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"usn10.obj_h1",
					},
					["hiddenHints"] = {
						"usn10.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn10.hint_loadinghint1",
						"usn10.hint_loadinghint2",
						"usn10.hint_loadinghint3",
						"usn10.hint_loadinghint4",
					},
					["allunitsid"] = {"2","23","113","26","38","7","15","19","295"},
					["allunitsnum"] = {"1","5","24","24","18","1","1","1","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"23","113","26","38","7","15","19","295"},
				},
			},
			
			{ -- USN11 Sub on Patrol (Vanilla)
				["id"] = "USN11",
				["name"] = "FE.mtree_usn11_name",
				["helpline"] = "MISSION 13 - UNDERSEA COMBAT\n\nInvestigate and respond to enemy presence in the area.",
				["background"] = "fe.mtree_usn11_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN11.bik",
				["debriefingText"] = "usn11.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_11_protecting_iowa.scn",
				["date"] = { 1944, 11, 29, },
				["Pos"] = { -0.098958, 0.324305, 5.000000 },
				--["prerequisites"] = { "USN10" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = {1,2,3,5,6,7,8,9,10,16,17,18,19,20,21,22,23,25,27,34,35,36,37,38,39,40,44,45,46,47,48,49,50,51},
				["picture"] = "fe/missions/USN11.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN11",
					["primaryObjectives"] = {
						"usn11.obj_p1",
					},
					["secondaryObjectives"] = {
						"usn11.obj_s1",
					},
					["hiddenObjectives"] = {
						"usn11.obj_h1",
					},
					["hiddenHints"] = {
						"usn11.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn11.hint_loadinghint1",
						"usn11.hint_loadinghint2",
						"usn11.hint_loadinghint3",
						"usn11.hint_loadinghint4",
					},
					["allunitsid"] = {"31", "125"},
					["allunitsnum"] = {"1", "1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"31", "125"},
				},
			},
			
			{ -- USN12 Raid on Indochina (Vanilla)
				["id"] = "USN12",
				["name"] = "FE.mtree_usn12_name",
				["helpline"] = "MISSION 14 - AIR COMBAT\n\nEscort friendly bombers on a bombing mission against Japanese supply routes.",
				["background"] = "fe.mtree_usn12_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN12.bik",
				["debriefingText"] = "usn12.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_12_Indochina.scn",
				["date"] = { 1945, 01, 11, },
				["Pos"] = { -0.285417, 0.309028, 5.000000 },
				--["prerequisites"] = { "USN11" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1,2,3,21,22,23,25,30,44,45,46,47,48 },
				["picture"] = "fe/missions/USN12.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN12",
					["primaryObjectives"] = {
						"usn12.obj_p1",
						"usn12.obj_p2",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"usn12.obj_h1",
					},
					["hiddenHints"] = {
						"usn12.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn12.hint_loadinghint1",
						"usn12.hint_loadinghint2",
						"usn12.hint_loadinghint3",
						"usn12.hint_loadinghint4",
					},
					["allunitsid"] = {"102", "104"},
					["allunitsnum"] = {"12", "12"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"102", "104"},
				},
			},
			
			{ -- USN13 Invading Iwojima (Vanilla)
				["id"] = "USN13",
				["name"] = "FE.mtree_usn13_name",
				["helpline"] = "MISSION 15 - AIR COMBAT\n\nSoften up the defenses with air support until the marines land.",
				["background"] = "fe.mtree_usn13_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN13.bik",
				["debriefingText"] = "usn13.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_13_Battle_of_Iwo_Jima.scn",
				["date"] = { 1945, 02, 19, },
				["Pos"] = { 0.201042, 0.042361, 5.000000 },
				--["prerequisites"] = { "USN12" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1,2,3,5,6,7,8,13,16,17,18,19,20,21,22,25,31,44,45,46,47,48,49},
				["picture"] = "fe/missions/USN13.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN13",
					["primaryObjectives"] = {
						"usn13.obj_p1",
						"usn13.obj_p2",
					},
					["secondaryObjectives"] = {
						"usn13.obj_s1",
						"usn13.obj_s2",
					},
					["hiddenObjectives"] = {
						"usn13.obj_h1",
					},
					["hiddenHints"] = {
						"usn13.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn13.hint_loadinghint1",
						"usn13.hint_loadinghint2",
						"usn13.hint_loadinghint3",
						"usn13.hint_loadinghint4",
					},
					["allunitsid"] = {"116", "26", "102"},
					["allunitsnum"] = {"24", "15", "15"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"116", "26", "102"},
				},
			},
			
			{ -- USN14 Battle of Okinawa (Vanilla)
				["id"] = "USN14",
				["name"] = "FE.mtree_usn14_name",
				["helpline"] = "MISSION 16 - COMBINED FLEET OPERATION\n\nConclude the Pacific campaign by defeating the Japanese forces at Okinawa.",
				["background"] = "fe.mtree_usn14_background",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN14.bik",
				["debriefingText"] = "usn14.debriefing",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_14_battle_of_okinawa.scn",
				["date"] = { 1945, 04, 01, },
				["Pos"] = { -0.053125, 0.059027, 5.000000 },
				--["prerequisites"] = { "USN13" },
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 44, 45, 46, 47, 48, 49, 50, 52, 53 },
				["picture"] = "fe/missions/USN14.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN14",
					["primaryObjectives"] = {
						"usn14.obj_p1",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"usn14.obj_h1",
					},
					["hiddenHints"] = {
						"usn14.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/USN01.tga",
--						"fe/missions/USN02.tga",
--						"fe/missions/USN03.tga",
--					},
					["hints"] = {
						"usn14.hint_loadinghint1",
						"usn14.hint_loadinghint2",
						"usn14.hint_loadinghint3",
						"usn14.hint_loadinghint4",
					},
					["allunitsid"] = {"23","25", "7", "295", "256", "234", "12", "26", "38", "113"},
					["allunitsnum"] = {"2","2", "2", "1", "1", "6", "3", "30", "30", "30"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"23","25", "7", "295", "256", "234", "12", "26", "38", "113"},
				},
			},
			
			{ -- USN17 Operation Downfall (New)
				["id"] = "USN17",
				["name"] = "Operation Downfall",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nBONUS MISSION - COMBINED FLEET OPERATION\n\nThe inevitable has happened, Japan has not surrendered... Crush the remaining Japanese resistance in this final battle!",
				["background"] = "Operation Downfall was the proposed Allied plan for the invasion of the Japanese Home Islands near the end of World War II. The planned operation was canceled when Japan surrendered following the atomic bombings of Hiroshima and Nagasaki, the Soviet declaration of war and the invasion of Manchuria. The operation had two parts: Operation Olympic and Operation Coronet. Set to begin in November 1945, Operation Olympic was intended to capture the southern third of the southernmost main Japanese island, Kyushu, with the recently captured island of Okinawa to be used as a staging area. In early 1946 would come Operation Coronet, the planned invasion of the Kanto Plain, near Tokyo, on the main Japanese island of Honshu. Airbases on Kyushu captured in Operation Olympic would allow land-based air support for Operation Coronet. If Downfall had taken place, it would have been the largest amphibious operation in history. Japan's geography made this invasion plan quite obvious to the Japanese as well; they were able to accurately predict the Allied invasion plans and thus adjust their defensive plan, Operation Ketsugo, accordingly. The Japanese planned an all-out defense of Kyushu, with little left in reserve for any subsequent defense operations. Casualty predictions varied widely, but were extremely high. Depending on the degree to which Japanese civilians would have resisted the invasion, estimates ran up into the millions for Allied casualties.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_USN14.bik",
				["debriefingText"] = "Japan has been invaded, and the bloodbath had only just begun. Who knows how much longer the war would have gone on for, if this had actually happened...\n\nMade in honor of all those that died during the war.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."USN/usn_17_tokyo.scn",
				["date"] = { 1945, 09, 28, },
				["Pos"] = { 0.18, -0.165, 5.000000 },
				--["prerequisites"] = { "USN14" },
				["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 44, 45, 46, 47, 48, 49, 50, 52, 53 },
				["picture"] = "fe/missions/USN17.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN14",
					["primaryObjectives"] = {
						"Invade Tokyo Bay!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Destroy both of the inland airfields!",
					},
					["hiddenHints"] = {
						"Dem AFs doe..."
					},
					["hints"] = {
						"Use your rear and side gunners to fend off attacking enemy planes.",
						"Never leave your troop transports exposed during a landing operation.",
						"Modify your ship formations to maximize your AA effectiveness.",
						"Mission made by Team Wolfpack. Enjoy!",
					},
					["allunitsid"] = {"117","26","38","113","302","256","15","7","295","11","23","234","41","12"},
					["allunitsnum"] = {"45","60","50","50","1","2","1","1","1","4","4","2","2","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"26","38","113","256","15","7","295","11","23"},
				},
			},
			
			---- REGULAR US MISSION END ----
			
		},
	},
	
	{ -- Japanese Bonus Missions
		["groupName"] = "IJN DLC",
		["helpLine"] = "FE.main_cs_allycamp_help",
		["gratMsg"] = "FE.rewards_congratulations_uscampaign",
		["gratDate"] = { 1941, 12, 07 },
		["missions"] = {
			
			---- VANILLA MISSION START ----
			
			--[[{ -- JM01 Attack on Pearl Harbor (Vanilla)
				["id"] = "JM01",
 				["name"] = "FE.mtree_ijn01_name",
 				["helpline"] = "VANILLA MISSION 01 - AIR COMBAT\n\nTora! Tora! Tora! Surprise the anchored US fleet.",
 				["background"] = "fe.mtree_ijn01_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN01.bik",
				["debriefingText"] = "ijn01.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_01_attack_on_pearl_harbor.scn",
				["date"] = { 1941, 12, 07, },
				["Pos"] = { 1.24, 0.090278, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/JM01.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN01",
					["primaryObjectives"] = {
						"ijn01.obj_p1",
						"ijn01.obj_p2",
						"ijn01.obj_p3",
						"ijn01.obj_s1" --mert a fasze kell mindig atirni minden szart utolag
					},
					["secondaryObjectives"] = {
						"ijn01.obj_h2",
					},
					["hiddenObjectives"] = {
						"ijn01.obj_h1",
						--"ijn01.obj_h2",							--nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn01.obj_h1_hint",
						--"ijn01.obj_h2_hint",						--hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn01.hint_loadinghint_1",
						"ijn01.hint_loadinghint_2",
						"ijn01.hint_loadinghint_3",
						"ijn01.hint_loadinghint_4",
					},
					["allunitsid"]  = {"150","158","162",},
					["allunitsnum"] = {"43","50","89",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},]]
			
			{ -- JM02 Destruction of Force Z (Vanilla)
				["id"] = "JM02",
 				["name"] = "FE.mtree_ijn02_name",
 				["helpline"] = "VANILLA MISSION 01 - AIR COMBAT\n\nThe rise of naval aviation brings an end to the era of the dreadnoughts.",
 				["background"] = "fe.mtree_ijn02_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN02.bik",
				["debriefingText"] = "ijn02.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_02_force_z.scn",
				["date"] = { 1941, 12, 10, },
				["Pos"] = { -0.235417, 0.465278, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... challange",
				["navalacademy"] = { 28, 31 },
				["picture"] = "fe/missions/JM02.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN02",
					["primaryObjectives"] = {
						"ijn02.obj_p1",
-- 						"ijn02.obj_p2",    -- Briefingben nem megjeleno objectiva
						"ijn02.obj_p3",
					},
					["secondaryObjectives"] = {
--						"ijn02.obj_s1", -- Briefingben nem megjeleno objectiva
					},
					["hiddenObjectives"] = {
						"ijn02.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn02.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn02.hint_loadinghint_1",
						"ijn02.hint_loadinghint_2",
						"ijn02.hint_loadinghint_3",
						"ijn02.hint_loadinghint_4",
					},
					["allunitsid"]  = {"166","167"},
					["allunitsnum"] = {"5","5"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- JM03 Battle of the Java Sea (Vanilla)
				["id"] = "JM03",
 				["name"] = "FE.mtree_ijn03_name",
 				["helpline"] = "VANILLA MISSION 02 - SEA COMBAT\n\nBe part of a Japanese task force to halt the ABDA forces.",
 				["background"] = "fe.mtree_ijn03_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN03.bik",
				["debriefingText"] = "ijn03.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_03_battle_of_the_java_sea.scn",
				["date"] = { 1942, 02, 27, },
				["Pos"] = { -0.155208, 0.615278, 5.000000 },
				--["prerequisites"] = { "JM02" },
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 5, 6, 7, 8, 9, 10, 14, 16, 17, 18, 19, 20 },
				["picture"] = "fe/missions/JM03.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN03",
					["primaryObjectives"] = {
						"ijn03.obj_p1",
						"ijn03.obj_p2",
--						"ijn03.obj_p3",
--						"ijn03.obj_p4",
--						"ijn03.obj_p5",
					},
					["secondaryObjectives"] = {
--						"ijn03.obj_s1",
--						"ijn03.obj_s2",
					},
					["hiddenObjectives"] = {
						"ijn03.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn03.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn03.hint_loadinghint_1",
						"ijn03.hint_loadinghint_2",
						"ijn03.hint_loadinghint_3",
						"ijn03.hint_loadinghint_4",
					},
					["allunitsid"]  = {"67"},
					["allunitsnum"] = {"1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					--["allunitslockhint"] = {},
					["changeables"] = {"67"},
				},
			},
			
			{ -- JM05 Invasion of Port Moresby (Vanilla)
				["id"] = "JM05",
 				["name"] = "Invasion of Port Moresby",
 				["helpline"] = "VANILLA MISSION 03 - COMBINED FLEET OPERATION\n\nTake the lead of an amphibious ship group and send your marines to capture the shores.",
 				["background"] = "fe.mtree_ijn05_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN05.bik",
				["debriefingText"] = "ijn05.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_05_invasion_of_port_moresby.scn",
				["date"] = { 1942, 05, 17, },
				["Pos"] = { 0.401041, 0.726389, 5.000000 },
				--["prerequisites"] = { "JM03" },
				["description"] = "'Invasion of Port Moresby' is another extraordinary challange for the top notch players. (Donald not included, can be bought seperately)",
				["navalacademy"] = { 11, 29, 44, 45, 46, 47, 49, 50, 54, 55, 56 },
				["picture"] = "fe/missions/JM05.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN05",
					["primaryObjectives"] = {
						"ijn05.obj_p4", --a tabla indexe alapjan 1_pri_objective_Group es 1_pri_Group tartozik hozza
						"ijn05.obj_p1", --a tabla indexe alapjan 2_pri_objective_Group es 2_pri_Group tartozik hozza
						"ijn05.obj_p2", --a tabla indexe alapjan 3_pri_objective_Group es 3_pri_Group tartozik hozza, mivel jelenleg nincs ilyen a briefing fileban nem is latszodik
					},
					["secondaryObjectives"] = {
						"ijn05.obj_s1", --a tabla indexe alapjan 1_sec_objective_Group es 1_sec_Group tartozik hozza
					},
					["hiddenObjectives"] = {
						"ijn05.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn05.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn05.hint_loadinghint_1",
						"ijn05.hint_loadinghint_2",
						"ijn05.hint_loadinghint_3",
						"ijn05.hint_loadinghint_4",
						"ijn05.hint_loadinghint_5",
					},
					["allunitsid"]  = {"275","67","70","224","150",},
					["allunitsnum"] = {"2","1","1","5","1",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"150","275","67"},
				},
			},
			
			{ -- JM06 Hunt for the USS Hornet (Vanilla)
				["id"] = "JM06",
 				["name"] = "FE.mtree_ijn06_name",
 				["helpline"] = "VANILLA MISSION 04 - UNDERSEA COMBAT\n\nCommand a Japanese submarine in search of the USS Hornet.",
 				["background"] = "fe.mtree_ijn06_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN06.bik",
				["debriefingText"] = "ijn06.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_06_prelude_to_midway.scn",
				["date"] = { 1942, 05, 28, },
				["Pos"] = { 0.816667, -0.033333, 5.000000 },
				--["prerequisites"] = { "JM05" },
				["description"] = "Subsomething",
				["navalacademy"] = { 34, 35, 36, 37, 38, 39, 40, 42, 51 },
				["picture"] = "fe/missions/JM06.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN06",
					["primaryObjectives"] = {
						"ijn06.obj_p1",
--						"ijn06.obj_p2",
--						"ijn06.obj_p3",
					},
					["secondaryObjectives"] = {
						"ijn06.obj_s1",
--						"ijn06.obj_s2",
--						"ijn06.obj_s3",
					},
					["hiddenObjectives"] = {
						"ijn06.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn06.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn06.hint_loadinghint_1",
						"ijn06.hint_loadinghint_2",
						"ijn06.hint_loadinghint_3",
						"ijn06.hint_loadinghint_4",
					},
					["allunitsid"]  = {"93",},
					["allunitsnum"] = {"3",},
					["changeables"] = {"93",},
				},
			},
			
			{ -- JM07 Invasion of Midway (Vanilla)
				["id"] = "JM07",
 				["name"] = "FE.mtree_ijn07_name",
 				["helpline"] = "VANILLA MISSION 05 - COMBINED FLEET OPERATION\n\nChange the course of history and win the battle of Midway for the Japanese Empire.",
 				["background"] = "fe.mtree_ijn07_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN07.bik",
				["debriefingText"] = "ijn07.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_07_invasion_of_midway.scn",
				["date"] = { 1942, 06, 04, },
				["Pos"] = { 0.908333, -0.043056, 5.000000 },
				--["prerequisites"] = { "JM06" },
				["description"] = "Some sort of mission",
				["navalacademy"] = {24,26,27,48,49,50,52,53},
				["picture"] = "fe/missions/JM07.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN07",
					["primaryObjectives"] = {
						"ijn07.obj_p1",
--						"ijn07.obj_p2",
--						"ijn07.obj_p3",
					},
					["secondaryObjectives"] = {
--						"ijn07.obj_s1",
						"ijn07.obj_s2",
					},
					["hiddenObjectives"] = {
						"ijn07.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn07.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn07.hint_loadinghint_1",
						"ijn07.hint_loadinghint_2",
						"ijn07.hint_loadinghint_3",
						"ijn07.hint_loadinghint_4",
					},
					["allunitsid"]  = {"61","69","52","51","275","150","162","158"},
					["allunitsnum"] = {"1","1","1","1","1","80","60","60"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"61","69","275","150","158"},
				},
			},
			
			{ -- JM08 Defense of Guadalcanal (Vanilla)
				["id"] = "JM08",
 				["name"] = "FE.mtree_ijn08_name",
 				["helpline"] = "VANILLA MISSION 06 - COMBINED FLEET OPERATION\n\nRepel American advancement towards Guadalcanal's shores.",
 				["background"] = "fe.mtree_ijn08_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN08.bik",
				["debriefingText"] = "ijn08.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_08_defend_guadalcanal.scn",
				["date"] = { 1942, 11, 12, },
				["Pos"] = { 0.606250, 0.727083, 5.000000 },
				--["prerequisites"] = { "JM07" },
				--["sideMission"] = true,
				["description"] = "Some sort of challange",
				["navalacademy"] = {23,24,48,52,53,56},
				["picture"] = "fe/missions/JM08.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN08",
					["primaryObjectives"] = {
						"ijn08.obj_p1",
						"ijn08.obj_p2",
--						"ijn08.obj_p3",
					},
					["secondaryObjectives"] = {
--						"ijn08.obj_s1",
					},
					["hiddenObjectives"] = {
						"ijn08.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn08.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn08.hint_loading_1",
						"ijn08.hint_loading_2",
						"ijn08.hint_loading_3",
						"ijn08.hint_loading_4",
					},
					["allunitsid"]  = {"152","154","167","77","174"},
					["allunitsnum"] = {"33","33","9","20", "5"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {"152","154","174","167"},
				},
			},
			
			{ -- JM10 Attack on Sydney Harbor (Vanilla)
				["id"] = "JM10",
 				["name"] = "Attack on Sydney Harbor",
 				["helpline"] = "VANILLA MISSION 07 - UNDERSEA COVERT OPERATION\n\nSneak into Sydney Harbor unseen to torpedo a vital supply ship.",
 				["background"] = "fe.mtree_ijn10_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN10.bik",
				["debriefingText"] = "ijn10.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_10_sydney.scn",
				["date"] = { 1942, 12, 21, },
				["Pos"] = { 0.456250, 1.232638, 5.000000 },
				--["prerequisites"] = { "JM08" },
				--["sideMission"] = true,
				["description"] = "Some kind of mission.",
				["navalacademy"] = {34,35,36,37,38,39,40,51},
				["picture"] = "fe/missions/JM10.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN10",
					["primaryObjectives"] = {
						"ijn10.obj_p1",
						"ijn10.obj_p2",
--						"ijn10.obj_p3",
					},
					["secondaryObjectives"] = {
						"ijn10.obj_s1",
					},
					["hiddenObjectives"] = {
						"ijn10.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn10.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn10.hint_loadinghint1",
						"ijn10.hint_loadinghint2",
						"ijn10.hint_loadinghint3",
						"ijn10.hint_loadinghint4",
					},
					["allunitsid"]  = {"83",},
					["allunitsnum"] = {"3",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- JM11 Seizing the Fijis (Vanilla)
				["id"] = "JM11",
 				["name"] = "Seizing the Fijis",
 				["helpline"] = "VANILLA MISSION 08 - COMBINED FLEET OPERATION\n\nLead a combined task force to overwhelm the Allies on the Fijian Islands.",
 				["background"] = "fe.mtree_ijn11_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN11.bik",
				["debriefingText"] = "ijn11.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_11_invasion_of_fiji.scn",
				["date"] = { 1943, 03, 07, },
				["Pos"] = { 0.902083, 0.900000, 5.000000 },
				--["prerequisites"] = { "JM10" },
				["description"] = "Some kind of mission.",
				["navalacademy"] = {52,53,54,55,56},
				["picture"] = "fe/missions/JM11.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"ijn11.obj_p1",
					},
					["secondaryObjectives"] = {
--						"ijn11.obj_s1",
--						"ijn11.obj_s2",
					},
					["hiddenObjectives"] = {
						"ijn11.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn11.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn11.hint_loading_1",
						"ijn11.hint_loading_2",
						"ijn11.hint_loading_3",
						"ijn11.hint_loading_4",
					},
					["allunitsid"]  = {"254","50","272","69","224","150","163","159",},
					["allunitsnum"] = {"1","1","1","1","2","40","40","40",},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"254","272","150","69","159",},
				},
			},
			
			{ -- JM14 Invasion of Hawaii (Vanilla)
				["id"] = "JM14",
 				["name"] = "FE.mtree_ijn14_name",
 				["helpline"] = "VANILLA MISSION 09 - COMBINED FLEET OPERATION\n\nCrush the American resistance in this decisive battle.",
 				["background"] = "fe.mtree_ijn14_background",
 				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "ijn14.debriefing",
 				["debriefingVoice"] = "",
 				["sceneFile"] = sceneFilePath.."IJN/JM/ijn_14_invasion_of_havaii.scn",
				["date"] = { 1944, 01, 01, },
				["Pos"] = { 1.240625, 0.101389, 5.000000 },
				--["prerequisites"] = { "JM11" },
				["description"] = "Some kind of mission.",
				["navalacademy"] = {44,45,46,47,48,49,50,52,53},
				["picture"] = "fe/missions/JM14.tga",
				["forcedDifficultyLevel"] = nil,
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"ijn14.obj_p1",
--						"ijn14.obj_p2",
--						"ijn14.obj_p3",
					},
					["secondaryObjectives"] = {
--						"ijn14.obj_s1",
					},
					["hiddenObjectives"] = {
						"ijn14.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
					},
					["hiddenHints"] = {
						"ijn14.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
					},
--					["loadingBackgrounds"] = {
--						"fe/missions/IJN01.tga",
--						"fe/missions/IJN02.tga",
--						"fe/missions/IJN03.tga",
--					},
					["hints"] = {
						"ijn14.hint_loading_1",
						"ijn14.hint_loading_2",
						"ijn14.hint_loading_3",
						"ijn14.hint_loading_4",
					},
					["allunitsid"]  = {"257","51","59","69","71","73","163","151","159"},
					["allunitsnum"] = {"1","1","1","1","1","2","30","30","30"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {"151","73","69","59","159",},
				},
			},
			
			---- VANILLA MISSION END ----
			
			---- LARGE MISSION START ----
			
			{ -- LM01 Java Sea Rush
				["id"] = "LM01",
				["name"] = "Java Sea Rush",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nLARGE MISSION 01 - COMBINED FLEET OPERATION\n\nDestroy the Allied resistance fleets in the Java Sea.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN03.bik",
				["debriefingText"] = "The Java Sea has been cleared.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/LM/java_charge.scn",
				["date"] = { 1942, 01, 05, },
				["Pos"] = { -0.155208, 0.615278, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/LM01.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN03",
					["primaryObjectives"] = {
						"Sink the ABDACOM cruisers!",
						"Destroy the British battleships!",
						"Break the final wave!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"59","284","388","278","270","277"},
					["allunitsnum"] = {"2","2","3","7","7","13"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- LM02 The Grand Battle
				["id"] = "LM02",
				["name"] = "The Grand Battle",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nLARGE MISSION 02 - COMBINED FLEET OPERATION\n\nAnnihilate the American carrier forces in the morning fog.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "The American carriers are no more.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/LM/kan_kes.scn",
				["date"] = { 1943, 11, 01, },
				["Pos"] = { 0.792, 0.778472, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/LM02.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"Find and sink the Enterprise!",
						"Finish all the enemy capital ships!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"291","271","257","57","59","388","280","278","270","277","322","328","159"},
					["allunitsnum"] = {"4","3","2","1","1","1","2","6","3","16","400","400","400"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- LM03 Battle of the Mountain Range
				["id"] = "LM03",
				["name"] = "Battle of the Mountain Range",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nLARGE MISSION 03 - COMBINED FLEET OPERATION\n\nClear the area of suspicious Allied activity.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "America's grand Midway classes now lay at the bottom of the sea.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/LM/mt_rng.scn",
				["date"] = { 1943, 12, 31, },
				["Pos"] = { 1.25, 0.505, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/LM03.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"Run the enemy blockade before the enemy damages your carriers!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"291","271","257","57","59","388","278","270","277","322","328","159"},
					["allunitsnum"] = {"4","3","2","1","3","2","8","11","25","400","400","400"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- LM04 Road to San Francisco
				["id"] = "LM04",
				["name"] = "Road to San Francisco",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nLARGE MISSION 04 - COMBINED FLEET OPERATION\n\nRun the San Francisco Blockade.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "The path to San Francisco is now clear.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/LM/sf_dash.scn",
				["date"] = { 1944, 01, 14, },
				["Pos"] = { 1.64, -0.2376, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/LM04.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"Sink the enemy blockade!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"291","59","388","287","284","278","270","277","322","328","159"},
					["allunitsnum"] = {"4","1","1","1","1","4","2","14","160","160","160"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- LM06 Strike of the Red Tiger
				["id"] = "LM06",
				["name"] = "Strike of the Red Tiger",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nLARGE MISSION 05 - COMBINED FLEET OPERATION\n\nA heavily defended convoy has been spotted out in the pacific, it must be sunk.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "A great victory, the attack on the convoy baited out two enemy strike fleets which both joined the convoy at the bottom of the sea.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/LM/strike.scn",
				["date"] = { 1941, 12, 31, },
				["Pos"] = { 1.436, 0.205, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/LM06.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN06",
					["primaryObjectives"] = {
						"Sink the enemy convoy!",
						"Sink the enemy battleships!",
						"Sink the enemy carriers!",
					},
					["secondaryObjectives"] = {
					
					},
					["hiddenObjectives"] = {
					
					},
					["hiddenHints"] = {
			
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"271","57","291","287","280","279","68","273","322","328","159"},
					["allunitsnum"] = {"1","1","1","1","1","1","3","11","120","120","120"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- LM05 Defense of Hokkaido
				["id"] = "LM05",
				["name"] = "Defense of Hokkaido",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nLARGE MISSION 06 - COMBINED FLEET OPERATION\n\nHalt the Allied ambush.",
				["background"] = "",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN14.bik",
				["debriefingText"] = "The war is over. The last Allied ships have been sunk.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."IJN/LM/mg_final.scn",
				["date"] = { 1944, 02, 25, },
				["Pos"] = { 0.395, -.290, 5.000000 },
				["prerequisites"] = {},
				["description"] = "Some kind of... mission",
				["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
				["picture"] = "fe/missions/LM05.tga",
				["forcedDifficultyLevel"] = nil,
				["MovieName"] = "",
				["japanese"] = {
					["briefingGuiLayer"] = "IJN14",
					["primaryObjectives"] = {
						"Destroy the landing fleet!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
					},
					["hiddenHints"] = {
					},
					["hints"] = {
						"Modify your ship formations to maximize AA efficency.",
						"Pay attention to all three dimensions of combat; air, sea and underwater.",
						"It would be adviseable to engage the enemy aircraft as far away from your fleet as possible.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"]  = {"291","271","257","255","388","278","273","329","183","328"}, 
					["allunitsnum"] = {"4","3","3","3","3","12","14","400","400","400"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["allunitslockhint"] = {},
					["changeables"] = {},
				},
			},
			
			---- LARGE MISSION END ----
			
		},
	},
	
	{ -- German Bonus Missions
		["groupName"] = "USN DLC",
		["helpLine"] = "FE.main_cs_allycamp_help",
		["gratMsg"] = "FE.rewards_congratulations_uscampaign",
		["gratDate"] = { 1941, 12, 07 },
		["missions"] = {
		
			{ -- KMS01 Operation Meeresblitz
				["id"] = "KMS01",
				["name"] = "Operation Meeresblitz",
				["helpline"] = "MISSION 01 - SHIP COMBAT\n\nDestroy the fleeing French convoy and bring an end to the French Republic.",
				["background"] = "The war in Europe had just begun, and France was quickly overrun by the Germany army. As the French are almost at the point of surrender, they sent out one last convoy from their mainland to the United Kingdom, in the hopes of preserving the country's best kept secrets. German intelligence, however, learned of this operation, and quickly dispatched their available capital ships in this short but fast naval operation.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN12.bik",
				["debriefingText"] = "The convoy was systematically taken apart and destroyed, with most if not all the escorts destroyed. Despite the brave British counter-attack, they did not have enough firepower to destroy the German Force, and the German capital ships lived to fight another day.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."KMS/kms_1.scn",
				["date"] = { 1940, 05, 17, },
				["Pos"] = { 1.58, 1.6025, 5.000000 },
				--["prerequisites"] = {},
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/KMS01.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "USN02",
					["primaryObjectives"] = {
						"Sink the enemy convoy!",
					},
					["secondaryObjectives"] = {
						"Ensure the survival of both of your cruisers!",
					},
					["hiddenObjectives"] = {
						"Destroy all reinforcements!",
					},
					["hiddenHints"] = {
						"SIGN OF POWER, SHOW OF FORCE!",
					},
					["hints"] = {
						"Bismarck, although very powerful, can get overwhelmed by more smaller ships if left unescorted.",
						"Fire intermittedly with your artillery for maximum accuracy.",
						"Remember to shoot at your targets broadside.",
						"Mission made by The Wolfpack Team. Thank you for playing!",
					},
					["allunitsid"] = {"250","251","264"}, -- Bismarck, Admiral Hipper, Maass
					["allunitsnum"] = {"2","2","4"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- KMS02 Wolfpack II
				["id"] = "KMS02",
				["name"] = "Wolfpack II",
				["helpline"] = "MISSION 02 - COMBINED COMBAT\n\nDestroy the large Allied convoy with your Wolfpack.",
				["background"] = "Arguably the largest part of the German ''Kriegsmarine'' was their submarine force. The German U-Boats were some of the most effective submarines ever built, especially when operating in so called ''wolfpacks''. The Allies had just sent a huge combined convoy to the island of Malta, the only Allied stronghold in the Mediterranean. The German submarines in the area plan to intercept the large convoy, and destroy it.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN12.bik",
				["debriefingText"] = "With the assistance of the Italians, which happened to be in the area, the convoy was completely annihilated, and Malta was now permanently isolated and would soon be forced to surrender.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."KMS/kms_2.scn",
				["date"] = { 1941, 10, 11, },
				["Pos"] = { 1.608, 1.99, 5.000000 },
				--["prerequisites"] = { "KMS01" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/KMS02.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "IJN06",
					["primaryObjectives"] = {
						"Sink all cargo ships!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Don't lose any of your submarines!",
					},
					["hiddenHints"] = {
						"''One hit, and we are going down. Avoid ze depf charges!''",
					},
					["hints"] = {
						"It takes 2 torpedoes to sink a destroyer or a cargo ship.",
						"Diving to crash depth level will slowly harm your submarines hull.",
						"Always keep an eye on the oxygen meter.",
						"Make good use of both submarines available to you.",
					},
					["allunitsid"] = {"193","283","282"},
					["allunitsnum"] = {"5","1","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- KMS03 Winter Fury
				["id"] = "KMS03",
				["name"] = "Winter Fury",
				["helpline"] = "MISSION 03 - COMBINED COMBAT\n\nSupport the land invasion by eliminating land installations on the Soviet coast.",
				["background"] = "The Navy of the Soviet Union, although not nearly as powerful as the other major nations of the world, was still of great concern to the Germans. The land invasion of the Soviet Union had just begun, and the Germans wanted to use their fast ships they had at their disposal in order to assist the landing troops with capturing their coastal objectives. However, due to the lack of the Washington Naval Treaty, the Soviets do have a nasty trick up their sleeve...",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN12.bik",
				["debriefingText"] = "The Soviets sprang their biggest susprise, and brought in one of the largest battleships afloat, the Kremlin. Regardless however, the Germans managed to outmanouver the Soviets, and destroy their forces, and the invasion of the Soviet Union resumed.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."KMS/kms_3.scn",
				["date"] = { 1942, 02, 01, },
				["Pos"] = { 1.8485, 1.347, 5.000000 },
				--["prerequisites"] = { "KMS02" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/KMS03.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "IJN05",
					["primaryObjectives"] = {
						"Strike the enemy land installations!",
					},
					["secondaryObjectives"] = {
						"Prevent the loss of 3 or more of your destroyers!",
					},
					["hiddenObjectives"] = {
						"Destroy all land installations!",
					},
					["hiddenHints"] = {
						"-.- .. .-.. .-.. / -.. . -- / ..-. --- .-. - .-. . ... ... . ... -.-.--",
					},
					["hints"] = {
						"Don't engage a stronger enemy head-on, instead opt for a more sneaky approach.",
						"Use torpedoes to cripple the larger vessels.",
						"Don't let your stronger ships get swarmed.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"] = {"262","264","313"},
					["allunitsnum"] = {"1","7","1"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- KMS04 Invasion of the Azores
				["id"] = "KMS04",
				["name"] = "Invasion of the Azores",
				["helpline"] = "MISSION 04 - COMBINED OPERATION\n\nCapture the crucial Azore islands in the vastness of the Atlantic.",
				["background"] = "The Azores are an island chain far off the coast of Portugal, however they had been given to the administration of the United Kingdom soon after the war started. It provides an ideal central Atlantic base for the British, allowing them to have a base for their submarine-hunting ships and aircraft, significantly hampering the progress of the German U-Boats operating in the Atlantic. As a result, it was absolutely neccessary for the Germans to control the islands, as it would deny the UK a vital base. This would be the first naval invasion of the ''Kriegsmarine'', and it would prove to the world if the German Navy had the capabilities of conducting effective naval invasions.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN12.bik",
				["debriefingText"] = "Although the Allies provided extreme resistance, comitting several battleships and carriers, the Germans managed to overpower them, and take control of the Azores. The German Navy now proved that it has the capabilities of naval invasions.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."KMS/kms_4.scn",
				["date"] = { 1943, 04, 28, },
				["Pos"] = { 1.39, 1.685, 5.000000 },
				--["prerequisites"] = { "KMS03" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/KMS04.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Secure all enemy bases!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Ensure the survival of all your ships!",
					},
					["hiddenHints"] = {
						"usn14, dlg03b"
					},
					["hints"] = {
						"Never leave your troop transports exposed during a landing operation.",
						"Always ensure you have a few CAP-dedicated squadrons over your fleet.",
						"You are going to be outnumbered, so use all the assets you have at your disposal.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"] = {"319","337","313","285","312","310","264","344"},
					["allunitsnum"] = {"30","30","1","1","1","5","2","3"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
			
			{ -- KMS05 Operation Sealion
				["id"] = "KMS05",
				["name"] = "Operation Sealion",
				["helpline"] = "WARNING: UNSTABLE! PLAY AT OWN RISK!\n\nMISSION 05 - COMBINED OPERATION\n\nTake part in the largest amphibious invasion in history and crush the British resistance.",
				["background"] = "The largest naval invasion in history is about to commence, stretching for miles upon miles, the British coast will soon feel the full might of the German navy. The British are aware of the plan, and are prepared, having assembled most of their remaining available vessels to the area's defense. The Germans, however, comitted all available and operational capital ships to them, to the invasion, and are intent on becoming the first nation in history to successfully invade the modern United Kingdom.",
				["backgroundVoice"] = "",
				["backgroundMovie"] = "movies/Footage_IJN12.bik",
				["debriefingText"] = "Despite more heavy resistance, and hard fighting on the part of the British, the invasion was a success, and for the first time in history another modern nation had successfully invaded the United Kingdom.",
				["debriefingVoice"] = "",
				["sceneFile"] = sceneFilePath.."KMS/kms_5.scn",
				["date"] = { 1943, 09, 16, },
				["Pos"] = { 1.567, 1.6012, 5.000000 },
				--["prerequisites"] = { "KMS04" },
				--["sideMission"] = true,
				["description"] = "",
				["navalacademy"] = { 1, 2, 3, 8, 21, 22, 23, 25, 26, 27, 44, 45, 46, 47, 48},
				["picture"] = "fe/missions/KMS05.tga",
				["forcedDifficultyLevel"] = nil,
				["allied"] = {
					["briefingGuiLayer"] = "IJN11",
					["primaryObjectives"] = {
						"Secure all enemy bases!",
					},
					["secondaryObjectives"] = {
					},
					["hiddenObjectives"] = {
						"Ensure the survival of all your capital ships!",
					},
					["hiddenHints"] = {
						"The big boys are back."
					},
					["hints"] = {
						"Multitasking is important to win this final battle.",
						"Never leave your troop transports exposed during a landing operation.",
						"Remember to shoot at your targets broadside.",
						"Turn broadside to maximize your AA potential.",
					},
					["allunitsid"] = {"319","347","337","338","313","250","262","356","251","312","310","344"},
					["allunitsnum"] = {"30","30","30","30","1","1","1","1","1","1","7","4"},
					["allunitslockid"] = {},
					["allunitslocknum"] = {},
					["changeables"] = {},
				},
			},
		
		},
	},
	
}

---- MULTIPLAYER & SKIRMISH MISSIONS ----

MissionTree["multiMissionInfos"] =
{
	
	---- VANILLA MAP START ----
	
	{ -- MULTI001 Dreadnought (Vanilla)
		["id"] = "29",
		["name"] = "mp01.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene1.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp01.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-14999.0000, 0.0000, 9543.6436,},
			["IslandCapture3v3_se"] = {14999.0000, 0.0000, -8095.1602,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_01",
				"mp.loading_02",
				"mp.loading_03",
				"mp.loading_04",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","316","317"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_01",
				"mp.loading_02",
				"mp.loading_03",
				"mp.loading_04",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","275","71","67"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","71","67","61"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","71","67","61"},
			["multiunitsidIC4v4"] = {"150","158","162","167","275","71","67","61"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150"},
			["multiunitsidCompetitive"] = {"167"},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
			  --[0] = { ["MenuDIS"] = true, }, --IC small
			  --[1] = { ["MenuDIS"] = true, }, --IC medium
			  --[2] = { ["MenuDIS"] = true, }, --IC large
			  --[3] = { ["MenuDIS"] = true, }, --IC huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = { ["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI002 Swirl (Vanilla)
		["id"] = "30",
		["name"] = "mp02.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene2.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp02.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-14766.7510, 0.0000, 7099.3203,},
			["Competitive_se"] = {-4909.9458, 0.0000, -3309.7881,},
			["Duel_nw"] = {1444.0869, 0.0000, 5690.9873,},
			["Duel_se"] = {11613.1875, 0.0000, -3331.7529,},
			["Escort_nw"] = {-1021.2964, 0.0000, 2121.4590,},
			["Escort_se"] = {15000.0000, 0.0000, -14683.9141,},
			["IslandCapture1v1_nw"] = {-4557.5400, 0.0000, 5058.0498,},
			["IslandCapture1v1_se"] = {7138.9146, 0.0000, -3308.9189,},
			["IslandCapture2v2_nw"] = {-9720.3818, 0.0000, 6326.5781,},
			["IslandCapture2v2_se"] = {10965.6953, 0.0000, -5157.9995,},
			["IslandCapture3v3_nw"] = {-10135.4873, 0.0000, 11549.9854,},
			["IslandCapture3v3_se"] = {11112.2148, 0.0000, -10594.6738,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4025.6387, 0.0000, -5135.2217,},
			["Siege_se"] = {4854.7012, 0.0000, -13257.2334,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM02_01.tga",
				"fe/missions/MM02_02.tga",
				"fe/missions/MM02_03.tga",
			},
			["hints"] = {
				"mp.loading_05",
				"mp.loading_06",
				"mp.loading_07",
				"mp.loading_08",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","317","7"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","317","7"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","317","7"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"23"},
			["multiunitsidCompetitive"] = {"23"},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM02_01.tga",
				"fe/missions/MM02_02.tga",
				"fe/missions/MM02_03.tga",
			},
			["hints"] = {
				"mp.loading_05",
				"mp.loading_06",
				"mp.loading_07",
				"mp.loading_08",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","275","67","61"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","67","61"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","67","61"},
			["multiunitsidIC4v4"] = {"150","158","162","167","275","67","61"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"93"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI003 Clash (Vanilla)
		["id"] = "31",
		["name"] = "mp03.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene3.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp03.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-11330.6855, 0.0000, 6076.0068,},
			["Competitive_se"] = {-2470.3455, 0.0000, -2620.7576,},
			["Duel_nw"] = {-9987.4004, 0.0000, 2011.4384,},
			["Duel_se"] = {20.0542, 0.0000, -8018.5552,},
			["Escort_nw"] = {-2348.4019, 0.0000, 11841.9824,},
			["Escort_se"] = {10203.3789, 0.0000, 1476.6410,},
			["IslandCapture1v1_nw"] = {-7533.9844, 0.0000, 1502.7413,},
			["IslandCapture1v1_se"] = {8429.6836, 0.0000, -3643.8464,},
			["IslandCapture2v2_nw"] = {-7252.3872, 0.0000, 5443.8818,},
			["IslandCapture2v2_se"] = {8329.3936, 0.0000, -6693.6494,},
			["IslandCapture3v3_nw"] = {-10904.9004, 0.0000, 6929.3594,},
			["IslandCapture3v3_se"] = {11146.3506, 0.0000, -6322.5957,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {3540.1348, 0.0000, 2635.3542,},
			["Siege_se"] = {12627.4863, 0.0000, -6250.0552,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM03_01.tga",
				"fe/missions/MM03_02.tga",
				"fe/missions/MM03_03.tga",
			},
			["hints"] = {
				"mp.loading_09",
				"mp.loading_10",
				"mp.loading_11",
				"mp.loading_12",
			},
			["multiunitsidIC1v1"] = {"318","108","331","117","299","390"},
			["multiunitsidIC2v2"] = {"318","108","331","117","299","390"},
			["multiunitsidIC3v3"] = {"318","108","331","117","299","390"},
			["multiunitsidIC4v4"] = {"318","108","331","117","299","390"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM03_01.tga",
				"fe/missions/MM03_02.tga",
				"fe/missions/MM03_03.tga",
			},
			["hints"] = {
				"mp.loading_09",
				"mp.loading_10",
				"mp.loading_11",
				"mp.loading_12",
			},
			["multiunitsidIC1v1"] = {"329","158","162","385","273","278"},
			["multiunitsidIC2v2"] = {"329","158","162","385","273","278"},
			["multiunitsidIC3v3"] = {"329","158","162","385","273","278"},
			["multiunitsidIC4v4"] = {"329","158","162","385","273","278"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150"},
			["multiunitsidCompetitive"] = {"150"},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI004 Serpent (Vanilla)
		["id"] = "32",
		["name"] = "mp04.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene4.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp04.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-6513.0298, 0.0000, 3648.5100,},
			["Competitive_se"] = {9803.7002, 0.0000, -11981.0596,},
			["Duel_nw"] = {-10275.1074, 0.0000, 12681.3203,},
			["Duel_se"] = {155.4033, 0.0000, 3172.4053,},
			["Escort_nw"] = {-14883.2480, 0.0000, 14841.4561,},
			["Escort_se"] = {10864.7100, 0.0000, -10679.8008,},
			["IslandCapture1v1_nw"] = {-1277.7550, 0.0000, 6593.4243,},
			["IslandCapture1v1_se"] = {3864.9971, 0.0000, -3896.7666,},
			["IslandCapture2v2_nw"] = {-4685.4346, 0.0000, 12368.1855,},
			["IslandCapture2v2_se"] = {12672.7402, 0.0000, -8080.6724,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -8116.0898,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-3457.1392, 0.0000, 8246.3594,},
			["Siege_se"] = {6462.7334, 0.0000, -1598.9143,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM04_01.tga",
				"fe/missions/MM04_02.tga",
				"fe/missions/MM04_03.tga",
			},
			["hints"] = {
				"mp.loading_13",
				"mp.loading_14",
				"mp.loading_15",
				"mp.loading_18",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","11","316"},
			["multiunitsidIC2v2"] = {"101","108","113","116","11","316","295"},
			["multiunitsidIC3v3"] = {"101","108","113","116","11","316","295"},
			["multiunitsidIC4v4"] = {"101","108","113","116","11","316","295"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101"},
			["multiunitsidCompetitive"] = {"101","108","27"},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM04_01.tga",
				"fe/missions/MM04_02.tga",
				"fe/missions/MM04_03.tga",
			},
			["hints"] = {
				"mp.loading_13",
				"mp.loading_14",
				"mp.loading_15",
				"mp.loading_18",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","14","71"},
			["multiunitsidIC2v2"] = {"150","158","162","167","14","71","67"},
			["multiunitsidIC3v3"] = {"150","158","162","167","14","71","67"},
			["multiunitsidIC4v4"] = {"150","158","162","167","14","71","67"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI005 Spine (Vanilla)
		["id"] = "33",
		["name"] = "mp05.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene5.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp05.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-7431.1650, 0.0000, 3139.7688,},
			["Competitive_se"] = {2829.5728, 0.0000, -5760.1128,},
			["Duel_nw"] = {-7279.4585, 0.0000, 4478.1411,},
			["Duel_se"] = {3317.5823, 0.0000, -5925.9561,},
			["Escort_nw"] = {-6583.1240, 0.0000, 8014.1484,},
			["Escort_se"] = {4602.3335, 0.0000, -2598.4534,},
			["IslandCapture1v1_nw"] = {-3594.4668, 0.0000, 9787.2461,},
			["IslandCapture1v1_se"] = {5123.8682, 0.0000, 2768.2539,},
			["IslandCapture2v2_nw"] = {-4432.8428, 0.0000, 6984.4482,},
			["IslandCapture2v2_se"] = {4908.7515, 0.0000, -9024.2988,},
			["IslandCapture3v3_nw"] = {-14989.4023, 0.0000, 10573.2480,},
			["IslandCapture3v3_se"] = {14680.3574, 0.0000, -11955.8232,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4518.0854, 0.0000, -8115.6270,},
			["Siege_se"] = {4704.1514, 0.0000, -15000.0000,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM05_01.tga",
				"fe/missions/MM05_02.tga",
				"fe/missions/MM05_03.tga",
			},
			["hints"] = {
				"mp.loading_17",
				"mp.loading_18",
				"mp.loading_19",
				"mp.loading_20",
			},
			["multiunitsidIC1v1"] = {"101","108","113","23"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","317","7"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","317","7"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","108","113"},
			["multiunitsidCompetitive"] = {"101"},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM05_01.tga",
				"fe/missions/MM05_02.tga",
				"fe/missions/MM05_03.tga",
			},
			["hints"] = {
				"mp.loading_17",
				"mp.loading_18",
				"mp.loading_19",
				"mp.loading_20",
			},
			["multiunitsidIC1v1"] = {"150","158","162","275"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","67","61"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","67","61"},
			["multiunitsidIC4v4"] = {"150","158","162","167","275","67","61"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"77"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI006 Jaws (Vanilla)
		["id"] = "34",
		["name"] = "mp06.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene6.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp06.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-14950.0000, 0.0000, 14950.0000,},
			["Competitive_se"] = {14950.0000, 0.0000, -14950.0000,},
			["Duel_nw"] = {401.4180, 0.0000, -1270.4556,},
			["Duel_se"] = {11715.2559, 0.0000, -12296.5410,},
			["Escort_nw"] = {-14578.2305, 0.0000, 15000.0000,},
			["Escort_se"] = {5904.5742, 0.0000, 1351.3513,},
			["IslandCapture1v1_nw"] = {-508.8157, 0.0000, -1172.7227,},
			["IslandCapture1v1_se"] = {12333.5146, 0.0000, -12155.7236,},
			["IslandCapture2v2_nw"] = {-6666.7427, 0.0000, 6744.2378,},
			["IslandCapture2v2_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture3v3_nw"] = {-10118.0820, 0.0000, 9255.6416,},
			["IslandCapture3v3_se"] = {11968.4375, 0.0000, -12029.9746,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {3391.7097, 0.0000, -5470.5293,},
			["Siege_se"] = {12175.0557, 0.0000, -13222.6309,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM06_01.tga",
				"fe/missions/MM06_02.tga",
				"fe/missions/MM06_03.tga",
			},
			["hints"] = {
				"mp.loading_21",
				"mp.loading_22",
				"mp.loading_23",
				"mp.loading_24",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","11","316","295"},
			["multiunitsidIC2v2"] = {"101","108","113","116","11","316","295"},
			["multiunitsidIC3v3"] = {"101","108","113","116","11","316","295"},
			["multiunitsidIC4v4"] = {"101","108","113","116","11","316","295"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","113"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM06_01.tga",
				"fe/missions/MM06_02.tga",
				"fe/missions/MM06_03.tga",
			},
			["hints"] = {
				"mp.loading_21",
				"mp.loading_22",
				"mp.loading_23",
				"mp.loading_24",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","14","71","67"},
			["multiunitsidIC2v2"] = {"150","158","162","167","14","71","67"},
			["multiunitsidIC3v3"] = {"150","158","162","167","14","71","67"},
			["multiunitsidIC4v4"] = {"150","158","162","167","14","71","67"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150","163"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI007 Status Quo (Vanilla)
		["id"] = "35",
		["name"] = "mp07.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene7.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp07.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-5768.1284, 0.0000, 4764.1987,},
			["Competitive_se"] = {13423.6309, 0.0000, -14833.4570,},
			["Duel_nw"] = {-12275.1074, 0.0000, 14681.3203,},
			["Duel_se"] = {14005.3027, 0.0000, -7694.2163,},
			["Escort_nw"] = {-3764.9146, 0.0000, 11546.9834,},
			["Escort_se"] = {9447.2832, 0.0000, -3956.6064,},
			["IslandCapture1v1_nw"] = {-5022.5732, 0.0000, 4755.1719,},
			["IslandCapture1v1_se"] = {6176.6299, 0.0000, -4584.7041,},
			["IslandCapture2v2_nw"] = {-8135.8647, 0.0000, 7090.1401,},
			["IslandCapture2v2_se"] = {7690.0356, 0.0000, -7914.1963,},
			["IslandCapture3v3_nw"] = {-14837.5654, 0.0000, 7485.9150,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -9317.2588,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {4242.3125, 0.0000, 592.9307,},
			["Siege_se"] = {14005.3027, 0.0000, -7694.2163,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM07_01.tga",
				"fe/missions/MM07_02.tga",
				"fe/missions/MM07_03.tga",
			},
			["hints"] = {
				"mp.loading_25",
				"mp.loading_26",
				"mp.loading_27",
				"mp.loading_28",
			},
			["multiunitsidIC1v1"] = {"101","108","113","23","316"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316","317"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316","317"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","316","317"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM07_01.tga",
				"fe/missions/MM07_02.tga",
				"fe/missions/MM07_03.tga",
			},
			["hints"] = {
				"mp.loading_25",
				"mp.loading_26",
				"mp.loading_27",
				"mp.loading_28",
			},
			["multiunitsidIC1v1"] = {"150","158","162","275","71"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","71","67"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","71","67"},
			["multiunitsidIC4v4"] = {"150","158","162","167","275","71","67"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150"},
			["multiunitsidCompetitive"] = {"150"},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI008 Coral (Vanilla)
		["id"] = "36",
		["name"] = "mp08.name",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene8.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp08.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-14950.0000, 0.0000, 14950.0000,},
			["Competitive_se"] = {80.0500, 0.0000, -248.1500,},
			["Duel_nw"] = {-3508.5400, 0.0000, 5050.8784,},
			["Duel_se"] = {14619.4297, 0.0000, -12013.8994,},
			["Escort_nw"] = {-14226.1699, 0.0000, 4642.0688,},
			["Escort_se"] = {5213.0933, 0.0000, -13954.3965,},
			["IslandCapture1v1_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture1v1_se"] = {3971.3367, 0.0000, -2154.0081,},
			["IslandCapture2v2_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture2v2_se"] = {5510.9517, 0.0000, -3141.3022,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 2860.0801,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-14870.3047, 0.0000, 14927.4688,},
			["Siege_se"] = {-2797.1636, 0.0000, 5537.2490,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM08_01.tga",
				"fe/missions/MM08_02.tga",
				"fe/missions/MM08_03.tga",
			},
			["hints"] = {
				"mp.loading_29",
				"mp.loading_30",
				"mp.loading_28",
				"mp.loading_32",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","316","317"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316","317"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316","317"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","108","113"},
			["multiunitsidCompetitive"] = {"31"},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM08_01.tga",
				"fe/missions/MM08_02.tga",
				"fe/missions/MM08_03.tga",
			},
			["hints"] = {
				"mp.loading_29",
				"mp.loading_30",
				"mp.loading_28",
				"mp.loading_32",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","275","71","67"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","71","67"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","71","67"},
			["multiunitsidIC4v4"] = {"150","158","162","167","275","71","67","61"},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150","158","162"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	---- VANILLA MAP END ----
	
	---- DLC MAP START ----
	
	{ -- MULTI009 Volcano (DLC)
		["id"] = "38",
		["name"] = "Volcano",
		["sceneFile"] = sceneFilePath.."multi/scene9.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp09.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] =  {-2894.1240, 0.0000, 9952.0215 },
			["Competitive_se"] =  {10340.5215, 0.0000, -9920.4902 },
			["Duel_nw"] = {-2745.8184, 0.0000, 3860.9436 },
			["Duel_se"] = { 3947.0508, 0.0000, -2843.4412 },
			["Escort_nw"]= {-15000.0000, 0.0000, 10011.9326, },
			["Escort_se"]= {15000.0000, 0.0000, -10043.1133, },
			["IslandCapture1v1_nw"] =  {-13035.1875, 0.0000, -3017.1125 },
			["IslandCapture1v1_se"] =  {14057.5391, 0.0000, -9967.6865 },
			["IslandCapture2v2_nw"] =  {-14995.6680, 0.0000, 9997.5820 },
			["IslandCapture2v2_se"] =  {14985.7402, 0.0000, -1811.9825 },
			["IslandCapture3v3_nw"] =  {-15000.0000, 0.0000, 10011.9326, },
			["IslandCapture3v3_se"] =  {15000.0000, 0.0000, -10043.1133, },
			["IslandCapture4v4_nw"] =  {-15000.0000, 0.0000, 10011.9326, },
			["IslandCapture4v4_se"] =  {15000.0000, 0.0000, -10043.1133, },
			["Siege_nw"] = {-15000.0000, 0.0000, 10011.9326, },
			["Siege_se"]= {15000.0000, 0.0000, -10043.1133, },
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_02",
				"mp.loading_05",
				"mp.loading_10",
				"mp.loading_32",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","317"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_02",
				"mp.loading_05",
				"mp.loading_10",
				"mp.loading_32",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","275","67"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","71","67","61"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","71","67","61"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {"101"},	
			},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				[5] = {	["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},		
	
	{ -- MULTI010 Choke Point (DLC)
		["id"] = "39",
		["name"] = "Choke Point",
		["sceneFile"] = sceneFilePath.."multi/scene10.scn",
		["date"] = { 2007, 02, 10 },
		["prerequisites"] = {},
		["description"] = "mp10.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] =  {-15000.0000, 0.0000, 10011.9326 },
			["Competitive_se"] =  {15000.0000, 0.0000, -10043.1133, },
			["Duel_nw"] = {-5520.7881, 0.0000, 9871.4844, },
			["Duel_se"] = { 6076.3457, 0.0000, -3372.8843, },
			["Escort_nw"]= {-3832.6099, 0.0000, 8812.9199, },
			["Escort_se"]= {4595.7949, 0.0000, -8826.6035, },
			["IslandCapture1v1_nw"] =  {-100.0000, 0.0000, -100.0000, },
			["IslandCapture1v1_se"] =  {100.0000, 0.0000, 100.0000, },
			["IslandCapture2v2_nw"] =  {-100.0000, 0.0000, -100.0000, },
			["IslandCapture2v2_se"] =  {100.0000, 0.0000, 100.0000, },
			["IslandCapture3v3_nw"] =  {-100.0000, 0.0000, -100.0000, },
			["IslandCapture3v3_se"] =  {100.0000, 0.0000, 100.0000, },
			["IslandCapture4v4_nw"] =  {-100.0000, 0.0000, -100.0000, },
			["IslandCapture4v4_se"] =  {100.0000, 0.0000, 100.0000, },
			["Siege_nw"] = {-5375.7183, 0.0000, 1166.6023, },
			["Siege_se"]= {5289.1416, 0.0000, -5862.7422, },
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","108"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150","158","73"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --small
				[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},		
	
	{ -- MULTI011 Operation MI (DLC)
		["id"] = "43",
		["name"] = "Operation MI",
		["sceneFile"] = sceneFilePath.."multi/scene11.scn",
		["date"] = { 1942, 06, 04 },
		["prerequisites"] = {},
		["description"] = "mp11.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] =  {-14950.0000, 0.0000, 9950.0000, },
			["Competitive_se"] =  {-4500.0000, 0.0000, -3350.0000, },
			["Duel_nw"] = {1775.1016, 0.0000, 3160.1677 },
			["Duel_se"] = { 14950.0000, 0.0000, -9950.0000 },
			["Escort_nw"]= {-2400.2224, 0.0000, 4039.0867, },
			["Escort_se"]= {14950.0000, 0.0000, -9950.0000, },
			["IslandCapture1v1_nw"] =  {-11958.7764, 0.0000, 1640.3953 },
			["IslandCapture1v1_se"] =  {9985.3643, 0.0000, -9496.4404 },
			["IslandCapture2v2_nw"] =  {-4460.6709, 0.0000, 9927.9551 },
			["IslandCapture2v2_se"] =  {14928.8857, 0.0000, -9938.1504 },
			["IslandCapture3v3_nw"] =  {-14992.6406, 0.0000, 9996.3555, },
			["IslandCapture3v3_se"] =  {14986.2178, 0.0000, -9985.8506, },
			["IslandCapture4v4_nw"] =  {-15000.0000, 0.0000, 10011.9326, },
			["IslandCapture4v4_se"] =  {15000.0000, 0.0000, -10043.1133, },
			["Siege_nw"] = {2361.5762, 0.0000, 977.3198, },
			["Siege_se"]= {13738.1299, 0.0000, -8055.1665, },
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p1",
				"mm.obj_p3",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_02",
				"mp.loading_05",
				"mp.loading_10",
				"mp.loading_32",
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","316"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"19","18"},
			["multiunitsidCompetitive"] = {"23"},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm08.obj_p2",
				"mm.obj_p4",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_02",
				"mp.loading_05",
				"mp.loading_10",
				"mp.loading_32",
			},
			["multiunitsidIC1v1"] = {"150","158","162","167","275","71"},
			["multiunitsidIC2v2"] = {"150","158","162","167","275","71"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","71"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"67","70"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = { ["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI012 Philippine Sea (DLC)
		["id"] = "44",
		["name"] = "Philippine Sea",
		["sceneFile"] = sceneFilePath.."multi/scene12.scn",
		["date"] = { 2007, 02, 10 },
		["prerequisites"] = {},
		["description"] = "mp12.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] =  {2454.6450, 0.0000, -7684.7422},
			["Competitive_se"] =  {14240.0889, 0.0000, -13790.6191},
			["Duel_nw"] = {-4889.1982, 0.0000, 312.9188},
			["Duel_se"] = { 2766.2419, 0.0000, -5823.8921 },
			["Escort_nw"]= {-14614.0938, 0.0000, 3403.2356},
			["Escort_se"]= {6351.9727, 0.0000, -11961.3564},
			["IslandCapture1v1_nw"] =  {-11429.2686, 0.0000, 8973.0762},
			["IslandCapture1v1_se"] =  {10831.8682, 0.0000, -9729.6621},
			["IslandCapture2v2_nw"] =  {-11334.6387, 0.0000, 5128.1421},
			["IslandCapture2v2_se"] =  {12370.3682, 0.0000, -6330.6309},
			["IslandCapture3v3_nw"] =  {-13268.1328, 0.0000, 14700.0098},
			["IslandCapture3v3_se"] =  {12570.4893, 0.0000, -11789.0176},
			["IslandCapture4v4_nw"] =  {-100.0000, 0.0000, -100.0000, },
			["IslandCapture4v4_se"] =  {100.0000, 0.0000, 100.0000, },
			["Siege_nw"] = {-14028.8750, 0.0000, -1133.3867},
			["Siege_se"]= {-3641.4661, 0.0000, -12547.8340},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {"318","108","331","299"},
			["multiunitsidIC2v2"] = {"318","108","331","116","299","316"},
			["multiunitsidIC3v3"] = {"318","108","331","116","299","316"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","108","113"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {"329","158","162","277"},
			["multiunitsidIC2v2"] = {"329","158","162","167","277","71"},
			["multiunitsidIC3v3"] = {"329","158","162","167","277","71"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150","158","162"},
			["multiunitsidCompetitive"] = {"93"},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI013 Leyte (DLC)
		["id"] = "45",
		["name"] = "Leyte",
		["sceneFile"] = sceneFilePath.."multi/scene13.scn",
		["date"] = { 2007, 02, 10 },
		["prerequisites"] = {},
		["description"] = "mp13.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] =  {-6899.3789, 0.0000, 4560.6963},
			["Competitive_se"] =  {7002.3403, 0.0000, -5245.5391},
			["Duel_nw"] = {-14864.3691, 0.0000, -955.8062},
			["Duel_se"] = { -2800.8899, 0.0000, -13785.8301 },
			["Escort_nw"]= {-7664.3418, 0.0000, 4918.9395},
			["Escort_se"]= {6828.4365, 0.0000, -5269.0137},
			["IslandCapture1v1_nw"] =  {-9985.7461, 0.0000, 8022.9585},
			["IslandCapture1v1_se"] =  {9541.6787, 0.0000, -9324.4600},
			["IslandCapture2v2_nw"] =  {-10281.2949, 0.0000, 13229.2939},
			["IslandCapture2v2_se"] =  {10021.5371, 0.0000, -14808.2207, },
			["IslandCapture3v3_nw"] =  {-12633.8447, 0.0000, 13939.8262},
			["IslandCapture3v3_se"] =  {13079.5938, 0.0000, -14245.8867, },
			["IslandCapture4v4_nw"] =  {-14626.8027, 0.0000, 11281.0254, },
			["IslandCapture4v4_se"] =  {14669.0684, 0.0000, -11331.4922, },
			["Siege_nw"] = {-7000.0000, 0.0000, 6800.0000},
			["Siege_se"]= {1000.0000, 0.0000, -1000.0000, },
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {"101","108","113","11"},
			["multiunitsidIC2v2"] = {"101","108","113","11","317"},
			["multiunitsidIC3v3"] = {"101","108","113","11","317"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","108","113"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {"150","158","162","58"},
			["multiunitsidIC2v2"] = {"150","158","162","58","67"},
			["multiunitsidIC3v3"] = {"150","158","162","58","67"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150","158","162"},
			["multiunitsidCompetitive"] = {"150","158","162"},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				--[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	{ -- MULTI014 Aleutian Islands (DLC)
		["id"] = "46",
		["name"] = "Aleutian Islands",
		["sceneFile"] = sceneFilePath.."multi/scene14.scn",
		["date"] = { 2007, 02, 10 },
		["prerequisites"] = {},
		["description"] = "mp14.hint",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-7045.1133, 0.0000, 1141.6270},
		  ["Competitive_se"] = {8206.9395, 0.0000, -7734.3477},
		  ["Duel_nw"] = {-15000.0000, 0.0000, -300.0000},
		  ["Duel_se"] = {-1000.0000, 0.0000, -12300.0000},
		  ["Escort_nw"] = {-10478.2275, 0.0000, 4039.4404},
		  ["Escort_se"] = {3910.8044, 0.0000, -11947.7559},
		  ["IslandCapture1v1_nw"] = {-6681.0957, 0.0000, 5964.5591},
		  ["IslandCapture1v1_se"] = {10016.1729, 0.0000, -6731.6699},
		  ["IslandCapture2v2_nw"] = {-6575.3281, 0.0000, 6659.0972},
		  ["IslandCapture2v2_se"] = {14279.3184, 0.0000, -7173.5493},
		  ["IslandCapture3v3_nw"] = {-14987.3682, 0.0000, 13020.2168},
		  ["IslandCapture3v3_se"] = {14172.9121, 0.0000, -14976.6270},
		  ["IslandCapture4v4_nw"] = {-14987.3682, 0.0000, 13020.2168},
		  ["IslandCapture4v4_se"] = {14172.9121, 0.0000, -14976.6270},
		  ["Siege_nw"] = {-10913.8516, 0.0000, 5268.6611},
		  ["Siege_se"] = {660.4121, 0.0000, -6759.6870},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {"101","108","113","23","317"},
			["multiunitsidIC2v2"] = {"101","108","113","23","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","317","7"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"23"},
			["multiunitsidCompetitive"] = {"102"},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"",
				"",
			},
			["secondaryObjectives"] = {
			},
			["hints"] = {
				"mp.loading_10",
				"mp.loading_22",
				"mp.loading_25",
				"mp.loading_27",
			},
			["multiunitsidIC1v1"] = {"150","158","162","275","67","61"},
			["multiunitsidIC2v2"] = {"150","158","162","275","67","61"},
			["multiunitsidIC3v3"] = {"150","158","162","167","275","67","61"},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] =  {"77", "75", "73", "70", "71", "67", "68", "69", "60", "61", "93", "150", "151", "152", "154", "158", "159", "162", "163"},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"70","73"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				--[3] = { ["MenuDIS"] = true, }, --huge
				--[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = {	["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				--[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				--[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				--[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},
	
	---- DLC MAP END ----
	
	---- NEW MAP START ----
	
	{ -- MULTI501 Clash of Carriers (New)
		["id"] = "501",
		["name"] = "Clash of Carriers",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene501.scn",
		["date"] = { 1942, 04, 15 },
		["prerequisites"] = {},
		["description"] = "Two carrier groups run into each other in the middle of the ocean. Reinforcements are called in for both sides. Planes are scrambled, but which side will come out victorious?",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"Sink the enemy carriers!",
				"Prevent the enemy from sinking your carriers!",
			},
			["secondaryObjectives"] = {
			},
--			["loadingBackgrounds"] = {
--				"fe/missions/MM01_01.tga",
--				"fe/missions/MM01_02.tga",
--				"fe/missions/MM01_03.tga",
--			},
			["hints"] = {
				"This is a very large map, make sure that you always overwatch your carriers.",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"There are reinforcements coming in from both sides, make sure to protect yours once they arrive.",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"Make sure you have a powerful computer for this mission!",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"Mission made by: Runsva, Captain Corgi and Gelling Jellay.",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"101","108","113"},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"Sink the enemy carriers!",
				"Prevent the enemy from sinking your carriers!",
			},
			["secondaryObjectives"] = {
			},
--			["loadingBackgrounds"] = {
--				"fe/missions/MM01_01.tga",
--				"fe/missions/MM01_02.tga",
--				"fe/missions/MM01_03.tga",
--			},
			["hints"] = {
				"This is a very large map, make sure you always overwatch your carriers.",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"There are reinforcements coming in from both sides, make sure to use them once they arrive.",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"Make sure you have a powerful computer for this!",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"Mission made by: Runsva, Captain Corgi and Gelling Jellay.",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC2v2"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC3v3"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidIC4v4"] = {"101","108","113","116","23","316","317","7"},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {"150","158","162"},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				--[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
		}),
	},	
	
	---- NEW MAP END ----
	
	---- BSM CLASSIC MAP START ----
	
	{ -- MULTI921 Steel Monsters (BSM CLASSIC)
		["id"] = "921",
		["name"] = "Steel Monsters",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene921.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
				--[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI923 Battle of The Philippines (BSM CLASSIC)
		["id"] = "923",
		["name"] = "Battle of The Philippines",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene923.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				--[6] = { ["MenuDIS"] = true, },
				[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI925 Battle off Samar (BSM CLASSIC)
		["id"] = "925",
		["name"] = "Battle off Samar",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene925.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				--[6] = { ["MenuDIS"] = true, },
				[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI926 Battle of the Surigao Strait (BSM CLASSIC)
		["id"] = "926",
		["name"] = "Battle of the Surigao Strait",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene926.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
				--[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI927 Battle of the Coral Sea (BSM CLASSIC)
		["id"] = "927",
		["name"] = "Battle of the Coral Sea",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene927.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				--[6] = { ["MenuDIS"] = true, },
				[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI922 Tokyo Express (BSM CLASSIC)
		["id"] = "922",
		["name"] = "Tokyo Express",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene922.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
				--[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI929 Wolfpack (BSM CLASSIC)
		["id"] = "929",
		["name"] = "Wolfpack",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."multi/scene929.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
				--[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	---- BSM CLASSIC MAP END ----
	
	---- COOP MAP START ----
	
	{ -- MULTI930 Battle of the Java Sea (COOP)
		["id"] = "930",
		["name"] = "Steel Monsters",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."chg/chg_2_java.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				--[6] = { ["MenuDIS"] = true, },
				[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	{ -- MULTI931 Hunt for the Cruiser (COOP)
		["id"] = "931",
		["name"] = "Steel Monsters",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."chg/chg_3_hunt.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				--[6] = { ["MenuDIS"] = true, },
				[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},
	
	--[[{ -- MULTI932 Operation Ten-Go (COOP)
		["id"] = "932",
		["name"] = "Operation Ten-Go",
		["debriefingText"] = "",
		["sceneFile"] = sceneFilePath.."chg/chg_10_tengo.scn",
		["date"] = { 1942, 05, 04 },
		["prerequisites"] = {},
		["description"] = "Command the fleets of the Japanese and American Navies in the first carrier battle in history.",
		["picture"] = "",
		["MultiPlayMapSizes"] = {
			["Competitive_nw"] = {-4959.3330, 0.0000, 8772.0215,},
			["Competitive_se"] = {6694.7876, 0.0000, -1994.9473,},
			["Duel_nw"] = {1798.4431, 0.0000, -8065.1709,},
			["Duel_se"] = {9850.0391, 0.0000, -14729.4463,},
			["Escort_nw"] = {6511.8198, 0.0000, 15000.0000,},
			["Escort_se"] = {15000.0000, 0.0000, 1000.4200,},
			["IslandCapture1v1_nw"] = {-9183.4160, 0.0020, 5099.7832,},
			["IslandCapture1v1_se"] = {9557.9873, 0.0000, -5130.2944,},
			["IslandCapture2v2_nw"] = {-8198.3291, 0.0000, 9128.5391,},
			["IslandCapture2v2_se"] = {9399.0586, 0.0000, -8539.1436,},
			["IslandCapture3v3_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture3v3_se"] = {15000.0000, 0.0000, -15000.0000,},
			["IslandCapture4v4_nw"] = {-15000.0000, 0.0000, 15000.0000,},
			["IslandCapture4v4_se"] = {15000.0000, 0.0000, -15000.0000,},
			["Siege_nw"] = {-4571.0371, 0.0000, 5022.8193,},
			["Siege_se"] = {5636.2417, 0.0000, -5011.1001,},
		},
		["allied"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.us_obj1",
				"mm904.us_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["japanese"] = {
			["briefingGuiLayer"] = "",
			["primaryObjectives"] = {
				"mm904.jap_obj1",
				"mm904.jap_obj2",
			},
			["secondaryObjectives"] = {
			},
			["loadingBackgrounds"] = {
				"fe/missions/MM01_01.tga",
				"fe/missions/MM01_02.tga",
				"fe/missions/MM01_03.tga",
			},
			["hints"] = {
				"mp.loading_05",--On large maps check the strategic map regularly. You will find it indispensable to know the battle situation.
				"mp.loading_07",--Always be aware of all three arenas of combat: the sky, sea-level and under the ocean.
				"mp.loading_14",--Remember: Speeding ahead of your allies will leave you vulnerable.
				"mp.loading_08",--Each fighting side has its own special units with unique abilities.
			},
			["multiunitsidIC1v1"] = {},
			["multiunitsidIC2v2"] = {},
			["multiunitsidIC3v3"] = {},
			["multiunitsidIC4v4"] = {},
			["multiunitsidDuel"] = {},
			["multiunitsidSiege"] = {},
			["multiunitsidEscort"] = {},
			["multiunitsidCompetitive"] = {},
		},
		["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
			[2] = {	--"MLS_GAMEMODE"
				[0] = { ["MenuDIS"] = true, }, --IC small
				--[1] = { ["MenuDIS"] = true, }, --IC medium
				[2] = { ["MenuDIS"] = true, }, --IC large
				[3] = { ["MenuDIS"] = true, }, --IC huge
				[4] = { ["MenuDIS"] = true, }, --duel
				[5] = { ["MenuDIS"] = true, }, --escort
				[6] = { ["MenuDIS"] = true, }, --siege
				[7] = { ["MenuDIS"] = true, }, --competitive
			},
			[3] = {--"MLS_MAPSIZE"
				[0] = { ["MenuDIS"] = true, }, --small
				--[1] = { ["MenuDIS"] = true, }, --medium
				[2] = { ["MenuDIS"] = true, }, --large
				[3] = { ["MenuDIS"] = true, }, --huge
			},
			[5] = {--"MLS_RESOURCE"
				[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
				--[7] = { ["MenuDIS"] = true, },
			},
			[7] = {--"MLS_TIME"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
			},
			[8] = {--"MLS_POINT"
				--[0] = { ["MenuDIS"] = true, },
				[1] = { ["MenuDIS"] = true, },
				[2] = { ["MenuDIS"] = true, },
				[3] = { ["MenuDIS"] = true, },
				[4] = { ["MenuDIS"] = true, },
				[5] = { ["MenuDIS"] = true, },
				[6] = { ["MenuDIS"] = true, },
			},
			[10] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
			[12] = {--"MLS_ENABLEPOWERUPS"
				[0] = { ["MenuDIS"] = true, },
				--[1] = { ["MenuDIS"] = true, },
			},
		}),
	},]]
	
	---- COOP MAP END ----
	
}