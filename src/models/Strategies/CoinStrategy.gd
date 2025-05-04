class_name CoinStrategy 
extends WorldStateStrategy

@export var target : Types.Cycle

func apply(world: WorldState) -> void:
	if target == Types.Cycle.Sun:
		world.sunCoins = true
	if target == Types.Cycle.Moon:
		world.moonCoins = true
