----------------------------------------------------------
-------- OLVASD EL MIELOTT FELVESZEL UJ RECORDOT! --------
----------------------------------------------------------
--[[
SYSTEM HINTEK CODEBOL JELENNEK MEG DE SCRIPTBOL IS BARMIKOR MEGHIVHATOAK! (HA VALAKI IDE FELVESZ UJ ELEMET AKKOR SZOLJON ATISNAK IS!)
OTHER HINTEKHEZ BARKI SZABADON BARMIKOR FELVEHET UJ REKORDOT EZEK CSAK SCRIPT UTASITASRA JELENNEK MEG!
OTHEREN BELUL KULON VAN BONTVA A SINGLE ES A MULTI, EZEN BELUL LEHET GENERAL VAGY PALYASPECIFIKUS IS EZT HASZNALNI KENE AZ ELNEVEZESNEL PL MULTI / PALYANEV + IDX (NAGYBAN FOGJA SEGITENI AZ ATLATHATOSAGOT AMIKOR FELDUZZAD A FILE.)
	PL:
		["OTHER"] = {
		["Single"] = {
			["IJN01_01"] = {
				["id"] = "IJN01_01",

		["OTHER"] = {
		["Single"] = {
			["GENERAL_01"] = {
				["id"] = "GENERAL_01",

		["SYSTEM"] = {
		["Unit"] = {
			["Unit_CV"] = {
				["id"] = "Unit_CV",

ID: MINDIG UNIQUENEK KELL LENNIE KOTELEZOEN! ERRE HIVATKOZIK A SCRIPT ES ASSERTAL A JATEK HA VAN 2 EGYFORMA ID.
TITLE: A SZOVEGBOX TETEJEN LESZ LEHET NEM FOGJUK HASZNALNI.
DESCRIPTION: EZ FOG MEGJELENNI A SZOVEGBOXBAN.
HA TILTE ES DESCRIPTION NINCS KITOLTVE MEG LEHET ADNI PARTY VAGY HA EZ SINCS KITOLTVE PLAYERINDEX SPECIFIKUS HINTEKET.
CRITICAL (true / false):  CRITICAL HINT PAUSEOL (SINGLEBEN) ES A KEPERNYO KOZEPEN JELENIK MEG, NON CRITICAL HINT A KEPERNYO SZELEN JELENIK MEG ES NEM ALL LE A JATEK KOZBEN.
STORING (unique / missionunique / repeatable / cooldown): UNIQUE EGYSZER JELENIK MEG A PLAYER ELETEBEN AUTOMATIKUSAN, MISSIONUNIQUE EGYSZER JELENIK MEG AZ ADOTT MISSIONBEN, REPEATABLE KORLATLANUL MEGJELENHET, COOLDOWN BEALLITOTT IDOKOZONKENT JELENHET MEG.
COOLDOWNTIME(sec): HA A STORING TYPE COOLDOWN AKKOR ENNEK A MEGADASA KOTELEZO. HA NEM AKKOR 0-AT KELL KOTELEZOEN BEIRNI.
DURATION(-1, 0, X sec): -1 A KOD KISZAMOLJA HOGY MEDDIG LEGYEN KINT, 0 A VEGTELENSEGIG KINT VAN, X sec MEGADOTT MASODPERCIG VAN KINT.

Type: tetszoleges de ertelemszeru lockitID. Tips listaban (ingame pause alatt) segit a rendszerezesben. Peldaul van egy altalanos plane hint, van torpedoveto hint, reconplane hin, ezeknek mind lehet Plane a type-ja, akkor egy menupont alatt jelennek meg
				["Type"] = "lockit.id.akarmi",
hidden: olyan hint, ami nem jelenik meg ingame, csak az ingame pause Tiplistajaban
				["hidden"] = false,
missionspecific: a tipsmenuben megjelenik, de csak az adott missionban, nem tarolodik a profilban
				["missionspecific"] = false,

NAMING CONVENTION:
EGY PALYASPECIFIKUS HINT PL EGY PORTY MORESBY SPECIFIKUS HINT MINDENKEPPEN A PALYA IDJEVEL KEZDODJON JELEN ESETBEN: IJN05 (GENERAL HINTNEL MEG SIMAN GENERAL KERUL AZ ID HELYERE)
HA CSAK DEMOHOZ KELL AKKOR AZ ID UTAN EZ IS SZEREPELJEN BENNE A JOBB ATTEKINTHETOSEG KEDVEERT.
A LEGVEGERE AKARMIT IRHATTOK AMI NEKTEK A LEGJOBB.
FENTI PELDA ALAPJAN PMHEZ EGY DEMOS HINT AZ ALABBI LENNE: IJN05_DEMO_01 VAGY IJN05_DEMO_INTRODUCTION STB.
]]


HintSystemMessages = {
	["SYSTEM"] = {

--------------------------------
---------- UNIT HINTS ----------
--------------------------------

		["Unit"] = {

---------- EXAMPLE ----------

			["EXAMPLE"] = {
				["id"] = "EXAMPLE",
				["Title"] = "EXAMPLE",
				["Type"] = "",
				["hidden"] = false,
				["missionspecific"] = false,
				["Description"] = "ingame.icontest2",
				["LuaCommand"] = "",
				---- if Title and Description is empty ----
				["AlliedTitle"] = "",
				["AlliedDescription"] = "",
				["AlliedLuaCommand"] = "",
				["JapaneseTitle"] = "",
				["JapaneseDescription"] = "",
				["JapaneseLuaCommand"] = "",
				---- if AlliedTitle and AlliedDescription is empty ----
				["TitleDescList"] = {
					["Player1"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player2"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player3"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player4"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player5"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player6"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player7"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
					["Player8"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
						["LuaCommand"] = "",
					},
				},
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- LST ----------

			["LST"] = {
				["id"] = "LST",
				["Title"] = "hints.unit_lst_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
		  	["Description"] = "hints.unit_hint_lst",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- TROOP TRANSPORT ----------

			["TROOP_TRANSPORT"] = {
				["id"] = "TROOP_TRANSPORT",
				["Title"] = "hints.unit_troopt_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_trooptransport",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- PT ----------

			["PT"] = {
				["id"] = "PT",
				["Title"] = "hints.unit_pt_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_pt",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- DESTROYER ----------

			["DESTROYER"] = {
				["id"] = "DESTROYER",
				["Title"] = "hints.unit_dd_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_destroyer",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- CRUISER ----------

			["CRUISER"] = {
				["id"] = "CRUISER",
				["Title"] = "hints.unit_ca_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_cruiser",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- BATTLESHIP ----------

			["BATTLESHIP"] = {
				["id"] = "BATTLESHIP",
				["Title"] = "hints.unit_bb_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_battleship",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- MOTHERSHIP ----------

			["MOTHERSHIP"] = {
				["id"] = "MOTHERSHIP",
				["Title"] = "hints.unit_cv_title",
				["Type"] = "hints.unit_ship_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_mothership",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- KAMIKAZE ----------

			["KAMIKAZE"] = {
				["id"] = "KAMIKAZE",
				["Title"] = "hints.unit_kamikaze_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_kamikaze",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- OHKA ----------

			["OHKA"] = {
				["id"] = "OHKA",
				["Title"] = "hints.unit_ohka_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_ohka",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- OHKA PAYLOAD ----------

			["OHKAPAYLOAD"] = {
				["id"] = "OHKA_PAYLOAD",
				["Title"] = "hints.weapon_plane_hint_ohkapayload_title",
				["Type"] = "hints.weapon_plane_hint",
				["hidden"] = true,
  			["Description"] = "hints.unit_hint_ohkapayload",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- PARATROOPER ----------

			["PARATROOPER"] = {
				["id"] = "PARATROOPER",
				["Title"] = "hints.unit_paratr_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_paratrooper",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- RECONPLANE ----------

			["RECONPLANE"] = {
				["id"] = "RECONPLANE",
				["Title"] = "hints.unit_recon_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_reconplane",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- LEVELBOMBER ----------

			["LEVELBOMBER"] = {
				["id"] = "LEVELBOMBER",
				["Title"] = "hints.unit_levelb_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_levelbomber",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- DIVEBOMBER ----------

			["DIVEBOMBER"] = {
				["id"] = "DIVEBOMBER",
				["Title"] = "hints.unit_diveb_hint",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_divebomber",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- TORPEDOBOMBER ----------

			["TORPEDOBOMBER"] = {
				["id"] = "TORPEDOBOMBER",
				["Title"] = "hints.unit_torpb_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_torpedobomber",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- FIGHTER ----------

			["FIGHTER"] = {
				["id"] = "FIGHTER",
				["Title"] = "hints.unit_fighter_title",
				["Type"] = "hints.unit_plane_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_fighter",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- SUBMARINE ----------

			["SUBMARINE"] = {
				["id"] = "SUBMARINE",
				["Title"] = "hints.unit_sub_title",
				["Type"] = "hints.unit_sub_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_submarine",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- COMMANDBUILDING ----------

			["COMMANDBUILDING"] = {
				["id"] = "COMMANDBUILDING",
				["Title"] = "hints.unit_cmdbuilding_title",
				["Type"] = "hints.gameplay_cpt_hint",
				["hidden"] = true,
				["Description"] = "hints.unit_hint_commandbuilding",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		},

----------------------------------
---------- WEAPON HINTS ----------
----------------------------------

		["Weapon"] = {

---------- AA / FLAK ----------

			["AAFLAK"] = {
				["id"] = "AAFLAK",
				["Title"] = "hints.weapon_ship_hint_aaflak_title",
				["Type"] = "hints.weapon_ship_hint",
				["Description"] = "hints.weapon_hint_aaflak",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_GUN_FIRE)",
			},

---------- LEVELBOMBER AA MODE ----------

			["LVLAA"] = {
				["id"] = "LVLAA",
				["Title"] = "hints.weapon_plane_hint_lvlaa_title",
				["Type"] = "hints.weapon_plane_hint",
				["Description"] = "hints.weapon_hint_lvlaa",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH)",
			},

---------- ARTILLERY ----------

			["ARTILLERY"] = {
				["id"] = "ARTILLERY",
				["Title"] = "hints.weapon_ship_hint_artillery_title",
				["Type"] = "hints.weapon_ship_hint",
				["Description"] = "hints.weapon_hint_artillery",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_GUN_FIRE)",
			},

---------- MACHINEGUN ----------

			["MACHINEGUN"] = {
				["id"] = "MACHINEGUN",
				["Title"] = "hints.weapon_plane_hint_machinegun_title",
				["Type"] = "hints.weapon_plane_hint",
				["Description"] = "hints.weapon_hint_machinegun",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_GUN_FIRE)",
			},

---------- BOMB ----------

			["BOMB"] = {
				["id"] = "BOMB",
				["Title"] = "hints.weapon_plane_hint_bomb_title",
				["Type"] = "hints.weapon_plane_hint",
				["Description"] = "hints.weapon_hint_bomb",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE,2)",
			},
--[[
---------- OHKA ----------

			["OHKA"] = {
				["id"] = "OHKA",
				["Title"] = "hints.weapon_hint_title",
				["Description"] = "hints.weapon_hint_ohka",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks()",
			},
]]
---------- ROCKET ----------

			["ROCKET"] = {
				["id"] = "ROCKET",
				["Title"] = "hints.weapon_plane_hint_rocket_title",
				["Type"] = "hints.weapon_plane_hint",
				["Description"] = "hints.weapon_hint_rocket",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE,2)",
			},

---------- TORPEDO SHIP ----------

			["TORPEDOSHIP"] = {
				["id"] = "TORPEDO_SHIP",
				["Title"] = "hints.weapon_ship_hint_torpedoship_title",
				["Type"] = "hints.weapon_ship_hint",
				["Description"] = "hints.weapon_hint_torpedoship",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_GUNC_TORPEDO);luaSetNarrativeParam(IC_GUN_FIRE,2)",
			},

---------- TORPEDO PLANE ----------

			["TORPEDOPLANE"] = {
				["id"] = "TORPEDO_PLANE",
				["Title"] = "hints.weapon_plane_hint_torpedoplane_title",
				["Type"] = "hints.weapon_plane_hint",
				["Description"] = "hints.weapon_hint_torpedoplane",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE,2)",
			},

---------- DC SHIP ----------

			["DCSHIP"] = {
				["id"] = "DC_SHIP",
				["Title"] = "hints.weapon_ship_hint_dcship_title",
				["Type"] = "hints.weapon_ship_hint",
				["Description"] = "hints.weapon_hint_dcship",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_GUNC_DEPTHCHARGE);luaSetNarrativeParam(IC_GUN_FIRE,2)",
			},

---------- DC PLANE ----------

			["DCPLANE"] = {
				["id"] = "DC_PLANE",
				["Title"] = "hints.weapon_plane_hint_dcplane_title",
				["Type"] = "hints.weapon_plane_hint",
				["Description"] = "hints.weapon_hint_dcplane",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE,2)",
			},
		},

------------------------------------
---------- GAMEPLAY HINTS ----------
------------------------------------

		["Gameplay"] = {

-------------------------
---------- MAP ----------
-------------------------

---------- MAP 1ST USE ----------

			["MAP1STUSE"] = {
				["id"] = "MAP1STUSE",
				["Title"] = "hints.gameplay_map1stuse_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_map1stuse",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- MAP PERMANENT ----------

			["MAPPERMANENT"] = {
				["id"] = "MAPPERMANENT",
				["Title"] = "hints.gameplay_mappermanent_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_mappermanent",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks()",
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MAP_CLOSEST_V,nil,true);luaSetNarrativeParam(IC_MAP_CLOSEST_V,2);luaSetNarrativeParam(IC_MAP_CLOSEST_H,3,true);luaSetNarrativeParam(IC_MAP_CLOSEST_H,4);luaSetNarrativeParam(IC_CMD_MAP_JUMPIN,5);luaSetNarrativeParam(IC_CMD_MAP_JOIN,6);luaSetNarrativeParam(IC_CMD_MAP_CLEARTARGET,7);luaSetNarrativeParam(IC_MAP_FILTER,8);luaSetNarrativeParam(IC_MAP_OBJECTIVES,9)",
			},

---------- FORMATION PERMANENT ----------

			["FORMATIONPERMANENT"] = {
				["id"] = "FORMATIONPERMANENT",
				["Title"] = "hints.gameplay_formationpermanent_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "hints.gameplay_hint_formationpermanent",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SEL_PREV_ITEM);luaSetNarrativeParam(IC_SEL_NEXT_ITEM,2);luaSetNarrativeParam(IC_MENU_BACK,3)",
			},

-----------------------------
---------- DAMAGES ----------
-----------------------------

---------- WATER ----------

			["WATER"] = {
				["id"] = "WATER",
				["Title"] = "hints.gameplay_damage_hint_water_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_water",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- FIRE ----------

			["FIRE"] = {
				["id"] = "FIRE",
				["Title"] = "hints.gameplay_damage_hint_fire_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_fire",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


---------- ENGINE ----------

			["ENGINE"] = {
				["id"] = "ENGINE",
				["Title"] = "hints.gameplay_damage_hint_engine_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_engine",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- ARMAMENT ----------

			["ARMAMENT"] = {
				["id"] = "ARMAMENT",
				["Title"] = "hints.gameplay_damage_hint_armament_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_armament",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- PERISCOPE ----------

			["PERISCOPE"] = {
				["id"] = "PERISCOPE",
				["Title"] = "hints.gameplay_damage_hint_periscope_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_periscope",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

-----------------------------
---------- CAPTURE ----------
-----------------------------

---------- LANDING 1ST ----------

			["LANDING1STGET"] = {
				["id"] = "LANDING1STGET",
				["Title"] = "hints.gameplay_landing1stget_title",
				["Type"] = "hints.gameplay_cpt_hint",
				["Description"] = "hints.gameplay_hint_landing1stget",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHLANDINGSHIPS)",
			},

---------- CAPTURE 1ST ----------

			["CAPTURE1STGET"] = {
				["id"] = "CAPTURE1STGET",
				["Title"] = "hints.gameplay_capture1stget_title",
				["Type"] = "hints.gameplay_cpt_hint",
				["Description"] = "hints.gameplay_hint_capture1stget",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

-----------------------------
---------- CONTROL ----------
-----------------------------

---------- BASIC PLANE ----------

			["BASICPLANE"] = {
				["id"] = "BASICPLANE",
				["Title"] = "hints.gameplay_basicplane_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_basicplane",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_POWER,nil,true);luaSetNarrativeParam(IC_PLANE_POWER,2);luaSetNarrativeParam(IC_PLANE_YAW,3,true);luaSetNarrativeParam(IC_PLANE_YAW,4)",
			},
			["BASICPLANE2"] = {
				["id"] = "BASICPLANE2",
				["Title"] = "hints.gameplay_basicplane_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_basicplane2",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_FIRE);luaSetNarrativeParam(IC_PLANE_BOMBSWITCH,2);luaSetNarrativeParam(IC_CMD_SETTARGET,3);luaSetNarrativeParam(IC_CMD_CLEARTARGET,4);luaSetNarrativeParam(IC_PLANE_TURBO,5)",
			},
			["BASICPLANE3"] = {
				["id"] = "BASICPLANE3",
				["Title"] = "hints.gameplay_basicplane_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_basicplane3",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH);luaSetNarrativeParam(IC_PLANE_LOOKMODE,2);luaSetNarrativeParam(IC_FORM_PREV,3);luaSetNarrativeParam(IC_FORM_NEXT,4)",
			},

---------- BASIC SHIP ----------

			["BASICSHIP"] = {
				["id"] = "BASICSHIP",
				["Title"] = "hints.gameplay_basicship_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "hints.gameplay_hint_basicship",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SHIP_THRUST,nil,true);luaSetNarrativeParam(IC_SHIP_THRUST,2);luaSetNarrativeParam(IC_SHIP_STEER,3,true);luaSetNarrativeParam(IC_SHIP_STEER,4);luaSetNarrativeParam(IC_GUN_FIRE,5);luaSetNarrativeParam(IC_GUNC_CHANGE,6,true);luaSetNarrativeParam(IC_GUNC_CHANGE,7)",
			},
			["BASICSHIP2"] = {
				["id"] = "BASICSHIP2",
				["Title"] = "hints.gameplay_basicship_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "hints.gameplay_hint_basicship2",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_CMD_SETTARGET);luaSetNarrativeParam(IC_CMD_CLEARTARGET,2);luaSetNarrativeParam(IC_REPAIR,3);luaSetNarrativeParam(IC_ZOOM_PC_TRICK,4);luaSetNarrativeParam(IC_FORM_PREV,5);luaSetNarrativeParam(IC_FORM_NEXT,6);luaSetNarrativeParam(IC_SEL_PREV_ITEM,7);luaSetNarrativeParam(IC_SEL_NEXT_ITEM,8)",
			},

---------- BASIC SUB ----------

			["BASICSUB"] = {
				["id"] = "BASICSUB",
				["Title"] = "hints.gameplay_basicsub_title",
				["Type"] = "hints.unit_sub_hint",
				["Description"] = "hints.gameplay_hint_basicsub",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SHIP_THRUST,nil,true);luaSetNarrativeParam(IC_SHIP_THRUST,2);luaSetNarrativeParam(IC_SHIP_STEER,3,true);luaSetNarrativeParam(IC_SHIP_STEER,4);luaSetNarrativeParam(IC_GUN_FIRE,5);luaSetNarrativeParam(IC_GUNC_CHANGE,6,true);luaSetNarrativeParam(IC_GUNC_CHANGE,7);luaSetNarrativeParam(IC_SUB_RISE,8);luaSetNarrativeParam(IC_SUB_DIP,9)",
			},
			["BASICSUB2"] = {
				["id"] = "BASICSUB2",
				["Title"] = "hints.gameplay_basicsub_title",
				["Type"] = "hints.unit_sub_hint",
				["Description"] = "hints.gameplay_hint_basicsub2",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_CMD_SETTARGET);luaSetNarrativeParam(IC_CMD_CLEARTARGET,2);luaSetNarrativeParam(IC_REPAIR,3);luaSetNarrativeParam(IC_ZOOM_PC_TRICK,4);luaSetNarrativeParam(IC_FORM_PREV,5);luaSetNarrativeParam(IC_FORM_NEXT,6)",
			},

---------- REPAIR PERMANENT ----------

			["REPPERMANENT"] = {
				["id"] = "REPPERMANENT",
				["Title"] = "hints.gameplay_reppermanent_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_repairpermanent",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_OVERLAY_V,nil,true);luaSetNarrativeParam(IC_OVERLAY_V,2);luaSetNarrativeParam(IC_OVERLAY_H,3,true);luaSetNarrativeParam(IC_OVERLAY_H,4);luaSetNarrativeParam(IC_REPAIR,5)",
			},

---------- REPAIR 1ST USE ----------

			["REPAIR1STUSE"] = {
				["id"] = "REPAIR1STUSE",
				["Title"] = "hints.gameplay_repair1stuse_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_repair1stuse",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_OVERLAY_V,nil,true);luaSetNarrativeParam(IC_OVERLAY_V,2);luaSetNarrativeParam(IC_OVERLAY_H,3,true);luaSetNarrativeParam(IC_OVERLAY_H,4);luaSetNarrativeParam(IC_REPAIR,5)",
			},

---------- ORDERS PERMANENT ----------

			["ORDPERMANENT"] = {
				["id"] = "ORDPERMANENT",
				["Title"] = "hints.gameplay_ordpermanent_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_orderspermanent",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_OVERLAY_V,nil,true);luaSetNarrativeParam(IC_OVERLAY_V,2);luaSetNarrativeParam(IC_OVERLAY_H,3,true);luaSetNarrativeParam(IC_OVERLAY_H,4);luaSetNarrativeParam(IC_OVERLAY_BLUE,5)",
			},

---------- ORDERS 1ST USE ----------

			["ORDER1STUSE"] = {
				["id"] = "ORDER1STUSE",
				["Title"] = "hints.gameplay_order1stuse_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_orders1stuse",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

---------- SM 1ST GET ----------

			["SM1STGET"] = {
				["id"] = "SM1STGET",
				["Title"] = "hints.gameplay_sm1stget_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_sm1stget",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY)",
			},

---------- SM 1ST USE ----------

			["SM1STUSE"] = {
				["id"] = "SM1STUSE",
				["Title"] = "hints.gameplay_sm1stuse_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_sm1stuse",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_SM_ATTACK,3);luaSetNarrativeParam(IC_SM_CHANGE_WEAPON,4)",
			},

---------- SM PERMANENT PLANE SPECT----------

			["SMPERMANENTPLANESPECT"] = {
				["id"] = "SMPERMANENTPLANESPECT",
				["Title"] = "hints.gameplay_smpermanentplane_spectator_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentplane_spectator",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_ATTACK,5);luaSetNarrativeParam(IC_SM_CHANGE_WEAPON,6)",
			},

---------- SM PERMANENT SP level SPECT----------

			["SMPERMANENTSPLEVELSPECT"] = {
				["id"] = "SMPERMANENTSPLEVELSPECT",
				["Title"] = "hints.gameplay_smpermanentsplevel_spectator_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentsplevel_spectator",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_ATTACK,5);luaSetNarrativeParam(IC_SM_JUMP_IN,6)",
			},

---------- SM PERMANENT UNIT LEVEL SPECT----------

			["SMPERMANENTUNITLEVELSPECT"] = {
				["id"] = "SMPERMANENTUNITLEVELSPECT",
				["Title"] = "hints.gameplay_smpermanentunitlevel_spectator_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentunitlevel_spectator",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_JUMP_IN,5)",
			},

---------- SM PERMANENT UNIT LEVEL, PLANE SPECT----------

			["SMPERMANENTUNITLEVELPLANESPECT"] = {
				["id"] = "SMPERMANENTUNITLEVELPLANESPECT",
				["Title"] = "hints.gameplay_smpermanentunitlevel_plane_spectator_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentunitlevel_plane_spectator",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_JUMP_IN,5);luaSetNarrativeParam(IC_SM_LAND,6)",
			},
---------- SM PERMANENT SHIP + KAMIKAZE SPECT----------

			["SMPERMANENTSHIPSPECT"] = {
				["id"] = "SMPERMANENTSHIPSPECT",
				["Title"] = "hints.gameplay_smpermanentship_spectator_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentship_spectator",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_ATTACK,5)",
			},

---------- SM PERMANENT PLANE ----------

			["SMPERMANENTPLANE"] = {
				["id"] = "SMPERMANENTPLANE",
				["Title"] = "hints.gameplay_smpermanentplane_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentplane",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_ATTACK,5);luaSetNarrativeParam(IC_SM_CHANGE_WEAPON,6)",
			},

---------- SM PERMANENT SP level ----------

			["SMPERMANENTSPLEVEL"] = {
				["id"] = "SMPERMANENTSPLEVEL",
				["Title"] = "hints.gameplay_smpermanentsplevel_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentsplevel",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_ATTACK,5);luaSetNarrativeParam(IC_SM_JUMP_IN,6)",
			},

---------- SM PERMANENT UNIT LEVEL ----------

			["SMPERMANENTUNITLEVEL"] = {
				["id"] = "SMPERMANENTUNITLEVEL",
				["Title"] = "hints.gameplay_smpermanentunitlevel_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentunitlevel",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_JUMP_IN,5)",
			},

---------- SM PERMANENT UNIT LEVEL, PLANE ----------

			["SMPERMANENTUNITLEVELPLANE"] = {
				["id"] = "SMPERMANENTUNITLEVELPLANE",
				["Title"] = "hints.gameplay_smpermanentunitlevel_plane_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentunitlevel_plane",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_JUMP_IN,5);luaSetNarrativeParam(IC_SM_LAND,6)",
			},
---------- SM PERMANENT SHIP + KAMIKAZE ----------

			["SMPERMANENTSHIP"] = {
				["id"] = "SMPERMANENTSHIP",
				["Title"] = "hints.gameplay_smpermanentship_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_smpermanentship",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_MENU_LEFT,3);luaSetNarrativeParam(IC_MENU_RIGHT,4);luaSetNarrativeParam(IC_SM_ATTACK,5)",
			},

---------- PUM 1ST GET ----------

			["PUM1STGET"] = {
				["id"] = "PUM1STGET",
				["Title"] = "hints.gameplay_pum1stget_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_pum1stget",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_POWERUPS_TOGGLE)",
			},

---------- PUM 1ST USE ----------

			["PUM1STUSE"] = {
				["id"] = "PUM1STUSE",
				["Title"] = "hints.gameplay_pum1stuse_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_pum1stuse",
				["critical"] = true,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_SM_ATTACK,3)",
			},

---------- PUM PERMANENT ----------

			["PUMPERMANENT"] = {
				["id"] = "PUMPERMANENT",
				["Title"] = "hints.gameplay_pumpermanent_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "hints.gameplay_hint_pumpermanent",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_SM_ATTACK,3)",
			},
		},
	},

---------------------------------------
---------- SYSTEM HINTS VEGE ----------
---------------------------------------


---------------------------------
---------- OTHER HINTS ----------
---------------------------------

	["OTHER"] = {
		["Single"] = {
			["Singlehint1"] = {
				["id"] = "Hint_5",
				["Title"] = "Hint1_Title_lockitid",
				["Type"] = "",
				["Description"] = "Hint1_Desc_lockitid",
				---- if Title and Description is empty ----
				["AlliedTitle"] = "",
				["AlliedDescription"] = "",
				["JapaneseTitle"] = "",
				["JapaneseDescription"] = "",
				---- if AlliedTitle and AlliedDescription is empty ----
				["TitleDescList"] = {
					["Player1"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player2"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player3"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player4"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player5"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player6"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player7"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player8"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
				},
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 12,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


---------------------------------

			--IJN01 - PEARL HARBOR HINTS
			["IJN01_Retreathint"] = {
				["id"] = "IJN01_Hint01",
				["Title"] = "ijn01.hint_01_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_1_desc", --Press retreat in the ORDERS menu to get a new squad.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN01_Dogfighthint"] = {
				["id"] = "IJN01_Hint02",
				["Title"] = "ijn01.hint_02_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "ijn01.hint_2_desc", --Use the <reft stick icon> to dive, climb and roll. Use up and down on the <right stick icon> to set your speed and left and right to control the rudder.	Hold down <turbo button icon> to temporarily boost your speed, this turbo boost takes time to recharge after use.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_POWER, nil);luaSetNarrativeParam(IC_PLANE_POWER, 2, true); luaSetNarrativeParam(IC_PLANE_YAW, 3); luaSetNarrativeParam(IC_PLANE_YAW, 4, true);luaSetNarrativeParam(IC_PLANE_TURBO, 5)",
			},
			["IJN01_Swaphint"] = {
				["id"] = "IJN01_Hint03",
				["Title"] = "ijn01.hint_03_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_3_desc", --If you're not feeling comfortable with the way the control sticks are set then press  <? button icon> to swap them now.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 60,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_BACK)",
			},
			["IJN01_Cockpithint"] = {
				["id"] = "IJN01_Hint04",
				["Title"] = "ijn01.hint_04_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "ijn01.hint_4_desc", --Press <cockpit view button icon> to go in and out of cockpit view. Press and hold <Look around button icon> and then move the <Right stick icon> to look around.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 12,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH);luaSetNarrativeParam(IC_PLANE_LOOKMODE, 2)",
			},
			["IJN01_Targetcyclehint"] = {
				["id"] = "IJN01_Hint05",
				["Title"] = "ijn01.hint_05_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn01.hint_5_desc", --Press <A button icon> to cycle between enemy targets. Press <A button icon> while your crosshair is over an enemy to make that enemy the active target.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -12,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_SETTARGET)",
			},
			["IJN01_Divebomberhint"] = {
				["id"] = "IJN01_Hint06",
				["Title"] = "ijn01.hint_06_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_6_desc", --This is a divebomber, try to dive down on a target and get as close as you can before releasing your bomb.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN01_releashint"] = {
				["id"] = "IJN01_Hint07",
				["Title"] = "ijn01.hint_07_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "ijn01.hint_7_desc", --If your plane is equipped with bombs press and hold <LT icon> to display the bombing reticule, press <RT icon> while in this view to release your bombs.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE, 2)",
			},
			["IJN01_Ordeshint"] = {
				["id"] = "IJN01_Hint08",
				["Title"] = "ijn01.hint_08_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn01.hint_8_desc", --Press and hold <X button icon> to bring up the orders menu, while holding X press the corresponding direction on the d-pad to give an order.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_OVERLAY_BLUE)",
			},
			["IJN01_Torpedoerhint"] = {
				["id"] = "IJN01_Hint09",
				["Title"] = "ijn01.hint_09_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_9_desc", --You are in a torpedo bomber. Torpedos must dropped below 100ft (the red line on your altimeter) or they will explode on impact.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE, 2)",
			},
			["IJN01_Poweruphint01"] = {
				["id"] = "IJN01_Hint10",
				["Title"] = "ijn01.hint_10_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_10_desc", --You've earned a power-up, press and hold <RB icon> to access the power-up menu.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_POWERUPS_TOGGLE)",
			},
			["IJN01_Poweruphint02"] = {
				["id"] = "IJN01_Hint11",
				["Title"] = "ijn01.hint_11_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_11_desc", --Select your power-up with the d-pad and press <A button icon> to use it.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN01_ShootedDownhint01"] = {
				["id"] = "IJN01_Hint12",
				["Title"] = "ijn01.hint_12_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_shooteddown_1", --#Mission.ShootedDownPlanes# fighter killed so far
				["critical"] = false,
				["storingrule"] = "repetable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN01_ShootedDownhint02"] = {
				["id"] = "IJN01_Hint13",
				["Title"] = "ijn01.hint_13_title",
				["Type"] = "hints.gameplay_ijn01_hint",
				["Description"] = "ijn01.hint_shooteddown_2", --#Mission.ShootedDownPlanes# fighter killed so far
				["critical"] = false,
				["storingrule"] = "repetable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			--IJN02 - FORCE Z HINTS

			--IJN03 - JAVA SEA HINTS
			["IJN03_Binocthint"] = {
				["id"] = "IJN03_Hint01",
				["Title"] = "ijn03.hint_01_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "ijn03.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH)",
			},

			["IJN03_RepairHint"] = {
				["id"] = "IJN03_Hint02",
				["Title"] = "ijn03.hint_02_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "ijn03.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_REPAIR)",
			},

			["IJN03_REPAIR1STUSE"] = {
				["id"] = "IJN03_REPAIR1STUSE_CLONE",
				["Title"] = "hints.gameplay_repair1stuse_title",
				["Type"] = "hints.gameplay_damage_hint",
				["Description"] = "hints.gameplay_hint_repair1stuse",
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_OVERLAY_V,nil,true);luaSetNarrativeParam(IC_OVERLAY_V,2);luaSetNarrativeParam(IC_OVERLAY_H,3,true);luaSetNarrativeParam(IC_OVERLAY_H,4);luaSetNarrativeParam(IC_REPAIR,5)",
			},


			--IJN04 - CORAL SEA HINTS
			["IJN04_AABroadHint"] = {
				["id"] = "IJN04_Hint01",
				["Title"] = "ijn04.hint_01_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "ijn04.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN04_ReconplaneHint"] = {
				["id"] = "IJN04_Hint02",
				["Title"] = "ijn04.hint_02_title",
				["Type"] = "hints.gameplay_ijn04_hint",
				["Description"] = "ijn04.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT)",
			},
			["IJN04_DepthChargeHint"] = {
				["id"] = "IJN04_Hint03",
				["Title"] = "ijn04.hint_03_title",
				["Type"] = "hints.gameplay_ijn04_hint",
				["Description"] = "ijn04.hint_3_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN04_SMHint"] = {
				["id"] = "IJN04_Hint04",
				["Title"] = "ijn04.hint_04_title",
				["Type"] = "hints.gameplay_ijn04_hint",
				["Description"] = "ijn04.hint_4_desc",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY)",
			},

			--IJN05 - PORT MORESBY HINTS
			["IJN05_Capturehint"] = {
				["id"] = "IJN05_Hint01",
				["Title"] = "ijn05.hint_01_title",
				["Type"] = "hints.gameplay_cpt_hint",
				["Description"] = "ijn05.hint_1_desc", --To capture an island move your ships close enough to cause the capture bar to appear. The more ships you have in range the faster the bar moves in your favour. LST's and landing boats cause the bar to move even faster.When you see <landing in range icon> icon press <LB icon> to launch landing ships.
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHLANDINGSHIPS)",
			},
			["IJN05_Zerohint"] = {
				["id"] = "IJN05_Hint02",
				["Title"] = "ijn05.hint_02_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_2_desc", --A squadron of Zero fighters have joined your side. They're waiting for your orders.
				["critical"] = false,
				["storingrule"] = "repetable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_Nellhint"] = {
				["id"] = "IJN05_Hint03",
				["Title"] = "ijn05.hint_03_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_3_desc", --A squadron of Nell bombers have joined your side. They're waiting for your orders.
				["critical"] = false,
				["storingrule"] = "repetable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_Maphint01"] = {
				["id"] = "IJN05_Hint04",
				["Title"] = "ijn05.hint_04_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn05.hint_4_desc", --Press <back button icon> to enter the map screen.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MAP_TOGGLE)",

			},
			["IJN05_Maphint02"] = {
				["id"] = "IJN05_Hint05",
				["Title"] = "ijn05.hint_05_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn05.hint_5_desc", --The light areas of the map are within visual range of your units, the green areas are within sonar range (the only way to detect submerged submarines), everything else is covered by radar and shows only the enemy presence not their composition.<LS Icon> moves around the map <RT icon> and <LT icon> zoom in and out, revealing more detail.Press <LB icon> to view mission objectives, press left and right on the d-pad to move between objectives.
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MAP_ZOOM);luaSetNarrativeParam(IC_MAP_ZOOM,2,true);luaSetNarrativeParam(IC_MAP_OBJECTIVES,3);luaSetNarrativeParam(IC_MENU_LEFT,4);luaSetNarrativeParam(IC_MENU_RIGHT,5)",
			},
			["IJN05_Maphint03"] = {
				["id"] = "IJN05_Hint06",
				["Title"] = "ijn05.hint_06_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn05.hint_6_desc", --<LS Icon> moves around the map <RT icon> and <LT icon> zoom in and out, revealing more detail.Press <LB icon> to view mission objectives, press left and right on the d-pad to move between objectives.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MAP_ZOOM);luaSetNarrativeParam(IC_MAP_ZOOM,2,true);luaSetNarrativeParam(IC_MAP_OBJECTIVES,3);luaSetNarrativeParam(IC_MENU_LEFT,4);luaSetNarrativeParam(IC_MENU_RIGHT,5)",
			},
			["IJN05_Maphint04"] = {
				["id"] = "IJN05_Hint07",
				["Title"] = "ijn05.hint_07_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn05.hint_7_desc", --Move the crosshair over a unit to see its details. Use the d-pad as normal to cycle through your own units or press <A button icon> to select a friendly unit under the crosshair. Pressing <A button icon> or <Y button icon> while over an enemy unit will order the currently selected friendly unit to attack that enemy unit.Press <Y button icon> while the crosshair is over empty ocean or sky to set that point as a destination for your currently selected unit. Press <Y button icon> while the crosshair is over a friendly unit to follow that unit with your currently selected unit (this causes a ship to join a formation).Press <B button icon> to cancel orders.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MENU_LEFT);luaSetNarrativeParam(IC_MENU_RIGHT,2);luaSetNarrativeParam(IC_CMD_SETTARGET,3);luaSetNarrativeParam(IC_CMD_CLEARTARGET,4);luaSetNarrativeParam(IC_CMD_MAP_JUMPIN,5)",
			},
			["IJN05_Maphint05"] = {
				["id"] = "IJN05_Hint08",
				["Title"] = "ijn05.hint_08_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "ijn05.hint_8_desc", --Y - select unit A - issue order B - cancel order LB - objectives menu
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_CMD_SETTARGET);luaSetNarrativeParam(IC_CMD_CLEARTARGET,2);luaSetNarrativeParam(IC_MAP_OBJECTIVES,3)",
			},
			["IJN05_CBHint"] = {
				["id"] = "IJN05_Hint09",
				["Title"] = "ijn05.hint_09_title",
				["Type"] = "hints.gameplay_general_hint",
				["Description"] = "ijn05.hint_9_desc", --Buildings and building defences can be selected and controlled just like your other units.
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_SMHint"] = {
				["id"] = "IJN05_Hint10",
				["Title"] = "ijn05.hint_10_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_10_desc", --Access the new stock through the support manager
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--event hints
			["IJN05_SubEventHint01"] = {
				["id"] = "IJN05_Hint11",
				["Title"] = "ijn05.hint_11_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_11_desc", --Destroy the submarine within the time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_ReconEventHint01"] = {
				["id"] = "IJN05_Hint12",
				["Title"] = "ijn05.hint_12_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_12_desc", --Recon the navpoints within the time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_LostplaneEventHint01"] = {
				["id"] = "IJN05_Hint13",
				["Title"] = "ijn05.hint_13_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_13_desc", --Locate the crashed plane witihin the time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_InterceptEventHint01"] = {
				["id"] = "IJN05_Hint14",
				["Title"] = "ijn05.hint_14_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_14_desc", --Shoot down the reconplanes within time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_ConvoyEventHint01"] = {
				["id"] = "IJN05_Hint15",
				["Title"] = "ijn05.hint_15_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_15_desc", --Destroy the truck convoy within the time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_CargoEventHint01"] = {
				["id"] = "IJN05_Hint16",
				["Title"] = "ijn05.hint_16_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_16_desc", --Sink all cargos within the time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 12,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_PatrolEventHint01"] = {
				["id"] = "IJN05_Hint17",
				["Title"] = "ijn05.hint_17_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_17_desc", --Destroy the PT boats within the time limit to receive a power-up!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["IJN05_EventReminderHint"] = {
				["id"] = "IJN05_Hint18",
				["Title"] = "ijn05.hint_18_title",
				["Type"] = "hints.gameplay_ijn05_hint",
				["Description"] = "ijn05.hint_18_desc", --#Mission.EventName# is active, #Mission.TimeLeft# seconds remaining!
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			-- IJN 06 HINTS

			["IJN06_ReconPlaneHint"] = {
				["id"] = "IJN06_Hint01",
				["Title"] = "ijn06.hint_01_title",
				["Type"] = "hints.gameplay_ijn06_hint",
				["Description"] = "ijn06.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_LEFT);luaSetNarrativeParam(IC_MENU_RIGHT,2);luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT,3)",
			},

			["IJN06_KaitenHint"] = {
				["id"] = "IJN06_Hint01_Kaiten",
				["Title"] = "ijn06.hint_01_kaiten_title",
				["Type"] = "hints.gameplay_ijn06_hint",
				["Description"] = "ijn06.hint_1_kaiten_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_LEFT);luaSetNarrativeParam(IC_MENU_RIGHT,2);luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT,3)",
			},

			["IJN06_PeriscopeHint"] = {
				["id"] = "IJN06_Hint02",
				["Title"] = "ijn06.hint_02_title",
				["Type"] = "hints.unit_sub_hint",
				["Description"] = "ijn06.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH)",
			},

			["IJN06_SafeHint"] = {
				["id"] = "IJN06_Hint03",
				["Title"] = "ijn06.hint_03_title",
				["Type"] = "hints.gameplay_ijn06_hint",
				["Description"] = "ijn06.hint_3_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN06_ZeroHint"] = {
				["id"] = "IJN06_Hint04",
				["Title"] = "ijn06.hint_04_title",
				["Type"] = "hints.gameplay_ijn06_hint",
				["Description"] = "ijn06.hint_4_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_POWERUPS_TOGGLE);luaSetNarrativeParam(IC_CMD_SETTARGET,2)",
			},

			["IJN06_EnemySubHint"] = {
				["id"] = "IJN06_Hint05",
				["Title"] = "ijn06.hint_05_title",
				["Type"] = "hints.gameplay_ijn06_hint",
				["Description"] = "ijn06.hint_5_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_SETTARGET)",
			},



			--IJN07 hints
			["IJN07_SubHint"] = {
				["id"] = "IJN07_Hint01",
				["Title"] = "ijn07.hint_01_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "ijn07.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_BBHint"] = {
				["id"] = "IJN07_Hint02",
				["Title"] = "ijn07.hint_02_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "ijn07.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_CAPHint"] = {
				["id"] = "IJN07_Hint03",
				["Title"] = "ijn07.hint_03_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "ijn07.hint_3_desc",
				["critical"] = false,
				["storingrule"] = "repetable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 300,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_ASHint"] = {
				["id"] = "IJN07_Hint04",
				["Title"] = "ijn07.hint_04_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "ijn07.hint_4_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_PilotHint"] = {
				["id"] = "IJN07_Hint05",
				["Title"] = "ijn07.hint_05_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "The most skillful pilots in the world are onboard your 4 carriers. They are precious for Imperial Navy.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_BuckupHint"] = {
				["id"] = "IJN07_Hint06",
				["Title"] = "ijn07.hint_06_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "There are backup plane materials on carriers for repairing/replacement. Also, a just in time assembling is possible.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_AkagiHint"] = {
				["id"] = "IJN07_Hint07",
				["Title"] = "ijn07.hint_07_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Convert from a battlecruiser, Akagi is an old but fast carrier, she carries 54 aircrafts. Akagi is the flagship of the Kido Butai and the First Carrier Fleet.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_KagaHint"] = {
				["id"] = "IJN07_Hint08",
				["Title"] = "ijn07.hint_08_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "The enormous battleship hull makes Kaga the slowest and least maneuverable in the fleet, but also brings her a good strength and stability, so as a larger hanger volume.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_SoryuHint"] = {
				["id"] = "IJN07_Hint09",
				["Title"] = "ijn07.hint_09_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Soryu is a mordern carrier. She is very fast and agile, lighter, while carrying no less aircraft than Akagi and Kaga, but she is the most lightly armoured carrier in the fleet.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_HiryuHint"] = {
				["id"] = "IJN07_Hint10",
				["Title"] = "ijn07.hint_10_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Hiryu is a mordern carrier. She is a bit better armoured than her sister Soryu, while as agile as Soryu. Hiryu is the flagship of Second Carrier Fleet.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_FireHint"] = {
				["id"] = "IJN07_Hint11",
				["Title"] = "ijn07.hint_11_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Your carriers are formidable but fragile war machines. Fires can suspend their flight deck. Launching aircraft makes them even more vulnerable as fuel and ammo are dispatching. But this is the same for your enemy!",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_LevelBomberHint"] = {
				["id"] = "IJN07_Hint12",
				["Title"] = "ijn07.hint_12_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Level bombers usually create scary carpet bombing, but usually lack of accuracy due to their altitude.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_TorpedoBomberHint"] = {
				["id"] = "IJN07_Hint13",
				["Title"] = "ijn07.hint_13_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "According to torpedo bombers, the most uncomfortable attack angle, is from the stern...",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_DiveBomberHint"] = {
				["id"] = "IJN07_Hint14",
				["Title"] = "ijn07.hint_14_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Dive bombers are lighter than level/torpedo bombers. But they often achieve surprise. Watch out your head.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN07_EnemyHint"] = {
				["id"] = "IJN07_Hint15",
				["Title"] = "ijn07.hint_15_title",
				["Type"] = "hints.gameplay_ijn07_hint",
				["Description"] = "Enemy attacks all focus on carriers. They seem ignoring your Kongo class battleships, prove them a mistake!",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			--IJN08 hints
			["IJN08_SMHint"] = {
				["id"] = "IJN08_Hint01",
				["Title"] = "ijn08.hint_01_title",
				["Type"] = "hints.gameplay_ijn08_hint",
				["Description"] = "ijn08.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN08_CBHint"] = {
				["id"] = "IJN08_Hint02",
				["Title"] = "ijn08.hint_02_title",
				["Type"] = "hints.gameplay_ijn08_hint",
				["Description"] = "ijn08.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN08_TorpHint"] = {
				["id"] = "IJN08_Hint03",
				["Title"] = "ijn08.hint_03_title",
				["Type"] = "hints.gameplay_ijn08_hint",
				["Description"] = "ijn08.hint_3_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN08_RocketHint"] = {
				["id"] = "IJN08_Hint04",
				["Title"] = "ijn08.hint_04_title",
				["Type"] = "hints.gameplay_ijn08_hint",
				["Description"] = "ijn08.hint_4_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			--IJN09 hints
			["IJN09_ReconplaneHint"] = {
				["id"] = "IJN09_Hint01",
				["Title"] = "ijn09.hint_01_title",
				["Type"] = "hints.gameplay_ijn09_hint",
				["Description"] = "ijn09.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN09_CruiserHint"] = {
				["id"] = "IJN09_Hint02",
				["Title"] = "ijn09.hint_02_title",
				["Type"] = "hints.gameplay_ijn09_hint",
				["Description"] = "ijn09.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN09_BomberHint"] = {
				["id"] = "IJN09_Hint03",
				["Title"] = "ijn09.hint_03_title",
				["Type"] = "hints.gameplay_ijn09_hint",
				["Description"] = "ijn09.hint_3_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN09_BBHint"] = {
				["id"] = "IJN09_Hint04",
				["Title"] = "ijn09.hint_04_title",
				["Type"] = "hints.gameplay_ijn09_hint",
				["Description"] = "ijn09.hint_4_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			--IJN10 HINTS
			["IJN10_MsubHint"] = {
				["id"] = "IJN10_Hint01",
				["Title"] = "ijn10.hint_01_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_1_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_TorpHint"] = {
				["id"] = "IJN10_Hint02",
				["Title"] = "ijn10.hint_02_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_2_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_MineHint"] = {
				["id"] = "IJN10_Hint03",
				["Title"] = "ijn10.hint_03_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_3_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_IdentifyHint"] = {
				["id"] = "IJN10_Hint04",
				["Title"] = "ijn10.hint_04_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_4_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_AmmoHint"] = {
				["id"] = "IJN10_Hint05",
				["Title"] = "ijn10.hint_05_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_5_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_SafeHint"] = {
				["id"] = "IJN10_Hint06",
				["Title"] = "ijn10.hint_06_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_6_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_SneakHint"] = {
				["id"] = "IJN10_Hint07",
				["Title"] = "ijn10.hint_07_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_7_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_SubsleftHint"] = {
				["id"] = "IJN10_Hint08",
				["Title"] = "ijn10.hint_08_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_8_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN10_WayPointHint"] = {
				["id"] = "IJN10_Hint09",
				["Title"] = "ijn10.hint_09_title",
				["Type"] = "hints.gameplay_ijn10_hint",
				["Description"] = "ijn10.hint_9_desc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			--IJN11 HINTS
			["IJN11_CarrierCAP"] = {
				["id"] = "IJN11_CarrierCAP",
				["Title"] = "ijn11.hint_CarrierCAP_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_carriercap",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_CBDestroy"] = {
				["id"] = "IJN11_CBDestroy",
				["Title"] = "ijn11.hint_CBDestroy_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_cbdestroy",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_CBRecap"] = {
				["id"] = "IJN11_CBRecap",
				["Title"] = "ijn11.hint_CBRecap_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_cbrecap",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_FormationShape"] = {
				["id"] = "IJN11_FormationShape",
				["Title"] = "ijn11.hint_FormationShape_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_formationshape",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_Torp"] = {
				["id"] = "IJN11_Torp",
				["Title"] = "ijn11.hint_Torp_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_torp",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			["IJN11_SubDC"] = {
				["id"] = "IJN11_SubDC",
				["Title"] = "ijn11.hint_SubDC_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_subdc",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_AK"] = {
				["id"] = "IJN11_AK",
				["Title"] = "ijn11.hint_AK_title",
				["Description"] = "ijn11.hint_ak",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			["IJN11_CleverBB"] = {
				["id"] = "IJN11_CleverBB",
				["Title"] = "ijn11.hint_CleverBB_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_cleverbb",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_Island"] = {
				["id"] = "IJN11_Island",
				["Title"] = "ijn11.hint_Island_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_island",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN11_BB"] = {
				["id"] = "IJN11_BB",
				["Title"] = "ijn11.hint_BB_title",
				["Type"] = "hints.gameplay_ijn11_hint",
				["Description"] = "ijn11.hint_bb",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			--IJN12

			["IJN12_Oxygene"] = {
				["id"] = "IJN12_Oxygene",
				["Title"] = "ijn12.hint_oxygene_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_oxygene",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN12_ASW"] = {
				["id"] = "IJN12_ASW",
				["Title"] = "ijn12.hint_ASW_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_asw",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN12_Dive"] = {
				["id"] = "IJN12_Dive",
				["Title"] = "ijn12.hint_Dive_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_dive",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			["IJN12_CV"] = {
				["id"] = "IJN12_CV",
				["Title"] = "ijn12.hint_CV_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_cv",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN12_Fido"] = {
				["id"] = "IJN12_Fido",
				["Title"] = "ijn12.hint_Fido_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_fido",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN12_Radar"] = {
				["id"] = "IJN12_Radar",
				["Title"] = "ijn12.hint_Radar_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_radar",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN12_Land"] = {
				["id"] = "IJN12_Land",
				["Title"] = "ijn12.hint_Land_title",
				["Type"] = "hints.gameplay_ijn12_hint",
				["Description"] = "ijn12.hint_land",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			--IJN13
			["IJN13_Assist"] = {
				["id"] = "IJN13_Assist",
				["Title"] = "ijn13.hint_Assist_title",
				["Type"] = "hints.gameplay_ijn13_hint",
				["Description"] = "ijn13.hint_assist",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN13_Kamikaze"] = {
				["id"] = "IJN13_Kamikaze",
				["Title"] = "ijn13.hint_Kamikaze_title",
				["Type"] = "hints.gameplay_ijn13_hint",
				["Description"] = "ijn13.hint_kamikaze",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN13_Lastplane"] = {
				["id"] = "IJN13_Lastplane",
				["Title"] = "ijn13.hint_lastplane_title",
				["Type"] = "hints.gameplay_ijn13_hint",
				["Description"] = "ijn13.hint_lastplane",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN13_Para"] = {
				["id"] = "IJN13_Para",
				["Title"] = "ijn13.hint_para_title",
				["Type"] = "hints.gameplay_ijn13_hint",
				["Description"] = "ijn13.hint_para",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN13_Strafe"] = {
				["id"] = "IJN13_Strafe",
				["Title"] = "ijn13.hint_strafe_title",
				["Type"] = "hints.gameplay_ijn13_hint",
				["Description"] = "ijn13.hint_strafe",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			--IJN14

			["IJN14_SM"] = {
				["id"] = "IJN14_SM",
				["Title"] = "ijn14.hint_sm_title",
				["Type"] = "hints.gameplay_ijn14_hint",
				["Description"] = "ijn14.hint_sm",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["IJN14_Recon"] = {
				["id"] = "IJN14_Recon",
				["Title"] = "ijn14.hint_recon_title",
				["Type"] = "hints.gameplay_ijn14_hint",
				["Description"] = "ijn14.hint_recon",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 6,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},


			--USN01
			["USN01_Hint_Switch_Unit"] = {
				["id"] = "USN01_Hint_Switch_Unit",
				["Title"] = "usn01.hint_Switch_Unit_title",
				["Type"] = "hints.gameplay_usn01_hint",
				["Description"] = "usn01.hint_switch_unit",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SEL_NEXT_ITEM);luaSetNarrativeParam(IC_SEL_PREV_ITEM,2)",
			},
			["USN01_Hint_Intercept"] = {
				["id"] = "USN01_Hint_Intercept",
				["Title"] = "usn01.hint_Intercept_title",
				["Type"] = "hints.gameplay_usn01_hint",
				["Description"] = "usn01.hint_intercept",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN01_Hint_Priority"] = {
				["id"] = "USN01_Hint_Priority",
				["Title"] = "usn01.hint_Priority_title",
				["Type"] = "hints.gameplay_usn01_hint",
				["Description"] = "usn01.hint_priority",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN01_Hint_Strafe"] = {
				["id"] = "USN01_Hint_Strafe",
				["Title"] = "usn01.hint_Strafe_title",
				["Type"] = "hints.gameplay_usn01_hint",
				["Description"] = "usn01.hint_strafe",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN01_Hint_Target"] = {
				["id"] = "USN01_Hint_Target",
				["Title"] = "usn01.hint_Target_title",
				["Type"] = "hints.gameplay_map_and_commands_hint",
				["Description"] = "usn01.hint_target",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_SETTARGET);luaSetNarrativeParam(IC_CMD_CLEARTARGET,2)",
			},
			["USN01_Hint_Aiming"] = {
				["id"] = "USN01_Hint_Aiming",
				["Title"] = "usn01.hint_Aiming_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "usn01.hint_aiming",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_FIRE)",
			},
			["USN01_Hint_Map"] = {
				["id"] = "USN01_Hint_Map",
				["Title"] = "usn01.hint_Map_title",
				["Type"] = "hints.gameplay_usn01_hint",
				["Description"] = "usn01.hint_map",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MAP_TOGGLE)",
			},
			["USN01_Hint_Turbo"] = {
				["id"] = "USN01_Hint_Turbo",
				["Title"] = "usn01.hint_Turbo_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "usn01.hint_turbo",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_TURBO)",
			},
			["USN01_Hint_Bomb"] = {
				["id"] = "USN01_Hint_Bomb",
				["Title"] = "usn01.hint_Bomb_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "usn01.hint_bomb",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_FIRE,2)",
			},
			["USN01_Hint_Torpedo"] = {
				["id"] = "USN01_Hint_Torpedo",
				["Title"] = "usn01.hint_Torpedo_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "usn01.hint_torpedo",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_FIRE,2)",
			},
			["USN01_Hint_Shoot_Please"] = {
				["id"] = "USN01_Hint_Shoot_Please",
				["Title"] = "usn01.hint_Shoot_Please_title",
				["Type"] = "hints.gameplay_usn01_hint",
				["Description"] = "usn01.hint_shoot_please",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 15,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			--USN02
			["USN02_Hint_Convoy"] = {
				["id"] = "USN02_Hint_Convoy",
				["Title"] = "usn02.hint_Convoy_title",
				["Type"] = "hints.gameplay_usn02_hint",
				["Description"] = "usn02.hint_convoy",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN02_Hint_Dodge"] = {
				["id"] = "USN02_Hint_Dodge",
				["Title"] = "usn02.hint_Dodge_title",
				["Type"] = "hints.gameplay_usn02_hint",
				["Description"] = "usn02.hint_dodge",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN02_Hint_Formation"] = {
				["id"] = "USN02_Hint_Formation",
				["Title"] = "usn02.hint_Formation_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "usn02.hint_formation",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_SETTARGET);luaSetNarrativeParam(IC_OVERLAY_BLUE,2)",
			},
			["USN02_Hint_Shipcontrol"] = {
				["id"] = "USN02_Hint_Shipcontrol",
				["Title"] = "usn02.hint_Shipcontrol_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "usn02.hint_shipcontrol",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SHIP_THRUST,nil,true);luaSetNarrativeParam(IC_SHIP_THRUST,2);luaSetNarrativeParam(IC_SHIP_STEER,3,true);luaSetNarrativeParam(IC_SHIP_STEER,4);luaSetNarrativeParam(IC_GUN_FIRE,5)",
			},
			["USN02_Hint_Switchunit"] = {
				["id"] = "USN02_Hint_Switchunit",
				["Title"] = "usn02.hint_Switchunit_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "usn02.hint_switchunit",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SEL_PREV_ITEM,nil);luaSetNarrativeParam(IC_SEL_NEXT_ITEM,2);luaSetNarrativeParam(IC_FORM_PREV,3);luaSetNarrativeParam(IC_FORM_NEXT,4)",
			},
			["USN02_Hint_Weapon"] = {
				["id"] = "USN02_Hint_Weapon",
				["Title"] = "usn02.hint_Weapon_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "usn02.hint_weapon",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_GUNC_CHANGE)",
			},
			["USN02_Hint_Shallow"] = {
				["id"] = "USN02_Hint_Shallow",
				["Title"] = "usn02.hint_Shallow_title",
				["Type"] = "hints.gameplay_usn02_hint",
				["Description"] = "usn02.hint_shallow",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN02_Hint_Newships"] = {
				["id"] = "USN02_Hint_Newships",
				["Title"] = "usn02.hint_Newships_title",
				["Type"] = "hints.gameplay_usn02_hint",
				["Description"] = "usn02.hint_newships",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 15,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN02_Hint_Ptboats"] = {
				["id"] = "USN02_Hint_Ptboats",
				["Title"] = "usn02.hint_Ptboats_title",
				["Type"] = "hints.gameplay_usn02_hint",
				["Description"] = "usn02.hint_ptboats",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 15,	-- secundum
				["duration"] = 16,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN03
			["USN03_Hint_Supportmanager"] = {
				["id"] = "USN03_Hint_Supportmanager",
				["Title"] = "usn03.hint_Supportmanager_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_supportmanager",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY)",
			},
			["USN03_Hint_Sendtorpedobombers"] = {
				["id"] = "USN03_Hint_Sendtorpedobombers",
				["Title"] = "usn03.hint_Sendtorpedobombers_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_sendtorpedobombers",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_LAND);luaSetNarrativeParam(IC_SM_CHANGE_WEAPON,2)",
			},
			["USN03_Hint_Sendgroups"] = {
				["id"] = "USN03_Hint_Sendgroups",
				["Title"] = "usn03.hint_Sendgroups_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_sendgroups",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MAP_TOGGLE)",
			},
			["USN03_Hint_Reinforce"] = {
				["id"] = "USN03_Hint_Reinforce",
				["Title"] = "usn03.hint_Reinforce_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_reinforce",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY)",
			},
			["USN03_Hint_Reload"] = {
				["id"] = "USN03_Hint_Reload",
				["Title"] = "usn03.hint_Reload_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "usn03.hint_reload",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN03_Hint_Screen"] = {
				["id"] = "USN03_Hint_Screen",
				["Title"] = "usn03.hint_Screen_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_screen",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN03_Hint_Battleship"] = {
				["id"] = "USN03_Hint_Battleship",
				["Title"] = "usn03.hint_Battleship_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_battleship",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN03_Hint_Hornet"] = {
				["id"] = "USN03_Hint_Hornet",
				["Title"] = "usn03.hint_Hornet_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_hornet",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN03_Hint_Hidden"] = {
				["id"] = "USN03_Hint_Hidden",
				["Title"] = "usn03.hint_Hidden_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_hidden",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN03_Hint_Defence"] = {
				["id"] = "USN03_Hint_Defence",
				["Title"] = "usn03.hint_Defence_title",
				["Type"] = "hints.gameplay_usn03_hint",
				["Description"] = "usn03.hint_defence",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			--USN04
			["USN04_Hint_AttackPTs"] = {
				["id"] = "USN04_Hint_AttackPTs",
				["Title"] = "usn04.hint_AttackPTs_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "usn04.hint_attackpts",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN04_Hint_DefendAirfield"] = {
				["id"] = "USN04_Hint_DefendAirfield",
				["Title"] = "usn04.hint_DefendAirfield_title",
				["Type"] = "hints.gameplay_usn04_hint",
				["Description"] = "usn04.hint_defendairfield",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN04_Hint_DefendTransport"] = {
				["id"] = "USN04_Hint_DefendTransport",
				["Title"] = "usn04.hint_DefendTransport_title",
				["Type"] = "hints.gameplay_usn04_hint",
				["Description"] = "usn04.hint_defendtransport",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN04_Hint_PTsAvailable"] = {
				["id"] = "USN04_Hint_PTsAvailable",
				["Title"] = "usn04.hint_PTsAvailable_title",
				["Type"] = "hints.gameplay_usn04_hint",
				["Description"] = "usn04.hint_ptsavailable",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY)",
			},
			["USN04_Hint_SupportPlanes"] = {
				["id"] = "USN04_Hint_SupportPlanes",
				["Title"] = "usn04.hint_SupportPlanes_title",
				["Type"] = "hints.gameplay_usn04_hint",
				["Description"] = "usn04.hint_supportplanes",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY)",
			},
			["USN04_Hint_Torpedo"] = {
				["id"] = "USN04_Hint_Torpedo",
				["Title"] = "usn04.hint_Torpedo_title",
				["Type"] = "hints.gameplay_usn04_hint",
				["Description"] = "usn04.hint_torpedo",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN04_Hint_TransportSpotted"] = {
				["id"] = "USN04_Hint_TransportSpotted",
				["Title"] = "usn04.hint_TransportSpotted_title",
				["Type"] = "hints.gameplay_usn04_hint",
				["Description"] = "usn04.hint_transportspotted",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN05
			["USN05_Hint_Outnumbered"] = {
				["id"] = "USN05_Hint_Outnumbered",
				["Title"] = "usn05.hint_Outnumbered_title",
				["Type"] = "hints.gameplay_usn05_hint",
				["Description"] = "usn05.hint_outnumbered",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN05_Hint_SanFrancisco_Warning"] = {
				["id"] = "USN05_Hint_SanFrancisco_Warning",
				["Title"] = "usn05.hint_SanFrancisco_title",
				["Type"] = "hints.gameplay_usn05_hint",
				["Description"] = "usn05.hint_sanfrancisco_warning",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_REPAIR)",
			},
			["USN05_Hint_HieiKill"] = {
				["id"] = "USN05_Hint_HieiKill",
				["Title"] = "usn05.hint_HieiKill_title",
				["Type"] = "hints.gameplay_usn05_hint",
				["Description"] = "usn05.hint_hieikill",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN05_Hint_FleetWarning"] = {
				["id"] = "USN05_Hint_FleetWarning",
				["Title"] = "usn05.hint_FleetWarning_title",
				["Type"] = "hints.gameplay_usn05_hint",
				["Description"] = "usn05.hint_fleetwarning",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN05_Hint_FlagshipEscaping"] = {
				["id"] = "USN05_Hint_FlagshipEscaping",
				["Title"] = "usn05.hint_FlagshipEscaping_title",
				["Type"] = "hints.gameplay_usn05_hint",
				["Description"] = "usn05.hint_flagshipescaping",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN05_Hint_Torpedo"] = {
				["id"] = "USN05_Hint_Torpedo",
				["Title"] = "usn05.hint_Torpedo_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "usn05.hint_torpedo",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN06
			["USN06_Hint_Sub"] = {
				["id"] = "USN06_Hint_Sub",
				["Title"] = "usn06.hint_Sub_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_sub",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Aim"] = {
				["id"] = "USN06_Hint_Aim",
				["Title"] = "usn06.hint_Aim_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_aim",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Torpedo"] = {
				["id"] = "USN06_Hint_Torpedo",
				["Title"] = "usn06.hint_Torpedo_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_torpedo",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Cargo"] = {
				["id"] = "USN06_Hint_Cargo",
				["Title"] = "usn06.hint_Cargo_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_cargo",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Escort"] = {
				["id"] = "USN06_Hint_Escort",
				["Title"] = "usn06.hint_Escort_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_escort",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Plane_Reinforcement"] = {
				["id"] = "USN06_Hint_Plane_Reinforcement",
				["Title"] = "usn06.hint_Plane_Reinforcement_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_plane_reinforcement",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_SubNoticed"] = {
				["id"] = "USN06_Hint_SubNoticed",
				["Title"] = "usn06.hint_SubNoticed_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_subnoticed",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_SubSpotted"] = {
				["id"] = "USN06_Hint_SubSpotted",
				["Title"] = "usn06.hint_SubSpotted_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_subspotted",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Sonar"] = {
				["id"] = "USN06_Hint_Sonar",
				["Title"] = "usn06.hint_Sonar_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_sonar",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Washington"] = {
				["id"] = "USN06_Hint_Washington",
				["Title"] = "usn06.hint_Washington_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_washington",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN06_Hint_Safezone"] = {
				["id"] = "USN06_Hint_Safezone",
				["Title"] = "usn06.hint_safezone_title",
				["Type"] = "hints.gameplay_usn06_hint",
				["Description"] = "usn06.hint_safezone",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MAP_TOGGLE)",
			},
			--USN07
			["USN07_Hint_Timeup"] = {
				["id"] = "USN07_Hint_Timeup",
				["Title"] = "usn07.hint_Timeup_title",
				["Type"] = "hints.gameplay_usn07_hint",
				["Description"] = "usn07.hint_timeup",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN07_Hint_Rocketsquad"] = {
				["id"] = "USN07_Hint_Rocketsquad",
				["Title"] = "usn07.hint_Rocketsquad_title",
				["Type"] = "hints.gameplay_usn07_hint",
				["Description"] = "usn07.hint_rocketsquad",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN07_Hint_Strafebunkers"] = {
				["id"] = "USN07_Hint_Strafebunkers",
				["Title"] = "usn07.hint_Strafebunkers_title",
				["Type"] = "hints.gameplay_usn07_hint",
				["Description"] = "usn07.hint_strafebunkers",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN07_Hint_Attackplanes"] = {
				["id"] = "USN07_Hint_Attackplanes",
				["Title"] = "usn07.hint_Attackplanes_title",
				["Type"] = "hints.gameplay_usn07_hint",
				["Description"] = "usn07.hint_attackplanes",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN07_Hint_Transports"] = {
				["id"] = "USN07_Hint_Transports",
				["Title"] = "usn07.hint_Transports_title",
				["Type"] = "hints.gameplay_usn07_hint",
				["Description"] = "usn07.hint_transports",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN08 - BATTLE OF PHILIPPINE SEA
			["USN08_Hint_CAP"] = {
				["id"] = "USN08_Hint_CAP",
				["Title"] = "usn08.hint_CAP_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_cap",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN08_Hint_ShootBombers"] = {
				["id"] = "USN08_Hint_ShootBombers",
				["Title"] = "usn08.hint_ShootBombers_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_shootbombers",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN08_Hint_Attackerplanes"] = {
				["id"] = "USN08_Hint_Attackerplanes",
				["Title"] = "usn08.hint_Attackerplanes_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_attackerplanes",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN08_Hint_Repair"] = {
				["id"] = "USN08_Hint_Repair",
				["Title"] = "usn08.hint_repair_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_repair",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN08_Hint_Sub_Joined"] = {
				["id"] = "USN08_Hint_Sub_Joined",
				["Title"] = "usn08.hint_sub_joined_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_sub_joined",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 18,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN08_Hint_Sub_Sneak"] = {
				["id"] = "USN08_Hint_Sub_Sneak",
				["Title"] = "usn08.hint_sub_sneak_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_sub_sneak",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN08_Hint_Sub_Dive"] = {
				["id"] = "USN08_Hint_Sub_Dive",
				["Title"] = "usn08.hint_sub_dive_title",
				["Type"] = "hints.gameplay_usn08_hint",
				["Description"] = "usn08.hint_sub_dive",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN09 - LEYTE
			["USN09_Hint_Control"] = {
				["id"] = "USN09_Hint_Control",
				["Title"] = "usn09.hint_control_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_control",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 10,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN09_Hint_Kamikaze"] = {
				["id"] = "USN09_Hint_Kamikaze",
				["Title"] = "usn09.hint_kamikaze_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_kamikaze",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN09_Hint_AA"] = {
				["id"] = "USN09_Hint_AA",
				["Title"] = "usn09.hint_aa_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_aa",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN09_Hint_StrafePTs"] = {
				["id"] = "USN09_Hint_StrafePTs",
				["Title"] = "usn09.hint_strafepts_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_strafepts",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN09_Hint_Rocket"] = {
				["id"] = "USN09_Hint_Rocket",
				["Title"] = "usn09.hint_rocket_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_rocket",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},

			["USN09_Hint_Avenger"] = {
				["id"] = "USN09_Hint_Avenger",
				["Title"] = "usn09.hint_avenger_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_avenger",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN09_Hint_MusashiNear"] = {
				["id"] = "USN09_Hint_MusashiNear",
				["Title"] = "usn09.hint_musashinear_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_musashinear",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN09_Hint_Map"] = {
				["id"] = "USN09_Hint_Map",
				["Title"] = "usn09.hint_map_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_map",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 10,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_MAP_TOGGLE)",
			},
			["USN09_Hint_Switch_Unit"] = {
				["id"] = "USN09_Hint_Switch_Unit",
				["Title"] = "usn09.hint_switch_unit_title",
				["Type"] = "hints.gameplay_usn09_hint",
				["Description"] = "usn09.hint_switch_unit",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_SEL_PREV_ITEM);luaSetNarrativeParam(IC_SEL_NEXT_ITEM,2)",
			},
			--USN10 - CAPE ENGANO TEST HINTS
			["USN10_Hint_Enterprise"] = {
				["id"] = "USN10_Hint_Enterprise",
				["Title"] = "usn10.hint_enterprise_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_enterprise",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Minefield"] = {
				["id"] = "USN10_Hint_Minefield",
				["Title"] = "usn10.hint_minefield_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_minefield",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Kamikaze"] = {
				["id"] = "USN10_Hint_Kamikaze",
				["Title"] = "usn10.hint_kamikaze_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_kamikaze",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Support_1"] = {
				["id"] = "USN10_Hint_Support_1",
				["Title"] = "usn10.hint_support_1_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_support_1",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Support_2"] = {
				["id"] = "USN10_Hint_Support_2",
				["Title"] = "usn10.hint_support_2_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_support_2",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Cruisers"] = {
				["id"] = "USN10_Hint_Cruisers",
				["Title"] = "usn10.hint_cruisers_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_cruisers",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Torpedo_1"] = {
				["id"] = "USN10_Hint_Torpedo_1",
				["Title"] = "usn10.hint_torpedo_1_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_torpedo_1",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Torpedo_2"] = {
				["id"] = "USN10_Hint_Torpedo_2",
				["Title"] = "usn10.hint_torpedo_2_title",
				["Type"] = "hints.gameplay_usn10_hint",
				["Description"] = "usn10.hint_torpedo_2",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN10_Hint_Carriers"] = {
				["id"] = "USN10_Hint_Carriers",
				["Title"] = "usn10.hint_carriers_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "usn10.hint_carriers",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN11
			["USN11_Hint_1streload"] = {
				["id"] = "USN11_Hint_1streload",
				["Title"] = "usn11.hint_1streload_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_1streload",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_AttackWithPete"] = {
				["id"] = "USN11_Hint_AttackWithPete",
				["Title"] = "usn11.hint_attackwithpete_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_attackwithpete",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_Buildings"] = {
				["id"] = "USN11_Hint_Buildings",
				["Title"] = "usn11.hint_buildings_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_buildings",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_ControlPete"] = {
				["id"] = "USN11_Hint_ControlPete",
				["Title"] = "usn11.hint_controlpete_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_controlpete",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_Morereload"] = {
				["id"] = "USN11_Hint_Morereload",
				["Title"] = "usn11.hint_morereload_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_morereload",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_PThangars"] = {
				["id"] = "USN11_Hint_PThangars",
				["Title"] = "usn11.hint_pthangars_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_pthangars",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_Subcontrol"] = {
				["id"] = "USN11_Hint_Subcontrol",
				["Title"] = "usn11.hint_subcontrol_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_subcontrol",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN11_Hint_Subdepth"] = {
				["id"] = "USN11_Hint_Subdepth",
				["Title"] = "usn11.hint_subdepth_title",
				["Type"] = "hints.gameplay_usn11_hint",
				["Description"] = "usn11.hint_Subdepth",
				["critical"] = false,
				["storingrule"] = "cooldown",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 180,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN12
			["USN12_Hint_saverockets"] = {
				["id"] = "USN12_Hint_saverockets",
				["Title"] = "usn12.hint_saverockets_title",
				["Type"] = "hints.gameplay_usn12_hint",
				["Description"] = "usn12.hint_saverockets",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN12_Hint_outpost"] = {
				["id"] = "USN12_Hint_outpost",
				["Title"] = "usn12.hint_outpost_title",
				["Type"] = "hints.gameplay_usn12_hint",
				["Description"] = "usn12.hint_outpost",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN12_Hint_planelimit"] = {
				["id"] = "USN12_Hint_planelimit",
				["Title"] = "usn12.hint_planelimit_title",
				["Type"] = "hints.gameplay_usn12_hint",
				["Description"] = "usn12.hint_planelimit",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN12_Hint_trainengine"] = {
				["id"] = "USN12_Hint_trainengine",
				["Title"] = "usn12.hint_trainengine_title",
				["Type"] = "hints.gameplay_usn12_hint",
				["Description"] = "usn12.hint_trainengine",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN12_Hint_refinery"] = {
				["id"] = "USN12_Hint_refinery",
				["Title"] = "usn12.hint_refinery_title",
				["Type"] = "hints.gameplay_usn12_hint",
				["Description"] = "usn12.hint_refinery",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN12_Hint_raiden"] = {
				["id"] = "USN12_Hint_raiden",
				["Title"] = "usn12.hint_raiden_title",
				["Type"] = "hints.gameplay_usn12_hint",
				["Description"] = "usn12.hint_raiden",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 60,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN13
			["USN13_Hint_AA"] = {
				["id"] = "USN13_Hint_AA",
				["Title"] = "usn13.hint_aa_title",
				["Type"] = "hints.gameplay_usn13_hint",
				["Description"] = "usn13.hint_aa",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN13_Hint_Planes"] = {
				["id"] = "USN13_Hint_Planes",
				["Title"] = "usn13.hint_planes_title",
				["Type"] = "hints.gameplay_usn13_hint",
				["Description"] = "usn13.hint_planes",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			--USN14
			["USN14_Hint_Hangars"] = {
				["id"] = "USN14_Hint_Hangars",
				["Title"] = "usn14.hint_hangars_title",
				["Type"] = "hints.gameplay_usn14_hint",
				["Description"] = "usn14.hint_hangars",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN14_Hint_Kamikaze"] = {
				["id"] = "USN14_Hint_Kamikaze",
				["Title"] = "usn14.hint_kamikaze_title",
				["Type"] = "hints.gameplay_usn14_hint",
				["Description"] = "usn14.hint_kamikaze",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN14_Hint_Reinforcement"] = {
				["id"] = "USN14_Hint_Reinforcement",
				["Title"] = "usn14.hint_reinforcement_title",
				["Type"] = "hints.gameplay_usn14_hint",
				["Description"] = "usn14.hint_reinforcement",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN14_Hint_Together"] = {
				["id"] = "USN14_Hint_Together",
				["Title"] = "usn14.hint_together_title",
				["Type"] = "hints.gameplay_usn14_hint",
				["Description"] = "usn14.hint_together",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["USN14_Hint_Transports"] = {
				["id"] = "USN14_Hint_Transports",
				["Title"] = "usn14.hint_transports_title",
				["Type"] = "hints.gameplay_usn14_hint",
				["Description"] = "usn14.hint_transports",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["missionspecific"] = true,
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["Training Ground 01 - IJN AIR"] = {
				["id"] = "ijnair_01",
				["Title"] = "trn1.hint_welcometitle",
				["Type"] = "hints.gameplay_trn01_hint",
				["Description"] = "trn1.hint_welcome",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},
			["Training Ground 01 - IJN AIR EVENT 01"] = {
				["id"] = "ijnair_event01hint01",
				["Title"] = "trn1.hint_event01hint01title",
				["Type"] = "hints.gameplay_trn01_hint",
				["Description"] = "trn1.hint_event01hint01",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},
			["Training Ground 02 - IJN SEA"] = {
				["id"] = "ijnsea_01",
				["Title"] = "trn2.hint_welcometitle",
				["Type"] = "hints.gameplay_trn02_hint",
				["Description"] = "trn2.hint_welcome",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},
			["Training Ground 02 - IJN SEA EVENT 01"] = {
				["id"] = "ijnsea_event01hint01",
				["Title"] = "trn2.hint_event01hint01title",
				["Type"] = "hints.gameplay_trn02_hint",
				["Description"] = "trn2.hint_event01hint01",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},
			["Training Ground 03 - USN AIR"] = {
				["id"] = "usnair_01",
				["Title"] = "trn3.hint_welcometitle",
				["Type"] = "hints.gameplay_trn03_hint",
				["Description"] = "trn3.hint_welcome",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},
			["Training Ground 03 - USN AIR EVENT 01"] = {
				["id"] = "usnair_event01hint01",
				["Title"] = "trn3.hint_event01hint01title",
				["Type"] = "hints.gameplay_trn03_hint",
				["Description"] = "trn3.hint_event01hint01",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["duration"] = -1,
			},
			["Training Ground 04 - USN SEA 01"] = {
				["id"] = "usnsea_01",
				["Title"] = "trn4.hint_welcometitle",
				["Type"] = "hints.gameplay_trn04_hint",
				["Description"] = "trn4.hint_welcome",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},
			["Training Ground 04 - IJN SEA EVENT 01"] = {
				["id"] = "usnsea_event01hint01",
				["Title"] = "trn4.hint_event01hint01title",
				["Type"] = "hints.gameplay_trn04_hint",
				["Description"] = "trn4.hint_event01hint01",
				["critical"] = true,
				["storingrule"] = "missionunique",
				["cooldowntime"] = 10,	-- secundum
				["duration"] = -1,
			},

			--------------------------------------------------------------------------------------------------------------
			--------------------------------------------Advanced features-------------------------------------------------
			--------------------------------------------------------------------------------------------------------------

			["Advanced_Hint_Cameralock"] = {
				["id"] = "Advanced_Hint_Cameralock",
				["Title"] = "hints.gameplay_hint_advanced_cameralock_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_advanced_cameralock",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_LOOKMODE)",
			},
			["Advanced_Hint_Bombcamera"] = {
				["id"] = "Advanced_Hint_Bombcamera",
				["Title"] = "hints.gameplay_hint_advanced_bombcamera_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_advanced_bombcamera",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_FIRE)",
			},
			["Advanced_Hint_Hinthistory"] = {
				["id"] = "Advanced_Hint_Hinthistory",
				["Title"] = "hints.gameplay_hint_advanced_hinthistory_title",
				["Type"] = "hints.gameplay_general_hint",
				["Description"] = "hints.gameplay_hint_advanced_hinthistory",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_PAUSE)",
			},
			["Advanced_Hint_Jumptounit"] = {
				["id"] = "Advanced_Hint_Jumptounit",
				["Title"] = "hints.gameplay_hint_advanced_jumptounit_title",
				["Type"] = "hints.gameplay_general_hint",
				["Description"] = "hints.gameplay_hint_advanced_jumptounit",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_JUMPIN)",
			},
			["Advanced_Hint_Crosshair"] = {
				["id"] = "Advanced_Hint_Crosshair",
				["Title"] = "hints.gameplay_hint_advanced_crosshair_title",
				["Type"] = "hints.unit_ship_hint",
				["Description"] = "hints.gameplay_hint_advanced_crosshair",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["Advanced_Hint_Turn"] = {
				["id"] = "Advanced_Hint_Turn",
				["Title"] = "hints.gameplay_hint_advanced_turn_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_advanced_turn",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["Advanced_Hint_Sonar"] = {
				["id"] = "Advanced_Hint_Sonar",
				["Title"] = "hints.gameplay_hint_advanced_sonar_title",
				["Type"] = "hints.unit_sub_hint",
				["Description"] = "hints.gameplay_hint_advanced_sonar",
				["critical"] = false,
				["storingrule"] = "repeatable",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 30,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["Advanced_Hint_Stall"] = {
				["id"] = "Advanced_Hint_Stall",
				["Title"] = "hints.gameplay_hint_advanced_stall_title",
				["Type"] = "hints.unit_plane_hint",
				["Description"] = "hints.gameplay_hint_advanced_stall",
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 0,	-- secundum
				["duration"] = -1,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_TURBO)",
			},

			--------------------------------------------------------------------------------------------------------------
			------------------------------------------------Unit test-----------------------------------------------------
			--------------------------------------------------------------------------------------------------------------

			["Unittest - Respawn.lua teszt hint"] = {
				["id"] = "unittest_01",
				["Title"] = "Welcome to the Unit Test Scene!",
				["Type"] = "",
				["Description"] = "In this this mission, you can test your unit. If the unit is lost, it's respawned instantly.",
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 10,	-- secundum
				["duration"] = 15,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["Unittest - Respawn.lua kerek hint"] = {
				["id"] = "unittest_02",
				["Title"] = "Landing Gear",
				["Type"] = "",
				["Description"] = "You can test your plane's landing gear by pressing the left bumper.",
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 10,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		},
		["Multi"] = {
			["Multihint1"] = {
				["id"] = "Hint_6",
				["Title"] = "Hint1_Title_lockitid",
				["Type"] = "",
				["Description"] = "Hint1_Desc_lockitid",
				---- if Title and Description is empty ----
				["AlliedTitle"] = "",
				["AlliedDescription"] = "",
				["JapaneseTitle"] = "",
				["JapaneseDescription"] = "",
				---- if AlliedTitle and AlliedDescription is empty ----
				["TitleDescList"] = {
					["Player1"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player2"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player3"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player4"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player5"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player6"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player7"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
					["Player8"] = {
						["Title"] = "Hint1_Title_lockitid",
						["Description"] = "Hint1_Desc_lockitid",
					},
				},
				["critical"] = false,
				["storingrule"] = "unique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 12,
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
-----------------------
-- Multiplayer Hintek--
-----------------------
			["MP_Hint_Escort01_Japanese"] = {
				["id"] = "ID_Hint_Escort01",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp01.hint_escort_desc_us";
				["JapaneseTitle"] = "mp01.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp01.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort02"] = {
				["id"] = "ID_Hint_Escort02",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp02.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp02.hint_escort_desc_us";
				["JapaneseTitle"] = "mp02.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp02.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort03"] = {
				["id"] = "ID_Hint_Escort03",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp03.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp03.hint_escort_desc_us";
				["JapaneseTitle"] = "mp03.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp03.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort04"] = {
				["id"] = "ID_Hint_Escort04",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp04.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp04.hint_escort_desc_us";
				["JapaneseTitle"] = "mp04.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp04.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort05"] = {
				["id"] = "ID_Hint_Escort05",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp05.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp05.hint_escort_desc_us";
				["JapaneseTitle"] = "mp05.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp05.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort06"] = {
				["id"] = "ID_Hint_Escort06",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp06.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp06.hint_escort_desc_us";
				["JapaneseTitle"] = "mp06.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp06.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort07"] = {
				["id"] = "ID_Hint_Escort07",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp07.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp07.hint_escort_desc_us";
				["JapaneseTitle"] = "mp07.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp07.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
			["MP_Hint_Escort08"] = {
				["id"] = "ID_Hint_Escort08",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_escort_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp08.hint_escort_desc_us_title";
				["AlliedDescription"] = "mp08.hint_escort_desc_us";
				["JapaneseTitle"] = "mp08.hint_escort_desc_jap_title";
				["JapaneseDescription"] = "mp08.hint_escort_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege01"] = {
				["id"] = "ID_Hint_Siege01",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp01.hint_siege_desc_us";
				["JapaneseTitle"] = "mp01.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp01.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege01_LST"] = {
				["id"] = "ID_Hint_Siege01_LST",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_lst_title";
				["AlliedDescription"] = "mp01.hint_siege_lst_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_TR"] = {
				["id"] = "ID_Hint_Siege01_TR",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_transport_title";
				["AlliedDescription"] = "mp01.hint_siege_transport_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_LCVP"] = {
				["id"] = "ID_Hint_Siege01_LCVP",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Title"] = "",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_daihatsu_title";
				["AlliedDescription"] = "mp01.hint_siege_daihatsu_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_OP"] = {
				["id"] = "ID_Hint_Siege01_OP",
				["Title"] = "mp01.hint_siege_player_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp01.hint_siege_player_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_PT"] = {
				["id"] = "ID_Hint_Siege01_PT",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "mp01.hint_siege_pt_title";
				["JapaneseDescription"] = "mp01.hint_siege_pt_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_Fort"] = {
				["id"] = "ID_Hint_Siege01_Fort",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "mp01.hint_siege_fort_title";
				["JapaneseDescription"] = "mp01.hint_siege_fort_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_LB"] = {
				["id"] = "ID_Hint_Siege01_LB",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "mp01.hint_siege_landbattery_title";
				["JapaneseDescription"] = "mp01.hint_siege_landbattery_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_HQ"] = {
				["id"] = "ID_Hint_Siege01_HQ",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "mp01.hint_siege_hq_title";
				["JapaneseDescription"] = "mp01.hint_siege_hq_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege01_PK"] = {
				["id"] = "ID_Hint_Siege01_PK",
				["Title"] = "mp01.hint_siege_playerkill_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp01.hint_siege_playerkill_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege02"] = {
				["id"] = "ID_Hint_Siege02",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp02.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp02.hint_siege_desc_us";
				["JapaneseTitle"] = "mp02.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp02.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege02_LB"] = {
				["id"] = "ID_Hint_Siege02_LB",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_landbattery_title";
				["AlliedDescription"] = "mp01.hint_siege_landbattery_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege02_HQ"] = {
				["id"] = "ID_Hint_Siege02_HQ",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_hq_title";
				["AlliedDescription"] = "mp01.hint_siege_hq_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege02_ships"] = {
				["id"] = "ID_Hint_Siege02_ships",
				["Title"] = "mp02.hint_siege_ships_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp02.hint_siege_ships_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege03"] = {
				["id"] = "ID_Hint_Siege03",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp03.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp03.hint_siege_desc_us";
				["JapaneseTitle"] = "mp03.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp03.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege03_LST"] = {
				["id"] = "ID_Hint_Siege03_LST",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "mp01.hint_siege_lst_title";
				["JapaneseDescription"] = "mp01.hint_siege_lst_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege03_islands"] = {
				["id"] = "ID_Hint_Siege03_islands",
				["Title"] = "mp03.hint_siege_islands_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp03.hint_siege_islands_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege03_DP"] = {
				["id"] = "ID_Hint_Siege03_DP",
				["Title"] = "mp03.hint_siege_DP_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp03.hint_siege_DP_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege04"] = {
				["id"] = "ID_Hint_Siege04",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp04.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp04.hint_siege_desc_us";
				["JapaneseTitle"] = "mp04.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp04.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege04_betty"] = {
				["id"] = "ID_Hint_Siege04_betty",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp04.hint_siege_betty_title";
				["AlliedDescription"] = "mp04.hint_siege_betty_us_desc";
				["JapaneseTitle"] = "mp04.hint_siege_betty_title";
				["JapaneseDescription"] = "mp04.hint_siege_betty_jap_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege05"] = {
				["id"] = "ID_Hint_Siege05",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp05.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp05.hint_siege_desc_us";
				["JapaneseTitle"] = "mp05.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp05.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege05_carriers"] = {
				["id"] = "ID_Hint_Siege05_carriers",
				["Title"] = "mp05.hint_siege_carriers_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp05.hint_siege_carriers_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege05_Fort"] = {
				["id"] = "ID_Hint_Siege05_Fort",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp05.hint_siege_fort_title";
				["AlliedDescription"] = "mp05.hint_siege_fort_us_desc";
				["JapaneseTitle"] = "mp05.hint_siege_fort_title";
				["JapaneseDescription"] = "mp05.hint_siege_fort_jap_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege05_bombers"] = {
				["id"] = "ID_Hint_Siege05_bombers",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "mp05.hint_siege_bomber_title";
				["JapaneseDescription"] = "mp05.hint_siege_bomber_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege06"] = {
				["id"] = "ID_Hint_Siege06",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp06.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp06.hint_siege_desc_us";
				["JapaneseTitle"] = "mp06.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp06.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege06_Fort"] = {
				["id"] = "ID_Hint_Siege06_Fort",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp05.hint_siege_fort_title";
				["AlliedDescription"] = "mp05.hint_siege_fort_jap_desc";
				["JapaneseTitle"] = "mp05.hint_siege_fort_title";
				["JapaneseDescription"] = "mp05.hint_siege_fort_us_desc";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege07"] = {
				["id"] = "ID_Hint_Siege07",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp07.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp07.hint_siege_desc_us";
				["JapaneseTitle"] = "mp07.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp07.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege07_Fort"] = {
				["id"] = "ID_Hint_Siege07_Fort",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_fort_title";
				["AlliedDescription"] = "mp01.hint_siege_fort_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege07_PT"] = {
				["id"] = "ID_Hint_Siege07_PT",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp01.hint_siege_pt_title";
				["AlliedDescription"] = "mp01.hint_siege_pt_desc";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege08"] = {
				["id"] = "ID_Hint_Siege08",
				["Title"] = "",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "mp08.hint_siege_desc_us_title";
				["AlliedDescription"] = "mp08.hint_siege_desc_us";
				["JapaneseTitle"] = "mp08.hint_siege_desc_jap_title";
				["JapaneseDescription"] = "mp08.hint_siege_desc_jap";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Siege08_ships"] = {
				["id"] = "ID_Hint_Siege08_ships",
				["Title"] = "mp08.hint_siege_ships_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp08.hint_siege_ships_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege08_torpedo"] = {
				["id"] = "ID_Hint_Siege08_torpedo",
				["Title"] = "mp08.hint_siege_torpedo_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp08.hint_siege_torpedo_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege08_critical"] = {
				["id"] = "ID_Hint_Siege08_critical",
				["Title"] = "mp08.hint_siege_critical_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp08.hint_siege_critical_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Siege08_BB"] = {
				["id"] = "ID_Hint_Siege08_BB",
				["Title"] = "mp08.hint_siege_BB_title",
				["Type"] = "hints.gameplay_multi_siege_hint",
				["Description"] = "mp08.hint_siege_BB_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive01"] = {
				["id"] = "ID_Hint_Competitive01",
				["Title"] = "mp01.hint_comp_desc_jap_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp01.hint_comp_desc_jap", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive01_Bonus"] = {
				["id"] = "ID_Hint_Competitive01_Bonus",
				["Title"] = "mp01.hint_comp_bonus_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp01.hint_comp_bonus_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive01_Spawn"] = {
				["id"] = "ID_Hint_Competitive01_Spawn",
				["Title"] = "mp01.hint_comp_fleet_spawn_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp01.hint_comp_fleet_spawn_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive01_HQ"] = {
				["id"] = "ID_Hint_Competitive01_HQ",
				["Title"] = "mp01.hint_comp_hq_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp01.hint_comp_hq_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02"] = {
				["id"] = "ID_Hint_Competitive02",
				["Title"] = "mp02.hint_comp_desc_us_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_desc_us", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive02_Bonus"] = {
				["id"] = "ID_Hint_Competitive02_Bonus",
				["Title"] = "mp02.hint_comp_bonus_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_bonus_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02_Fleet"] = {
				["id"] = "ID_Hint_Competitive02_Fleet",
				["Title"] = "mp02.hint_comp_fleet_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_fleet_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02_HQ"] = {
				["id"] = "ID_Hint_Competitive02_HQ",
				["Title"] = "mp02.hint_comp_hq_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_hq_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02_Ohka"] = {
				["id"] = "ID_Hint_Competitive02_Ohka",
				["Title"] = "mp02.hint_comp_ohka_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_ohka_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02_Boat"] = {
				["id"] = "ID_Hint_Competitive02_Boat",
				["Title"] = "mp02.hint_comp_boat_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_boat_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02_Sub"] = {
				["id"] = "ID_Hint_Competitive02_Sub",
				["Title"] = "mp02.hint_comp_sub_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_sub_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive02_Points"] = {
				["id"] = "ID_Hint_Competitive02_Points",
				["Title"] = "mp02.hint_comp_points_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp02.hint_comp_points_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive03"] = {
				["id"] = "ID_Hint_Competitive03",
				["Title"] = "mp03.hint_comp_desc_jap_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp03.hint_comp_desc_jap", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive03_SB_spawn"] = {
				["id"] = "ID_Hint_Competitive03_SB_spawn",
				["Title"] = "mp03.hint_comp_SB_spawn_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp03.hint_comp_SB_spawn_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive03_SB"] = {
				["id"] = "ID_Hint_Competitive03_SB",
				["Title"] = "mp03.hint_comp_SB_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp03.hint_comp_SB_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive04"] = {
				["id"] = "ID_Hint_Competitive04",
				["Title"] = "mp04.hint_comp_desc_jap_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp04.hint_comp_desc_us", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive04_divide"] = {
				["id"] = "ID_Hint_Competitive04_divide",
				["Title"] = "mp04.hint_comp_divide_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp04.hint_comp_divide_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive04_targets"] = {
				["id"] = "ID_Hint_Competitive04_targets",
				["Title"] = "mp04.hint_comp_targets_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp04.hint_comp_targets_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive04_units"] = {
				["id"] = "ID_Hint_Competitive04_units",
				["Title"] = "mp04.hint_comp_units_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp04.hint_comp_units_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive05"] = {
				["id"] = "ID_Hint_Competitive05",
				["Title"] = "mp05.hint_comp_desc_jap_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp05.hint_comp_desc_us", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive05_rockets"] = {
				["id"] = "ID_Hint_Competitive05_rockets",
				["Title"] = "mp05.hint_comp_rockets_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp05.hint_comp_rockets_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive05_TB"] = {
				["id"] = "ID_Hint_Competitive05_TB",
				["Title"] = "mp05.hint_comp_TB_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp05.hint_comp_TB_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive05_enemy_planes"] = {
				["id"] = "ID_Hint_Competitive05_enemy_planes",
				["Title"] = "mp05.hint_comp_enemy_planes_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp05.hint_comp_enemy_planes_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive06"] = {
				["id"] = "ID_Hint_Competitive06",
				["Title"] = "mp06.hint_comp_desc_us_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp06.hint_comp_desc_us", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive06_level"] = {
				["id"] = "ID_Hint_Competitive06_level",
				["Title"] = "mp06.hint_comp_level_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp06.hint_comp_level_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive06_supply"] = {
				["id"] = "ID_Hint_Competitive06_supply",
				["Title"] = "mp06.hint_comp_supply_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp06.hint_comp_supply_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive07"] = {
				["id"] = "ID_Hint_Competitive07",
				["Title"] = "mp07.hint_comp_desc_jap_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp07.hint_comp_desc_jap", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive08"] = {
				["id"] = "ID_Hint_Competitive08",
				["Title"] = "mp08.hint_comp_desc_jap_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp08.hint_comp_desc_us", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Competitive08_dive"] = {
				["id"] = "ID_Hint_Competitive08_dive",
				["Title"] = "mp08.hint_comp_dive_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp08.hint_comp_dive_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Competitive08_destroyer"] = {
				["id"] = "ID_Hint_Competitive08_destroyer",
				["Title"] = "mp08.hint_comp_destroyer_title",
				["Type"] = "hints.gameplay_multi_comp_hint",
				["Description"] = "mp08.hint_comp_destroyer_desc", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = false,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = -1;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
				["missionspecific"] = true,
			},
		["MP_Hint_Duel_01"] = {
				["id"] = "ID_Hint_Duel01",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_02"] = {
				["id"] = "ID_Hint_Duel02",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_03"] = {
				["id"] = "ID_Hint_Duel03",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_04"] = {
				["id"] = "ID_Hint_Duel04",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_05"] = {
				["id"] = "ID_Hint_Duel05",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_06"] = {
				["id"] = "ID_Hint_Duel06",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_07"] = {
				["id"] = "ID_Hint_Duel07",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_Duel_08"] = {
				["id"] = "ID_Hint_Duel08",
				["Title"] = "mp.hint_duel_title",
				["Type"] = "hints.gameplay_multi_duel_hint",
				["Description"] = "mp.hint_duel_desc",	-- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture01"] = {
				["id"] = "ID_Hint_IslandCapture01",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture02"] = {
				["id"] = "ID_Hint_IslandCapture02",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture03"] = {
				["id"] = "ID_Hint_IslandCapture03",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture04"] = {
				["id"] = "ID_Hint_IslandCapture04",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture05"] = {
				["id"] = "ID_Hint_IslandCapture05",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture06"] = {
				["id"] = "ID_Hint_IslandCapture06",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture07"] = {
				["id"] = "ID_Hint_IslandCapture07",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		["MP_Hint_IslandCapture08"] = {
				["id"] = "ID_Hint_IslandCapture08",
				["Title"] = "mp.hint_ic_title",
				["Type"] = "hints.gameplay_multi_ic_hint",
				["Description"] = "mp.obj_ic_pri", -- Hint szovege !!!
				---- if Title and Description is empty ----
				["AlliedTitle"] = "";
				["AlliedDescription"] = "";
				["JapaneseTitle"] = "";
				["JapaneseDescription"] = "";
				---- if AlliedTitle and AlliedDescription is empty ----
				["critical"] = true,
				["storingrule"] = "missionunique",
				-- unique: 		only once in a player's life
				-- missionunique: 	only once per a mission
				-- repeatable:		every time an event ocures
				-- cooldown:		can reocure after defined time
				["cooldowntime"] = 12,	-- secundum
				["duration"] = 0;
				-- 12:			after 12 sec the hint will autodisappear
				-- 0:			won't autodisppear
				-- -1:			code will count the disappear-time
			},
		},
	},
}
