class_name Game
extends Node2D

@export var coinScene : PackedScene

@onready var _camera : Camera2D = %Camera2D
@onready var _filter : ColorRect = %ColorRect
@onready var _introLabel : Label = $IntroLabel
@onready var coinTimer : Timer = $Timer2

var _worldState := WorldState.new()
var _startingCameraPosition : Vector2
var maxCoins = 10
var _coins = 0


func _ready() -> void:
	AudioManager.music.play(MusicManager.MusicId.GameTheme)
	_startingCameraPosition = _camera.position
	_worldState.setStartingConditions()
	SignalBus.coinCollected.connect(_onCoinPicked)
	SignalBus.cyclePassed.connect(_onCycleChanged)
	_filter.show()
	_filter.modulate.a = 0.0
	_worldState.parent = self


func _onCycleChanged(toCycle: Types.Cycle) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	if toCycle == Types.Cycle.Sun:
		tween.tween_property(_filter, "modulate:a", 0.0, 0.5)
	if toCycle == Types.Cycle.Moon:
		tween.tween_property(_filter, "modulate:a", 0.2, 0.5)

func _on_timer_timeout() -> void:
	SignalBus.tickAdvanced.emit()

func _on_down_change_camera_button_clicked() -> void:
	_worldState.changeCycle()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(10, 0), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition, 0.15)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1080), 1.0)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1090), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1080), 0.15)

func _on_up_change_camera_button_2_clicked() -> void:
	_worldState.changeCycle()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(-10, 1080), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, 1080), 0.15)
	tween.tween_property(_camera, "position", _startingCameraPosition, 1.0)
	tween.tween_property(_camera, "position", _startingCameraPosition + Vector2(0, -10), 0.05)
	tween.tween_property(_camera, "position", _startingCameraPosition, 0.15)

func _onCoinPicked(_type: Types.Cycle) -> void:
	_coins -= 1

func _on_timer_2_timeout() -> void:
	if _coins >= maxCoins:
		return
	if _worldState.sunCoins and _worldState.moonCoins:
		var coin : Coin = coinScene.instantiate() as Coin
		coin.setType(Types.Cycle.Sun if randi_range(0,1) == 1 else Types.Cycle.Moon)
		coin.position = Vector2(randf_range(100, 1820), randf_range(100, 980))
		add_child(coin)
		_coins += 1
		return
	if _worldState.sunCoins:
		var coin : Coin = coinScene.instantiate() as Coin
		coin.setType(Types.Cycle.Sun)
		coin.position = Vector2(randf_range(100, 1820), randf_range(100, 980))
		add_child(coin)
		_coins += 1
		return
	if _worldState.moonCoins:
		var coin : Coin = coinScene.instantiate() as Coin
		coin.setType(Types.Cycle.Moon)
		coin.position = Vector2(randf_range(100, 1820), randf_range(100, 980))
		add_child(coin)
		_coins += 1
		return

func _on_timer_3_timeout() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(_introLabel, "modulate:a", 0.0, 20)
	await tween.finished
	_introLabel.hide()
