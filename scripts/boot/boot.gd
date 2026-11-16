extends Control

@onready var _status_label: Label = %StatusLabel


func _ready() -> void:
	_status_label.text = "PROJECT FOUNDATION INITIALIZED\nCore application services are loaded. Gameplay development is next."
	AppState.set_active_screen("boot")
