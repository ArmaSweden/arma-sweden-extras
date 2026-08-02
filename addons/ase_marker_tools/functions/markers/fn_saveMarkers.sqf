private _markers = [];

if (count allMapMarkers == 0) exitWith {};

{
	// Marker must be created by a player
	if (!(["_USER_DEFINED", _x, true] call BIS_fnc_inString)) then {continue};

	_markerName = _x;
	_playerId = (_x splitString "#/") select 1;

	// Save to side channel if singleplayer
	if (!isMultiplayer) then {
		_markerName = _x regexReplace ["(?!\/)\d+$", "1"];
	};

	// Marker must be owned by the player
	if (_playerId != getPlayerID player) then { continue };

	if (markerShape _x == "POLYLINE") then {
		_markers pushBack ([
			"POLYLINE",
			_markerName,
			markerPolyline _x,
			markerColor _x
		] joinString "|");
	} else {
		_markers pushBack ([
			_markerName,
			markerPos _x,
			markerType _x,
			markerDir _x,
			markerColor _x,
			markerAlpha _x,
			markerText _x,
			markerSize _x
		] joinString "|");
	};
} forEach allMapMarkers;

profileNamespace setVariable ["ASE_savedMarkers", _markers];