class_name CurrecyCounter
extends Control

@export var cycle : Types.Cycle
@export var texture : Texture2D

@onready var _container : HBoxContainer = $HBoxContainer
@onready var _icon : TextureRect = %Icon
@onready var _currentLabel : Label = %CurrentLabel
@onready var _nextLabel : Label = %NextLabel
@onready var _labels : Control = %Labels

var _startPosition : Vector2


func _ready() -> void:
	_icon.texture = texture
	if cycle == Types.Cycle.Moon :
		_container.layout_direction = Control.LAYOUT_DIRECTION_RTL
		SignalBus.moonCurrencyChanged.connect(_onCurrencyChanged)
	else:
		SignalBus.sunCurrencyChanged.connect(_onCurrencyChanged)
	await get_tree().process_frame
	_startPosition = _labels.position


func _onCurrencyChanged(newValue: int) -> void:
	_nextLabel.text = str(newValue)
	_nextLabel.modulate.a = 0.0
	_nextLabel.show()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_parallel(true)
	tween.tween_property(_currentLabel, "modulate:a", 0.0, 0.3)
	tween.tween_property(_nextLabel, "modulate:a", 1.0, 0.3)
	tween.tween_property(_labels, "position", _startPosition + Vector2(0, -80), 0.3)
	await tween.finished
	_currentLabel.text = str(newValue)
	_currentLabel.modulate.a = 1.0
	_nextLabel.hide()
	_labels.position = _startPosition
