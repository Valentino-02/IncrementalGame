class_name PowerUpUI
extends Control

@onready var _icon : TextureRect = $TextureRect

var _data : PowerUpResource


func _ready() -> void:
	if _data == null:
		return
	_icon.texture = _data.icon

func setData(data: PowerUpResource) -> void:
	_data = data


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			SignalBus.powerUpIconClicked.emit(_data)
