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

MissionTree = {
	["missionGroups"] = {
		{
			["groupName"] = "Training grounds",
			["helpLine"] = "FE.main_cs_allycamp_help",
			["gratMsg"] = "FE.rewards_congratulations_uscampaign",
			["gratDate"] = { 1940, 09, 08 },
			["missions"] = {
				{
					["id"] = "TRN1",
 					["name"] = "FE.mtree_trn01_name",
 					["helpline"] = "FE.mtree_trn01_helpline",
					["debriefingText"] = "",
 					["sceneFile"] = "universe/Scenes/TrainingGrounds/IJN_AirTraining.scn",
 					["date"] = { 1940, 09, 08, },
					["Pos"] = { 0.066120, -0.027083, 5.000000 },
					["prerequisites"] = {},
					["description"] = "Train yourself, be a locomotive",
					["picture"] = "fe/missions/TG_IJN01.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN05",
						["primaryObjectives"] = {
							"am1.obj_p1",
						},
						["secondaryObjectives"] = {
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/TG_IJN01.tga",
--							"fe/missions/JMTG01_02.tga",
--							"fe/missions/JMTG01_03.tga",
--						},
						["hints"] = {
							"trn.hint_loadinghint1",
							"trn.hint_loadinghint2",
							"trn.hint_loadinghint3",
							"trn.hint_loadinghint4",
						},
						["demotips"] = {
							[1] = {
								[1] = {
									["img1"] = "",
									["img2"] = "common/icons/class/AK_s.tga",
									["img3"] = "",
									["tiptitle"] = "globals.areyousure",
									["tipdesc"] = "globals.accept",
								},
--								[2] = {
--								},
								[3] = {
									["img1"] = "",
									["img2"] = "common/icons/class/AK_s.tga",
									["img3"] = "",
									["tiptitle"] = "globals.areyousure",
									["tipdesc"] = "globals.accept",
								},
								[4] = {
									["img1"] = "",
									["img2"] = "common/icons/class/AK_s.tga",
									["img3"] = "",
									["tiptitle"] = "globals.areyousure",
									["tipdesc"] = "globals.accept",
								},
--								[5] = {
--								},
								[6] = {
									["img1"] = "",
									["img2"] = "common/icons/class/AK_s.tga",
									["img3"] = "",
									["tiptitle"] = "globals.areyousure",
									["tipdesc"] = "globals.accept",
								},
							},
						},
					},
				},
				{
					["id"] = "TRN2",
 					["name"] = "FE.mtree_trn02_name",
 					["helpline"] = "FE.mtree_trn02_helpline",
					["debriefingText"] = "",
 					["sceneFile"] = "universe/Scenes/TrainingGrounds/IJN_SeaTraining.scn",
 					["date"] = { 1940, 09, 08, },
					["Pos"] = { 0.123412, -0.106249, 5.000000 },
					["prerequisites"] = {},
					["description"] = "Train yourself, be a locomotive",
					["picture"] = "fe/missions/TG_IJN02.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN05",
						["primaryObjectives"] = {
							"am1.obj_p1",
						},
						["secondaryObjectives"] = {
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/TG_IJN02.tga",
--							"fe/missions/JMTG02_02.tga",
--							"fe/missions/JMTG02_03.tga",
--						},
						["hints"] = {
							"trn.hint_loadinghint1",
							"trn.hint_loadinghint2",
							"trn.hint_loadinghint3",
							"trn.hint_loadinghint4",
						},
					},
				},
				{
					["id"] = "TRN3",
 					["name"] = "FE.mtree_trn03_name",
 					["helpline"] = "FE.mtree_trn03_helpline",
					["debriefingText"] = "",
 					["sceneFile"] = "universe/Scenes/TrainingGrounds/USN_AirTraining.scn",
					["date"] = { 1940, 09, 08, },
					["Pos"] = { 0.687995, 0.283334, 5.000000 },
					["prerequisites"] = {},
					["description"] = "Train yourself, be a locomotive",
					["picture"] = "fe/missions/TG_USN01.tga",
					["forcedDifficultyLevel"] = nil,
					["allied"] = {
						["briefingGuiLayer"] = "IJN05",
						["primaryObjectives"] = {
							"am1.obj_p1",
						},
						["secondaryObjectives"] = {
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/TG_USN01.tga",
--							"fe/missions/USTG01_02.tga",
--							"fe/missions/USTG01_03.tga",
--						},
						["hints"] = {
							"trn.hint_loadinghint1",
							"trn.hint_loadinghint2",
							"trn.hint_loadinghint3",
							"trn.hint_loadinghint4",
						},
					},
				},
				{
					["id"] = "TRN4",
 					["name"] = "FE.mtree_trn04_name",
 					["helpline"] = "FE.mtree_trn04_helpline",
					["debriefingText"] = "",
 					["sceneFile"] = "universe/Scenes/TrainingGrounds/USN_SeaTraining.scn",
 					["date"] = { 1940, 09, 08, },
					["Pos"] = { 0.735911, 0.187501, 5.000000 },
					["prerequisites"] = {},
					["description"] = "Train yourself, be a locomotive",
					["picture"] = "fe/missions/TG_USN02.tga",
					["forcedDifficultyLevel"] = nil,
					["allied"] = {
						["briefingGuiLayer"] = "IJN05",
						["primaryObjectives"] = {
							"am1.obj_p1",
						},
						["secondaryObjectives"] = {
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/TG_USN02.tga",
--							"fe/missions/USTG02_02.tga",
--							"fe/missions/USTG02_03.tga",
--						},
						["hints"] = {
							"trn.hint_loadinghint1",
							"trn.hint_loadinghint2",
							"trn.hint_loadinghint3",
							"trn.hint_loadinghint4",
						},
					},
				},
			},
		},
		{
			["groupName"] = "IJN campaign",
			["helpLine"] = "FE.main_cs_allycamp_help",
			["gratMsg"] = "FE.rewards_congratulations_uscampaign",
			["gratDate"] = { 1941, 12, 07 },
			["missions"] = {
				{
					["id"] = "IJN01",
 					["name"] = "FE.mtree_ijn01_name",
 					["helpline"] = "FE.mtree_ijn01_helpline",
 					["background"] = "fe.mtree_ijn01_background",
 					["backgroundVoice"] = "campaign/IJN01/IJN01.FSB",
					["backgroundMovie"] = "movies/Footage_IJN01.bik",
					["debriefingText"] = "ijn01.debriefing",
 					["debriefingVoice"] = "campaign/IJN01/IJN01_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_01_attack_on_pearl_harbor.scn",
					["date"] = { 1941, 12, 07, },
					["Pos"] = { 1.252084, 0.090278, 5.000000 },
					["prerequisites"] = {},
					["description"] = "Some kind of... mission",
					["navalacademy"] = { 1, 2, 3, 21, 22, 23, 25, 26, 27, 48 },
					["picture"] = "fe/missions/IJN01.tga",
					["forcedDifficultyLevel"] = nil,
					["MovieName"] = "movies/jp_intro.bik",
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
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
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
						["changeables"] = {"150","158",},
					},
				},
				{
					["id"] = "IJN02",
 					["name"] = "FE.mtree_ijn02_name",
 					["helpline"] = "FE.mtree_ijn02_helpline",
 					["background"] = "fe.mtree_ijn02_background",
 					["backgroundVoice"] = "campaign/IJN02/IJN02.FSB",
					["backgroundMovie"] = "movies/Footage_IJN02.bik",
					["debriefingText"] = "ijn02.debriefing",
 					["debriefingVoice"] = "campaign/IJN02/IJN02_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_02_force_z.scn",
					["date"] = { 1941, 12, 10, },
					["Pos"] = { -0.235417, 0.465278, 5.000000 },
					["description"] = "Some kind of... challange",
					["navalacademy"] = { 28, 31 },
					["picture"] = "fe/missions/IJN02.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN02",
						["primaryObjectives"] = {
							"ijn02.obj_p1",
-- 							"ijn02.obj_p2",    -- Briefingben nem megjeleno objectiva
							"ijn02.obj_p3",
						},
						["secondaryObjectives"] = {
--							"ijn02.obj_s1", -- Briefingben nem megjeleno objectiva
						},
						["hiddenObjectives"] = {
							"ijn02.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn02.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
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
						["changeables"] = {"167"},
					},
				},
				{
					["id"] = "IJN03",
 					["name"] = "FE.mtree_ijn03_name",
 					["helpline"] = "FE.mtree_ijn03_helpline",
 					["background"] = "fe.mtree_ijn03_background",
 					["backgroundVoice"] = "campaign/IJN03/IJN03.FSB",
					["backgroundMovie"] = "movies/Footage_IJN03.bik",
					["debriefingText"] = "ijn03.debriefing",
 					["debriefingVoice"] = "campaign/IJN03/IJN03_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_03_battle_of_the_java_sea.scn",
					["date"] = { 1942, 02, 27, },
					["Pos"] = { -0.155208, 0.615278, 5.000000 },
					["description"] = "Some kind of... mission",
					["navalacademy"] = { 5, 6, 7, 8, 9, 10, 14, 16, 17, 18, 19, 20 },
					["picture"] = "fe/missions/IJN03.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN03",
						["primaryObjectives"] = {
							"ijn03.obj_p1",
							"ijn03.obj_p2",
--							"ijn03.obj_p3",
--							"ijn03.obj_p4",
--							"ijn03.obj_p5",
						},
						["secondaryObjectives"] = {
--							"ijn03.obj_s1",
--							"ijn03.obj_s2",
						},
						["hiddenObjectives"] = {
							"ijn03.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn03.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
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
						--["allunitslockhint"] = {"FE.mtree_ijn03_bonus"},
						["changeables"] = {"67",},
					},
				},
				{
					["id"] = "IJN04",
 					["name"] = "FE.mtree_ijn04_name",
 					["helpline"] = "FE.mtree_ijn04_helpline",
 					["background"] = "fe.mtree_ijn04_background",
 					["backgroundVoice"] = "campaign/IJN04/IJN04.FSB",
					["backgroundMovie"] = "movies/Footage_IJN04.bik",
					["debriefingText"] = "ijn04.debriefing",
					["debriefingVoice"] = "campaign/IJN04/IJN04_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_04_coral_sea.scn",
					["date"] = { 1942, 05, 08, },
					["Pos"] = { 0.483334, 0.772917, 5.000000 },
					["description"] = "Some kind of... challenge",
					["navalacademy"] = { 4, 24, 52, 53 },
					["picture"] = "fe/missions/IJN04.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN04",
						["primaryObjectives"] = {
							"ijn04.obj_p1",
						},
						["secondaryObjectives"] = {
--							"ijn04.obj_s1",
							"ijn04.obj_s2",
--							"ijn04.obj_s3",
						},
						["hiddenObjectives"] = {
							"ijn04.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn04.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn04.hint_loadinghint_1",
							"ijn04.hint_loadinghint_2",
							"ijn04.hint_loadinghint_3",
							"ijn04.hint_loadinghint_4",
						},
						["allunitsid"]  = {"67", "150", "159",},
						["allunitsnum"] = {"1", "20","9","9",},
						["changeables"] = {"150","67","159"},
					},
				},
				{
					["id"] = "IJN05",
 					["name"] = "FE.mtree_ijn05_name",
 					["helpline"] = "FE.mtree_ijn05_helpline",
 					["background"] = "fe.mtree_ijn05_background",
 					["backgroundVoice"] = "campaign/IJN05/IJN05.FSB",
					["backgroundMovie"] = "movies/Footage_IJN05.bik",
					["debriefingText"] = "ijn05.debriefing",
 					["debriefingVoice"] = "campaign/IJN05/IJN05_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_05_invasion_of_port_moresby.scn",
					["date"] = { 1942, 05, 17, },
					["Pos"] = { 0.401041, 0.726389, 5.000000 },
					["description"] = "'Invasion of Port Moresby' is another extraordinary challange for the top notch players. (Donald not included, can be bought seperately)",
					["navalacademy"] = { 11, 29, 44, 45, 46, 47, 49, 50, 54, 55, 56 },
					["picture"] = "fe/missions/IJN05.tga",
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
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn05.hint_loadinghint_1",
							"ijn05.hint_loadinghint_2",
							"ijn05.hint_loadinghint_3",
							"ijn05.hint_loadinghint_4",
							"ijn05.hint_loadinghint_5",
						},
						["allunitsid"]  = {"73","67","70","86","150",},
						["allunitsnum"] = {"5","1","1","5","1",},
						["allunitslockid"] = {"158","JM4_GOLD",},
						["allunitslocknum"] = {"3",},
						["allunitslockhint"] = {"FE.mtree_ijn05_bonus"},
						["changeables"] = {"150","73","67","158",},
					},
				},
				{
					["id"] = "IJN06",
 					["name"] = "FE.mtree_ijn06_name",
 					["helpline"] = "FE.mtree_ijn06_helpline",
 					["background"] = "fe.mtree_ijn06_background",
 					["backgroundVoice"] = "campaign/IJN06/IJN06.FSB",
					["backgroundMovie"] = "movies/Footage_IJN06.bik",
					["debriefingText"] = "ijn06.debriefing",
 					["debriefingVoice"] = "campaign/IJN06/IJN06_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_06_prelude_to_midway.scn",
					["date"] = { 1942, 05, 28, },
					["Pos"] = { 0.816667, -0.033333, 5.000000 },
					["description"] = "Subsomething",
					["navalacademy"] = { 34, 35, 36, 37, 38, 39, 40, 42, 51 },
					["picture"] = "fe/missions/IJN06.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN06",
						["primaryObjectives"] = {
							"ijn06.obj_p1",
--							"ijn06.obj_p2",
--							"ijn06.obj_p3",
						},
						["secondaryObjectives"] = {
							"ijn06.obj_s1",
--							"ijn06.obj_s2",
--							"ijn06.obj_s3",
						},
						["hiddenObjectives"] = {
							"ijn06.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn06.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
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
				{
					["id"] = "IJN07",
 					["name"] = "Operation MI",
 					["helpline"] = "FE.mtree_ijn07_helpline",
 					["background"] = "fe.mtree_ijn07_background",
 					["backgroundVoice"] = "campaign/IJN07/IJN07.FSB",
					["backgroundMovie"] = "movies/Footage_IJN07.bik",
					["debriefingText"] = "ijn07.debriefing",
 					["debriefingVoice"] = "campaign/IJN07/IJN07_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_07_invasion_of_midway.scn",
					["date"] = { 1942, 06, 04, },
					["Pos"] = { 0.908333, -0.043056, 5.000000 },
					["description"] = "Some sort of mission",
					["navalacademy"] = {24,26,27,48,49,50,52,53},
					["picture"] = "fe/missions/IJN07.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN07",
						["primaryObjectives"] = {
							"ijn07.obj_p1",
--							"ijn07.obj_p2",
--							"ijn07.obj_p3",
						},
						["secondaryObjectives"] = {
--							"ijn07.obj_s1",
							"ijn07.obj_s2",
						},
						["hiddenObjectives"] = {
							"ijn07.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn07.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn07.hint_loadinghint_1",
							"ijn07.hint_loadinghint_2",
							"ijn07.hint_loadinghint_3",
							"ijn07.hint_loadinghint_4",
							-- "The most elite pilots in the world are onboard Akagi, Kaga, Soryu, and Hiryu. They are precious for Imperial Navy.",
						},
						["allunitsid"]  = {"61","69","52","51","73","150","162","158"},
						["allunitsnum"] = {"1","1","1","1","1","80","60","60"},
						["allunitslockid"] = {"93","JM6_GOLD"},
						["allunitslocknum"] = {"1",},
						["allunitslockhint"] = {"FE.mtree_ijn07_bonus"},
						["changeables"] = {"52","51","61","69","73","150","158","93",},
					},
				},
				{
					["id"] = "IJN08",
 					["name"] = "FE.mtree_ijn08_name",
 					["helpline"] = "FE.mtree_ijn08_helpline",
 					["background"] = "fe.mtree_ijn08_background",
 					["backgroundVoice"] = "campaign/IJN08/IJN08.FSB",
					["backgroundMovie"] = "movies/Footage_IJN08.bik",
					["debriefingText"] = "ijn08.debriefing",
 					["debriefingVoice"] = "campaign/IJN08/IJN08_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_08_defend_guadalcanal.scn",
					["date"] = { 1942, 11, 12, },
					["Pos"] = { 0.606250, 0.727083, 5.000000 },
					--["sideMission"] = true,
					["description"] = "Some sort of challange",
					["navalacademy"] = {23,24,48,52,53,56},
					["picture"] = "fe/missions/IJN08.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN08",
						["primaryObjectives"] = {
							"ijn08.obj_p1",
							"ijn08.obj_p2",
--							"ijn08.obj_p3",
						},
						["secondaryObjectives"] = {
--							"ijn08.obj_s1",
						},
						["hiddenObjectives"] = {
							"ijn08.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn08.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
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
				{
					["id"] = "IJN09",
 					["name"] = "FE.mtree_ijn09_name",
 					["helpline"] = "FE.mtree_ijn09_helpline",
 					["background"] = "fe.mtree_ijn09_background",
 					["backgroundVoice"] = "campaign/IJN09/IJN09.FSB",
					["backgroundMovie"] = "movies/Footage_IJN09.bik",
					["debriefingText"] = "ijn09.debriefing",
 					["debriefingVoice"] = "campaign/IJN09/IJN09_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_09_guadalcanal.scn",
					["date"] = { 1942, 11, 13, },
					["Pos"] = { 0.589583, 0.709722, 5.000000 },
					["description"] = "Some sort of mission",
					["navalacademy"] = {8,9,10,14,16,17,18,19,20,49,50},
					["picture"] = "fe/missions/IJN09.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN09",
						["primaryObjectives"] = {
							"ijn09.obj_p1",
--							"ijn09.obj_p2",
--							"ijn09.obj_p3",
						},
						["secondaryObjectives"] = {
							"ijn09.obj_s1",
--							"ijn09.obj_s2",
--							"ijn09.obj_s3",
						},
						["hiddenObjectives"] = {
							"ijn09.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn09.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn09.hint_loading_1",
							"ijn09.hint_loading_2",
							"ijn09.hint_loading_3",
							"ijn09.hint_loading_4",
						},
						["allunitsid"]  = {"70","67","73","60"},
						["allunitsnum"] = {"2","1","1","1"},
						["allunitslockid"] = {"167", "JM8_GOLD"},
						["allunitslocknum"] = {"2"},
						["allunitslockhint"] = {"FE.mtree_ijn09_bonus2","FE.mtree_ijn09_bonus"},
						["changeables"] = {"73","67","60"},
					},
				},
				{
					["id"] = "IJN10",
 					["name"] = "FE.mtree_ijn10_name",
 					["helpline"] = "FE.mtree_ijn10_helpline",
 					["background"] = "fe.mtree_ijn10_background",
 					["backgroundVoice"] = "campaign/IJN10/IJN10.FSB",
					["backgroundMovie"] = "movies/Footage_IJN10.bik",
					["debriefingText"] = "ijn10.debriefing",
 					["debriefingVoice"] = "campaign/IJN10/IJN10_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_10_sydney.scn",
					["date"] = { 1942, 12, 21, },
					["Pos"] = { 0.456250, 1.232638, 5.000000 },
					--["sideMission"] = true,
					["description"] = "Some kind of mission.",
					["navalacademy"] = {34,35,36,37,38,39,40,51},
					["picture"] = "fe/missions/IJN10.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN10",
						["primaryObjectives"] = {
							"ijn10.obj_p1",
							"ijn10.obj_p2",
--							"ijn10.obj_p3",
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
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
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
				{
					["id"] = "IJN11",
 					["name"] = "FE.mtree_ijn11_name",
 					["helpline"] = "FE.mtree_ijn11_helpline",
 					["background"] = "fe.mtree_ijn11_background",
 					["backgroundVoice"] = "campaign/IJN11/IJN11.FSB",
					["backgroundMovie"] = "movies/Footage_IJN11.bik",
					["debriefingText"] = "ijn11.debriefing",
 					["debriefingVoice"] = "campaign/IJN11/IJN11_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_11_invasion_of_fiji.scn",
					["date"] = { 1943, 03, 07, },
					["Pos"] = { 0.902083, 0.900000, 5.000000 },
					["description"] = "Some kind of mission.",
					["navalacademy"] = {52,53,54,55,56},
					["picture"] = "fe/missions/IJN11.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN11",
						["primaryObjectives"] = {
							"ijn11.obj_p1",
						},
						["secondaryObjectives"] = {
--							"ijn11.obj_s1",
--							"ijn11.obj_s2",
						},
						["hiddenObjectives"] = {
							"ijn11.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn11.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn11.hint_loading_1",
							"ijn11.hint_loading_2",
							"ijn11.hint_loading_3",
							"ijn11.hint_loading_4",
						},
						["allunitsid"]  = {"61","50","73","69","86","150","163","159",},
						["allunitsnum"] = {"1","1","1","1","2","40","40","40",},
						["allunitslockid"] = {"8","JM10_GOLD",},
						["allunitslocknum"] = {"1",},
						["allunitslockhint"] = {"FE.mtree_ijn11_bonus"},
						["changeables"] = {"50","61","73","150","69","8","159",},
					},
				},
				{
					["id"] = "IJN12",
 					["name"] = "FE.mtree_ijn12_name",
 					["helpline"] = "FE.mtree_ijn12_helpline",
 					["background"] = "fe.mtree_ijn12_background",
 					["backgroundVoice"] = "campaign/IJN12/IJN12.FSB",
					["backgroundMovie"] = "movies/Footage_IJN12.bik",
					["debriefingText"] = "ijn12.debriefing",
 					["debriefingVoice"] = "campaign/IJN12/IJN12_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_12_havaii_2.scn",
					["date"] = { 1943, 04, 26, },
					["Pos"] = { 1.705208, 0.856945, 5.000000 },
					--["sideMission"] = true,
					["description"] = "Some kind of mission.",
					["navalacademy"] = {42,47,51},
					["picture"] = "fe/missions/IJN12.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN12",
						["primaryObjectives"] = {
							"ijn12.obj_p1",
							"ijn12.obj_p2",
--							"ijn12.obj_p3",
--							"ijn12.obj_p4",

						},
						["secondaryObjectives"] = {
--							"ijn12.obj_s1",
						},
						["hiddenObjectives"] = {
							"ijn12.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn12.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn12.hint_loading_1",
							"ijn12.hint_loading_2",
							"ijn12.hint_loading_3",
							"ijn12.hint_loading_4",
						},
						["allunitsid"]  = {"93",},
						["allunitsnum"] = {"1",},
						["allunitslockid"] = {},
						["allunitslocknum"] = {},
						["changeables"] = {"93",},
					},
				},
				{
					["id"] = "IJN13",
 					["name"] = "FE.mtree_ijn13_name",
 					["helpline"] = "FE.mtree_ijn13_helpline",
 					["background"] = "fe.mtree_ijn13_background",
 					["backgroundVoice"] = "campaign/IJN13/IJN13.FSB",
					["backgroundMovie"] = "movies/Footage_IJN13.bik",
					["debriefingText"] = "ijn13.debriefing",
 					["debriefingVoice"] = "campaign/IJN13/IJN13_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_13.scn",
					["date"] = { 1943, 11, 02, },
					["Pos"] = { 1.213542, 0.093055, 5.000000 },
					--["sideMission"] = true,
					["description"] = "Some kind of mission.",
					["navalacademy"] = {32},
					["picture"] = "fe/missions/IJN13.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN13",
						["primaryObjectives"] = {
							"ijn13.obj_p1",
--							"ijn13.obj_p2",
--							"ijn13.obj_p3",
--							"ijn13.obj_p4",
						},
						["secondaryObjectives"] = {
							"ijn13.obj_s1",
						},
						["hiddenObjectives"] = {
							"ijn13.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn13.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn13.hint_loading_1",
							"ijn13.hint_loading_2",
							"ijn13.hint_loading_3",
							"ijn13.hint_loading_4",
						},
						["allunitsid"]  = {"150",},
						["allunitsnum"] = {"30",},
						["allunitslockid"] = {},
						["allunitslocknum"] = {},
						["changeables"] = {"150",},
					},
				},
				{
					["id"] = "IJN14",
 					["name"] = "FE.mtree_ijn14_name",
 					["helpline"] = "FE.mtree_ijn14_helpline",
 					["background"] = "fe.mtree_ijn14_background",
 					["backgroundVoice"] = "campaign/IJN14/IJN14.FSB",
					["backgroundMovie"] = "movies/Footage_IJN14.bik",
					["debriefingText"] = "ijn14.debriefing",
 					["debriefingVoice"] = "campaign/IJN14/IJN14_OUT.FSB",
 					["sceneFile"] = "universe/Scenes/missions/IJN/ijn_14_invasion_of_havaii.scn",
					["date"] = { 1944, 01, 01, },
					["Pos"] = { 1.240625, 0.101389, 5.000000 },
					["description"] = "Some kind of mission.",
					["navalacademy"] = {44,45,46,47,48,49,50,52,53},
					["picture"] = "fe/missions/IJN14.tga",
					["forcedDifficultyLevel"] = nil,
					["japanese"] = {
						["briefingGuiLayer"] = "IJN14",
						["primaryObjectives"] = {
							"ijn14.obj_p1",
--							"ijn14.obj_p2",
--							"ijn14.obj_p3",
						},
						["secondaryObjectives"] = {
--							"ijn14.obj_s1",
						},
						["hiddenObjectives"] = {
							"ijn14.obj_h1", --nem tartozik hozza group, nem latszik alapbol a neve, csak ha mar egyszer completelte a jatekos.
						},
						["hiddenHints"] = {
							"ijn14.obj_h1_hint" --hint az 1-es hidden objektiva teljesitesehez
						},
--						["loadingBackgrounds"] = {
--							"fe/missions/IJN01.tga",
--							"fe/missions/IJN02.tga",
--							"fe/missions/IJN03.tga",
--						},
						["hints"] = {
							"ijn14.hint_loading_1",
							"ijn14.hint_loading_2",
							"ijn14.hint_loading_3",
							"ijn14.hint_loading_4",
						},
						["allunitsid"]  = {"50","51","59","69","71","73","163","151","159"},
						["allunitsnum"] = {"1","1","1","1","1","2","30","30","30"},
						["allunitslockid"] = {"14","JM12_GOLD","58","JM13_GOLD",},
						["allunitslocknum"] = {"2","1",},
						["allunitslockhint"] = {"FE.mtree_ijn14_bonus","FE.mtree_ijn14_bonus2"},
						["changeables"] = {"50","51","151","73","69","59","159",},
					},
				},
			},-- missions end
		}, --campaing group end
		{
			["groupName"] = "USN campaign",
			["helpLine"] = "FE.main_cs_allycamp_help",
			["gratMsg"] = "FE.rewards_congratulations_uscampaign",
			["gratDate"] = { 1942, 06, 04 },
			["missions"] = {
				{
					["id"] = "USN01",
 					["name"] = "FE.mtree_usn01_name",
 					["helpline"] = "FE.mtree_usn01_helpline",
 					["background"] = "fe.mtree_usn01_background",
 					["backgroundVoice"] = "campaign/USN01/USN01.fsb",
					["backgroundMovie"] = "movies/Footage_USN01.bik",
					["debriefingText"] = "usn01.debriefing",
 					["debriefingVoice"] = "campaign/USN01/USN01_out.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_01_Battle_of_Eastern_Solomons.scn",
					["date"] = { 1942, 08, 24, },
					["Pos"] = { 0.502083, 0.670139, 5.000000 },
					["prerequisites"] = {},
					["description"] = "",
					["navalacademy"] = { 1, 2, 21, 22, 23, 25, 26, 27, 48 },
					["picture"] = "fe/missions/USN01.tga",
					["forcedDifficultyLevel"] = nil,
					["MovieName"] = "movies/us_intro.bik",
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
						["changeables"] = {"101", "113"}, --Wildcat, Avenger
					},
				},
				{
					["id"] = "USN02",
 					["name"] = "FE.mtree_usn02_name",
 					["helpline"] = "FE.mtree_usn02_helpline",
 					["background"] = "fe.mtree_usn02_background",
 					["backgroundVoice"] = "campaign/USN02/USN02.fsb",
					["backgroundMovie"] = "movies/Footage_USN02.bik",
					["debriefingText"] = "usn02.debriefing",
 					["debriefingVoice"] = "campaign/USN02/USN02_out.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_02_Battle_of_Cape_Esperance.scn",
					["date"] = { 1942, 10, 11, },
					["Pos"] = { 0.478125, 0.746528, 5.000000 },
					--["sideMission"] = false,
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn02.hint_loadinghint1",
							"usn02.hint_loadinghint2",
							"usn02.hint_loadinghint3",
							"usn02.hint_loadinghint4",
						},
						["allunitsid"] = {"19","17","25"},
						["allunitsnum"] = {"1","1","2"},
						["allunitslockid"] = {},
						["allunitslocknum"] = {},
						["changeables"] = {"25", "19"}, --Clemson, Northampton
					},
				},
				{
					["id"] = "USN03",
 					["name"] = "FE.mtree_usn03_name",
 					["helpline"] = "FE.mtree_usn03_helpline",
 					["background"] = "fe.mtree_usn03_background",
 					["backgroundVoice"] = "campaign/USN03/USN03.fsb",
					["backgroundMovie"] = "movies/Footage_USN03.bik",
					["debriefingText"] = "usn03.debriefing",
 					["debriefingVoice"] = "campaign/USN03/USN03_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_03_Battle_of_Santa_Cruz.scn",
					["date"] = { 1942, 10, 26, },
					["Pos"] = { 0.585416, 0.778472, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn03.hint_loadinghint1",
							"usn03.hint_loadinghint2",
							"usn03.hint_loadinghint3",
							"usn03.hint_loadinghint4",
						},
						["allunitsid"] = {"2","7","17","19","25","101","113","108"},
						["allunitsnum"] = {"1","1","3","1", "7" ,"20","30","30"},
						["allunitslockid"] = {},
						["allunitslocknum"] = {},
						["changeables"] = {"101","113","19","25"}, --Wildcat, Avenger, Northampton, Clemson
					},
				},
				{
					["id"] = "USN04",
 					["name"] = "FE.mtree_usn04_name",
 					["helpline"] = "FE.mtree_usn04_helpline",
 					["background"] = "fe.mtree_usn04_background",
 					["backgroundVoice"] = "campaign/USN04/USN04.fsb",
					["backgroundMovie"] = "movies/Footage_USN04.bik",
					["debriefingText"] = "usn04.debriefing",
 					["debriefingVoice"] = "campaign/USN04/USN04_out.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_04_Defend_Guadalcanal.scn",
					["date"] = { 1942, 11, 08, },
					["Pos"] = { 0.486458, 0.761805, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
				{
					["id"] = "USN05",
 					["name"] = "FE.mtree_usn05_name",
 					["helpline"] = "FE.mtree_usn05_helpline",
 					["background"] = "fe.mtree_usn05_background",
 					["backgroundVoice"] = "campaign/USN05/USN05.fsb",
					["backgroundMovie"] = "movies/Footage_USN05.bik",
					["debriefingText"] = "usn05.debriefing",
 					["debriefingVoice"] = "campaign/USN05/USN05_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_05_GuadalCanal_1st_Battle.scn ",
					["date"] = { 1942, 11, 13, },
					["Pos"] = { 0.489583, 0.745139, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn05.hint_loadinghint1",
							"usn05.hint_loadinghint2",
							"usn05.hint_loadinghint3",
							"usn05.hint_loadinghint4",
						},
						["allunitsid"] = {"17", "19", "18", "23", "25"},
						["allunitsnum"] = {"1", "1", "1", "5", "1"},
						["allunitslockid"] = {},
						["allunitslocknum"] = {},
						["changeables"] = {"23", "18"}, --Fletcher, Cleveland
					},
				},
				{
					["id"] = "USN06",
 					["name"] = "FE.mtree_usn06_name",
 					["helpline"] = "FE.mtree_usn06_helpline",
 					["background"] = "fe.mtree_usn06_background",
 					["backgroundVoice"] = "campaign/USN06/USN06.fsb",
					["backgroundMovie"] = "movies/Footage_USN06.bik",
					["debriefingText"] = "usn06.debriefing",
 					["debriefingVoice"] = "campaign/USN06/USN06_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_06_Guadalcanal_2nd_battle.scn ",
					["date"] = { 1942, 11, 14, },
					["Pos"] = { 0.500000, 0.756250, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn06.hint_loadinghint1",
							"usn06.hint_loadinghint2",
							"usn06.hint_loadinghint3",
							"usn06.hint_loadinghint4",
						},
						["allunitsid"] = {"31", "27", "135", "7", "23"},
						["allunitsnum"] = {"1", "6", "60", "2", "4"},
						["allunitslockid"] = {"118","US04_SILVER"},
						["allunitslocknum"] = {"1"},
						["allunitslockhint"] = {"FE.mtree_usn06_bonus"},
						["changeables"] = {"31", "135", "7"}, --Narwhal, P-40 Warhawk, South Dakota
					},
				},
				{
					["id"] = "USN07",
 					["name"] = "FE.mtree_usn07_name",
 					["helpline"] = "FE.mtree_usn07_helpline",
 					["background"] = "fe.mtree_usn07_background",
 					["backgroundVoice"] = "campaign/USN07/USN07.fsb",
					["backgroundMovie"] = "movies/Footage_USN07.bik",
					["debriefingText"] = "usn07.debriefing",
 					["debriefingVoice"] = "campaign/USN07/USN07_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_07_invasion_of_tarawa.scn",
					["date"] = { 1943, 11, 20, },
					["Pos"] = { 0.690624, 0.513889, 5.000000 },
					--["sideMission"] = true,
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
						["changeables"] = {"102"},
					},
				},
				{
					["id"] = "USN08",
 					["name"] = "FE.mtree_usn08_name",
 					["helpline"] = "FE.mtree_usn08_helpline",
 					["background"] = "fe.mtree_usn08_background",
 					["backgroundVoice"] = "campaign/USN08/USN08.fsb",
					["backgroundMovie"] = "movies/Footage_USN08.bik",
					["debriefingText"] = "usn08.debriefing",
 					["debriefingVoice"] = "campaign/USN08/USN08_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_08_Battle_of_Philippine_Sea.scn",
					["date"] = { 1944, 06, 19, },
					["Pos"] = { 0.059375, 0.229861, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn08.hint_loadinghint1",
							"usn08.hint_loadinghint2",
							"usn08.hint_loadinghint3",
							"usn08.hint_loadinghint4",
						},
						["allunitsid"] = {"2","17","23","26","113","38","31"},
						["allunitsnum"] = {"2","1","3","42","60","36","1"},
						["allunitslockid"] = {"102","US07_GOLD"},
						["allunitslocknum"] = {"12"},
						["allunitslockhint"] = {"FE.mtree_usn08_bonus"},
						["changeables"] = {"23", "31", "113", "26"}, --Fletcher, Narwhal, Avenger, Hellcat
					},
				},
				{
					["id"] = "USN09",
 					["name"] = "FE.mtree_usn09_name",
 					["helpline"] = "FE.mtree_usn09_helpline",
 					["background"] = "fe.mtree_usn09_background",
 					["backgroundVoice"] = "campaign/USN09/USN09.fsb",
					["backgroundMovie"] = "movies/Footage_USN09.bik",
					["debriefingText"] = "usn09.debriefing",
 					["debriefingVoice"] = "campaign/USN09/USN09_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_09_Leyte.scn",
					["date"] = { 1944, 10, 24, },
					["Pos"] = { -0.045833, 0.340972, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
						["changeables"] = {"113"}, --Avenger
					},
				},
				{
					["id"] = "USN10",
 					["name"] = "FE.mtree_usn10_name",
 					["helpline"] = "FE.mtree_usn10_helpline",
 					["background"] = "fe.mtree_usn10_background",
 					["backgroundVoice"] = "campaign/USN10/USN10.fsb",
					["backgroundMovie"] = "movies/Footage_USN10.bik",
					["debriefingText"] = "usn10.debriefing",
 					["debriefingVoice"] = "campaign/USN10/USN10_out.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_10_Battle_of_Cape_Engano.scn",
					["date"] = { 1944, 10, 25, },
					["Pos"] = { -0.072917, 0.197917, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn10.hint_loadinghint1",
							"usn10.hint_loadinghint2",
							"usn10.hint_loadinghint3",
							"usn10.hint_loadinghint4",
						},
						["allunitsid"] = {"2","23","113","26","38","7","15","19"},
						["allunitsnum"] = {"1","5","24","24","18","1","1","1"},
						["allunitslockid"] = {"19","US09_GOLD"},
						["allunitslocknum"] = {"1"},
						["allunitslockhint"] = {"FE.mtree_usn10_bonus"},
						["changeables"] = {"113", "7", "23", "26"}, --Avenger, South Dakota, Fletcher, Hellcat
					},
				},
				{
					["id"] = "USN11",
 					["name"] = "FE.mtree_usn11_name",
 					["helpline"] = "FE.mtree_usn11_helpline",
 					["background"] = "fe.mtree_usn11_background",
 					["backgroundVoice"] = "campaign/USN11/USN11.fsb",
					["backgroundMovie"] = "movies/Footage_USN11.bik",
					["debriefingText"] = "usn11.debriefing",
 					["debriefingVoice"] = "campaign/USN11/USN11_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_11_protecting_iowa.scn",
					["date"] = { 1944, 11, 29, },
					["Pos"] = { -0.098958, 0.324305, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
						["changeables"] = {"31"}, --Narwhal
					},
				},
				{
					["id"] = "USN12",
 					["name"] = "FE.mtree_usn12_name",
 					["helpline"] = "FE.mtree_usn12_helpline",
 					["background"] = "fe.mtree_usn12_background",
 					["backgroundVoice"] = "campaign/USN12/USN12.fsb",
					["backgroundMovie"] = "movies/Footage_USN12.bik",
					["debriefingText"] = "usn12.debriefing",
 					["debriefingVoice"] = "campaign/USN12/USN12_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_12_Indochina.scn",
					["date"] = { 1945, 01, 11, },
					["Pos"] = { -0.285417, 0.309028, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
						["changeables"] = {"104"}, --Lightning
					},
				},
				{
					["id"] = "USN13",
 					["name"] = "FE.mtree_usn13_name",
 					["helpline"] = "FE.mtree_usn13_helpline",
 					["background"] = "fe.mtree_usn13_background",
 					["backgroundVoice"] = "campaign/USN13/USN13.fsb",
					["backgroundMovie"] = "movies/Footage_USN13.bik",
					["debriefingText"] = "usn13.debriefing",
 					["debriefingVoice"] = "campaign/USN13/USN13_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_13_Battle_of_Iwo_Jima.scn",
					["date"] = { 1945, 02, 19, },
					["Pos"] = { 0.201042, 0.042361, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
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
						["changeables"] = {"26", "116"}, --Hellcat, B-17
					},
				},
				{
					["id"] = "USN14",
 					["name"] = "FE.mtree_usn14_name",
 					["helpline"] = "FE.mtree_usn14_helpline",
 					["background"] = "fe.mtree_usn14_background",
 					["backgroundVoice"] = "campaign/USN14/USN14.fsb",
					["backgroundMovie"] = "movies/Footage_USN14.bik",
					["debriefingText"] = "usn14.debriefing",
 					["debriefingVoice"] = "campaign/USN14/USN14_OUT.fsb",
 					["sceneFile"] = "universe/Scenes/missions/USN/usn_14_battle_of_okinawa.scn",
					["date"] = { 1945, 04, 01, },
					["Pos"] = { -0.053125, 0.059027, 5.000000 },
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
--						["loadingBackgrounds"] = {
--							"fe/missions/USN01.tga",
--							"fe/missions/USN02.tga",
--							"fe/missions/USN03.tga",
--						},
						["hints"] = {
							"usn14.hint_loadinghint1",
							"usn14.hint_loadinghint2",
							"usn14.hint_loadinghint3",
							"usn14.hint_loadinghint4",
						},
						["allunitsid"] = {"23", "7", "19", "2", "36", "12", "26", "38", "113"},
						["allunitsnum"] = {"4", "1", "1", "1", "6", "1", "30", "30", "30"},
						["allunitslockid"] = {"7","US11_GOLD", "12", "US13_GOLD"},
						["allunitslocknum"] = {"1", "2"},
						["allunitslockhint"] = {"FE.mtree_usn14_bonus", "FE.mtree_usn14_bonus2"},
						["changeables"] = {"7", "23", "26", "113", "19"}, --South-Dakota, Fletcher, Hellcat, Avenger, Northampton
					},
				},
				--[[{
					["id"] = "USN001",
 					["name"] = "BSJ VISUAL FEATURE TEST",
 					["helpline"] = "HELPLINE",
					["debriefingText"] = "",
 					["sceneFile"] = "universe/Scenes/missions/USN/prototype_test.scn",
					["date"] = { 1942, 09, 08, },
					["prerequisites"] = {},
					["description"] = "Experience a sample of BSJ's visuals. Inside you'll find a new, more detailed and see-through water, new weapons and new levels of destruction.",
					["picture"frontend/fe_missionfoto_am01.tga",
					["forcedDifficultyLevel"] = nil,
					["allied"] = {
						["briefingGuiLayer"] = "Visual",
						["primaryObjectives"] = {
							"am1.obj_p1",
						},
						["secondaryObjectives"] = {
						},
--						["loadingBackgrounds"] = {
--							"frontend/fe_missionfoto_am01.tga",
--							"frontend/fe_missionfoto_am1_2.tga",
--							"frontend/fe_missionfoto_am1_3.tga",
--						},
						["hints"] = {
							"am1.hint_1",
							"am1.hint_2",
							"am1.hint_4",
							"am1.hint_5",
							"am1.hint_3",
						},
					},
				},]]--
			},
		},
		{
			["groupName"] = "IJN DLC",
			["helpLine"] = "FE.main_cs_allycamp_help",
			["gratMsg"] = "FE.rewards_congratulations_uscampaign",
			["gratDate"] = { 1940, 09, 08 },
			["missions"] = {
			}
		},
		{
			["groupName"] = "USN DLC",
			["helpLine"] = "FE.main_cs_allycamp_help",
			["gratMsg"] = "FE.rewards_congratulations_uscampaign",
			["gratDate"] = { 1940, 09, 08 },
			["missions"] = {
			}
		},
	},
	["multiMissionInfos"] = {
		{
			["id"] = "29",
			["name"] = "mp01.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene1.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM01_01.tga",
--					"fe/missions/MM01_02.tga",
--					"fe/missions/MM01_03.tga",
--				},
				["hints"] = {
					"mp.loading_01",
					"mp.loading_02",
					"mp.loading_03",
					"mp.loading_04",
				},
				["multiunitsidIC1v1"] = {"27", "23", "41", "31", "18", "19", "12", "36", "7",},
				["multiunitsidIC2v2"] = {"27", "23", "41", "31", "18", "108", "113", "125", "121", "116", "136", "101", "19", "12", "36", "7",},
				["multiunitsidIC3v3"] = {"27", "23", "41", "18", "108", "113", "121", "116", "136", "101", "19", "12", "36", "7",},
				["multiunitsidIC4v4"] = {"27", "23", "41", "31", "18", "102", "108", "113", "125", "121", "116", "136", "101", "19", "12", "36", "7",},
				["multiunitsidDuel"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26",  "102", "104", "134", "135",},
				["multiunitsidSiege"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26", "102", "104", "134", "135", "27", "23", "41", "31", "18", "102", "108", "113", "125", "121", "116", "136", "101", "19", "12", "36", "7",},
				["multiunitsidEscort"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26", "102", "104", "134", "135", "27", "23", "41", "31", "18", "102", "108", "113", "125", "121", "116", "136", "101", "19", "12", "36", "7",},
				["multiunitsidCompetitive"] = {"23", "25", "19", "21", "18", "20", "10", "13", "27", "31", "101", "133", "26", "102", "104", "134", "135", "27", "23", "41", "31", "18", "102", "108", "113", "125", "121", "116", "136", "101", "19", "12", "36", "7",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM01_01.tga",
--					"fe/missions/MM01_02.tga",
--					"fe/missions/MM01_03.tga",
--				},
				["hints"] = {
					"mp.loading_01",
					"mp.loading_02",
					"mp.loading_03",
					"mp.loading_04",
				},
				["multiunitsidIC1v1"] = {"77", "73", "91", "93", "70", "67", "86", "61",},
				["multiunitsidIC2v2"] = {"77", "73", "91", "93", "70", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidIC3v3"] = {"77", "73", "91", "70", "158", "163", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidIC4v4"] = {"77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["UniqueMultiSettings"] = luaOverrideMultiLobbySettings({
				[2] = {	--"MLS_GAMEMODE"
				  --[0] = { ["MenuDIS"] = true, }, --IC small
				  --[1] = { ["MenuDIS"] = true, }, --IC medium
				  --[2] = { ["MenuDIS"] = true, }, --IC large
				    [3] = { ["MenuDIS"] = true, }, --IC huge
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
		{
			["id"] = "30",
			["name"] = "mp02.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene2.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM02_01.tga",
--					"fe/missions/MM02_02.tga",
--					"fe/missions/MM02_03.tga",
--				},
				["hints"] = {
					"mp.loading_05",
					"mp.loading_06",
					"mp.loading_07",
					"mp.loading_08",
				},
				["multiunitsidIC1v1"] = {"27", "23", "41", "10", "31", "36"},
				["multiunitsidIC2v2"] = {"101","108","113","125","121","116","136","27","23","41","36","31","20","10","9",},
				["multiunitsidIC3v3"] = {"101","108","113","125","121","116","136","27","23","41","20","10","9"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM02_01.tga",
--					"fe/missions/MM02_02.tga",
--					"fe/missions/MM02_03.tga",
--				},
				["hints"] = {
					"mp.loading_05",
					"mp.loading_06",
					"mp.loading_07",
					"mp.loading_08",
				},
				["multiunitsidIC1v1"] = {"77", "73", "91", "60", "93", "86"},
				["multiunitsidIC2v2"] = {"150","158","163","167","186","174","172","77","73","91","71","60","61","86","93"},
				["multiunitsidIC3v3"] = {"150","158","163","167","186","174","172","77","73","91","71","60","61"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
		{
			["id"] = "31",
			["name"] = "mp03.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene3.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM03_01.tga",
--					"fe/missions/MM03_02.tga",
--					"fe/missions/MM03_03.tga",
--				},
				["hints"] = {
					"mp.loading_09",
					"mp.loading_10",
					"mp.loading_11",
					"mp.loading_12",
				},
				["multiunitsidIC1v1"] = {"27", "23", "41", "10", "31", "18"},
				["multiunitsidIC2v2"] = {"133","108","112","125","121","116","136","27","25","41","36","31","18",},
				["multiunitsidIC3v3"] = {"133","108","112","125","121","116","136","27","25","41","36","31","18"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM03_01.tga",
--					"fe/missions/MM03_02.tga",
--					"fe/missions/MM03_03.tga",
--				},
				["hints"] = {
					"mp.loading_09",
					"mp.loading_10",
					"mp.loading_11",
					"mp.loading_12",
				},
				["multiunitsidIC1v1"] = {"77", "73", "91", "60", "93", "71"},
				["multiunitsidIC2v2"] = {"154","158","162","174","172","168","186","77","75","91","86","93","71",},
				["multiunitsidIC3v3"] = {"154","158","162","174","172","168","186","77","75","91","86","93","71"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
		{
			["id"] = "32",
			["name"] = "mp04.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene4.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM04_01.tga",
--					"fe/missions/MM04_02.tga",
--					"fe/missions/MM04_03.tga",
--				},
				["hints"] = {
					"mp.loading_13",
					"mp.loading_14",
					"mp.loading_15",
					"mp.loading_18",
				},
				["multiunitsidIC1v1"] = {"101", "108", "113", "125", "121", "116", "136", "27", "23", "41", "36", "18"},
				["multiunitsidIC2v2"] = {"101","108","113","125","121","116","136","27","23","41","36","31","18","19"},
				["multiunitsidIC3v3"] = {"101","108","113","125","121","116","136","27","23","41","36","31","18","19"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM04_01.tga",
--					"fe/missions/MM04_02.tga",
--					"fe/missions/MM04_03.tga",
--				},
				["hints"] = {
					"mp.loading_13",
					"mp.loading_14",
					"mp.loading_15",
					"mp.loading_18",
				},
				["multiunitsidIC1v1"] = {"150", "158", "163", "174", "172", "167", "186", "77", "91", "86", "73", "71"},
				["multiunitsidIC2v2"] = {"150","158","163","174","172","167","186","77","73","91","86","93","81","67"},
				["multiunitsidIC3v3"] = {"150","158","163","174","172","167","186","77","73","91","86","93","81","67"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
		{
			["id"] = "33",
			["name"] = "mp05.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene5.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM05_01.tga",
--					"fe/missions/MM05_02.tga",
--					"fe/missions/MM05_03.tga",
--				},
				["hints"] = {
					"mp.loading_17",
					"mp.loading_18",
					"mp.loading_19",
					"mp.loading_20",
				},
				["multiunitsidIC1v1"] = {"101", "108", "113", "125", "121", "136", "27", "23", "41", "36"},
				["multiunitsidIC2v2"] = {"101","108","113","27","41","36","9","19","23",},
				["multiunitsidIC3v3"] = {"101","108","113","27","41","36","9","19","23",},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM05_01.tga",
--					"fe/missions/MM05_02.tga",
--					"fe/missions/MM05_03.tga",
--				},
				["hints"] = {
					"mp.loading_17",
					"mp.loading_18",
					"mp.loading_19",
					"mp.loading_20",
				},
				["multiunitsidIC1v1"] = {"150", "158", "163", "174", "172", "167", "77", "91", "86", "73"},
				["multiunitsidIC2v2"] = {"150","158","162","77","73","91","86","61","67"},
				["multiunitsidIC3v3"] = {"150","158","162","77","73","91","86","61","67"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
		{
			["id"] = "34",
			["name"] = "mp06.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene6.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM06_01.tga",
--					"fe/missions/MM06_02.tga",
--					"fe/missions/MM06_03.tga",
--				},
				["hints"] = {
					"mp.loading_21",
					"mp.loading_22",
					"mp.loading_23",
					"mp.loading_24",
				},
				["multiunitsidIC1v1"] = {"27", "23", "41", "19", "18", "104", "108", "113"},
				["multiunitsidIC2v2"] = {"104","108","113","125","116","136","27","23","41","18","19"},
				["multiunitsidIC3v3"] = {"104","108","113","125","116","136","27","23","41","18","19"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM06_01.tga",
--					"fe/missions/MM06_02.tga",
--					"fe/missions/MM06_03.tga",
--				},
				["hints"] = {
					"mp.loading_21",
					"mp.loading_22",
					"mp.loading_23",
					"mp.loading_24",
				},
				["multiunitsidIC1v1"] = {"77", "91", "67", "73", "71", "152", "158", "162"},
				["multiunitsidIC2v2"] = {"152","158","162","174","167","186","77","73","91","91","67",},
				["multiunitsidIC3v3"] = {"152","158","162","174","167","186","77","73","91","91","67"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
		{
			["id"] = "35",
			["name"] = "mp07.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene7.scn",
			["date"] = { 1942, 06, 04 },
			["prerequisites"] = {},
			["description"] = "mp07.hint",
			["picture"] = "",
			["MultiPlayMapSizes"] = {
				["Competitive_nw"] = {-5768.1284, 0.0000, 4764.1987,},
				["Competitive_se"] = {13423.6309, 0.0000, -14833.4570,},
				["Duel_nw"] = {-1543.2856, 0.0000, 8676.6885,},
				["Duel_se"] = {9686.7539, 0.0000, -2266.4968,},
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM07_01.tga",
--					"fe/missions/MM07_02.tga",
--					"fe/missions/MM07_03.tga",
--				},
				["hints"] = {
					"mp.loading_25",
					"mp.loading_26",
					"mp.loading_27",
					"mp.loading_28",
				},
				["multiunitsidIC1v1"] = {"23","25","51","20","133","108","121"},
				["multiunitsidIC2v2"] = {"101","102","136","108","113","125","116","27","23","41","18","19"},
				["multiunitsidIC3v3"] = {"101","102","136","108","113","125","116","27","23","41","18","19"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM07_01.tga",
--					"fe/missions/MM07_02.tga",
--					"fe/missions/MM07_03.tga",
--				},
				["hints"] = {
					"mp.loading_25",
					"mp.loading_26",
					"mp.loading_27",
					"mp.loading_28",
				},
				["multiunitsidIC1v1"] = {"154","158","172","77","75","70","91"},
				["multiunitsidIC2v2"] = {"77","73","91","71","67","150","45","186","158","162","174","167"},
				["multiunitsidIC3v3"] = {"77","73","91","71","67","150","45","186","158","162","174","167"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
		{
			["id"] = "36",
			["name"] = "mp08.name",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scene8.scn",
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
--				["loadingBackgrounds"] = {
--					"fe/missions/MM08_01.tga",
--					"fe/missions/MM08_02.tga",
--					"fe/missions/MM08_03.tga",
--				},
				["hints"] = {
					"mp.loading_29",
					"mp.loading_30",
					"mp.loading_28",
					"mp.loading_32",
				},
				["multiunitsidIC1v1"] = {"27", "23", "41", "19", "18", "101", "108", "113","36"},
				["multiunitsidIC2v2"] = {"101","108","113","23","27","41","36","31","71","67"},
				["multiunitsidIC3v3"] = {"101","108","113","23","27","41","36","31","71","67"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--					"fe/missions/MM08_01.tga",
--					"fe/missions/MM08_02.tga",
--					"fe/missions/MM08_03.tga",
--				},
				["hints"] = {
					"mp.loading_29",
					"mp.loading_30",
					"mp.loading_28",
					"mp.loading_32",
				},
				["multiunitsidIC1v1"] = {"77", "91", "67", "73", "71", "152", "158", "162","86"},
				["multiunitsidIC2v2"] = {"150","158","162","73","77","91","86","93","18","19"},
				["multiunitsidIC3v3"] = {"150","158","162","73","77","91","86","93","18","19"},
				["multiunitsidIC4v4"] = {},
				["multiunitsidDuel"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidSiege"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidEscort"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
				["multiunitsidCompetitive"] = {"8", "14", "32", "58", "59", "68", "81", "175", "183", "189", "70", "77", "73", "91", "93", "70", "45", "158", "163", "174", "172", "167", "186", "45", "67", "86", "61", "183", "189",},
			},
		},
	},
}

DoFile("scripts/datatables/ScriptOptions.lua")
if TestMissionTree then
	local testMissions = {
		{
			["id"] = "test1",
			["name"] = "repcsiteszt",
			["helpline"] = "no help",
			["debriefingText"] = "",
			["sceneFile"] = "universe/Scenes/Unittest/planes_all_balu.scn",
			["date"] = { 1945, 04, 01, },
			["Pos"] = { 0.605911, 0.267501, 5.000000 },
			["prerequisites"] = {},
			["description"] = "",
			["navalacademy"] = {},
			["picture"] = "fe/missions/USN01.tga",
			["forcedDifficultyLevel"] = nil,
			["allied"] = {
				["briefingGuiLayer"] = "USN14",
				["primaryObjectives"] = {
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--				},
				["hints"] = {
				},
				["allunitsid"] = {},
				["allunitsnum"] = {},
				["allunitslockid"] = {},
				["allunitslocknum"] = {},
				["changeables"] = {},
			},
		},
		{
			["id"] = "test2",
			["name"] = "hajoteszt",
			["helpline"] = "no help",
			["debriefingText"] = "",
			["sceneFile"] = "universe/Scenes/Unittest/ships_all_rigi.scn",
			["date"] = { 1945, 04, 01, },
			["Pos"] = { 0.605911, 0.267501, 5.000000 },
			["prerequisites"] = {},
			["description"] = "",
			["navalacademy"] = {},
			["picture"] = "fe/missions/USN01.tga",
			["forcedDifficultyLevel"] = nil,
			["allied"] = {
				["briefingGuiLayer"] = "USN14",
				["primaryObjectives"] = {
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--				},
				["hints"] = {
				},
				["allunitsid"] = {},
				["allunitsnum"] = {},
				["allunitslockid"] = {},
				["allunitslocknum"] = {},
				["changeables"] = {},
			},
		},
		{
			["id"] = "test3",
			["name"] = "bildingteszt",
			["helpline"] = "no help",
			["debriefingText"] = "",
			["sceneFile"] = "universe/Scenes/Unittest/all_structures_balu_landscape.scn",
			["date"] = { 1945, 04, 01, },
			["Pos"] = { 0.605911, 0.267501, 5.000000 },
			["prerequisites"] = {},
			["description"] = "",
			["navalacademy"] = {},
			["picture"] = "fe/missions/USN01.tga",
			["forcedDifficultyLevel"] = nil,
			["allied"] = {
				["briefingGuiLayer"] = "USN14",
				["primaryObjectives"] = {
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--				},
				["hints"] = {
				},
				["allunitsid"] = {},
				["allunitsnum"] = {},
				["allunitslockid"] = {},
				["allunitslocknum"] = {},
				["changeables"] = {},
			},
		},
		{
			["id"] = "test4",
			["name"] = "TestTargeting",
			["helpline"] = "no help",
			["debriefingText"] = "",
			["sceneFile"] = "universe/Scenes/TestScenes/Interface/TestTargeting.scn",
			["date"] = { 1945, 04, 01, },
			["Pos"] = { 0.605911, 0.267501, 5.000000 },
			["prerequisites"] = {},
			["description"] = "",
			["navalacademy"] = {},
			["picture"] = "fe/missions/USN01.tga",
			["forcedDifficultyLevel"] = nil,
			["allied"] = {
				["briefingGuiLayer"] = "USN14",
				["primaryObjectives"] = {
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--				},
				["hints"] = {
				},
				["allunitsid"] = {},
				["allunitsnum"] = {},
				["allunitslockid"] = {},
				["allunitslocknum"] = {},
				["changeables"] = {},
			},
		},
		{
			["id"] = "test5",
			["name"] = "TestDamage",
			["helpline"] = "no help",
			["debriefingText"] = "",
			["sceneFile"] = "universe/Scenes/TestScenes/Interface/TestDamage.scn",
			["date"] = { 1945, 04, 01, },
			["Pos"] = { 0.605911, 0.267501, 5.000000 },
			["prerequisites"] = {},
			["description"] = "",
			["navalacademy"] = {},
			["picture"] = "fe/missions/USN01.tga",
			["forcedDifficultyLevel"] = nil,
			["allied"] = {
				["briefingGuiLayer"] = "USN14",
				["primaryObjectives"] = {
				},
				["secondaryObjectives"] = {
				},
--				["loadingBackgrounds"] = {
--				},
				["hints"] = {
				},
				["allunitsid"] = {},
				["allunitsnum"] = {},
				["allunitslockid"] = {},
				["allunitslocknum"] = {},
				["changeables"] = {},
			},
		},
	}

	for key, value in pairs (testMissions) do
		table.insert(MissionTree.missionGroups[1].missions, value)
	end
end

if TestMultiMaps then
	local multiMaps = {
		{
			["id"] = "37",
			["name"] = "NSA",
			["debriefingText"] = "",
			["sceneFile"] = "universe/Scenes/TestScenes/NetworkTest/NetworkTest.scn",
			["date"] = { 1942, 06, 04 },
			["prerequisites"] = {},
			["description"] = "",
			["picture"] = "",
			["allied"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p1",
					"mm.obj_p3",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"fe/missions/MM08_01.tga",
	--					"fe/missions/MM08_02.tga",
	--					"fe/missions/MM08_03.tga",
	--				},
				["hints"] = {
					"Planes reload their equipment after a short amount of time if the reload option is on.",
					"The ships and bases repair themselves to maximum health, but it takes a long time.",
					"Aim for the magazine to cause huge explosion on the ships; it inflicts critical damage.",
				},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"fe/missions/MM08_01.tga",
	--					"fe/missions/MM08_02.tga",
	--					"fe/missions/MM08_03.tga",
	--				},
				["hints"] = {
					"Planes reload their equipment after a short amount of time if the reload option is on.",
					"The ships and bases repair themselves to maximum health, but it takes a long time.",
					"Aim for the magazine to cause huge explosion on the ships; it inflicts critical damage.",
				},
			},
		},
		{
			["id"] = "38",
			["name"] = "poweruptest",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/poweruptest.scn",
			["date"] = { 1942, 06, 04 },
			["prerequisites"] = {},
			["description"] = "",
			["picture"] = "",
			["allied"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p1",
					"mm.obj_p3",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"frontend/fe_missionfoto_mm8.tga",
	--					"frontend/fe_missionfoto_mm8u.tga",
	--					"frontend/fe_missionfoto_mm8j.tga",
	--				},
				["hints"] = {
					"am4.hint_3",
					"am4.hint_2",
					"am9.hint_2",
				},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"frontend/fe_missionfoto_mm8.tga",
	--					"frontend/fe_missionfoto_mm8u.tga",
	--					"frontend/fe_missionfoto_mm8j.tga",
	--				},
				["hints"] = {
					"am4.hint_3",
					"am4.hint_2",
					"am9.hint_2",
				},
			},
		},
		{
			["id"] = "39",
			["name"] = "landingtest",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/landingtest.scn",
			["date"] = { 1942, 06, 04 },
			["prerequisites"] = {},
			["description"] = "",
			["picture"] = "",
			["allied"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p1",
					"mm.obj_p3",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"frontend/fe_missionfoto_mm8.tga",
	--					"frontend/fe_missionfoto_mm8u.tga",
	--					"frontend/fe_missionfoto_mm8j.tga",
	--				},
				["hints"] = {
					"am4.hint_3",
					"am4.hint_2",
					"am9.hint_2",
				},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"mm08.obj_p2",
					"mm.obj_p4",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"frontend/fe_missionfoto_mm8.tga",
	--					"frontend/fe_missionfoto_mm8u.tga",
	--					"frontend/fe_missionfoto_mm8j.tga",
	--				},
				["hints"] = {
					"am4.hint_3",
					"am4.hint_2",
					"am9.hint_2",
				},
			},
		},
		{
			["id"] = "40",
			["name"] = "scenex",
			["debriefingText"] = "",
			["sceneFile"] = "universe/scenes/missions/multi/scenex.scn",
			["date"] = { 2653, 11, 25 },
			["prerequisites"] = {},
			["description"] = "ide nem tudom mit kell irni",
			["picture"] = "",
			["allied"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"keszits scenet egy nap alatt ugy, hogy kozbe nem hasznalod a ctrl+c, ctrl+v billentyu kombinaciokat",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"frontend/fe_missionfoto_mm8.tga",
	--					"frontend/fe_missionfoto_mm8u.tga",
	--					"frontend/fe_missionfoto_mm8j.tga",
	--				},
				["hints"] = {
					"Sose hivj engine codert TestRelease-hez!",
					"A jo teszter elore szed!",
					"Watch out for Freecam fire!",
				},
			},
			["japanese"] = {
				["briefingGuiLayer"] = "",
				["primaryObjectives"] = {
					"Sose hivj engine codert TestRelease-hez!",
					"A jo teszter elore szed!",
					"Watch out for AA fire!",
				},
				["secondaryObjectives"] = {
				},
	--				["loadingBackgrounds"] = {
	--					"frontend/fe_missionfoto_mm8.tga",
	--					"frontend/fe_missionfoto_mm8u.tga",
	--					"frontend/fe_missionfoto_mm8j.tga",
	--				},
				["hints"] = {
					"Sose hivj engine codert TestRelease-hez!",
					"A jo teszter elore szed!",
					"Watch out for Freecam fire!",
				},
			},
		},
	}
end
