class KevlarNVGogglesBase extends NVGogglesBase config(SwatEquipment);

// this class has been added in order to keep weight and bulk values accurate between classes -- EFdee
simulated function float GetWeight() {
	return 2.04;		// IMPORTANT: Make sure to alter the value in DynamicLoadOutSpec.uc as well!
}

simulated function float GetBulk() {
	return 2.644;	// IMPORTANT: Make sure to alter the value in DynamicLoadOutSpec.uc as well!
}

