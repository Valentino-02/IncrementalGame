class_name LoseBar
extends Control

@onready var _sunBar : ProgressBar = %SunBar
@onready var _moonBar : ProgressBar = %MoonBar

var _sunBarPosition : Vector2
var _moonBarPosition : Vector2


func _ready() -> void:
	SignalBus.sunCurrencyChanged.connect(func(newValue) : _onCurrencyChanged(_sunBar, newValue))
	SignalBus.moonCurrencyChanged.connect(func(newValue) : _onCurrencyChanged(_moonBar, newValue))
	SignalBus.maxCurrencyChanged.connect(_onMaxCurrencyChanged)
	await get_tree().process_frame
	_sunBarPosition = _sunBar.position
	_moonBarPosition = _moonBar.position

func _onCurrencyChanged(bar: ProgressBar, newValue: int) -> void:
	bar.value = newValue
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if bar == _moonBar:
		tween.tween_property(bar, "position", _moonBarPosition + Vector2(10, 0), 0.1)
		tween.tween_property(bar, "position", _moonBarPosition , 0.1)
	else:
		tween.tween_property(bar, "position", _sunBarPosition + Vector2(-10, 0), 0.1)
		tween.tween_property(bar, "position", _sunBarPosition, 0.1)

func _onMaxCurrencyChanged(newValue: int) -> void:
	_sunBar.max_value = newValue
	_moonBar.max_value = newValue
