Globals =
{
	["LimboMinTime"] = 3,

	["UnitCameraSpeedMul"] = 2.0,

	["Difficulty"] =
	{
		["HPMultipliers"] = { 2.0, 1.5, 1.0, },
		["PlayerCheatMultipliers"] = { 1, 1, 1, },
		["ScoreMultipliers"] = { 1/4, 1/2, 1, },
		["LockRadiusMultipliers"] = { 3.0, 2.0, 1.5, },
	}, --Difficulty

	["Damage"] =
	{
		["Yellow"] = 0.01, -- ennyiszerese a HPBlack-nek a HPYellow
		["Red"] = 0.51, -- ennyiszerese a HPBlack-nek a HPRed
		["MalfunctionRepairTreshold"] = 0.9,
	}, --Damage

	["Minimap"] =
	{
		["MinimapRange"] = 4000,
		["VisibilityRange"] = 4000, -- jelenlegi desing szerint ennek ugyanannyinak kell lennie mint a MinimapRange
	}, --Minimap

	["ExtraEffects"]=
	{
		"PlaneRumble",
		"EnvironmentAirRaid",
		"EnvironmentUSHorn",
		"Akagi Launching",
	},

	["CameraShake"] =
	{
		["GlobalMultiplier"] = 0.25,

		["StrengthMax"] = 4.0,
		["Decay"] = 1.0,
	}, --CameraShake

	["CameraHimbilimbi"] =
	{
		["Frequencies"] = { 0.301, 0.287, 0.273 }, -- milyen gyorsan himbilimbizik
		["BaseAmplitudes"] = { 0.3, 0.3, 0.3 }, -- mennyire ter ki himbilimbinel
		["ViewModeAmpMultipliers"] =
		{
			["Default"] = 0,
			["ShipCaptain"] = 1,
			["PTBoat"] = 0.3,
			["PlanePilot"] = 0.3,
			["MovieCameraOuter"] = 1,
			["MovieCameraDeck"] = 0.1,
		}, --ViewModeAmpMultipliers
		["WeatherAmpMultipliers"] =
		{
			["Default"] = 1,
			["Clear"] = 1,
			["Misty"] = 1,
			["Rainy"] = 4,
			["Foggy"] = 1,
		}, --WeatherAmpMultipliers
	}, --CameraHimbilimbi

	["DayTime"] =
	{
		["StartDayTimeDefault"] = 12, -- alapertelmezett ido scene inditasakor
		["DayTimeSpeed"] = 10, -- ennyiszer gyorsabban telik az ido a napszakokra vonatkozolag

		["MorningStart"] = 4, -- vilagosodas kezdete
		["MorningEnd"] = 8, -- nappal kezdete
		["EveningStart"] = 18, -- sotetedes kezdete
		["EveningEnd"] = 22, -- ejszaka kezdete

		["HighNoonMaxVisionRange"] = 5000, -- nappali max latotavolsag
		["NightVisibility"] = 0.5, -- ejszakai latotavolsag-szorzo
		["FireMaxModifier"] = 2, -- sotetben ennyivel szorzodik az ego/lovoldozo unit lathatosaga
		["SmokeMaxModifier"] = 2, -- vilagosban ennyivel szorzodik a fustolgo unit lathatosaga
		["FireSmokeModifierDuration"] = 20, -- ennyi ideig ervenyes a loves/tuz/fust okozta szorzo
	}, --DayTime

	["WeatherReconModifiers"] = -- latasi viszonyokhoz rendelt recon szorzok
	{
		["Default"] = 1,
		["Clear"] = 1, -- tiszta ido
		["Misty"] = 0.8, -- paras
		["Rainy"] = 0.6, -- esos
		["Foggy"] = 0.5, -- kodos
	}, --WeatherReconModifiers

	["WarningScrollSpeeds"] =
	{
		["actual"] = 0.001,
		["history"] = 0.0002,
	}, --WarningScrollSpeeds

	["WeaponSystems"] =
	{
		-- ennyi idonkent gondolkodik a weapondirector
		["WeaponDirectorThinkTime"] = 2, 

		-- ennyi idonkent ellenorzik az agyuk, hogy az adott iranyba lohetnek-e ugy, hogy nem talalunk el barati egyseget vagy terraint
		["SafeToFireCacheTimeOut"] = 2,
	}, --WeaponSystems

	["LineOfSight"] =
	{
		-- idozitok, hogy ne minden frameben legyen minden unitra kiszamolva, hogy latszik-e vagy sem
		["VisibleTimeOut"]   = 5, -- ha egy unitot lekerdezeskor epp latunk, ennyi ideig ugy tekintjuk hogy latjuk. utana lesz csak a kovetkezo ellenorzes
		["InvisibleTimeOut"] = 4, -- ha egy unitot lekerdezeskor epp NEM latunk, ennyi ideig ugy tekintjuk hogy tovabbra se nem latjuk. utana lesz csak a kovetkezo ellenorzes
		
		-- lathatosagi vizsgalat parameterei. Azt kell eldonteni, hogy A entity latja-e B entityt, van-e koztuk valami akadaly, ami miatt nem lathatja.
		-- a lathatosagi vizsgalat ket pont kozott zajlik, es azt vizsgalja, hogy a ket pontot osszekoto szakasz utkozik-e a landscapeval, vagy sem.
		-- Entity (pl egy hajo) eseten a vizsgalt pont az entity kozepe, de az Y koordinata (a magassag) nem az entity kozepenek a magassaga, 
		-- hanem az entity modelljet befoglalo bounding box tetejenek a magassaga. Azaz nagyjabol a modell legmagasabb pontjanak magassaga.
		-- Ehez a magassag ertekhez aztan meg hozzaadodik valamennyi, a kovetkezo parameterektol fuggoen, es attol, hogy ez az entity az, aki nez (viewer), vagy az, akit neznek (target).
		-- a modositott magassagu ket pontot nezzuk, hogy latjak-e egymast, vagy sem.
		["TargetHeightMul"] = 0.0, -- a nezett pont magassagahoz hozzaadodik az entity magassaga (bounding box magassaga) szorozva ennyivel. Ha ez a szorzat kisebb, mint TargetHeightAdd, akkor annyi meter adodik hozza
		["TargetHeightAdd"] = 5.0, -- a nezett pont magassagahoz hozzaadodik legalabb ennyi meter
		["ViewerHeightAdd"] = 0.0, -- a nezo pont magassagahoz hozzaadodik az entity magassaga (bounding box magassaga) szorozva ennyivel. Ha ez a szorzat kisebb, mint ViewerHeightAdd, akkor annyi meter adodik hozza
		["ViewerHeightAdd"] = 5.0, -- a nezett pont magassagahoz hozzaadodik legalabb ennyi meter
	}, -- LineOfSight

	["KillReasonMessages"] =
	{
		["harm"]     = "ingame.kr_harm",
		["soft"]     = "ingame.kr_soft",
		["exited"]   = "ingame.kr_exited",
		["landed"]   = "ingame.kr_landed",
		["captured"] = "ingame.kr_captured",
		["sold"] = "ingame.kr_sold",
		["other"]    = "ingame.kr_soft",
	},

	["BlackoutDefaultTime"] = 1,

	["TargetMarkers"] =
	{
		["MarkTargetsRadius"] = 0.05,
		["NormalSizeDist"] = 500,
		["MinIconZoom"] = 0.5,
		["MaxIconZoom"] = 0.8,
	},

	["FOVs"] = -- degrees
	{
		["Ship"] = 30,
		["Plane"] = 40,
	},

	["UnitSellTime"] = 30,
	["UnitSellTimeSingle"] = 5,
	
	["MapUnitColors"] =
	{
		["us"] = { 90, 200, 250, 255 },
		["usAI"] = { 4, 87, 128, 255 },
		["jap"] = { 240, 50, 50, 255 },
		["japAI"] = { 90, 10, 10, 255 },
		["neutral"] = { 165, 190, 189, 255 },
		["selected"] = { 243, 204, 84, 255 },
		["target"] = { 200, 200, 200, 255 },
		["usTarget"] = { 0, 101, 151, 255 },
		["japTarget"] = { 156, 33, 3, 255 },
		["dead"] = { 53, 53, 53, 255 },
	},
	["MapMarkerColors"] =
	{
		[0] = { 190, 176, 151, 255 }, -- leader
		[1] = { 209, 159, 73, 255 }, -- primary objective
		[2] = { 128, 143, 188, 255 }, -- secondary objective
		[3] = { 252, 170, 30, 255 }, -- ping
		[4] = { 252, 170, 30, 255 }, -- ping attack
		[5] = { 252, 170, 30, 255 }, -- ping defend
	},
	["ChatColors"] =
	{
		[0] = { 255, 255, 255, 255 }, -- global chat
		[1] = { 192, 255, 192, 255 }, -- party chat
		[2] = { 185, 185, 185, 255 }, -- slot change: join, leave, swap slot
		[3] = { 235, 199, 139, 255 }, -- positive: eg. command building captured
		[4] = { 200, 226, 255, 255 }, -- neutral: eg. ping
		[5] = { 253, 144, 48, 255 }, -- negative: eg. unit lost
		[6] = { 185, 185, 185, 255 }, -- swap slot
		[7] = { 185, 185, 185, 255 }, -- join
		[8] = { 185, 185, 185, 255 }, -- leave
		[9] = { 185, 185, 185, 255 }, -- surrend
		[10]= { 185, 185, 185, 255 }, -- not surrend
	},

	["ObjectiveSounds"]=
	{
		"sound/environment/environment_objective_add.fsb",
		"sound/environment/environment_objective_completed.fsb",
		"sound/environment/environment_objective_fail.fsb",
	},

	["MapZoomTime"] = 0.25,
	["MapGlobalScale"] = 0.7,
	["SpawnAttemptDelay"] = 0.5,
	["SpawnPlaneDelayRange"] = 150,
	["SpawnPlaneDelayDistance"] = 200,
}
