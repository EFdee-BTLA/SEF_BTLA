///////////////////////////////////////////////////////////////////////////////
// Gangster can flee, investigate and neutralize both officers and suspects.
// See SwatEnemy::ConstructCharacterAIHook
///////////////////////////////////////////////////////////////////////////////

class SwatGangster extends SwatEnemy;

import enum EquipmentSlot from Engine.HandheldEquipment;
import enum Pocket from Engine.HandheldEquipment;

///////////////////////////////////////////////////////////////////////////////

protected function ConstructCharacterAIHook(AI_Resource characterResource)
{
    characterResource.addAbility(new class'SwatAICommon.InvestigateAction');
	characterResource.addAbility(new class'SwatAICommon.AttackOfficerAction');
    characterResource.addAbility(new class'SwatAICommon.MoveToAttackOfficerAction');
    characterResource.addAbility(new class'SwatAICommon.PickUpWeaponAction');
	characterResource.addAbility(new class'SwatAICommon.ReactToBeingShotAction');
	characterResource.addAbility(new class'SwatAICommon.BarricadeAction');
    characterResource.addAbility(new class'SwatAICommon.ThreatenHostageAction');
    characterResource.addAbility(new class'SwatAICommon.ConverseWithHostagesAction');
	characterResource.addAbility(new class'SwatAICommon.FleeAction');
	characterResource.addAbility(new class'SwatAICommon.InitialReactionAction');
	characterResource.addAbility(new class'SwatAICommon.PepperSprayedAction');
	characterResource.addAbility(new class'SwatAICommon.GassedAction');
	characterResource.addAbility(new class'SwatAICommon.FlashbangedAction');
	characterResource.addAbility(new class'SwatAICommon.TasedAction');
	characterResource.addAbility(new class'SwatAICommon.StunnedByC2Action');
	characterResource.addAbility(new class'SwatAICommon.InitialReactionAction');
	characterResource.addAbility(new class'SwatAICommon.StungAction');
	characterResource.addAbility(new class'SwatAICommon.AvoidLocationAction');
	characterResource.addAbility(new class'SwatAICommon.EnemyCowerAction');		
}

///////////////////////////////////////////////////////////////////////////////
// AI Reload Action
///////////////////////////////////////////////////////////////////////////////

protected function ConstructWeaponAI()
{
	local AI_Resource weaponResource;
    weaponResource = AI_Resource(weaponAI);
    assert(weaponResource != none);

	weaponResource.addAbility(new class'SwatAICommon.ReloadAction');

	// call down the chain
	Super.ConstructWeaponAI();
}

///////////////////////////////////////////////////////////////////////////////
// AI Vision
///////////////////////////////////////////////////////////////////////////////

event bool IgnoresSeenPawnsOfType(class<Pawn> SeenType)
{
    // we see everyone except our own
    return (ClassIsChildOf(SeenType, class'SwatGame.SwatGangster') ||
			ClassIsChildOf(SeenType, class'SwatGame.SwatHostage') ||
		    ClassIsChildOf(SeenType, class'SwatGame.SwatTrainer') ||
			ClassIsChildOf(SeenType, class'SwatGame.SniperPawn'));
}

///////////////////////////////////////////////////////////////////////////////
// Move To Attack Officer
///////////////////////////////////////////////////////////////////////////////

protected function ConstructMovementAI()
{
    local AI_Resource movementResource;
    
	movementResource = AI_Resource(movementAI);
    assert(movementResource != none);

    super.constructMovementAI();

	movementResource.addAbility(new class'SwatAICommon.MoveToAttackOfficerAction');
}

///////////////////////////////////////////////////////////////////////////////