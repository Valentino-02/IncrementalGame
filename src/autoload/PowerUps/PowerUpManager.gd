extends Node

enum PowerUpId{
	UpgradesUnlock1,
	MaxHealth1,
	MoreMoon1,
	MoreSun1,
}

@export var powerUps : Dictionary[PowerUpId, PowerUpResource]

var _unlockGraph: Dictionary[PowerUpId, Array] = {
	PowerUpId.UpgradesUnlock1: [],
	PowerUpId.MaxHealth1: [PowerUpId.UpgradesUnlock1],
	PowerUpId.MoreMoon1: [PowerUpId.UpgradesUnlock1],
	PowerUpId.MoreSun1: [PowerUpId.UpgradesUnlock1],
}

func _ready() -> void:
	_setIds()


func getPowerUp(id: PowerUpId) -> PowerUpResource:
	return powerUps.get(id)

func takeUnlockedPowerUps(locked: Array[PowerUpManager.PowerUpId], owned: Array[PowerUpManager.PowerUpId]) -> Array[PowerUpManager.PowerUpId]:
	var newUnlocked : Array[PowerUpId] = []
	for id in locked.duplicate():
		if _shouldUnlock(id, owned):
			newUnlocked.append(id)
			locked.erase(id)
	return newUnlocked

func getAllIds() -> Array[PowerUpId]:
	return powerUps.keys()

func _setIds() -> void:
	for id in powerUps.keys():
		var powerUp : PowerUpResource = powerUps.get(id) as PowerUpResource
		powerUp.setId(id)

func _shouldUnlock(id: PowerUpId, owned: Array[PowerUpManager.PowerUpId]) -> bool:
	var requirements = _unlockGraph.get(id, [])
	for req in requirements:
		if req not in owned:
			return false
	return true
