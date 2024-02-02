//Created by Vlad2D
//Game Version 1.33
//ASL last updated 02-02-2024 (DD-MM-YYYY)

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
    int Start : "FCPrimal.exe", 0x0325E500, 0x34;
    int End : "FCPrimal.exe", 0x03265230, 0x170;
	int Loading : "FCPrimal.exe", 0x03254248, 0x8, 0x48, 0x678, 0x40, 0x0, 0x18, 0x5C4; 
}

startup
{
    {
    // Loads Settings.xml into Livesplit using "asl-help".

        Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
        vars.Helper.GameName = "Far Cry: Primal";
        vars.Helper.Settings.CreateFromXml("Components/FCPrimal.Settings.xml");
    }

// Asks user to change to Real Time if LiveSplit is currently set to Game Time.

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var mbox = MessageBox.Show(
            "Far Cry Primal uses Real Time as timing method.\nWould you like to switch to it?",
            "LiveSplit | Far Cry Primal",
            MessageBoxButtons.YesNo);

        if (mbox == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.RealTime;
    }

	vars.CompletedMissions = new HashSet<int>();
}

onStart
{
	vars.CompletedMissions.Clear();
}

start
{
    return
        current.Start == 0 && old.Start == 1
            && current.Loading == 0 && current.missionchain == 0;
}

split
{
return
    current.missionchain == old.missionchain + 1
        && current.missionchain > 0 && current.missionchain < 59
        && settings["mission" + current.missionchain] && vars.CompletedMissions.Add(current.missionchain)
    || old.DarwaFort == 0 && current.DarwaFort == 1
        && settings["DarwaFort"] && current.Loading == 0
    || old.FireScreamer == 0 && current.FireScreamer == 1
        && settings["FireScreamer"] && current.Loading == 0
    || current.Outpost == old.Outpost + 1
        && current.Outpost > 0 && current.Outpost < 15
        && settings["outpost" + current.Outpost] && current.Loading == 0
    || current.Bonfire == old.Bonfire + 1
        && current.Bonfire > 0 && current.Bonfire < 16
        && settings["bonfire" + current.Bonfire] && current.Loading == 0
    || current.SpiritTotem == old.SpiritTotem + 1
        && current.SpiritTotem > 0 && current.SpiritTotem < 12
        && settings["SpiritTotem" + current.SpiritTotem] && current.Loading == 0
    || current.CavePaintings == old.CavePaintings + 1
        && current.CavePaintings > 0 && current.CavePaintings < 22
        && settings["CavePaintings" + current.CavePaintings] && current.Loading == 0
    || current.WenjaBracelet == old.WenjaBracelet + 1
        && current.WenjaBracelet > 0 && current.WenjaBracelet < 25
        && settings["WenjaBracelet" + current.WenjaBracelet] && current.Loading == 0
    || current.IzilaMask == old.IzilaMask + 1
        && current.IzilaMask > 0 && current.IzilaMask < 25
        && settings["IzilaMask" + current.IzilaMask] && current.Loading == 0
    || current.DayshaHand == old.DayshaHand + 1
        && current.DayshaHand > 0 && current.DayshaHand < 100
        && settings["DayshaHand" + current.DayshaHand] && current.Loading == 0;
}

isLoading
{
	return current.Loading != 0;
}

//TODO:
//Try finding Upgardes for village again, maybe messed up something
//Legendary Beasts side quests