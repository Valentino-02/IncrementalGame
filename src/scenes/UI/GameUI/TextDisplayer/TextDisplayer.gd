class_name TextDisplayer
extends Control

@onready var _sunCost : Label = %SunCost
@onready var _title : Label = %Title
@onready var _moonCost : Label = %MoonCost
@onready var _description : Label = %Description


func _ready() -> void:
	SignalBus.powerUpIconClicked.connect(_onPowerUpIconClicked)


func _onPowerUpIconClicked(data: PowerUpResource) -> void:
	_sunCost.text = str(data.sunCost)
	_moonCost.text = str(data.moonCost)
	_title.text = data.title
	_description.text = data.description
