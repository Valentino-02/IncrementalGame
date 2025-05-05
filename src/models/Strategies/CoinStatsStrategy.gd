class_name CoinStatsStrategy 
extends WorldStateStrategy

enum Type {
	Max,
	Frecuency
}

@export var type : Type
@export var amount : float

func apply(world: WorldState) -> void:
	if type == Type.Max:
		world.increaseCoinCap(int(amount))
	if type == Type.Frecuency:
		world.increaseCoinFrecuency(amount)
