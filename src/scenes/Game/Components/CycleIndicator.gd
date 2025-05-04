class_name CycleIndicator
extends Node2D

@onready var _sun : Sprite2D = %Sun
@onready var _moon : Sprite2D = %Moon

func _ready() -> void:
	SignalBus.cyclePassed.connect(_onCyclePassed)
	_floatForever(_sun, _sun.position)
	_floatForever(_moon, _moon.position)


func _floatForever(sprite: Sprite2D, startPos: Vector2) -> void:
	var amp := randf_range(15, 17.5)  
	var dur := randf_range(0.75, 0.75)   
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position", startPos + Vector2(amp, 0), dur)
	tween.tween_property(sprite, "position", startPos + Vector2(-amp, 0), dur)
	await tween.finished
	_floatForever(sprite, startPos)

func _onCyclePassed(_toCycle: Types.Cycle) -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", rotation_degrees + 180, 1.0)
