class CfgPatches
{
    class ASE_ksp58_weight_fix
    {
		author = "Anctus of Arma Sweden";
		name = "ASE Ksp 58 weight fix";
		url = "https://www.armasweden.se/";
		requiredAddons[] = {"sfp_ksp58"};
		skipWhenMissingDependencies = 1;
		requiredVersion = 0.1;
		units[] = {};
		weapons[] = {};
    };
};

class CfgWeapons
{
	class Rifle_Base_F;
	class Rifle_Long_Base_F: Rifle_Base_F
	{
		class WeaponSlotsInfo;
	};
	class sfp_ksp58_base: Rifle_Long_Base_F
	{
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			mass=255.2;
		};
	};
	class sfp_ksp58a: sfp_ksp58_base
	{
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			mass=255.2;
		};
	};
	class sfp_ksp58: sfp_ksp58_base
	{
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			mass=255.2;
		};
	};
	class sfp_ksp58B2: sfp_ksp58_base
	{
		class WeaponSlotsInfo: WeaponSlotsInfo
		{
			mass=255.2;
		};
	};
};