extends Node

## Versioned persistent data. Match-only temporary state must not be stored here.

signal save_loaded(data: Dictionary)
signal save_written(data: Dictionary)

const SAVE_PATH := "user://iron_yard_save.json"
const SAVE_VERSION := 1
const DEFAULT_SAVE_DATA: Dictionary = {
	"credits": 0,
	"lifetime_score": 0,
	"unlocks": [],
	"statistics": {},
}

var _save_data: Dictionary = {}


func _ready() -> void:
	_save_data = DEFAULT_SAVE_DATA.duplicate(true)
	var error := load_game()
	if error != OK:
		push_warning("Save data could not be loaded. Defaults remain active. Error: %s" % error)


func get_save_data() -> Dictionary:
	return _save_data.duplicate(true)


func get_value(key: String, fallback: Variant = null) -> Variant:
	return _save_data.get(key, fallback)


func set_value(key: String, value: Variant) -> void:
	if key.is_empty() or key in ["schema_version", "data"]:
		return
	_save_data[key] = value


func load_game() -> Error:
	if not FileAccess.file_exists(SAVE_PATH):
		_save_data = DEFAULT_SAVE_DATA.duplicate(true)
		return OK

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return FileAccess.get_open_error()

	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return ERR_PARSE_ERROR

	var payload: Dictionary = parsed
	var stored_version := int(payload.get("schema_version", 0))
	if stored_version > SAVE_VERSION:
		return ERR_INVALID_DATA

	var stored_data: Variant = payload.get("data", {})
	if typeof(stored_data) != TYPE_DICTIONARY:
		return ERR_INVALID_DATA

	_save_data = DEFAULT_SAVE_DATA.duplicate(true)
	for key in stored_data:
		_save_data[key] = stored_data[key]

	_save_data["credits"] = maxi(0, int(_save_data.get("credits", 0)))
	_save_data["lifetime_score"] = maxi(0, int(_save_data.get("lifetime_score", 0)))
	if typeof(_save_data.get("unlocks", [])) != TYPE_ARRAY:
		_save_data["unlocks"] = []
	if typeof(_save_data.get("statistics", {})) != TYPE_DICTIONARY:
		_save_data["statistics"] = {}

	save_loaded.emit(get_save_data())
	return OK


func save_game() -> Error:
	var payload := {
		"schema_version": SAVE_VERSION,
		"saved_at_unix": int(Time.get_unix_time_from_system()),
		"data": _save_data,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return FileAccess.get_open_error()

	file.store_string(JSON.stringify(payload, "\t"))
	file.flush()
	var error := file.get_error()
	if error == OK:
		save_written.emit(get_save_data())
	return error
