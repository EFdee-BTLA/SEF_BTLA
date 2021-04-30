///////////////////////////////////////////////////////////////////////////////
// RestrainAndReportGoal.uc - RestrainAndReportGoal class
// The goal that causes the Officer to restrain a compliant suspect or hostage

class RestrainAndReportGoal extends SwatCharacterGoal;
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// Variables

var(parameters) Pawn CompliantTarget;

///////////////////////////////////////////////////////////////////////////////
//
// Constructor

overloaded function construct( AI_Resource r, Pawn inCompliantTarget)
{
	super.construct( r );

	assert(inCompliantTarget != None);
	CompliantTarget = inCompliantTarget;
	log("New RestrainAndReportGoal posted");
}

///////////////////////////////////////////////////////////////////////////////
defaultproperties
{
	priority = 80
	goalName = "RestrainAndReport"
}
