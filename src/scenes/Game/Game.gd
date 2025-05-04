class_name Game
extends Node2D

@onready var _camera : Camera2D = %Camera2D

var _worldState := WorldState.new()
var _startingCameraPosition : Vector2


func _ready() -> void:
	AudioManager.music.play(MusicManager.MusicId.GameTheme)
	_startingCameraPosition = _camera.position


func _on_timer_timeout() -> void:
	SignalBus.tickAdvanced.emit()

func _on_down_change_camera_button_clicked() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(10, 0), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition, 0.15)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1080), 1.0)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1090), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1080), 0.15)

func _on_up_change_camera_button_2_clicked() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(-10, 1080), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1080), 0.15)
	tween.tween_property(_camera, "position", _startingCameraPosition, 1.0)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, -10), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition, 0.15)
