params ["_channelId"];

if (!isMultiplayer) exitWith { false };

_mapDisplay = call ASE_fnc_getMapDisplay;
_isInPlanningPhase = _mapDisplay isEqualTo findDisplay 52 || _mapDisplay isEqualTo findDisplay 53;
if (_isInPlanningPhase && !ASE_setting_markerTools_restrictPlacementBeforeStart) exitWith { false };

_isChannelRestricted = [
	ASE_setting_markerTools_disablePlacementGlobal,
	ASE_setting_markerTools_disablePlacementSide,
	ASE_setting_markerTools_disablePlacementCommand,
	ASE_setting_markerTools_disablePlacementGroup,
	ASE_setting_markerTools_disablePlacementVehicle,
	ASE_setting_markerTools_disablePlacementDirect
];

if (_channelId == -1 || _channelId > 5) exitWith {
	false
};

_isChannelRestricted select _channelId