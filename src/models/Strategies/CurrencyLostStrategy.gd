class_name CurrencyLostStrategy 
extends WorldStateStrategy

@export var target : Types.Cycle
@export var factor : int

func apply(world: WorldState) -> void:
	if target == Types.Cycle.Sun:
		world.getSunState().factor = factor
	if target == Types.Cycle.Moon:
		world.getMoonState().factor = factor
