extends Node

enum PowerUpId{
	UpgradesUnlock1,
	UpgradesUnlock2,
	MaxHealth1,
	MaxHealth2,
	MaxHealth3,
	MaxHealth4,
	MaxHealth5,
	MaxHealth6,
	MaxHealth7,
	MaxHealth8,
	MaxHealth9,
	MaxHealth10,
	SunCoins,
	MoonCoins,
	MoreMoon1,
	MoreMoon2,
	MoreMoon3,
	MoreMoon4,
	MoreSun1,
	MoreSun2,
	MoreSun3,
	MoreSun4,
}

@export var powerUps : Dictionary[PowerUpId, PowerUpResource]

var _unlockGraph: Dictionary[PowerUpId, Array] = {
	PowerUpId.UpgradesUnlock1: [],
	PowerUpId.UpgradesUnlock2: [PowerUpId.UpgradesUnlock1],
	PowerUpId.MaxHealth1: [PowerUpId.UpgradesUnlock1],
	PowerUpId.MaxHealth2: [PowerUpId.MaxHealth1],
	PowerUpId.MaxHealth3: [PowerUpId.MaxHealth2],
	PowerUpId.MaxHealth4: [PowerUpId.MaxHealth3],
	PowerUpId.MaxHealth5: [PowerUpId.MaxHealth4, PowerUpId.UpgradesUnlock2],
	PowerUpId.MaxHealth6: [PowerUpId.MaxHealth5],
	PowerUpId.MaxHealth7: [PowerUpId.MaxHealth6],
	PowerUpId.MaxHealth8: [PowerUpId.MaxHealth7],
	PowerUpId.MaxHealth9: [PowerUpId.MaxHealth8],
	PowerUpId.MaxHealth10: [PowerUpId.MaxHealth9],
	PowerUpId.SunCoins: [PowerUpId.UpgradesUnlock1],
	PowerUpId.MoonCoins: [PowerUpId.UpgradesUnlock1],
	PowerUpId.MoreSun1: [PowerUpId.UpgradesUnlock2],
	PowerUpId.MoreSun2: [PowerUpId.MoreSun1],
	PowerUpId.MoreSun3: [PowerUpId.MoreSun2],
	PowerUpId.MoreSun4: [PowerUpId.MoreSun3],
	PowerUpId.MoreMoon1: [PowerUpId.UpgradesUnlock2],
	PowerUpId.MoreMoon2: [PowerUpId.MoreMoon1],
	PowerUpId.MoreMoon3: [PowerUpId.MoreMoon2],
	PowerUpId.MoreMoon4: [PowerUpId.MoreMoon3],
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
	var requirements = _unlockGraph.get(id)
	if requirements == null:
		return false
	for req in requirements:
		if req not in owned:
			return false
	return true
