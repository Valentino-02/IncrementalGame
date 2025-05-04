class_name SunState

var _isGenerating : bool = true
var _currency : int:
	set(newValue):
		_currency = newValue
		SignalBus.sunCurrencyChanged.emit(_currency)


func _init() -> void:
	SignalBus.tickAdvanced.connect(_onTickAdvanced)
	SignalBus.cyclePassed.connect(_onCyclePassed)


func _onTickAdvanced() -> void:
	if not _isGenerating:
		return
	_currency += 1

func _onCyclePassed(toCycle: Types.Cycle) -> void:
	if toCycle == Types.Cycle.Sun:
		_isGenerating = true
	else:
		_isGenerating = false
