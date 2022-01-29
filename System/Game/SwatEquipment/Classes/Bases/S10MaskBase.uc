class S10MaskBase extends Engine.Headgear
    implements IProtectFromCSGas, IProtectFromPepperSpray, IProtectFromFlashbang;

function QualifyProtectedRegion()
{
    assertWithDescription(ProtectedRegion < REGION_Body_Max,
        "[Carlos] The S10MaskBase class "$class.name
        $" specifies ProtectedRegion="$GetEnum(ESkeletalRegion, ProtectedRegion)
        $".  ProtectiveEquipment may only protect body regions or Region_None.");
}
