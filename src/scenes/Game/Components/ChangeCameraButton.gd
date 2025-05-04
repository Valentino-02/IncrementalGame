class_name ChangeCameraButton
extends Area2D

signal clicked

enum Direction {Up, Down}

@export var direction : Direction

@onready var _particles : GPUParticles2D = %GPUParticles2D
@onready var _sprite : Sprite2D = %Sprite2D


func _ready() -> void:
	if direction == Direction.Up:
		_sprite.flip_v = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		clicked.emit()

func _on_mouse_entered() -> void:
	_particles.emitting = true

func _on_mouse_exited() -> void:
	_particles.emitting = false
