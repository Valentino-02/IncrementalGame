class_name MaxCurrencyStrategy 
extends WorldStateStrategy

@export var amount : int

func apply(world: WorldState) -> void:
	world.setMaxCurrency(amount)
