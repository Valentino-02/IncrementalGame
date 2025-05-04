class_name UpgradesDisplayer
extends Control

@export var upgradeIconScene : PackedScene

@onready var _container : GridContainer = %GridContainer


func _ready() -> void:
	SignalBus.unlockedPowerUpsChanged.connect(_onUnlockedPowerUpsChanged)

func addUpgradeIcon(data: PowerUpResource) -> void:
	var scene : PowerUpUI = upgradeIconScene.instantiate() as PowerUpUI
	scene.setData(data)
	_container.add_child(scene)

func _onUnlockedPowerUpsChanged(newIds: Array[PowerUpManager.PowerUpId]) -> void:
	for child in _container.get_children():
		child.queue_free()
	for id in newIds:
		addUpgradeIcon(PowerUpManager.getPowerUp(id))
