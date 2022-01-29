///////////////////////////////////////////////////////////////////////////////
class Shotgun extends RoundBasedWeapon;
///////////////////////////////////////////////////////////////////////////////

var(Shotgun) config float WoodBreachingChance "The chance to breach a wooden door, per pellet.";
var(Shotgun) config float MetalBreachingChance "The chance to breach a metal door, per pellet.";
var(Shotgun) config bool IgnoreAmmoOverrides "Whether to ignore breaching chance overrides from ammo types.";
var(Shotgun) config int ShellTextureIndex_FP;
var(Shotgun) config int ShellTextureIndex_TP;

function bool ShouldBreach(float BreachingChance)
{
	return FRand() < BreachingChance;
}

function bool ShouldPenetrateMaterial(float BreachingChance)
{
  local ShotgunAmmo ShotgunAmmo;

  ShotgunAmmo = ShotgunAmmo(Ammo);
  assertWithDescription(ShotgunAmmo != None, "[eezstreet] Shotgun "$self$" is not using ShotgunAmmo!");

  if(!ShotgunAmmo.WillPenetrateDoor())
    return false;

  return FRand() < BreachingChance;
}

simulated function bool HandleBallisticImpact(
    Actor Victim,
    vector HitLocation,
    vector HitNormal,
    vector NormalizedBulletDirection,
    Material HitMaterial,
    ESkeletalRegion HitRegion,
    out float Momentum,
    out float KillEnergy,
    out int BulletType,
    vector ExitLocation,
    vector ExitNormal,
    Material ExitMaterial
    )
{
	local vector PlayerToDoor;
	local float MaxDoorDistance;
	local float BreachingChance;
	local ShotgunAmmo ShotgunAmmo;

	ShotgunAmmo = ShotgunAmmo(Ammo);

	if(Role == Role_Authority)  // ONLY do this on the server!!
	{
		MaxDoorDistance = 99.45;		//1.5 meters in UU
    	PlayerToDoor = HitLocation - Owner.Location;

    	switch (HitMaterial.MaterialVisualType)
    	{
	    	case MVT_ThinMetal:
	    	case MVT_ThickMetal:
	    	case MVT_Default:
				if(!IgnoreAmmoOverrides && ShotgunAmmo.AmmoOverridesWeaponBreachChance())
				{
					BreachingChance = ShotgunAmmo.GetAmmoBreachChance(false);
				}
				else
				{
					BreachingChance = MetalBreachingChance;
				}
	    		break;
	    	case MVT_Wood:
				if(!IgnoreAmmoOverrides && ShotgunAmmo.AmmoOverridesWeaponBreachChance())
				{
					BreachingChance = ShotgunAmmo.GetAmmoBreachChance(true);
				}
				else
				{
					BreachingChance = WoodBreachingChance;
				}
	    		break;
	    	default:
	    		BreachingChance = 0;
	    		break;
    	}

      if (Victim.IsA('SwatDoor') && PlayerToDoor Dot PlayerToDoor < MaxDoorDistance*MaxDoorDistance && ShouldBreach(BreachingChance) )
      {
        IHaveSkeletalRegions(Victim).OnSkeletalRegionHit(
                HitRegion,
                HitLocation,
                HitNormal,
                0,                  //damage: unimportant for breaching a door
                GetDamageType(),
                Owner);
        if(!ShouldPenetrateMaterial(BreachingChance))
        {
          Momentum = 0; // All of the momentum is lost
        }
      }

	}

	// We should still consider it to have ballistic impacts
	return Super.HandleBallisticImpact(
	    Victim,
	    HitLocation,
	    HitNormal,
	    NormalizedBulletDirection,
	    HitMaterial,
	    HitRegion,
	    Momentum,
        KillEnergy,
        BulletType,
	    ExitLocation,
	    ExitNormal,
	    ExitMaterial);
}

function changeShellsMaterial()
{
local String ShellTextureName;
local String ShellTextureNameTP;
local ShotgunAmmo ShotgunAmmo;
ShotgunAmmo = ShotgunAmmo(Ammo);
	
if (ShotgunAmmo != None) //asserting shotgun is using shotgun ammo.... kind of a joke but still
{
	
	//Get Shell type , associate with Texture
	switch( ShotgunAmmo.GetFriendlyName() ) //get FriendlyName , you can find it in the Class-Ammo-FriendlyName field
	{
		case "000 Buckshot":
					ShellTextureName = "Shells.shell_buckshotshader"; 
					ShellTextureNameTP = "Shells.shell_buckshot512shader"; 
		break;
		case "00 Buckshot":
					ShellTextureName = "Shells.shell_buckshotshader"; 
					ShellTextureNameTP = "Shells.shell_buckshot512shader"; 
		break;
		case "0 Buckshot":
					ShellTextureName = "Shells.shell_buckshotshader"; 
					ShellTextureNameTP = "Shells.shell_buckshot512shader"; 
		break;
		case "1 Buckshot":
					ShellTextureName = "Shells.shell_4buckshotshader"; 
					ShellTextureNameTP = "Shells.shell_4buckshot512shader"; 
		break;
		case "4 Buckshot":
					ShellTextureName = "Shells.shell_4buckshotshader"; 
					ShellTextureNameTP = "Shells.shell_4buckshot512shader"; 
		break;
		case "Breaching Round":
					ShellTextureName = "Shells.shell_breachingshader"; 
					ShellTextureNameTP = "Shells.shell_breaching512shader"; 
		break;
		case "Armor Piercing Slug":
					ShellTextureName = "Shells.shell_slugshader"; 
					ShellTextureNameTP = "Shells.shell_slug512shader"; 
		break;
		case "Hollow Point Slug":
					ShellTextureName = "Shells.shell_HPslugshader"; 
					ShellTextureNameTP = "Shells.shell_HPslug512shader"; 
		break;
		case "Bean bag Round":
					ShellTextureName = "Shells.shell_bbshader"; 
        break;
		default:  //default texture just to avoid CTD
				ShellTextureName = "Shells.buckshotshader";
				ShellTextureNameTP = "Shells.buckshot512shader";
		break;
	}
	
	
	
	if (ShellTextureIndex_FP > -1 )
	{
		//change material
		FirstPersonModel.Skins[ShellTextureIndex_FP] = Material(DynamicLoadObject( ShellTextureName, class'Material'));	
	}

	if (ShellTextureIndex_TP > -1 )
	{
		//change material
		ThirdPersonModel.Skins[ShellTextureIndex_TP] = Material(DynamicLoadObject( ShellTextureName, class'Material'));
	}
}	

}

simulated function EquippedHook()
{
    Super.EquippedHook();

	changeShellsMaterial();
}


defaultproperties
{
	WoodBreachingChance = 0.1;
	MetalBreachingChance = 0.05;
    ShellTextureIndex_FP = -1;
	ShellTextureIndex_TP = -1;
}
