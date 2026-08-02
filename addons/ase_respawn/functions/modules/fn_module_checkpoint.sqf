// TODO: Make map marker optional
// TODO: Make option to allow deactivating respawn even if it's on timer
// TODO: Run on server only, and make markers global

_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_isActivated = param [2,false,[true]];

_side = _logic getVariable ["Side", 0];
_name = _logic getVariable ["Name", ""];
_activeTime = parseNumber (_logic getVariable ["Time", 0]);
_showNotification = _logic getVariable ["Notification", false];
_removePrevious = _logic getVariable ["RemovePrevious", 0]; // TODO: Implement

_disableModule = {
	//_activeTime = param [0, 0, [0]];

	if (_activeTime > 0 && _logic getVariable ["isOnTimer", false]) exitWith {};
	if (!(_logic getVariable ["isEnabled", true])) exitWith {};
	if (_logic getVariable ["marker", ""] == "") exitWith {};

	deleteMarkerLocal (_logic getVariable "marker");
	_logic setVariable ["isEnabled", false];
	_logic setVariable ["marker", ""];
};

if (_isActivated) then {
	if (_logic getVariable ["isEnabled", false]) exitWith {
		_logic setVariable ["endTime", time + _activeTime];
	};
	
	// Create map marker
	_marker = "";
	switch (_side) do {
		case 0: {
			_marker = createMarkerLocal [format ["respawn_west %1", _logic], getPos _logic];
			_marker setMarkerColorLocal "ColorWEST";
		};
		case 1: {
			_marker = createMarkerLocal [format ["respawn_east %1", _logic], getPos _logic];
			_marker setMarkerColorLocal "ColorEAST"
		};
		case 2: {
			_marker = createMarkerLocal [format ["respawn_guerrila %1", _logic], getPos _logic];
			_marker setMarkerColorLocal "ColorGUER"
		};
		case 3: {
			_marker = createMarkerLocal [format ["respawn_civilian %1", _logic], getPos _logic];
			_marker setMarkerColorLocal "ColorCIV"
		};
		default { };
	};
	_marker setMarkerTypeLocal "respawn_inf";
	_marker setMarkerTextLocal _name;
	_logic setVariable ["marker", _marker];

	// TODO: Show only to the players in _side
	// Show notification
	if (_showNotification) then {
		["RespawnAdded", ["Respawn Available", "A checkpoint was activated", "Arma-Sweden-Extras\addons\ase_respawn\ui\icons\moduleCheckpoint.paa"]] call bis_fnc_shownotification;
	};

	_logic setVariable ["isEnabled", true];

	if (_activeTime > 0) then {
		_logic setVariable ["isOnTimer", true];
		[_logic, _activeTime, _disableModule] spawn {
			params ["_logic", "_activeTime", "_disableModule"];

			_logic setVariable ["endTime", time + _activeTime];
			waitUntil { time >= _logic getVariable "endTime" || !(_logic getVariable ["isEnabled", true])};
			_logic setVariable ["isOnTimer", false];
			call _disableModule;
		};
	};

} else {
	call _disableModule;
};

true;