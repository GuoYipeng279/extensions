--Copy from spa.h
ACHIEVEMENT_RUA_DU = 27 	-- Tin Can Captain 														– Sink 20 enemy ships with your destroyer by using torpedoes 
ACHIEVEMENT_RUA_CU = 28 	-- Broadside Kill 														- Sink an enemy ship with your cruiser in 15 seconds 
ACHIEVEMENT_RUA_BU = 29 	-- Long-range Gunnery													– Destroy an enemy ship with your battleship which is further than 2800 meters 
ACHIEVEMENT_RUA_MU = 30 	-- Flat Top Commander													– Send up 50 airplanes in the air with the support manager
ACHIEVEMENT_RUA_SU = 31 	-- Death from Below 													- Sink an enemy battleship with your submarine
ACHIEVEMENT_RUA_FU = 32 	-- Fighter Ace															– Destroy 5 enemy planes in less than 30 seconds without losing your fighter plan
ACHIEVEMENT_RUA_TBU = 33 	-- Hattrick																– Achieve 3 torpedo hits with the same torpedo bomber
ACHIEVEMENT_RUA_DBU = 34 	-- Deadly Accuracy														– Achieve 20 magazine hits with dive bombers
ACHIEVEMENT_RUA_LBU = 35 	-- Double Whammy. [Magic Carpet]										– Do damage to at least two targets in one bombing run
ACHIEVEMENT_GA_SL = 36 		-- Supply Line						(ACHIEVEMENT_RUA_RU)				– Use the support manager to successfully send up a plane or request a ship
ACHIEVEMENT_GA_AE = 37		-- Advantage						(ACHIEVEMENT_RUA_PTU)
ACHIEVEMENT_RUA_KU = 38		-- Banzaaai!	- Impact with at least 600km/h airspeed to an enemy ship 
ACHIEVEMENT_MA_SA = 39		-- Surprise Attack					(ACHIEVEMENT_MA_SA)
ACHIEVEMENT_MA_TP = 40 		-- Turning Point					(ACHIEVEMENT_MA_TP)
ACHIEVEMENT_MA_PS = 41 		-- Preventive Strike				(ACHIEVEMENT_MA_PS)
ACHIEVEMENT_MA_FD = 42 		-- Under Cover of Darkness [From Dusk till Dawn] (ACHIEVEMENT_MA_FD)
ACHIEVEMENT_MA_QS = 43 		-- Queen Sacrifice					(ACHIEVEMENT_MA_QS)
ACHIEVEMENT_MA_MT = 44 		-- Marianas Turkey Shoot			(ACHIEVEMENT_MA_MT)
ACHIEVEMENT_MA_YC = 45 		-- You shall not Cross!				(ACHIEVEMENT_MA_YC)
ACHIEVEMENT_SA_PM = 46 		-- Past Memories					(ACHIEVEMENT_SA_PM)
ACHIEVEMENT_SA_IM = 47 		-- I’ve Changed My Mind				(ACHIEVEMENT_SA_IM)					- Land on an airfield or carrier with a kamikaze squadron
ACHIEVEMENT_SA_UH = 48 		-- Underwater Hideout				(ACHIEVEMENT_SA_UH)
ACHIEVEMENT_SA_TK = 49 		-- Trainkiller						(ACHIEVEMENT_SA_TK)
ACHIEVEMENT_SA_OC = 50 		-- Flying Fish. [Oh, You Can!]		(ACHIEVEMENT_SA_OC)					- Land on the water with a seaplane or flying boat 
ACHIEVEMENT_AO_MOH = 51 	-- Take No Prisoners. [Medal of Honor]
ACHIEVEMENT_CA_USV = 52 	-- National Veteran
ACHIEVEMENT_CA_USE = 53 	-- National Hero
ACHIEVEMENT_CA_JPV = 54 	-- Fist of the Emperor
ACHIEVEMENT_CA_JPE = 55 	-- Wrath of the Emperor
ACHIEVEMENT_CA_HOS = 56 	-- War Room
ACHIEVEMENT_CA_WOG = 57 	-- Conqueror
ACHIEVEMENT_CA_AA = 58 		-- Armchair Admiral
ACHIEVEMENT_CA_FA = 59 		-- Frontline Admiral
ACHIEVEMENT_CA_CJM = 60 	-- Rising Sun
ACHIEVEMENT_CA_CUM = 61 	-- Stars and Stripes
ACHIEVEMENT_GA_SH = 62 		-- Submarine Hunter-killer			(ACHIEVEMENT_CA_CBC)
ACHIEVEMENT_CA_OF = 63 		-- Overwhelming Force
ACHIEVEMENT_CA_SA = 64 		-- Shock and Awe
ACHIEVEMENT_CA_IC = 65 		-- Island Hopping
ACHIEVEMENT_CA_VR = 66 		-- Victory Rush
ACHIEVEMENT_RANK_FR = 67 	-- Fleet Commander
ACHIEVEMENT_RANK_SR = 68 	-- Head of the Fleet
ACHIEVEMENT_GA_DN = 69 		-- Disembarkation
ACHIEVEMENT_GA_AI = 70 		-- Airborne Invasion													- Capture a base by using paratroopers 
ACHIEVEMENT_GA_DB = 71 		-- Don’t Mess with the Big Boys
ACHIEVEMENT_GA_PL = 72 		-- Repair for your Life
ACHIEVEMENT_GA_AO = 73 		-- Against the Odds														- Sink a stronger enemy ship than your ship 
ACHIEVEMENT_GA_WY = 74 		-- We are not Sinking yet
ACHIEVEMENT_GA_MP = 75 		-- Pure Gold. [My Precious!]
ACHIEVEMENT_GA_HM = 76 		-- Hero of Midway														- Played Battlestations Midway
ACHIEVEMENT_MA_LM = 77 		-- Legend of Midway														- Beat Defending Midway on veteran
ACHIEVEMENT_MA_CS = 78 		-- Making History														- Beat Battle of Coral Sea (US Campaign) on veteran

Achievements = {}

Achievements["BW_AAM"] =
{
	["Name"] = "FE.badge_bw_aam", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 1000,
		 },
	["Description"] = "FE.badge_bw_aam_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bw_aam.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BW_AM"] =
{
	["Name"] = "FE.badge_bw_am", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 800,
		 },
	["Description"] = "FE.badge_bw_am_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bw_am.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "unit", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BW_TM"] =
{
	["Name"] = "FE.badge_bw_tm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 50,
		 },
	["Description"] = "FE.badge_bw_tm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bw_tm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "unit", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BW_RM"] =
{
	["Name"] = "FE.badge_bw_rm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 200,
		 },
	["Description"] = "FE.badge_bw_rm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bw_rm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BW_DCM"] =
{
	["Name"] = "FE.badge_bw_dcm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 50,
		 },
	["Description"] = "FE.badge_bw_dcm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bw_dcm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_DM"] =
{
	["Name"] = "FE.badge_bu_dm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 10,
		 },
	["Description"] = "FE.badge_bu_dm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_dm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_CM"] =
{
	["Name"] = "FE.badge_bu_cm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 15,
		 },
	["Description"] = "FE.badge_bu_cm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_cm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_BM"] =
{
	["Name"] = "FE.badge_bu_bm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 20,
		 },
	["Description"] = "FE.badge_bu_bm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_bm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_SM"] =
{
	["Name"] = "FE.badge_bu_sm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 5,
		 },
	["Description"] = "FE.badge_bu_sm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_sm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_FA"] =
{
	["Name"] = "FE.badge_bu_fa", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 30,
		 },
	["Description"] = "FE.badge_bu_fa_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_fa.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_VTB"] =
{
	["Name"] = "FE.badge_bu_vtb", -- lockitID
	["Params"] = { 
		[1] = 20,
		 },
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Description"] = "FE.badge_bu_vtb_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_vtb.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_VDB"] =
{
	["Name"] = "FE.badge_bu_vdb", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 20,
		 },
	["Description"] = "FE.badge_bu_vdb_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_vdb.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_VLB"] =
{
	["Name"] = "FE.badge_bu_vlb", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 10,
		 },
	["Description"] = "FE.badge_bu_vlb_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_vlb.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_VR"] =
{
	["Name"] = "FE.badge_bu_vr", -- lockitID
	["ID"] = 10, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 10,
		 },
	["Description"] = "FE.badge_bu_vr_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_vr.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_PTM"] =
{
	["Name"] = "FE.badge_bu_ptm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 10,
		 },
	["Description"] = "FE.badge_bu_ptm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_ptm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BU_KM"] =
{
	["Name"] = "FE.badge_bu_km", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 20,
		 },
	["Description"] = "FE.badge_bu_km_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bu_km.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BO_CV"] =
{
	["Name"] = "FE.badge_bo_cv", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 20,
		 },
	["Description"] = "FE.badge_bo_cv_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bo_cv.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BO_DCM"] =
{
	["Name"] = "FE.badge_bo_dcm", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 50,
		 },
	["Description"] = "FE.badge_bo_dcm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bo_dcm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BO_KSS"] =
{
	["Name"] = "FE.badge_bo_kss", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 3,
		 },
	["Description"] = "FE.badge_bo_kss_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bo_kss.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BO_KSP"] =
{
	["Name"] = "FE.badge_bo_ksp", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 10,
		 },
	["Description"] = "FE.badge_bo_ksp_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bo_ksp.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BO_EE"] =
{
	["Name"] = "FE.badge_bo_ee", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 10,
		 },
	["Description"] = "FE.badge_bo_ee_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bo_ee.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["BO_SC"] =
{
	["Name"] = "FE.badge_bo_sc", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["Params"] = { 
		[1] = 20,
		 },
	["Description"] = "FE.badge_bo_sc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/badges/bo_sc.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Score"] = 100,
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_DU"] =
{
	["Name"] = "FE.achievement_tincc_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_DU;
	["Params"] = {
		[1] = 20, -- enemy ships killed with torpdeoes
		}, 
	["Description"] = "FE.achievement_tincc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_du.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_CU"] =
{
	["Name"] = "FE.achievement_broadsidek_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_CU;
	["Params"] = { 
		[1] = 15, -- seconds
		 },
	["Description"] = "FE.achievement_broadsidek_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_cu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_BU"] =
{
	["Name"] = "FE.achievement_longrg_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_BU;
	["Params"] = { 
		[1] = 2800, -- meters
		 },
	["Description"] = "FE.achievement_longrg_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_bu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_MU"] =
{
	["Name"] = "FE.achievement_flattc_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_MU;
	["Params"] = { 
		[1] = 50, -- planes spawned
		 },
	["Description"] = "FE.achievement_flattc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_mu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_SU"] =
{
	["Name"] = "FE.achievement_deathfb_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_SU;
	["Params"] = { 
		[1] = 1, -- battleship sunk
		 },
	["Description"] = "FE.achievement_deathfb_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_su.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_FU"] =
{
	["Name"] = "FE.achievement_fightera_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_FU;
	["Params"] = { 
		[1] = 5, -- enemy planes
		[2] = 30, -- seconds
		 },
	["Description"] = "FE.achievement_fightera_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_fu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_TBU"] =
{
	["Name"] = "FE.achievement_hattrick_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_TBU;
	["Params"] = { 
		[1] = 3, -- torpedo hits
		 },
	["Description"] = "FE.achievement_hattrick_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_tbu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_DBU"] =
{
	["Name"] = "FE.achievement_deadlya_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_DBU;
	["Params"] = { 
		[1] = 20, -- magazine hits with bombs
		 },
	["Description"] = "FE.achievement_deadlya_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_dbu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_LBU"] =
{
	["Name"] = "FE.achievement_magicc_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_LBU;
	["Params"] = { 
		[1] = 2, -- targets hit with the same bombing
		[2] = 4, -- time beetwean two damage
		 },
	["Description"] = "FE.achievement_magicc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_lbu.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RUA_KU"] =
{
	["Name"] = "FE.achievement_banzai_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RUA_KU;
	["Params"] = { 
		[1] = 166, -- m/s (600 km/h)
		 },
	["Description"] = "FE.achievement_banzai_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rua_ku.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_SA"] =
{
	["Name"] = "FE.achievement_surprisea_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_SA;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_surprisea_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_sa.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_TP"] =
{
	["Name"] = "FE.achievement_turningp_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_TP;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_turningp_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_tp.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_PS"] =
{
	["Name"] = "FE.achievement_preventives_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_PS;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_preventives_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_ps.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_FD"] =
{
	["Name"] = "FE.achievement_fromdtd_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_FD;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_fromdtd_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_ucod.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_QS"] =
{
	["Name"] = "FE.achievement_queens_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_QS;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_queens_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_qs.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_MT"] =
{
	["Name"] = "FE.achievement_marianasts_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_MT;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_marianasts_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_mt.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_YC"] =
{
	["Name"] = "FE.achievement_yousnc_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_YC;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_yousnc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_zd.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["AO_MOH"] =
{
	["Name"] = "FE.achievement_medaloh_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_AO_MOH;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_medaloh_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ma_tnp.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_LM"] =
{
	["Name"] = "Legend of Midway", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_LM;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "Beat Defending Midway (US Campaign) on veteran difficulty with a gold medal with no unlocks used.", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/defending_midway.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["MA_CS"] =
{
	["Name"] = "Making History", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_MA_CS;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "Beat Battle of Coral Sea (US Campaign) on veteran difficulty with a gold medal with no unlocks used.", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/coral_sea.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_SL"] =
{
	["Name"] = "FE.achievement_supplyl_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_SL;
	["Params"] = { 
		[1] = 1, -- planes sent up with support manager
		 },
	["Description"] = "FE.achievement_supplyl_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_sl.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_AE"] =
{
	["Name"] = "FE.achievement_advantage_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_AE;
	["Params"] = { 
		[1] = 1, -- naval supplies used
		 },
	["Description"] = "FE.achievement_advantage_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_ae.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_DN"] =
{
	["Name"] = "FE.achievement_disembarkation_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_DN;
	["Params"] = { 
		[1] = 1, -- islands capture by landing ships
		 },
	["Description"] = "FE.achievement_disembarkation_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_dn.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_AI"] =
{
	["Name"] = "FE.achievement_airbornei_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_AI;
	["Params"] = { 
		[1] = 1, -- islands captured by paratroopers
		 },
	["Description"] = "FE.achievement_airbornei_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_ai.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_SH"] =
{
	["Name"] = "FE.achievement_submarinehk_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_SH;
	["Params"] = { 
		[1] = 1, -- subs destroyed by torpedoes
		 },
	["Description"] = "FE.achievement_submarinehk_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_sh.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_DB"] =
{
	["Name"] = "FE.achievement_dontmwtbb_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_DB;
	["Params"] = { 
		[1] = 1, -- carriers killed with battleships
		 },
	["Description"] = "FE.achievement_dontmwtbb_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_db.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_PL"] =
{
	["Name"] = "FE.achievement_pumpfyl_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_PL;
	["Params"] = { 
		[1] = 3, -- ???
		 },
	["Description"] = "FE.achievement_pumpfyl_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_rl.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_AO"] =
{
	["Name"] = "FE.achievement_againstto_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_AO;
	["Params"] = { 
		[1] = 1, -- stronger ships sunk
		 },
	["Description"] = "FE.achievement_againstto_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_ao.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_WY"] =
{
	["Name"] = "FE.achievement_weansy_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_WY;
	["Params"] = { 
		[1] = 3, -- HP percentage when sinking an enemy ship
		 },
	["Description"] = "FE.achievement_weansy_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_wy.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_MP"] =
{
	["Name"] = "FE.achievement_myp_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_MP;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_myp_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_pg.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["GA_HM"] =
{
	["Name"] = "FE.achievement_heroom_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_GA_HM;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_heroom_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ga_hm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["SA_PM"] =
{
	["Name"] = "FE.achievement_pastm_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_SA_PM;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_pastm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/sa_pm.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["SA_IM"] =
{
	["Name"] = "FE.achievement_ivecmm_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_SA_IM;
	["Params"] = { 
		[1] = 1, -- kamikazes landed
		 },
	["Description"] = "FE.achievement_ivecmm_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/sa_im.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["SA_UH"] =
{
	["Name"] = "FE.achievement_underwaterh_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_SA_UH;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_underwaterh_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/sa_uh.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["SA_TK"] =
{
	["Name"] = "FE.achievement_trainkiller_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_SA_TK;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_trainkiller_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/sa_tk.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["SA_OC"] =
{
	["Name"] = "FE.achievement_ohyc_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_SA_OC;
	["Params"] = { 
		[1] = 0,
		 },
	["Description"] = "FE.achievement_ohyc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/sa_ff.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_USV"] =
{
	["Name"] = "FE.achievement_nationalv_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_USV;
	["Params"] = { 
		[1] = 25, -- multi sessions finished
		 },
	["Description"] = "FE.achievement_nationalv_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_usv.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_USE"] =
{
	["Name"] = "FE.achievement_nationalh_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_USE;
	["Params"] = { 
		[1] = 100, -- multi sessions finished
		 },
	["Description"] = "FE.achievement_nationalh_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_use.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_JPV"] =
{
	["Name"] = "FE.achievement_fistote_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_JPV;
	["Params"] = { 
		[1] = 25, -- multi sessions finished
		 },
	["Description"] = "FE.achievement_fistote_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_jpv.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_JPE"] =
{
	["Name"] = "FE.achievement_wrathote_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_JPE;
	["Params"] = { 
		[1] = 100, -- multi sessions finished
		 },
	["Description"] = "FE.achievement_wrathote_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_jpe.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_HOS"] =
{
	["Name"] = "FE.achievement_warr_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_HOS;
	["Params"] = { 
		[1] = 50, -- hosted and finished
		 },
	["Description"] = "FE.achievement_warr_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_wr.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_WOG"] =
{
	["Name"] = "FE.achievement_conqueror_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_WOG;
	["Params"] = { 
		[1] = 50, -- sessions won
		 },
	["Description"] = "FE.achievement_conqueror_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_c.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_AA"] =
{
	["Name"] = "FE.achievement_armchaira_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_AA;
	["Params"] = { 
		[1] = 1, -- sessions won without shooting
		 },
	["Description"] = "FE.achievement_armchaira_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_aa.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_FA"] =
{
	["Name"] = "FE.achievement_frontlinea_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_FA;
	["Params"] = { 
		[1] = 1, -- session won without the map
		 },
	["Description"] = "FE.achievement_frontlinea_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_fa.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_CJM"] =
{
	["Name"] = "FE.achievement_risings_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_CJM;
	["Params"] = { 
		[1] = 2, -- difficulty level (2 - hard, 1 - any) ?
		 },
	["Description"] = "FE.achievement_risings_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_rs.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_CUM"] =
{
	["Name"] = "FE.achievement_starsas_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_CUM;
	["Params"] = { 
		[1] = 2, -- difficulty level (2 - hard, 1 - any) ?
		 },
	["Description"] = "FE.achievement_starsas_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_sas.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_OF"] =
{
	["Name"] = "FE.achievement_overwhelmingf_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_OF;
	["Params"] = { 
		[1] = 1, -- difficulty level (2 - hard, 1 - any) ?
		 },
	["Description"] = "FE.achievement_overwhelmingf_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_of.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_SA"] =
{
	["Name"] = "FE.achievement_shockaa_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_SA;
	["Params"] = { 
		[1] = 1, -- difficulty level (2 - hard, 1 - any) ?
		 },
	["Description"] = "FE.achievement_shockaa_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_saa.tga",
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_IC"] =
{
	["Name"] = "FE.achievement_islandh_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_IC;
	["Params"] = { 
		[1] = 56, --Map Count * MapMask
		[2] = 7,  --MapMask (Huge|Large|Medium|Small)
		 },
	["Description"] = "FE.achievement_islandh_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_ic.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["CA_VR"] =
{
	["Name"] = "FE.achievement_victoryr_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_CA_VR;
	["Params"] = { 
		[1] = 1920,
		[2] = 240, -- 0xF0
		 },
	["Description"] = "FE.achievement_victoryr_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/ca_vr.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RANK_FR"] =
{
	["Name"] = "FE.achievement_fleetc_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RANK_FR;
	["Params"] = { 
		[1] = 12, -- lifetime score
		 },
	["Description"] = "FE.achievement_fleetc_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rank_fr.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RANK_SR"] =
{
	["Name"] = "FE.achievement_headotf_name", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = ACHIEVEMENT_RANK_SR;
	["Params"] = { 
		[1] = 20, -- lifetime score
		 },
	["Description"] = "FE.achievement_headotf_desc", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rank_sr.tga",
	["Multi"] = true, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
Achievements["RANK"] =
{
	["Name"] = "", -- lockitID
	["ID"] = 0, -- ID of the icon (AchievementsGUI.lua)
	["XLastAchievementID"] = 0;
	["Params"] = { 
		[1] = 0, -- lifetime score
		[2] = 15000,
		[3] = 45000,
		[4] = 90000,
		[5] = 135000,
		[6] = 180000,
		[7] = 230000,
		[8] = 400000,
		[9] = 600000,
		[10] = 1200000,
		[11] = 1600000,
		[12] = 2000000,
		[13] = 2400000,
		[14] = 3000000,
		[15] = 3600000,
		[16] = 4200000,
		[17] = 5000000,
		[18] = 5800000,
		[19] = 6600000,
		[20] = 8000000,
		},
	["Description"] = "", -- lockitID
	["Sound"] = "", -- sound effect played when the award reached
	["GUITexture"] = "fe/achievement/rank_sr.tga", -- placeholder
	["Multi"] = false, -- set it true, if the achievement is multispecific [used by the MultiMenuMain screen]
	["Unlock"] = {
		["Type"] = "", -- unit/art
		["Index"] = {}, -- vehicleclass indexes/art indexes
	},
}
