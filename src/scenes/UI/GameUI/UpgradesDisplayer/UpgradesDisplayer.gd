class_name UpgradesDisplayer
extends Control

@export var upgradeIconScene : PackedScene

@onready var _container : GridContainer = %GridContainer


func _ready() -> void:
	addUpgradeIcon(PowerUpManager.getPowerUp(PowerUpManager.PowerUpId.UpgradesUnlock1))
	addUpgradeIcon(PowerUpManager.getPowerUp(PowerUpManager.PowerUpId.MaxHealth1))

func addUpgradeIcon(data: PowerUpResource) -> void:
	var scene : PowerUpUI = upgradeIconScene.instantiate() as PowerUpUI
	scene.setData(data)
	_container.add_child(scene)
	
