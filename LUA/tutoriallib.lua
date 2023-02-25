TutorialLib =
{
	{
		["GroupName"] = "FE.tutoriallib_category_01",
		{	
			["Index"] = 1,
			["Name"] = "FE.tutoriallib_01_title",
			["Movie"] = "tutorial_01",
			["Description"] = 
				"FE.tutoriallib_01",
			    --"The numbered panels are:",
                --"1 - Own unit information",
                --"2 - Minimap",
				--"3 - Active Target information",
				--"With the d-pad left and right you can switch anytime between your squads and units." 
				--},
			["LuaCommand"] = "luaSetNarrativeParam(IC_SEL_PREV_ITEM);luaSetNarrativeParam(IC_SEL_NEXT_ITEM,2)",
				
		},
		{	
			-------Target Selection-------------------
			["Index"] = 2,
			["Name"] = "FE.tutoriallib_02_title",
			["Movie"] = "tutorial_02",
			["Description"] = 
				"FE.tutoriallib_02",
				--"You can clear a target at any time by pressing the B button.",
				--"You can also press the A button to cycle targets between all detected enemy units. Every time you press the A button, you will select the next-nearest target.",
				--"If you have set an Active Target and aim on a different enemy unit then another target information panel pops up above the first only to stay active while you maintain your aim.",
				--},
			["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_SETTARGET);luaSetNarrativeParam(IC_CMD_CLEARTARGET,2)",
		},
		{	
			-------Orders Panel-------------------
			["Index"] = 3,
			["Name"] = "FE.tutoriallib_03_title",
			["Movie"] = "tutorial_03",
			["Description"] =
				"FE.tutoriallib_03", 
				--"Note that you have different options for the different types of units. These will be explained later on in each unit type's Orders section.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_OVERLAY_BLUE)",
		},
		{	
			-------Support Manager-------------------
			["Index"] = 4,
			["Name"] = "FE.tutoriallib_04_title",
			["Movie"] = "tutorial_04",
			["Description"] =
				"FE.tutoriallib_04", 
				--"Especially important in multiplayer mode as through this menu will you spawn your units.",
				--"For a detailed description check the videos in the support manager and multiplayer sections."
 				--},
		},
	},
	{
		----------------Ship Basics------------------------------
		["GroupName"] = "FE.tutoriallib_category_02",
		{	
			-------Cruising and Firing-------------------
			["Index"] = 5,
			["Name"] = "FE.tutoriallib_05_title",
			["Movie"] = "tutorial_05",
			["Description"] =
				"FE.tutoriallib_05", 
				--"Use the 'rudder controls' to steer the ship. Once set you're ship will continue turning until you straighten it. You can look and aim your weapons in a different direction from the one you're travelling.",
				--"Use the 'Camera Stick' to do so. To change weapons push 'Next weapon'. The different weapons have different crosshairs and a  text read-out tells you what weapon you have just selected. You can fire with the 'Fire Button'.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SHIP_THRUST,nil,true);luaSetNarrativeParam(IC_SHIP_THRUST,2);luaSetNarrativeParam(IC_SHIP_STEER,3,true);luaSetNarrativeParam(IC_SHIP_STEER,4);luaSetNarrativeParam(IC_GUNC_CHANGE,5,true);luaSetNarrativeParam(IC_GUNC_CHANGE,6);luaSetNarrativeParam(IC_GUN_FIRE,7)",
		},
		{	
			-------Binoculars-------------------
			["Index"] = 6,
			["Name"] = "FE.tutoriallib_06_title",
			["Movie"] = "tutorial_06",
			["Description"] = 
				"FE.tutoriallib_06", 
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_PC_TRICK)",
		},
		{	
			-------Weapon System information-------------------
			["Index"] = 7,
			["Name"] = "FE.tutoriallib_07_title",
			["Movie"] = "tutorial_07",
			["Description"] = 
				"FE.tutoriallib_07", 
				--"A yellow light means the turret can see the target but is still turning to aim. A green light means the turret is ready to fire. A flashing red light indicates reloading.",
				--},
		},
	},
	{
		----------------Ship Weapon Systems------------------------------
		["GroupName"] = "FE.tutoriallib_category_03",
		{	
			-------AA/Flak-------------------
			["Index"] = 8,
			["Name"] = "FE.tutoriallib_08_title",
			["Movie"] = "tutorial_08",
			["Description"] = 
				"FE.tutoriallib_08", 
				--"When you pull the trigger every gun that can see the cross-hair will fire.",
				--},
		},
		{	
			-------Artillery-------------------
			["Index"] = 9,
			["Name"] = "FE.tutoriallib_09_title",
			["Movie"] = "tutorial_09",
			["Description"] = 
				"FE.tutoriallib_09", 
				--"One being manual and the other automatic. For manual you should aim at a spot on the surface where you think the target will be upon impact.",
				--"To trigger the automatic targeting system you should simply aim on a ship's hull. Based on unit types artillery can have different firing range.",
				--},
		},
		{	
			-------Torpedo-------------------
			["Index"] = 10,
			["Name"] = "FE.tutoriallib_10_title",
			["Movie"] = "tutorial_10",
			["Description"] = 
				"FE.tutoriallib_10", 
				--"Fired irrelevant of weapon elevation they travel underwater and hit below the waterline.",
				--"To make things harder for your enemy you should fire them in a spread.",
				--},
		},
		{	
			-------Depth Charge-------------------
			["Index"] = 11,
			["Name"] = "FE.tutoriallib_11_title",
			["Movie"] = "tutorial_11",
			["Description"] = 
				"FE.tutoriallib_11", 
				--"When you drop depth charges you switch to a special camera which you can rotate with the 'Camera Stick' while retaining you're ability to control your ship with the 'Move Stick'.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SHIP_THRUST,nil,true);luaSetNarrativeParam(IC_SHIP_THRUST,2);luaSetNarrativeParam(IC_SHIP_STEER,3,true);luaSetNarrativeParam(IC_SHIP_STEER,4)",
		},
		{	
			-------Hedgehog-------------------
			["Index"] = 12,
			["Name"] = "FE.tutoriallib_12_title",
			["Movie"] = "tutorial_12",
			["Description"] = 
				"FE.tutoriallib_12", 
				--"However different to the K-Gun, you won't swich to the underwater camera and as it is positioned on the front your ship you're only able to fire within a limited angle.",
				--},
		},
		{	
			-------Rockets-------------------
			["Index"] = 13,
			["Name"] = "FE.tutoriallib_13_title",
			["Movie"] = "tutorial_13",
			["Description"] =
				"FE.tutoriallib_13", 
				--"Much like artillery you can fire these rockets only at surface targets.",				},
		},
		{	
			-------Plane Launch-------------------
			["Index"] = 14,
			["Name"] = "FE.tutoriallib_14_title",
			["Movie"] = "tutorial_14",
			["Description"] = 
				"FE.tutoriallib_14", 
				--"Use them to further your recon.",	},
			["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT)",
		},
		{	
			-------Kamikaze-------------------
			["Index"] = 15,
			["Name"] = "FE.tutoriallib_15_title",
			["Movie"] = "tutorial_15",
			["Description"] =
				"FE.tutoriallib_15", 
				--"To fulfill their only purpose drive these extremely fragile vessels into an enemy ships hull.",		},
		},
	},	
	{
		----------------Ship Repair------------------------------
		["GroupName"] = "FE.tutoriallib_category_04",
		{	
			-------Setting Repair-------------------
			["Index"] = 16,
			["Name"] = "FE.tutoriallib_16_title",
			["Movie"] = "tutorial_16",
			["Description"] = 
				"FE.tutoriallib_16", 
				--"Experiencing this you should enter the repair menu ('press and hold the Left Stick') and take immediate counter-measures.",
				--"You can set your repair team with the 'Left Stick' to:",
				--"* Water Repair (North)   * Armament Repair (West)    * Device Failure Repair (South)    * Fire Fighting (East)",
				--"* Not moving the stick lets you select Body Repair, a general repair slowly filling your ships health bar back to the maximum.",
				--"On the menu you see the actually selected repair type  as well as the active failures. A flashing icon indicates  a very recent failure.",
				--"Responding to this with the correct action results in a reflex bonus meaning your team will repair things faster.",		},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_OVERLAY_BLUE);luaSetNarrativeParam(IC_OVERLAY_V,2,true);luaSetNarrativeParam(IC_OVERLAY_V,3);luaSetNarrativeParam(IC_OVERLAY_H,4,true);luaSetNarrativeParam(IC_OVERLAY_H,5)",
		},
		{	
			-------Fire damage-------------------
			["Index"] = 17,
			["Name"] = "FE.tutoriallib_17_title",
			["Movie"] = "tutorial_17",
			["Description"] = 
				"FE.tutoriallib_17", 
				--"To minimalize the chances of further failures set your team to Fire Fighting. This also means your ship will lose less health than otherwise.",
				--},
		},
		{	
			-------Water damage-------------------
			["Index"] = 18,
			["Name"] = "FE.tutoriallib_18_title",
			["Movie"] = "tutorial_18",
			["Description"] = 
				"FE.tutoriallib_18", 
				--"Setting your team to pumping the ship will lose less health.",
				--},
		},
		{	
			-------Device Failure-------------------
			["Index"] = 19,
			["Name"] = "FE.tutoriallib_19_title",
			["Movie"] = "tutorial_19",
			["Description"] =
				"FE.tutoriallib_19", 
				--"* Engine Failure: the ship stops and can't move until repaired.",
				--"* Steering Jam: the ships rudder gets locked in whatever position it is at the moment. For the time of the failure you won't be able to steer the ship.",
				--"* Runway Failure: the carrier can not send up any planes while having this failure.",
				--},
		},
		{	
			-------Armament Failure-------------------
			["Index"] = 20,
			["Name"] = "FE.tutoriallib_20_title",
			["Movie"] = "tutorial_20",
			["Description"] =
				"FE.tutoriallib_20", 
				--"The more black dots you have the more ineffective you will get in a battle. Don't forget to set your team to Armament Repair.",				},
		},
	},	
	{
		----------------Plane Basics------------------------------
		["GroupName"] = "FE.tutoriallib_category_05",
		{	
			-------Flying-------------------
			["Index"] = 21,
			["Name"] = "FE.tutoriallib_21_title",
			["Movie"] = "tutorial_21",
			["Description"] =
				"FE.tutoriallib_21",
				--"Moving the right stick left/right activates the rudder, which can be used to make gentle turns. This greatly helps when aiming at a target.",
				--"You can get a temporary increase in speed while you hold the 'Turbo button'. However allow it some time to recharge after excessive use.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_YAW,nil,true);luaSetNarrativeParam(IC_PLANE_YAW,2);luaSetNarrativeParam(IC_PLANE_TURBO,3)",
		},
		{	
			-------View modes-------------------
			["Index"] = 22,
			["Name"] = "FE.tutoriallib_22_title",
			["Movie"] = "tutorial_22",
			["Description"] = 
				"FE.tutoriallib_22", 
				--"With the 'Lookaround' action you can achieve 360 awereness. To access it press and hold the 'Lookaround button' while moving the 'left stick'.",
				--"When in a cockpit you can use it to turn your head around and look left/right outside the window.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH);luaSetNarrativeParam(IC_PLANE_LOOKMODE,2)",
		},
		{	
			-------Releasing payload-------------------
			["Index"] = 23,
			["Name"] = "FE.tutoriallib_23_title",
			["Movie"] = "tutorial_23",
			["Description"] = 
				"FE.tutoriallib_23", 
				--"When the reticule is pointing at the target, press 'Use Weapon' to release your bombs.",
				--},
			["LuaCommand"] = "luaSetNarrativeParam(IC_PLANE_BOMBSWITCH);luaSetNarrativeParam(IC_PLANE_BOMBFIRE,2)",
		},
		{	
			-------Landing-------------------
			["Index"] = 24,
			["Name"] = "FE.tutoriallib_24_title",
			["Movie"] = "tutorial_24",
			["Description"] = 
				"FE.tutoriallib_24", 
				--"Similarly you should land on airfields from their end.",
				--},
		},
	},	
	{
		----------------Plane Weapon Systems------------------------------
		["GroupName"] = "FE.tutoriallib_category_06",
		{	
			-------Machine Gun-------------------
			["Index"] = 25,
			["Name"] = "FE.tutoriallib_25_title",
			["Movie"] = "tutorial_25",
			["Description"] = 
				"FE.tutoriallib_25", 
				--"but also has a limited potencial for strafing light armoured ships and land based installations. ",
			--},
		},
		{	
			-------Divebomb-------------------
			["Index"] = 26,
			["Name"] = "FE.tutoriallib_26_title",
			["Movie"] = "tutorial_26",
			["Description"] = 
				"FE.tutoriallib_26", 
				--"This makes them particularily useful against moving targets, such as ships. Try to get as close as you can to the target, as this will maximize your chances of a hit.",
				--},
		},
		{	
			-------Torpedobomb-------------------
			["Index"] = 27,
			["Name"] = "FE.tutoriallib_27_title",
			["Movie"] = "tutorial_27",
			["Description"] = 
				"FE.tutoriallib_27", 
				--"Otherwise they will detonate when they hit the water. Against submarines there is a special torpedo called Fido available on the US side. After drop it is able to follow the submarine even through depth level differences.",
				--},
		},
		{	
			-------Levelbomb-------------------
			["Index"] = 28,
			["Name"] = "FE.tutoriallib_28_title",
			["Movie"] = "tutorial_28",
			["Description"] = 
				"FE.tutoriallib_28", 
				--"This is a technique called carpet-bombing, which maximizes the chance of a hit.",	},
		},
		{	
			-------Depth Charge-------------------
			["Index"] = 29,
			["Name"] = "FE.tutoriallib_29_title",
			["Movie"] = "tutorial_29",
			["Description"] = 
				"FE.tutoriallib_29", 
				--"Try to release the charges as close as you can to your target.",			},
		},
		{	
			-------Rockets-------------------
			["Index"] = 30,
			["Name"] = "FE.tutoriallib_30_title",
			["Movie"] = "tutorial_30",
			["Description"] = 
				"FE.tutoriallib_30", 
				--"Japanese planes equip 'air-to-air' rockets to take down enemy planes.",
				--"US planes mount 'air-to-ground' rockets to be more effective when attacking land targets.",
				--"And there is Tiny Tim. A huge rocket carried by a US torpedobomber to be used against surface targets, mainly ships. Its great advantage is that you can launch it outside AA range.",
				--},
		},
		{	
			-------Gunner Role-------------------
			["Index"] = 31,
			["Name"] = "FE.tutoriallib_31_title",
			["Movie"] = "tutorial_31",
			["Description"] = 
				"FE.tutoriallib_31", 
				--"If you enter AA mode on these planes ('AA mode button') you get a camera that you can control around to aim with your turrets.",
				--"Main controls stay active, so you can set your speed, gain or lose altitude and roll.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_ROLE_SWITCH)",
		},
		{	
			-------Kamikaze-------------------
			["Index"] = 32,
			["Name"] = "FE.tutoriallib_32_title",
			["Movie"] = "tutorial_32",
			["Description"] = 
				"FE.tutoriallib_32", 
				--"Those planes will do great damage upon impact.",			},
		},
		{	
			-------Ohka-------------------
			["Index"] = 33,
			["Name"] = "FE.tutoriallib_33_title",
			["Movie"] = "tutorial_33",
			["Description"] = 
				"FE.tutoriallib_33", 
				--"Upon and after release you can switch into an Ohka and take its control. Controls are like plane controls with the difference of igniting rocket engine.",
				--"You can do that with the 'Turbo button', and accelerate to a great speed that helps you avoid AA fire.",
				--"However your manouvering abilities highly diminish, so make sure you got your target right.",
				--"For you to control Ohka's are only available in multiplayer mode.",				},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_PLANE_TURBO)",
		},
	},	
	{
		----------------Submarine Basics------------------------------
		["GroupName"] = "FE.tutoriallib_category_07",
		{	
			-------Basic Controls-------------------
			["Index"] = 34,
			["Name"] = "FE.tutoriallib_34_title",
			["Movie"] = "tutorial_34",
			["Description"] = 
				"FE.tutoriallib_34", 
				--"Press the up/down on the d-pad to set the desired Depth Level on the Indicator.",
				--"Setting speed and direction is no different from that of the ships, with speed and rudder controls on the 'MoveStick' and aim controls on the 'Camerastick'.",
				--"You also get a periscope which you can activate with the 'Periscope button' at periscope depth.",			},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_SUB_RISE);luaSetNarrativeParam(IC_SUB_DIP,2);luaSetNarrativeParam(IC_SHIP_THRUST,3,true);luaSetNarrativeParam(IC_SHIP_THRUST,4);luaSetNarrativeParam(IC_SHIP_STEER,5,true);luaSetNarrativeParam(IC_SHIP_STEER,6);luaSetNarrativeParam(IC_ZOOM_PC_TRICK,7)",
		},
		{	
			-------Depth Levels-------------------
			["Index"] = 35,
			["Name"] = "FE.tutoriallib_35_title",
			["Movie"] = "tutorial_35",
			["Description"] = 
				"FE.tutoriallib_35", 
				--"At periscope depth you can raise your periscope (button), which is used to aim torpedoes and observe your surroundings, and according to your aim fire torpedos from the forward or rear torpedo tubes.",
				--"Once you are deeper than periscope level, you cannot use your periscope, and you cannot fire torpedoes. Depth Level 3 is useful for skulking around, making it harder for units to hit you with depth charges. ",
				--"The lowest depth level is below safe level of operation. Stay down there too long, and your hull will implode. The good thing, though, is that at this level you become invisible to sonar, giving you a chance to escape from enemy detection.",
				--"Be careful, though, it’s a risky tactic.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_ZOOM_PC_TRICK)",
		},
		{	
			-------Damage-------------------
			["Index"] = 36,
			["Name"] = "FE.tutoriallib_36_title",
			["Movie"] = "tutorial_36",
			["Description"] = 
				"FE.tutoriallib_36", 
				--"In addition there's a possibility to break your periscope, so watch out while manouvering under ships.",
				--"Breaking your periscope you should set Device Failure Repair in the Repair menu.",
				--},
		},
		{	
			-------Air Supply-------------------
			["Index"] = 37,
			["Name"] = "FE.tutoriallib_37_title",
			["Movie"] = "tutorial_37",
			["Description"] = 
				"FE.tutoriallib_37", 
				--"If you're air supply reaches a critical limit your submarine will automatically come to the surface.",
				--},
		},
	},
	{
		----------------Submarine Weapon Systems------------------------------
		["GroupName"] = "FE.tutoriallib_category_08",
		{	
			-------AA/Flak-------------------
			["Index"] = 38,
			["Name"] = "FE.tutoriallib_38_title",
			["Movie"] = "tutorial_38",
			["Description"] = 
				"FE.tutoriallib_38", 
				--"However don't rely on it too much, rather avoid direct surface contact with the enemy.",
				--},
		},
		{	
			-------Artillery-------------------
			["Index"] = 39,
			["Name"] = "FE.tutoriallib_39_title",
			["Movie"] = "tutorial_39",
			["Description"] = 
				"FE.tutoriallib_39", 
				--"On rare occasions could it to be useful and only against very lightly armoured enemies.",
				--},
		},
		{	
			-------Torpedo-------------------
			["Index"] = 40,
			["Name"] = "FE.tutoriallib_40_title",
			["Movie"] = "tutorial_40",
			["Description"] = 
				"FE.tutoriallib_40", 
				--"Note that there are submarines with front and rear torpedo tubes and only the tubes in the direction you aim will fire.",
				--"If you want to command the other end to fire you have to change your aim accordingly.",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks()",
		},
		{	
			-------Plane Launch-------------------
			["Index"] = 42,
			["Name"] = "FE.tutoriallib_42_title",
			["Movie"] = "tutorial_42",
			["Description"] = 
				"FE.tutoriallib_42", 
				--"You can launch them only when you are surfaced.",
				--},
			["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT)",
		},
		{	
			-------Kaiten Launch-------------------
			["Index"] = 43,
			["Name"] = "FE.tutoriallib_43_title",
			["Movie"] = "tutorial_43",
			["Description"] = 
				"FE.tutoriallib_43", 
				--"Practically these are man controlled torpedos, a sort of kamikaze.",
				--"Only available in Multiplayer and Skirmish mode and only on the Japanese side.",				},
			["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT)",
		},
	},	
	{
		----------------Tactical Map------------------------------
		["GroupName"] = "FE.tutoriallib_category_09",
		{	
			-------Basics-------------------
			["Index"] = 44,
			["Name"] = "FE.tutoriallib_44_title",
			["Movie"] = "tutorial_44",
			["Description"] = 
				"FE.tutoriallib_44", 
				--"Your currently selected unit is highlighted in yellow. You can move around the cursor with the 'Left stick' and zoom in on the map by pulling the right trigger. To zoom back out, pull the left trigger.",
				--"When the map is at maximum zoom, extra detail is revealed, such as land fortifications and individual squadron members.",
				--"At the intermediate level, you can still see individual ships, but plane squadron members and land units become hidden.",
				--"At the highest level of zoom, all that is shown is the flagship or squadron leader for each unit formation.",
				--"Apart from keeping the main game screen's information panels the map shows you the status of your various objectives. A grey number means the objective is still active.",
				--"A green number means an objective has been completed, while a red one means it has failed.",
				--"To review a mission’s objectives, press LB to enter Objective mode. When you are in Objective mode, you can cycle through your objectives by using the directional pad or the A button.",
				--"To exit objective mode, press either LB or B button",
				--},
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_MAP_TOGGLE);luaSetNarrativeParam(IC_MAP_ZOOM,2,true);luaSetNarrativeParam(IC_MAP_ZOOM,3);luaSetNarrativeParam(IC_MAP_OBJECTIVES,4);luaSetNarrativeParam(IC_MENU_LEFT,5);luaSetNarrativeParam(IC_MENU_RIGHT,6);luaSetNarrativeParam(IC_MENU_BACK,7);luaSetNarrativeParam(IC_MAP_FILTER,8)",
		},
		{	
			-------Selection and issuing Orders-------------------
			["Index"] = 45,
			["Name"] = "FE.tutoriallib_45_title",
			["Movie"] = "tutorial_45",
			["Description"] = 
				"FE.tutoriallib_45", 
				--"To select a unit position the cursor over it and press Y button. Note that you retain your ability to switch units in the usual way with the d-pad.",
				--"You can also use the crosshair to issue orders to your currently selected unit.",
				--"Pressing the A button will tell it to move to a designated point, but if you press it on an enemy unit then your unit will move to attack the target.",
				--"Targeting a friendly means your unit will follow that unit: planes will circle above ships and two ships will get into a formation.",
				--"If you want to cancel a move or attack order at any time, simply press the B button. ",
				--},
			["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_MAP_JUMPIN);luaSetNarrativeParam(IC_CMD_MAP_TARGET,2);luaSetNarrativeParam(IC_CMD_MAP_CLEARTARGET,3)",
		},
		{	
			-------Stackable commands-------------------
			["Index"] = 46,
			["Name"] = "FE.tutoriallib_46_title",
			["Movie"] = "tutorial_46",
			["Description"] = 
				"FE.tutoriallib_46", 
			["LuaCommand"] = "luaSetNarrativeParam(IC_CMD_MAP_TARGET);luaSetNarrativeParam(IC_CMD_MAP_CLEARTARGET,2)",
		},
		{	
			-------reconnaisance-------------------
			["Index"] = 47,
			["Name"] = "FE.tutoriallib_47_title",
			["Movie"] = "tutorial_47",
			["Description"] = 
				"FE.tutoriallib_47", 
				--"The darker coloured area is the Radar detection area. Units detected by radar are displayed as ‘unknown’, that is because all that is known about them is their position and basic type.",
				--"Finally, the green area is the sonar area. Sonar is the only method of detecting a submerged submarine.",
				--},
		},
		
	},
	{
		----------------Orders------------------------------
		["GroupName"] = "FE.tutoriallib_category_10",
		{	
			-------Basics-------------------
			["Index"] = 48,
			["Name"] = "FE.tutoriallib_48_title",
			["Movie"] = "tutorial_48",
			["Description"] = 
				"FE.tutoriallib_48", 
		},
		{	
			-------Ship Orders-------------------
			["Index"] = 49,
			["Name"] = "FE.tutoriallib_49_title",
			["Movie"] = "tutorial_49",
			["Description"] = 
				"FE.tutoriallib_49", 
		},
		{	
			-------Formation Screen-------------------
			["Index"] = 50,
			["Name"] = "FE.tutoriallib_50_title",
			["Movie"] = "tutorial_50",
			["Description"] = 
				"FE.tutoriallib_50", 
			["LuaCommand"] = "luaSetNarrativeSticks();luaSetNarrativeParam(IC_CMD_MAP_JOIN);luaSetNarrativeParam(IC_FORM_PREV,2);luaSetNarrativeParam(IC_FORM_NEXT,3)",
		},
		{	
			-------Submarine Orders-------------------
			["Index"] = 51,
			["Name"] = "FE.tutoriallib_51_title",
			["Movie"] = "tutorial_51",
			["Description"] = 
				"FE.tutoriallib_51", 
		},
		
	},
	{
		----------------Support Manager------------------------------
		["GroupName"] = "FE.tutoriallib_category_11",
		{	
			-------Panels-------------------
			["Index"] = 52,
			["Name"] = "FE.tutoriallib_52_title",
			["Movie"] = "tutorial_52",
			["Description"] = "FE.tutoriallib_52",
			["LuaCommand"] = "luaSetNarrativeParam(IC_SM_SECONDARY);luaSetNarrativeParam(IC_MENU_UP,2);luaSetNarrativeParam(IC_MENU_DOWN,3);luaSetNarrativeParam(IC_SM_ATTACK,4);luaSetNarrativeParam(IC_SM_CHANGE_WEAPON,5)",
		},
		{	
			-------Unit Setup-------------------
			["Index"] = 53,
			["Name"] = "FE.tutoriallib_53_title",
			["Movie"] = "tutorial_53",
			["Description"] = "FE.tutoriallib_53",
			["LuaCommand"] = "luaSetNarrativeParam(IC_MENU_UP);luaSetNarrativeParam(IC_MENU_DOWN,2);luaSetNarrativeParam(IC_SM_ATTACK,3);luaSetNarrativeParam(IC_SM_CHANGE_WEAPON,4)",
		},	
	},
	{
		----------------Amphibious Attack------------------------------
		["GroupName"] = "FE.tutoriallib_category_12",
		{	
			-------Capturing an island-------------------
			["Index"] = 54,
			["Name"] = "FE.tutoriallib_54_title",
			["Movie"] = "tutorial_54",
			["Description"] = "FE.tutoriallib_54",
			["LuaCommand"] = "luaSetNarrativeParam(IC_SHIP_LAUNCHUNIT)",
		},
		{	
			-------Capturing value-------------------
			["Index"] = 55,
			["Name"] = "FE.tutoriallib_55_title",
			["Movie"] = "tutorial_55",
			["Description"] = "FE.tutoriallib_55",
		},	
		{	
			-------Base defence-------------------
			["Index"] = 56,
			["Name"] = "FE.tutoriallib_56_title",
			["Movie"] = "tutorial_56",
			["Description"] = "FE.tutoriallib_56",
		},	
	},
	{
		----------------Multiplayer------------------------------
		["GroupName"] = "FE.tutoriallib_category_13",
		{	
			-------Resource system-------------------
			["Index"] = 57,
			["Name"] = "FE.tutoriallib_57_title",
			["Movie"] = "tutorial_57",
			["Description"] = "FE.tutoriallib_57",
		},
		{	
			-------Paratrooper attack-------------------
			["Index"] = 58,
			["Name"] = "FE.tutoriallib_58_title",
			["Movie"] = "tutorial_58",
			["Description"] = "FE.tutoriallib_58",
		},	
		{	
			-------power-ups-------------------
			["Index"] = 59,
			["Name"] = "FE.tutoriallib_59_title",
			["Movie"] = "tutorial_59",
			["Description"] = "FE.tutoriallib_59",
			["LuaCommand"] = "luaSetNarrativeParam(IC_POWERUPS_TOGGLE);luaSetNarrativeParam(IC_MENU_UP,2);luaSetNarrativeParam(IC_MENU_DOWN,3);luaSetNarrativeParam(IC_MENU_SELECT,4)",
		},	
	},
}

		
