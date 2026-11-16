extends Node

## Stores application settings. Graphics profiles are declarative in Phase 1;
## the rendering implementation phase will connect them to real renderer settings.

signal settings_changed(settings: Dictionary)

const SETTINGS_PATH := "user://iron_yard_settings.cfg"

const DEFAULT_SETTINGS: Dictionary = {
	"quality_preset": "medium",
	"master_volume": 1.0,
	"music_volume": 0.8,
	"sfx_volume": 1.0,
	"look_sensitivity": 1.0,
	"invert_y": false,
}

const QUALITY_PROFILES: Dictionary = {
	"low": {
		"render_scale": 0.75,
		"shadow_tier": 0,
		"effects_density": 0.25,
		"texture_tier": 0,
	},
	"medium": {
		"render_scale": 0.85,
		"shadow_tier": 1,
		"effects_density": 0.50,
		"texture_tier": 1,
	},
	"high": {
		"render_scale": 1.0,
		"shadow_tier": 2,
		"effects_density": 0.80,
		"texture_tier": 2,
	},
	"ultra": {
		"render_scale": 1.0,
		"shadow_tier": 3,
		"effects_density": 1.0,
		"texture_tier": 3,
	},
}

var _settings: Dictionary = {}


func _ready() -> void:
	_settings = DEFAULT_SETTINGS.duplicate(true)
	var error := load_settings()
	if error != OK:
		push_warning("Settings could not be loaded. Defaults remain active. Error: %s" % error)


func get_settings() -> Dictionary:
	return _settings.duplicate(true)


func get_setting(key: String, fallback: Variant = null) -> Variant:
	return _settings.get(key, fallback)


func get_quality_preset() -> String:
	var preset := str(_settings.get("quality_preset", "medium"))
	return preset if QUALITY_PROFILES.has(preset) else "medium"


func get_quality_profile() -> Dictionary:
	return QUALITY_PROFILES[get_quality_preset()].duplicate(true)


func set_quality_preset(preset: String) -> bool:
	if not QUALITY_PROFILES.has(preset):
		return false
	_settings["quality_preset"] = preset
	return save_settings() == OK


func set_setting(key: String, value: Variant) -> bool:
	if not DEFAULT_SETTINGS.has(key) or key == "quality_preset":
		return false

	match key:
		"master_volume", "music_volume", "sfx_volume":
			value = clampf(float(value), 0.0, 1.0)
		"look_sensitivity":
			value = clampf(float(value), 0.1, 3.0)
		"invert_y":
			value = bool(value)

	_settings[key] = value
	return save_settings() == OK


func load_settings() -> Error:
	var config := ConfigFile.new()
	var error := config.load(SETTINGS_PATH)
	if error == ERR_FILE_NOT_FOUND:
		return OK
	if error != OK:
		return error

	for key in DEFAULT_SETTINGS:
		_settings[key] = config.get_value("settings", key, DEFAULT_SETTINGS[key])

	if not QUALITY_PROFILES.has(str(_settings.get("quality_preset", "medium"))):
		_settings["quality_preset"] = "medium"

	for volume_key in ["master_volume", "music_volume", "sfx_volume"]:
		_settings[volume_key] = clampf(float(_settings[volume_key]), 0.0, 1.0)
	_settings["look_sensitivity"] = clampf(float(_settings["look_sensitivity"]), 0.1, 3.0)
	_settings["invert_y"] = bool(_settings["invert_y"])
	return OK


func save_settings() -> Error:
	var config := ConfigFile.new()
	for key in _settings:
		config.set_value("settings", key, _settings[key])

	var error := config.save(SETTINGS_PATH)
	if error == OK:
		settings_changed.emit(get_settings())
	return error
