class_name SunState

var _isGenerating : bool = true
var _currency : int:
	set(newValue):
		_currency = clamp(newValue, 0, 9999)
		SignalBus.sunCurrencyChanged.emit(_currency)


func _init() -> void:
	SignalBus.tickAdvanced.connect(_onTickAdvanced)
	SignalBus.cyclePassed.connect(_onCyclePassed)


func getCurrency() -> int:
	return _currency

func pay(amount: int) -> void:
	_currency -= amount

func _onTickAdvanced() -> void:
	if not _isGenerating:
		return
	_currency += 1

func _onCyclePassed(toCycle: Types.Cycle) -> void:
	if toCycle == Types.Cycle.Sun:
		_isGenerating = true
	else:
		_isGenerating = false
