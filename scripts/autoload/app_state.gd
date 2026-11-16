extends Node

## High-level application/session state. Match rules belong in future match controllers.

signal session_started(mode_id: String)
signal session_ended(mode_id: String)
signal active_screen_changed(screen_id: String)

var active_screen_id: String = "boot"
var active_mode_id: String = ""
var session_active: bool = false


func set_active_screen(screen_id: String) -> void:
	if screen_id == active_screen_id:
		return
	active_screen_id = screen_id
	active_screen_changed.emit(active_screen_id)


func begin_session(mode_id: String) -> bool:
	var clean_mode_id := mode_id.strip_edges()
	if clean_mode_id.is_empty() or session_active:
		return false
	active_mode_id = clean_mode_id
	session_active = true
	session_started.emit(active_mode_id)
	return true


func end_session() -> void:
	if not session_active:
		return
	var ended_mode_id := active_mode_id
	session_active = false
	active_mode_id = ""
	session_ended.emit(ended_mode_id)
