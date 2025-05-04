class_name PowerUpUI
extends Control

@onready var _icon : TextureRect = $TextureRect
@onready var _color : ColorRect = %ColorRect

var _data : PowerUpResource


func _ready() -> void:
	if _data == null:
		return
	_icon.texture = _data.icon
	_color.modulate.a = 0.0
	_color.show()

func setData(data: PowerUpResource) -> void:
	_data = data


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			SignalBus.powerUpIconClicked.emit(_data)

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(_color, "modulate:a", 0.3, 0.15)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(_color, "modulate:a", 0.0, 0.15)
