// Created by Vlad2D and Binslev and Rapora9
// Game Version 1.3.3
// ASL last updated 28-12-2024 (DD-MM-YYYY)

state("FCPrimal")
{
	int missionchain : "FCPrimal.exe", 0x0325BA58, 0x110, 0x18;
	int DarwaFort : "FCPrimal.exe", 0x0325BA58, 0x110, 0x450;
	int FireScreamer : "FCPrimal.exe", 0x0325BA58, 0x110, 0x480;
	int Outpost : "FCPrimal.exe", 0x0325BA58, 0x110, 0x60;
	int Bonfire : "FCPrimal.exe", 0x0325BA58, 0x110, 0x318;
	int SpiritTotem : "FCPrimal.exe", 0x0325BA58, 0x110, 0x510;
	int CavePaintings : "FCPrimal.exe", 0x0325BA58, 0x110, 0x570;
	int WenjaBracelet : "FCPrimal.exe", 0x0325BA58, 0x110, 0x528;
	int IzilaMask : "FCPrimal.exe", 0x0325BA58, 0x110, 0x540;
	int DayshaHand : "FCPrimal.exe", 0x0325BA58, 0x110, 0x558;
	int Loading : "FCPrimal.exe", 0x03254248, 0x8, 0x48, 0x678, 0x40, 0x0, 0x18, 0x5C4;
	int SlowMotion : "FCPrimal.exe", 0x03286570, 0x30, 0x58, 0x50, 0x18, 0x68, 0xB8;
	float PosX : "FCPrimal.exe", 0x032684B8, 0x8, 0x38, 0x10, 0x0;
	float PosY : "FCPrimal.exe", 0x03223F88, 0x1C;
	//int Start : "FCPrimal.exe", 0x0325E500, 0x34; not needed as of now
	//int End : "FCPrimal.exe", 0x03265230, 0x170; not needed as of now
}


startup
{
	// A value to keep track of missions.
	vars.CompletedMissions = new HashSet<int>();
    
    	{
    	// Loads Settings.xml into Livesplit using "asl-help".
        	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
        	vars.Helper.GameName = "Far Cry: Primal";
        	vars.Helper.Settings.CreateFromXml("Components/FCPrimal.Settings.xml");
    	}

    	{
    	// Asks user to change to game time if LiveSplit is currently set to real time.
	    	vars.Helper.AlertLoadless();
    	}
}


init
{
	// Pauses the timer if the game closes or crashes.
    	timer.IsGameTimePaused = false;
    	game.Exited += (s, e) => timer.IsGameTimePaused = true;
}


onStart
{
	vars.CompletedMissions.Clear();
}


start
{
	// Auto-starts the timer when player moves from run starting position at intro or cave.

	// positions
	float introX = 3950.75f;
	float introY = -4722.419f;
	float caveX = -3294.163f;
	float caveY = 160.004f;
	//float introX2 = 3950.71f; not needed as of now
	//float introY2 = -4722.306f; not needed as of now

	// is player on the exact starting position
	bool isAtIntro = Math.Abs(old.PosX - introX) < 0.01f && Math.Abs(old.PosY - introY) < 0.01f;
	bool isAtCave = Math.Abs(old.PosX - caveX) < 0.01f && Math.Abs(old.PosY - caveY) < 0.01f;

	return
		current.Loading == 0 && (isAtIntro || isAtCave) && (current.PosX != old.PosX || current.PosY != old.PosY) && current.PosY != 0;
}


split
{
	return
	    	current.missionchain == old.missionchain + 1
	        && current.missionchain > 0 && old.missionchain < 59
	        && settings["mission" + current.missionchain] && vars.CompletedMissions.Add(current.missionchain)
	    || old.DarwaFort == 0 && current.DarwaFort == 1
	        && settings["DarwaFort"] && current.Loading == 0
	    || old.FireScreamer == 0 && current.FireScreamer == 1
	        && settings["FireScreamer"] && current.Loading == 0
	    || current.Outpost == old.Outpost + 1
	        && current.Outpost > 0 && old.Outpost < 15
	        && settings["outpost" + current.Outpost] && current.Loading == 0
	    || current.Bonfire == old.Bonfire + 1
	        && current.Bonfire > 0 && old.Bonfire < 16
	        && settings["bonfire" + current.Bonfire] && current.Loading == 0
	    || current.SpiritTotem == old.SpiritTotem + 1
	        && current.SpiritTotem > 0 && old.SpiritTotem < 12
	        && settings["SpiritTotem" + current.SpiritTotem] && current.Loading == 0
	    || current.CavePaintings == old.CavePaintings + 1
	        && current.CavePaintings > 0 && old.CavePaintings < 22
	        && settings["CavePaintings" + current.CavePaintings] && current.Loading == 0
	    || current.WenjaBracelet == old.WenjaBracelet + 1
	        && current.WenjaBracelet > 0 && old.WenjaBracelet < 25
	        && settings["WenjaBracelet" + current.WenjaBracelet] && current.Loading == 0
	    || current.IzilaMask == old.IzilaMask + 1
	        && current.IzilaMask > 0 && old.IzilaMask < 25
	        && settings["IzilaMask" + current.IzilaMask] && current.Loading == 0
	    || current.DayshaHand == old.DayshaHand + 1
	        && current.DayshaHand > 0 && old.DayshaHand < 100
	        && settings["DayshaHand" + current.DayshaHand] && current.Loading == 0
	    || current.SlowMotion == 1 && old.SlowMotion == 0
		&& settings["SlowMotion"] && current.Loading == 0;
}


isLoading
{
	return current.Loading != 0;
}

//TODO:
//Try finding Upgrades for village again, maybe messed up something
//Great Beast Hunts
