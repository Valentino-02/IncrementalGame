class_name SunState

var _isGenerating : bool = true
var _currencyPerTick : int = 1
var _currency : int:
	set(newValue):
		_currency = clamp(newValue, 0, 9999)
		SignalBus.sunCurrencyChanged.emit(_currency)


func _init() -> void:
	SignalBus.tickAdvanced.connect(_onTickAdvanced)
	SignalBus.cyclePassed.connect(_onCyclePassed)
	SignalBus.maxCurrencyReached.connect(_onMaxCurrencyReached)
	SignalBus.coinCollected.connect(_onCoinPicked)


func getCurrency() -> int:
	return _currency

func setCurrencyPerTick(newValue: int) -> void:
	_currencyPerTick = newValue

func pay(amount: int) -> void:
	_currency -= amount

func _onTickAdvanced() -> void:
	if not _isGenerating:
		return
	_currency += _currencyPerTick

func _onCyclePassed(toCycle: Types.Cycle) -> void:
	if toCycle == Types.Cycle.Sun:
		_isGenerating = true
	else:
		_isGenerating = false

func _onMaxCurrencyReached() -> void:
	_currency = 0

func _onCoinPicked(type: Types.Cycle) -> void:
	if type != Types.Cycle.Sun:
		return
	_currency += _currencyPerTick
