class_name PowerUpResource
extends Resource

@export var icon : Texture2D
@export var title: String
@export var sunCost: int
@export var moonCost: int
@export_multiline var description: String
@export var strategies: Array[WorldStateStrategy] = []

var _id : PowerUpManager.PowerUpId


func setId(id: PowerUpManager.PowerUpId) -> void:
	_id = id

func getId() -> PowerUpManager.PowerUpId:
	return _id
