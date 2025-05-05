class_name PassTimeUI
extends Control

@onready var _button : Button = %Button
@onready var _timer : Timer = %Timer
@onready var _particles : GPUParticles2D = %GPUParticles2D

var _startPos : Vector2

func _ready() -> void:
	await get_tree().process_frame
	_startPos = _button.position
	_floatForever()

func _floatForever() -> void:
	var amp := randf_range(5.0, 10.0)  
	var dur := randf_range(1.5, 2.0)   
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(_button, "position", _startPos + Vector2(0, -amp), dur)
	tween.tween_property(_button, "position", _startPos, dur)
	await tween.finished
	_floatForever()

func _on_button_pressed() -> void:
	_button.disabled = true
	_particles.emitting = false
	_timer.start()
	SignalBus.passTimeClicked.emit()
	AudioManager.sfx.play(SfxManager.SfxId.AdvanceCycle)

func _on_timer_timeout() -> void:
	_button.disabled = false
	_particles.emitting = true
