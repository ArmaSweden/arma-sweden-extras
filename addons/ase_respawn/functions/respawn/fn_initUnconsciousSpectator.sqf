params ["_unit", "_state"];

if (!hasInterface) exitWith {};
if (_unit != player) exitWith {};
if (player in (call BIS_fnc_listCuratorPlayers)) exitWith {};

if (_state) then {

	[] spawn {

		// Disable ACE screen effects
		ppEffectDestroy ace_medical_feedback_ppUnconsciousBlackout;
		ppEffectDestroy ace_medical_feedback_ppUnconsciousBlur;

		// Flag in case player changes unconscious state multiple times in succession
		localNamespace setVariable ["ASE_isBootingUnconsciousSpectator", true];

		sleep 4;
		cutText ["", "BLACK OUT", 0.25];
		sleep 1;

		_side = [objNull];
		_canSpectateOthers = false;
		switch (ASE_setting_respawn_unconsciousSpectatorList) do {
			case 1: {
				_side = [side group player];
				_canSpectateOthers = true;
			};
			case 2: {
				_side = [];
				_canSpectateOthers = true;
			};
		};

		["Initialize", [player, _side, ASE_setting_respawn_enableUnconsciousSpectateAI, false, true, false, false, false, false, _canSpectateOthers]] call BIS_fnc_EGSpectator;

		waitUntil { "GetDisplay" call BIS_fnc_EGSpectator isnotEqualTo displayNull };

		// Force spectate player's unconscious body
		if (ASE_setting_respawn_unconsciousSpectatorList isEqualTo 0) then {
			missionNamespace setVariable ["BIS_EGSpectator_whitelistedSides", [objNull]];
			uiNamespace setVariable ["RscEGSpectator_focus", player];
			["SetCameraMode", ["follow"]] call BIS_fnc_EGSpectatorCamera;
		};

		_spectatorFocus = uiNamespace getVariable ["RscEGSpectator_focus", objNull];
		localNamespace setVariable ["ASE_spectatorFocus", _spectatorFocus];

		// Disable voice and radio transmission while unconscious
		if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
			// Save current voice volume and set to 0 to prevent local speech
			localNamespace setVariable ["ASE_unconsciousVoiceVolume", TF_speak_volume_meters];
			0 call TFAR_fnc_setVoiceVolume;
			// Disable radio transmission
			[player, true] call TFAR_fnc_forceSpectator;
		};

		_display = "GetDisplay" call BIS_fnc_EGSpectator;
		
		_display displayAddEventHandler ["KeyDown", {
			params ["_display", "_key", "_shift", "_ctrl", "_alt"];

			if (_key isEqualTo 57) then {
				// Disable space key for changing perspective when spectating self
				if (uiNamespace getVariable ["RscEGSpectator_focus", objNull] == player) then {
					true
				};
			};
		}];

		_eventHandler = addMissionEventHandler ["EachFrame", {
			_spectatorFocus = uiNamespace getVariable ["RscEGSpectator_focus", objNull];

			if (isNull _spectatorFocus || !alive player) exitWith {
				removeMissionEventHandler ["EachFrame", _thisEventHandler];
				// Restore voice/radio if player died while unconscious
				if (!alive player && isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
					(localNamespace getVariable ["ASE_unconsciousVoiceVolume", 20]) call TFAR_fnc_setVoiceVolume;
					[player, false] call TFAR_fnc_forceSpectator;
				};
			};
			
			// Only third person allowed when spectating self
			if (_spectatorFocus == player && "GetCameraMode" call BIS_fnc_EGSpectatorCamera != "follow") then {
				["SetCameraMode", ["follow"]] call BIS_fnc_EGSpectatorCamera;
			};

			// Spectator focus changed
			if (_spectatorFocus != localNamespace getVariable ["ASE_spectatorFocus", objNull]) then {
				localNamespace setVariable ["ASE_spectatorFocus", _spectatorFocus];
			};
		}, [_display]];

		cutText ["","BLACK IN"];

		localNamespace setVariable ["ASE_isBootingUnconsciousSpectator", false];

	};

} else {
	call ASE_fnc_closeUnconsciousSpectator;
};