class_name TimeIndicatorUI
extends Control


func _ready() -> void:
	SignalBus.cyclePassed.connect(_onCyclePassed)


func _onCyclePassed(toCycle: Types.Cycle) -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", rotation_degrees + 180, 1.0)
