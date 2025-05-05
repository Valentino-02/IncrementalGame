class_name Coin
extends Node2D

@export var sunTexture : Texture2D
@export var moonTexture : Texture2D

@onready var _sprite : Sprite2D = $Sprite2D

var _clicked : bool = false
var _type : Types.Cycle

func _ready() -> void:
	_floatForever(position)
	_sprite.modulate = Color("747474")
	_sprite.texture = sunTexture if _type == Types.Cycle.Sun else moonTexture
	_sprite.modulate.a = 0.0
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(_sprite, "modulate:a", 1.0, 0.3)

func setType(type: Types.Cycle) -> void:
	_type = type

func _floatForever(startPos: Vector2) -> void:
	var amp := randf_range(15.0, 20.0)  
	var dur := randf_range(1.5, 2.0)   
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", startPos + Vector2(0, -amp), dur)
	tween.tween_property(self, "position", startPos, dur)
	await tween.finished
	_floatForever(startPos)


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if _clicked:
			return
		_clicked = true
		AudioManager.sfx.play(SfxManager.SfxId.CollectCoin)
		SignalBus.coinCollected.emit(_type)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(_sprite, "modulate:a", 0.0, 0.4)
		await tween.finished
		queue_free()

func _on_area_2d_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(_sprite, "modulate", Color("ffffff"), 0.2)


func _on_area_2d_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(_sprite, "modulate", Color("747474"), 0.2)
