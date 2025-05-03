class_name WorldState

var _sunState := SunState.new() 
var _moonState := MoonState.new() 
var _currentCycle : Types.Cycle = Types.Cycle.Sun
var _cyclesPassed : int = 0

func _init() -> void:
	SignalBus.passTimeClicked.connect(_passTimeClicked)


func _passTimeClicked() -> void:
	_cyclesPassed += 1
	_currentCycle = Types.Cycle.Sun if _currentCycle == Types.Cycle.Moon else Types.Cycle.Moon
	SignalBus.cyclePassed.emit(_currentCycle)
