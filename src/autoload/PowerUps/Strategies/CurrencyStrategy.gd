class_name CurrencyStrategy 
extends WorldStateStrategy

@export var target : Types.Cycle
@export var amount : int

func apply(world: WorldState) -> void:
	if target == Types.Cycle.Sun:
		world.getSunState().setCurrencyPerTick(amount)
	if target == Types.Cycle.Moon:
		world.getMoonState().setCurrencyPerTick(amount)
