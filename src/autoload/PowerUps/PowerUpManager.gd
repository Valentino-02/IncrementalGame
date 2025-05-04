extends Node

enum PowerUpId{
	UpgradesUnlock1,
	MaxHealth1,
}

@export var powerUps : Dictionary[PowerUpId, PowerUpResource]

func getPowerUp(id: PowerUpId) -> PowerUpResource:
	return powerUps.get(id)
