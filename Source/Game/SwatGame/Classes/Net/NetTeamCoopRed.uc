///////////////////////////////////////////////////////////////////////////////

class NetTeamCoopRed extends NetTeam;

///////////////////////////////////////////////////////////////////////////////

simulated function int GetTeamNumber()
{
    return 2;
}

defaultproperties
{
	TeamIndex = 2
    TeamName = "Red Team"
	ColorTag = "ff0000"
    DefaultPlayerClass = class'NetPlayerCoop'
}

///////////////////////////////////////////////////////////////////////////////
