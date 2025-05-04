class_name WorldState

var _sunState := SunState.new() 
var _moonState := MoonState.new() 
var _currentCycle : Types.Cycle = Types.Cycle.Sun


func _init() -> void:
	SignalBus.passTimeClicked.connect(changeCycle)
	SignalBus.sunCurrencyChanged.connect(func(newValue): _onCurrencyChanged(Types.Cycle.Sun, newValue))
	SignalBus.moonCurrencyChanged.connect(func(newValue): _onCurrencyChanged(Types.Cycle.Moon, newValue))
	SignalBus.powerUpBought.connect(_onPowerUpBought)


func changeCycle() -> void:
	if _currentCycle == Types.Cycle.Sun:
		_currentCycle = Types.Cycle.Moon
		AudioManager.music.enableLowPass()
	else:
		_currentCycle = Types.Cycle.Sun
		AudioManager.music.disableLowPass()
	SignalBus.cyclePassed.emit(_currentCycle)

func _onCurrencyChanged(type: Types.Cycle, newValue: int) -> void:
	if type == Types.Cycle.Sun:
		SignalBus.currencyChanged.emit(newValue, _moonState.getCurrency())
	if type == Types.Cycle.Moon:
		SignalBus.currencyChanged.emit(_sunState.getCurrency(), newValue)

func _onPowerUpBought(data: PowerUpResource) -> void:
	_sunState.pay(data.sunCost)
	_moonState.pay(data.moonCost)
