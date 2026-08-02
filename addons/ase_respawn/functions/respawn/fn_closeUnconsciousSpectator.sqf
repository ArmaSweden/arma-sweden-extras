params ["_unit", "_killer", "_instigator", "_useEffects"];

if (!(["IsInitialized"] call BIS_fnc_EGSpectator)) exitWith {};

[] spawn {
	waitUntil { !(localNamespace getVariable ["ASE_isBootingUnconsciousSpectator", false]) };

	cutText ["", "BLACK OUT", 0.25];
	sleep 0.25;
	["Terminate"] call BIS_fnc_EGSpectator;
	localNamespace setVariable ["ASE_spectatorFocus", objNull];

	// Re-enable voice and radio transmission after regaining consciousness
	if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
		(localNamespace getVariable ["ASE_unconsciousVoiceVolume", 20]) call TFAR_fnc_setVoiceVolume;
		[player, false] call TFAR_fnc_forceSpectator;
	};

	cutText ["","BLACK IN", 0.25];
};