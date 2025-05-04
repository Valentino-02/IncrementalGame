class_name WorldState

var _sunState := SunState.new() 
var _moonState := MoonState.new() 
var _currentCycle : Types.Cycle = Types.Cycle.Sun
var _cyclesPassed : int = 0

func _init() -> void:
	SignalBus.passTimeClicked.connect(_passTimeClicked)


func _passTimeClicked() -> void:
	_cyclesPassed += 1
	if _currentCycle == Types.Cycle.Sun:
		_currentCycle = Types.Cycle.Moon
		AudioManager.music.enableLowPass()
	else:
		_currentCycle = Types.Cycle.Sun
		AudioManager.music.disableLowPass()
	SignalBus.cyclePassed.emit(_currentCycle)
