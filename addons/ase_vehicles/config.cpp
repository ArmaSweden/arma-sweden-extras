class CfgPatches
{
	class ASE_vehicles
    {
		author = "SageNTitled of Arma Sweden";
		name = "ASE Vehicles";
		url = "https://www.armasweden.se/";
		requiredAddons[] = {"CUP_Vehicles_Core"};
		skipWhenMissingDependencies = 1;
		requiredVersion = 0.100000;
		units[] = {};
		weapons[] = {};
	};
};

class CfgFactionClasses
{
	class ASE_B_Sweden
	{
		displayName = "Swedish Armed Forces";
		author = "SageNTitled of Arma Sweden";
		icon = ""; // TODO: Add icon
		priority = 1;
		side = 1;
	};
};

class CfgEditorSubcategories
{
	class ASE_Eden_tanks
	{
		displayName = "Tanks";
	};
	class ASE_Eden_helicopters
	{
		displayName = "Helicopters";
	};
};

class CfgVehicles
{
	class CUP_B_Leopard2A6_GER;
	class CUP_B_Leopard2A6_GER_import : CUP_B_Leopard2A6_GER { scope = 0; class EventHandlers; };
	class ASE_B_Strv122 : CUP_B_Leopard2A6_GER_import
	{
		// TODO: Change to Swedish crew
		scope = 0;
		scopeCurator = 0;
		ace_hunterkiller = 1;
		class EventHandlers: EventHandlers
		{
			init = "if (local (_this select 0)) then { [(_this select 0), """", [], false] call BIS_fnc_initVehicle; };";
		};
		class textureSources
		{
			class M90_Woodland
			{
				displayName = "M90 Woodland";
				author = "SageNTitled of Arma Sweden";
				textures[] = {
					"Arma-Sweden-Extras\addons\ase_vehicles\data\Strv122\hull.paa",
					"Arma-Sweden-Extras\addons\ase_vehicles\data\Strv122\turret.paa",
					"CUP\TrackedVehicles\CUP_TrackedVehicles_Leopard2\data\wdl_Wheels_co.paa",
					"CUP\TrackedVehicles\CUP_TrackedVehicles_Leopard2\data\wdl_trans_ca.paa",
					"a3\armor_f\data\camonet_nato_green_co.paa", // TODO: Create M90 camo net
					"CUP\TrackedVehicles\CUP_TrackedVehicles_Leopard2\data\license_plate_co.paa", // TODO: Change license plate or remove
					"CUP\TrackedVehicles\CUP_TrackedVehicles_Leopard2\data\unit_sign_armor_ca.paa" // TODO: Maybe remove
				};
				factions[] = { "ASE_B_Sweden" };
			};
		};
	};
	class ASE_B_Strv122_SWE : ASE_B_Strv122
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Strv 122 (Woodland)";
		textureList[] = {
			"M90_Woodland", 1
		};
		side = 1;
		faction = "ASE_B_Sweden";
		editorSubcategory = "ASE_Eden_tanks";
	};

	class CUP_B_UH60M_US;
	class CUP_B_UH60M_US_import : CUP_B_UH60M_US { scope = 0; class EventHandlers; };
	class ASE_B_Hkp16 : CUP_B_UH60M_US_import
	{
		scope = 0;
		scopeCurator = 0;
		class EventHandlers: EventHandlers
		{
			init = "if (local (_this select 0)) then { [(_this select 0), """", [], false] call BIS_fnc_initVehicle; };";
		};
		class textureSources
		{
			class Green
			{
				displayName = "Green";
				author = "SageNTitled of Arma Sweden";
				textures[] = {
					"Arma-Sweden-Extras\addons\ase_vehicles\data\Hkp16\fuselage.paa",
					"Arma-Sweden-Extras\addons\ase_vehicles\data\Hkp16\engine.paa"
				};
				factions[] = { "ASE_B_Sweden" };
			};
		};
	};
	class ASE_B_Hkp16_SWE : ASE_B_Hkp16
	{
		// TODO: Change to Swedish crew
		scope = 2;
		scopeCurator = 2;
		displayName = "Hkp 16";
		textureList[] = {
			"Green", 1
		};
		side = 1;
		faction = "ASE_B_Sweden";
		editorSubcategory = "ASE_Eden_helicopters";
	};
};