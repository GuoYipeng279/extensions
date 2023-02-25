-- credits table

CIT_CATEGORY = 0
CIT_PERSON   = 1         -- this is the default value, not mandatory
CIT_IMAGE    = 2
CIT_SPACE    = 3         -- some space
CIT_MOVEY    = 4         -- move y once
CIT_OFFSETX  = 5         -- set default x offset
CIT_BACK     = 6         -- for images

CA_LEFT     = 0          -- this is the default value, not mandatory
CA_RIGHT    = 1
CA_CENTER   = 2

DEF_X_OFS = 0.08

-- item property examples
-- ----------------------
--  ["Type"]   = CIT_CATEGORY,                      -- default is CIT_PERSON
--  ["Text"]   = "FE.credits.programming",
--  ["Color"]  = { 1,0.5,0.5,1 },                   -- default is white
--  ["Offset"] = -0.1
--  ["Align"]  = CA_CENTER                          -- default is CA_LEFT

Credits=
{
	["Speed"]    = 0.05,         -- global scroll speed
	["StartY"]   = 0.8,          -- text start y
	["RowSpace"] = 0.01,         -- row space
	["Credits_Items"]=
	{
		{
			["Type"] = CIT_OFFSETX,
		 	["Offset"] = DEF_X_OFS,
		},		

		{
		  ["Type"]  = CIT_IMAGE,
		  ["Text"]  = "bsplogo",
		  ["Align"]  = CA_CENTER,
		},			
		{ ["Type"] = CIT_SPACE, },

--		{
--		  ["Type"]   = CIT_CATEGORY,
--		  ["Text"]   = "platform: "..Platform("PC","XBOX"),
--		},			
--		{
--		  ["Type"]   = CIT_CATEGORY,
--		  ["Text"]   = "region: "..REGION,
--		},			
--		{ ["Type"] = CIT_SPACE, },

-- ESH
		---- CPC v2.0 Start ----

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "Battlestations: Pacific Remastered Mod",
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},
		
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },	
		
		{ ["Type"] = CIT_SPACE, },	
		
		{ ["Text"] = "NOTE:", }, 
		{ ["Text"] = "ALL new ship and aircraft models you see in this mod", }, 
		{ ["Text"] = "were downloaded from www.gamemodels3d.com, and are originally from", }, 
		{ ["Text"] = "Wargaming's ''World of Warships'' and Gaijin's ''War Thunder'' respectively.", }, 
		{ ["Text"] = "If you wish to experience these models in their full glory,", }, 
		{ ["Text"] = "go to www.worldofwarships.com and www.warthunder.com respectivelly.", }, 
		
		{ ["Type"] = CIT_SPACE, },		
		
		{ ["Text"] = "The main purpose of this mod project was to provide", }, 
		{ ["Text"] = "a free and better alternative to any paid imported models out there,", }, 
		{ ["Text"] = "such as the ones from DGDXGDG and SurgeonSasha.", }, 
		{ ["Text"] = "We claim no ownership to any new models present in the game,", }, 
		{ ["Text"] = "since they were imported purely for fun reasons. We simply wanted to", }, 
		{ ["Text"] = "make a fun naval game that people will enjoy.", }, 
		
		{ ["Type"] = CIT_SPACE, },	
		
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "Special thanks to",
		},
		
		{ ["Type"] = CIT_SPACE, },
		
		{ ["Text"] = "All the ex-Eidos developers who provided us with the knowledge", }, 
		{ ["Text"] = "''Jack Martison'' for the ''Epic Thunder'' sound mod for War Thunder", }, 
		{ ["Text"] = "''GlitchyScripts'' for making the Halo ''XLiveLessNess'' plugin", }, 
		{ ["Text"] = "Marc Mons for allowing us to use their ''Acatraz'' island model", }, 
		{ ["Text"] = "''Master Modeler'' from gamemodels3d.com", }, 
		{ ["Text"] = "''netsec_planes'' for taking a major role in development of AlterBSP", }, 
		{ ["Text"] = "The BSmodHQ Team", }, 
		{ ["Text"] = "The original Midway Modders", }, 
		
		{ ["Type"] = CIT_SPACE, },	
		
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "Developed by Team Wolfpack",
		},
		
		{ ["Type"] = CIT_SPACE, },
		
		{ ["Text"] = "Admiral Jmman", }, 
		{ ["Text"] = "Agglo", }, 
		{ ["Text"] = "Ahasi", }, 
		{ ["Text"] = "Arisaka", }, 
		{ ["Text"] = "Axis_Crusher", }, 
		{ ["Text"] = "Battleship 61", }, 
		{ ["Text"] = "BOATFUCKER", }, 
		{ ["Text"] = "Breeze", }, 
		{ ["Text"] = "Carson Swain", },
		{ ["Text"] = "CodePhantom", },
		{ ["Text"] = "Cycorix", }, 
		{ ["Text"] = "DefunctWalnut", },
		{ ["Text"] = "Dein les Ailes Noires", },
		{ ["Text"] = "Delta", },
		{ ["Text"] = "EliteFuller", },
		{ ["Text"] = "Ferettodesu", },
		{ ["Text"] = "bolo6", },
		{ ["Text"] = "Haruna Line Poi", },
		{ ["Text"] = "HeatProofTex", },
		{ ["Text"] = "[BBDR] Herr Atomik", },
		{ ["Text"] = "HRVSoldier", },
		{ ["Text"] = "Impulse, aka Darkpilot", },
		{ ["Text"] = "leran_per", },
		{ ["Text"] = "Megalodontux", },
		{ ["Text"] = "Microscopics-Unlimited", },
		{ ["Text"] = "netsec_planes", },
		{ ["Text"] = "! NT !", },
		{ ["Text"] = "Polsotni pyatyy", },
		{ ["Text"] = "Runsva", },
		{ ["Text"] = "Spareni", },
		{ ["Text"] = "Stars", },
		{ ["Text"] = "Tabletopash94", },
		{ ["Text"] = "TheMustardHigh", },
		{ ["Text"] = "YamatoFavor", },
		{ ["Text"] = "Yellow", },
		
		---- CPC v2.0 End ----

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "EIDOS STUDIOS HUNGARY",
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_headofstudio",	-- Head of Studio
		},
		{ ["Text"] = "Söröss Attila", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_projectmanager",	-- Project Manager
		},
		{ ["Text"] = "Györei Viktor", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_leaddesigners",	-- Lead Designers
		},
		{ ["Text"] = "Kasszián Károly", },
		{ ["Text"] = "Szalacsi Botond", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_spleveldesignersscripters",	-- Single Player Level Designers & Scripters
		},
		{ ["Text"] = "Andrássy Balázs", },
		{ ["Text"] = "Báling Péter", },
		{ ["Text"] = "Deák Attila", },
		{ ["Text"] = "Gombosi László", },
		{ ["Text"] = "Karácsonyi Gergely", },
		{ ["Text"] = "Óvári Tamás", },
		{ ["Text"] = "Petrekovits Péter", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_mpdesigners",	-- Multiplayer Designers
		},
		{ ["Text"] = "Andrássy Gábor", },
		{ ["Text"] = "Béressy Gábor", },
		{ ["Text"] = "Mohácsi Attila", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_scriptwriter",	-- Script Writer
		},
		{ ["Text"] = "Andrássy Balázs", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_consultantseniordesigner",	-- Consultant Senior Designer
		},
		{ ["Text"] = "Gáspár János", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_consultantdesigner",	-- Consultant Designer
		},
		{ ["Text"] = "Nagy-Szakáll Ferenc", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_leadprogrammer",	-- Lead Programmer
		},
		{ ["Text"] = "Somfai Ákos", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_uigameprogrammers",	-- User Interface & Game Programmers
		},
		{ ["Text"] = "Bodács Gábor", },
		{ ["Text"] = "Császár Zoltán", },
		{ ["Text"] = "Kett Norbert", },
		{ ["Text"] = "Rieger Péter", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_engineprogrammers",	-- Engine Programmers
		},
		{ ["Text"] = "Horváth Zoltán", },
		{ ["Text"] = "Magyar László", },
		{ ["Text"] = "Pintér Ferenc", },
		{ ["Text"] = "Török Balázs", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_mpprogrammer",	-- Multiplayer Programmer
		},
		{ ["Text"] = "Gócza Viktor", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_aiprogrammer",	-- AI Programmer
		},
		{ ["Text"] = "Benke Zsolt", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_consultantseniorprogrammer",	-- Consultant Senior Programmer
		},
		{ ["Text"] = "Puhr Gábor", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_leadartist",	-- Lead Artist
		},
		{ ["Text"] = "Nagy Zoltán", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_seniortechnicalartists",	-- Senior Technical Artists
		},
		{ ["Text"] = "Kiss Ferenc", },
		{ ["Text"] = "Seres Lehel", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_levelartists",	-- Level Artists
		},
		{ ["Text"] = "Ferro Attila", },
		{ ["Text"] = "Gaál Attila", },
		{ ["Text"] = "Sághy Viktor", },
		{ ["Text"] = "Sédtõi Levente", },
		{ ["Text"] = "Szalai István", },
		{ ["Text"] = "Tömör Gergõ", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_uiartists",	-- User Interface Artists
		},
		{ ["Text"] = "Gaál Attila", },
		{ ["Text"] = "Sédtõi Levente", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_leadfmvartist",	-- Lead FMV Artist
		},
		{ ["Text"] = "Tóth Péter", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_seniorfmvartists",	-- Senior FMV Artists
		},
		{ ["Text"] = "Kerti Tamás", },
		{ ["Text"] = "Rigó Péter", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_fmvartists",	-- FMV Artists
		},
		{ ["Text"] = "Dajkó Tibor", },
		{ ["Text"] = "Kissné Kovács Éva", },
		{ ["Text"] = "Radványi Norbert", },
		{ ["Text"] = "Tujner János", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_qasupervisor",	-- QA Supervisor
		},
		{ ["Text"] = "Kozma Zoltán", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_qatesters",	-- Quality Assurance Testers
		},
		{ ["Text"] = "Heiczinger Zsolt", },
		{ ["Text"] = "Horváth Péter András", },
		{ ["Text"] = "Kunosi György", },
		{ ["Text"] = "Létai János", },
		{ ["Text"] = "Malatinszky Bence", },
		{ ["Text"] = "Simon Balázs", },
		{ ["Text"] = "Sinka Tamás", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_itmanager",	-- IT Manager
		},
		{ ["Text"] = "Fertõi Ferenc", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_sysadmin",	-- System Administrator
		},
		{ ["Text"] = "Horváth Péter", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_officeadmin",	-- Office Administrator
		},
		{ ["Text"] = "Tankó Veronika", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_receptionist",	-- Receptionist
		},
		{ ["Text"] = "Szívós Andrea", },
		{ ["Type"] = CIT_SPACE, },

-- WITH THE ASSISTANCE OF...
				{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_withtheassistance", -- WITH THE ASSISTANCE OF
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},	
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },
		
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_supplementaryart",	-- Supplementary Artwork
		},
		{ ["Text"] = "Ifj. Rácz László", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_addprogramming",	-- Additional Programming
		},
		{ ["Text"] = "Kiss Árpád István", },
		{ ["Text"] = "Kovács Róbert", },
		{ ["Text"] = "Lehõcz Kornél", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_addqa",	-- Additional QA
		},
		{ ["Text"] = "Ács Máté", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_soundeffects",	-- Sound Effects
		},
		{ ["Text"] = "Hotelsinus Sound Design, Zizics László", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_music",	-- Music
		},
		{ ["Text"] = "Music by Richard Jacques Studios, Composed by Richard Jacques and David Kates.", },
		{ ["Type"] = CIT_SPACE, },

-- 3D ASSET PRODUCTION (3D Brigade Kft.)
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_assetproduction",	-- 3D ASSET PRODUCTION
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "3D Brigade Kft.",
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_executiveproducer",	-- Executive Producer
		},
		{ ["Text"] = "Forrai Gábor", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_producer",	-- Producer
		},
		{ ["Text"] = "Kálvin Balázs", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_leadartists",	-- Lead Artists
		},
		{ ["Text"] = "Vékony Csaba", },
		{ ["Text"] = "Kemenczei Tamás", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_technicalleadartist",	-- Technical Lead Artist
		},
		{ ["Text"] = "Kalázdi Balázs", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_artists",	-- Artists
		},
		{ ["Text"] = "Antal János", },
		{ ["Text"] = "Balla Gábor", },
		{ ["Text"] = "Berghammer Zsolt", },
		{ ["Text"] = "Bodnár Gábor", },
		{ ["Text"] = "Borbély Csaba", },
		{ ["Text"] = "Bosnyák József", },
		{ ["Text"] = "Budai Imre", },
		{ ["Text"] = "Farkas Attila", },
		{ ["Text"] = "Farkas László", },
		{ ["Text"] = "Hunyás Adrián", },
		{ ["Text"] = "Jaczkó Bálint", },
		{ ["Text"] = "Kenedli István", },
		{ ["Text"] = "Kovács Márk", },
		{ ["Text"] = "Lázár Attila", },
		{ ["Text"] = "Lázár Nikoletta", },
		{ ["Text"] = "Magas Zoltán", },
		{ ["Text"] = "Mázás József", },
		{ ["Text"] = "Mester Tamás", },
		{ ["Text"] = "Orbán Péter", },
		{ ["Text"] = "Rádli Tamás", },
		{ ["Text"] = "Szabó Tamás", },
		{ ["Text"] = "Szügyi Gábor", },
		{ ["Text"] = "Velicsek Gusztáv", },
		
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_technicalsetup",	-- Technical Setup
		},
		{ ["Text"] = "Domján László", },
		{ ["Type"] = CIT_SPACE, },

-- MOTION CAPTURE (BOHEMIA)
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_mocap",	-- MOTION CAPTURE SERVICES PROVIDED BY
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "Bohemia Interactive Studio",
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_mocapleadengineer",	-- Lead Engineer / Optical Data Processing
		},			

		{ ["Text"] = "Stepan Kment", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_motioneditinglead",	-- Motion Editing Lead
		},			

		{ ["Text"] = "Radim Pech", },
		{ ["Type"] = CIT_SPACE, },
		
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_motionediting",	-- Motion Editing
		},			

		{ ["Text"] = "Petr Rak", },
		{ ["Text"] = "Martin Valasek", },
		{ ["Text"] = "Ondoej  Valasek", },
		{ ["Type"] = CIT_SPACE, },
		
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_mocapperformers",	-- Motion Capture Performers
		},			

		{ ["Text"] = "Alexandra Lanska", },
		{ ["Text"] = "Roman Kracik", },
		{ ["Text"] = "Josef Roubal", },
		{ ["Type"] = CIT_SPACE, },

-- SPECIAL THANKS TO
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_specialthanks", -- SPECIAL THANKS TO
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },
		
		{ ["Text"] = "Klaude Thomas", },
		{ ["Text"] = "Kullai Imre", },
		{ ["Text"] = "Matthew Miles Griffiths", },
		{ ["Text"] = "Nyulászi Zsolt", },
		{ ["Text"] = "Tiszai Zsuzsanna", },
		{ ["Type"] = CIT_SPACE, },

--  THANKS TO
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_thanks", -- THANKS TO
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },


		{ ["Text"] = "-=)CSF(=-Akagi", },
		{ ["Text"] = "Arrow", },
		{ ["Text"] = "chip5541", },
		{ ["Text"] = "Cpt.sharp", },
		{ ["Text"] = "CrisGer", },
		{ ["Text"] = "Dogmeatz", },
		{ ["Text"] = "Dremora Warlord", },
		{ ["Text"] = "It3llig3nc3", },
		{ ["Text"] = "Kai Robin", },
		{ ["Text"] = "Lexxy", },
		{ ["Text"] = "mortalstakes", },
		{ ["Text"] = "Saki1211", },
		{ ["Text"] = "sblendo", },
		{ ["Text"] = "Scipio65", },
		{ ["Text"] = "Shamrock", },
		{ ["Text"] = "Sith Darthfoxx", },
		{ ["Text"] = "SSG.ROCK", },
		{ ["Text"] = "Wolfpack Apone", },
		{ ["Type"] = CIT_SPACE, },
		{ ["Text"] = "Bagó Péter", },
		{ ["Text"] = "Bakonyi Péter", },
		{ ["Text"] = "Böhm József", },
		{ ["Text"] = "Czinege Róbert", },
		{ ["Text"] = "Dujmov Gábor", },
		{ ["Text"] = "Egri János", },
		{ ["Text"] = "Fehérvári Szabolcs", },
		{ ["Text"] = "Gregor Gábor", },
		{ ["Text"] = "Hidvégi Ariel", },
		{ ["Text"] = "Kapornaky Mihály", },
		{ ["Text"] = "Kaptás András", },
		{ ["Text"] = "Kasz Krisztián", },
		{ ["Text"] = "Kiss Péter János", },
		{ ["Text"] = "Kopecskó Attila", },
		{ ["Text"] = "Kormann Péter", },
		{ ["Text"] = "Kovács György", },
		{ ["Text"] = "Kozma Zoltán", },
		{ ["Text"] = "Kunosi György", },
		{ ["Text"] = "Ladányi Ádám", },
		{ ["Text"] = "Máté Zsolt", },
		{ ["Text"] = "Molnár Ferenc", },
		{ ["Text"] = "Ruzsics László", },
		{ ["Text"] = "Szabó Tibor", },
		{ ["Text"] = "Szalay Gergõ", },
		{ ["Text"] = "Szentmiklósi István", },
		{ ["Text"] = "Szombathelyi Áron", },
		{ ["Text"] = "Tornai Gábor", },
		{ ["Text"] = "Tóth Benedek", },
		{ ["Text"] = "Varga Ákos", },
		{ ["Text"] = "Vedrõdi Balázs", },
		{ ["Type"] = CIT_SPACE, },
		
--  DEV BABIES
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_devbabies", -- THANKS TO
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },		

	  { ["Text"] = "Béressy Lilien", },
	  { ["Text"] = "Györei Botond", },
	  { ["Text"] = "Horváth Zoltán Nándor", },
	  { ["Text"] = "Kozma Boglárka", },
	  { ["Text"] = "Szalai Alex Ákos", },
	  { ["Text"] = "Tömör Nándor Keresztély", },
		{ ["Type"] = CIT_SPACE, },		
		
-- EGS
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "EIDOS GAME STUDIOS",
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },
		
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_generalmanager",	-- General Manager
		},			

		{ ["Text"] = "Lee Singleton", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_producer",	-- Producer
		},			
		{ ["Text"] = "Jonathan Eardley", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_associateproducer",	-- Associate Producer
		},			
		{ ["Text"] = "Saty Mann", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_brandmanager",	-- Brand Manager
		},			
		{ ["Text"] = "Trevor Burrows", },

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_assistantbrandmanager",	-- Assistant Brand Manager
		},			
		{ ["Text"] = "Luke Willoughby", },

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_extdesigner",	-- External Games Designer
		},			
		{ ["Text"] = "Alastair Cornish", },

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_prodacqcoordinator",	-- Product Acquisitions Coordinator
		},			
		{ ["Text"] = "Caspar Gray", },

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_financialcontroller",	-- Financial Controller
		},			
		{ ["Text"] = "James Trundle", },

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_globalcommmanager",	-- Global Communications Manager
		},			
		{ ["Text"] = "Gareth Ramsay", },

		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_communitymanager",	-- Community Manager
		},			
		{ ["Text"] = "Mike Oldman", },
		{ ["Type"] = CIT_SPACE, },

-- EIDOS
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "EIDOS",
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_chiefexecutiveofficer",	-- Chief Executive Officer
		},			
		{ ["Text"] = "Phil Rogers", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_chieffinancialofficer",	-- Chief Financial Officer
		},			
		{ ["Text"] = "Robert Brent", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_companysecretary",	-- Company Secretary
		},			
		{ ["Text"] = "Anthony Price", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_prodacqdirector",	-- Product Acquisition Director
		},			
		{ ["Text"] = "Ian Livingstone", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_grpstratplanningdirector",	-- Group Strategic Planning Director
		},			
		{ ["Text"] = "Fabien Rossini", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_grpmarketingdirector",	-- Group Marketing Director
		},			
		{ ["Text"] = "Sarah Hoeksma", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_operationsdirector",	-- Operations Director
		},			
		{ ["Text"] = "Richard Lever", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_cto",	-- Chief Technical Officer
		},			
		{ ["Text"] = "Julien Merceron", },
		{ ["Type"] = CIT_SPACE, },

-- OPERATIONS
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_operations", -- OPERATIONS
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_prodncreativemanager",	-- Production and Creative Manager
		},			
		{ ["Text"] = "Linda Ormrod", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_productionexecutive",	-- Production Executive
		},			
		{ ["Text"] = "Tiago Silva", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_sencreativeartworker",	-- Senior Creative Artworker
		},			
		{ ["Text"] = "Emma Ward", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_distributionsupervisors",	-- Distribution Supervisors
		},			
		{ ["Text"] = "Fiona Batey", },
		{ ["Text"] = "Dorn Edwards", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_masteringmanager",	-- Mastering Manager
		},			
		{ ["Text"] = "Jason Walker", },
		{ ["Type"] = CIT_SPACE, },

-- FUNCTIONALITY QA
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_funcqa", -- FUNCTIONALITY QA
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_qahead",	-- Head of Quality Assurance
		},			
		{ ["Text"] = "Marc Titheridge", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_qapm",	-- Quality Assurance Project Manager
		},			
		{ ["Text"] = "David Pettit", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_qatechnicians",	-- Quality Assurance Technicians
		},			
		{ ["Text"] = "VMC Game Labs Montreal", },
		{ ["Type"] = CIT_SPACE, },

-- LOCALISATION
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_localisation", -- LOCALISATION
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_lochead",	-- Head of Localisation
		},			
		{ ["Text"] = "Monica Dalla Valle", },
		{ ["Text"] = "Caroline Simon", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_locmanager",	-- Localisation Manager
		},			
		{ ["Text"] = "Jan Büchner", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_locqasupervisor",	-- Localisation QA Supervisor
		},			
		{ ["Text"] = "Augusto d'Apuzzo", },
		{ ["Type"] = CIT_SPACE, },

-- DIALOGUE

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_dialogue", -- DIALOGUE
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_dialwrit",   --Writer
		},			
		{ ["Text"] = "James Leach", },
		{ ["Type"] = CIT_SPACE, },

-- VOICEOVER STUDIO
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_vostudio", -- VOICEOVER STUDIO
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },


		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "ID Audio",
		},			
		{ ["Text"] = "Patrick McQuaid", },
		{ ["Type"] = CIT_SPACE, },

		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_voicetalent",	-- Voice Talent
		},			
		{ ["Text"] = "Brian Bowles", },
		{ ["Text"] = "Corey Johnson", },
		{ ["Text"] = "Dai Tabuci", },
		{ ["Text"] = "Eiji Mihara", },
		{ ["Text"] = "Eiji Kusuhara", },
		{ ["Text"] = "Eric Meyers", },
		{ ["Text"] = "Garrick Hagon", },
		{ ["Text"] = "James Goode", },
		{ ["Text"] = "Kenji Watanabe", },
		{ ["Text"] = "Martin Sherman", },
		{ ["Text"] = "Masashi Fujimoto", },
		{ ["Text"] = "Masato Kamo", },
		{ ["Text"] = "Sadao Ueda", },
		{ ["Text"] = "Stefan Ashton Frank", },
		{ ["Text"] = "Takashi Sudo", },
		{ ["Text"] = "Tom Clarke-Hill", },
		{ ["Text"] = "Walter Lewis", },
		{ ["Type"] = CIT_SPACE, },

-- SPECIAL THANKS
		{
		  ["Type"]   = CIT_CATEGORY,
		  ["Text"]   = "FE.credits_specthx", -- SPECIAL THANKS
		  ["Color"] = { 0.803922, 0.584314, 0.329412, 1.000000 }, -- gold
		},			
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },

		{ ["Text"] = "FE.credits_egs_thx1", },
		{ ["Text"] = "FE.credits_egs_thx2", },
		{ ["Text"] = "FE.credits_egs_thx3", },
		{ ["Type"] = CIT_SPACE, },
		{ ["Type"] = CIT_IMAGE, ["Text"] = "spacer", },
		{ ["Type"] = CIT_SPACE, },


------------------------------------------------------------------------------------------------------
	},
}

if REGION == "EU" then -- EU
	if XENON then -- XENON
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations: Pacific © Eidos Interactive Limited, 2009.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Published by Eidos Interactive Limited, 2009. Developed by", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Eidos Hungary KFT.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations, Battlestations: Pacific, Eidos, Eidos Interactive and the", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Eidos logo are trademarks of Eidos Interactive Limited.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Uses FMOD Ex Sound System. Firelight Technologies.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "All other trademarks are the property of their respective owners.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "All rights reserved.", ["Align"]=CA_LEFT, } )
	else -- PC
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations: Pacific © Eidos Interactive Limited, 2009.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Published by Eidos Interactive Limited, 2009. Developed by", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Eidos Hungary KFT.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations, Battlestations: Pacific, Eidos, Eidos Interactive and the", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Eidos logo are trademarks of Eidos Interactive Limited.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_IMAGE, ["Text"] = "binklogo", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_BACK, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Uses Bink Video. Copyright © 1997-2009 by RAD Game Tools, Inc.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Uses FMOD Ex Sound System. Firelight Technologies.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "All other trademarks are the property of their respective owners.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_OFFSETX, ["Offset"] = DEF_X_OFS, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "All rights reserved.", ["Align"]=CA_LEFT, } )
	end
else -- USA
	if XENON then -- XENON
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations: Pacific © Eidos Interactive Limited, 2009.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Developed by Eidos Hungary KFT. Co-published by Eidos, Inc. and Warner Bros", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Home Entertainment, a division of Warner Bros. Home Entertainment Inc.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations, Battlestations: Pacific, Eidos, and the Eidos logo are trademarks of", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Eidos Interactive Limited.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "The rating icon is a registered trademark of the Entertainment Software Association.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Uses FMOD Ex Sound System. Firelight Technologies.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "All other trademarks are the property of their respective owners. All rights reserved.", ["Align"]=CA_LEFT, } )

		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_IMAGE, ["Text"] = "wblogo", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_BACK, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "WBIE LOGO, WB SHIELD: %c & © Warner Bros. Entertainment Inc.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "(s09)", ["Align"]=CA_LEFT, } )
	else -- PC
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations: Pacific © Eidos Interactive Limited, 2009.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Developed by Eidos Hungary KFT. Co-published by Eidos, Inc. and Warner Bros", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Home Entertainment, a division of Warner Bros. Home Entertainment Inc.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Battlestations, Battlestations: Pacific, Eidos, and the Eidos logo are trademarks of", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Eidos Interactive Limited.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_IMAGE, ["Text"] = "binklogo", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_BACK, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Uses Bink Video. Copyright © 1997-2009 by RAD Game Tools, Inc.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Uses FMOD Ex Sound System. Firelight Technologies. The rating", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "icon is a registered trademark of the Entertainment Software", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_OFFSETX, ["Offset"] = DEF_X_OFS, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "Association. All other trademarks are the property of their respective owners.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "All rights reserved.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_OFFSETX, ["Offset"] = DEF_X_OFS, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_IMAGE, ["Text"] = "wblogo", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Type"] = CIT_BACK, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "WBIE LOGO, WB SHIELD: %c & © Warner Bros. Entertainment Inc.", ["Align"]=CA_LEFT, } )
		table.insert( Credits.Credits_Items, { ["Text"] = "(s09)", ["Align"]=CA_LEFT, } )
	end
end

table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
table.insert( Credits.Credits_Items, { ["Type"] = CIT_SPACE, } )
