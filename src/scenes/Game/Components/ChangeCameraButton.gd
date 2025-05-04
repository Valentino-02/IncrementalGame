class_name ChangeCameraButton
extends Area2D

signal clicked

enum Direction {Up, Down}

@export var direction : Direction

@onready var _particles : GPUParticles2D = %GPUParticles2D
@onready var _sprite : Sprite2D = %Sprite2D
@onready var _timer : Timer = %Timer

var _onCooldown : bool = false


func _ready() -> void:
	if direction == Direction.Up:
		_sprite.flip_v = true
	_floatForever(position)


func _floatForever(startPos: Vector2) -> void:
	var amp := randf_range(5.0, 10.0)  
	var dur := randf_range(1.0, 1.5)   
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", startPos + Vector2(0, -amp), dur)
	tween.tween_property(self, "position", startPos, dur)
	await tween.finished
	_floatForever(startPos)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if _onCooldown:
			return
		clicked.emit()
		_timer.start()
		_onCooldown = true

func _on_mouse_entered() -> void:
	_particles.emitting = true

func _on_mouse_exited() -> void:
	_particles.emitting = false

func _on_timer_timeout() -> void:
	_onCooldown = false
