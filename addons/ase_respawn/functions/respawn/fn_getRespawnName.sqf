params ["_respawnPoint"];

private ["_name"];

switch (typeName _respawnPoint) do {
	case "ARRAY": {
		_name = "Respawn point";
	};
	case "STRING": {
		_name = markerText _respawnPoint;
	};
	case "OBJECT": {
		_name = _respawnPoint getvariable ["Name","Respawn point"];
	};
	default {
		_name = "Respawn point";
	};
};

_name