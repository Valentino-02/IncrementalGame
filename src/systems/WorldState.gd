class_name WorldState

var _sunState := SunState.new() 
var _moonState := MoonState.new() 
var _maxCurrency : int:
	set(newValue):
		_maxCurrency = newValue
		SignalBus.maxCurrencyChanged.emit(_maxCurrency)
var _currentCycle : Types.Cycle = Types.Cycle.Sun
var _lockedPowerUps : Array[PowerUpManager.PowerUpId] = []
var _unlockedPowerUps : Array[PowerUpManager.PowerUpId] = []
var _ownedPowerUps: Array[PowerUpManager.PowerUpId] = []
var sunCoins := false
var moonCoins := false


func _init() -> void:
	SignalBus.passTimeClicked.connect(changeCycle)
	SignalBus.sunCurrencyChanged.connect(func(newValue): _onCurrencyChanged(Types.Cycle.Sun, newValue))
	SignalBus.moonCurrencyChanged.connect(func(newValue): _onCurrencyChanged(Types.Cycle.Moon, newValue))
	SignalBus.powerUpBought.connect(_onPowerUpBought)

func getSunState() -> SunState:
	return _sunState

func getMoonState() -> MoonState:
	return _moonState

func setStartingConditions() -> void:
	_lockedPowerUps = PowerUpManager.getAllIds()
	var newUnlocks = PowerUpManager.takeUnlockedPowerUps(_lockedPowerUps, _ownedPowerUps)
	_unlockedPowerUps.append_array(newUnlocks)
	SignalBus.unlockedPowerUpsChanged.emit(_unlockedPowerUps)
	_maxCurrency = 10

func setMaxCurrency(newValue: int) -> void:
	_maxCurrency = newValue

func changeCycle() -> void:
	if _currentCycle == Types.Cycle.Sun:
		_currentCycle = Types.Cycle.Moon
		AudioManager.music.enableLowPass()
	else:
		_currentCycle = Types.Cycle.Sun
		AudioManager.music.disableLowPass()
	SignalBus.cyclePassed.emit(_currentCycle)

func _onCurrencyChanged(type: Types.Cycle, newValue: int) -> void:
	if newValue >= _maxCurrency:
		SignalBus.maxCurrencyReached.emit()
	if type == Types.Cycle.Sun:
		SignalBus.currencyChanged.emit(newValue, _moonState.getCurrency())
	if type == Types.Cycle.Moon:
		SignalBus.currencyChanged.emit(_sunState.getCurrency(), newValue)

func _onPowerUpBought(data: PowerUpResource) -> void:
	_sunState.pay(data.sunCost)
	_moonState.pay(data.moonCost)
	_ownedPowerUps.append(data.getId())
	var newUnlocks = PowerUpManager.takeUnlockedPowerUps(_lockedPowerUps, _ownedPowerUps)
	_unlockedPowerUps.erase(data.getId())
	_unlockedPowerUps.append_array(newUnlocks)
	_applyStrategies(data.strategies)
	SignalBus.ownedPowerUpsChanged.emit(_ownedPowerUps)
	SignalBus.unlockedPowerUpsChanged.emit(_unlockedPowerUps)

func _applyStrategies(strategies: Array[WorldStateStrategy]) -> void:
	for strategy in strategies:
		strategy.apply(self)
