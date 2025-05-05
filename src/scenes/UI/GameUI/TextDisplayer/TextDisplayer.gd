class_name TextDisplayer
extends Control

@onready var _sunCost : Label = %SunCost
@onready var _title : Label = %Title
@onready var _moonCost : Label = %MoonCost
@onready var _description : Label = %Description
@onready var _background : ColorRect = %FocusBackground
@onready var _buyIcon : Panel = %BuyPanel
@onready var _particles : GPUParticles2D = %GPUParticles2D

var _currentData : PowerUpResource
var _canBuy : bool = false

func _ready() -> void:
	SignalBus.powerUpIconClicked.connect(_onPowerUpIconClicked)
	_background.modulate.a = 0.0
	_buyIcon.modulate.a = 0.0
	SignalBus.currencyChanged.connect(_onCurrencyChanged)


func _onPowerUpIconClicked(data: PowerUpResource) -> void:
	_sunCost.text = str(data.sunCost)
	_moonCost.text = str(data.moonCost)
	_title.text = data.title
	_description.text = data.description
	_currentData = data

func _onCurrencyChanged(sunNewValue: int, moonNewValue: int) -> void:
	if not _currentData:
		return
	if sunNewValue >= _currentData.sunCost and moonNewValue >= _currentData.moonCost:
		_canBuy = true
		_particles.emitting = true
	else:
		_canBuy = false
		_particles.emitting = false

func _on_mouse_entered() -> void:
	if not _currentData:
		return
	_background.show()
	_buyIcon.show()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property(_background, "modulate:a", 0.7, 0.3)
	tween.tween_property(_buyIcon, "modulate:a", 1.0, 0.3)

func _on_mouse_exited() -> void:
	if not _currentData:
		return
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel(true)
	tween.tween_property(_background, "modulate:a", 0.0, 0.2)
	tween.tween_property(_buyIcon, "modulate:a", 0.0, 0.2)
	await tween.finished
	_background.hide()
	_buyIcon.hide()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not _canBuy:
				return
			AudioManager.sfx.play(SfxManager.SfxId.PurchasePower)
			SignalBus.powerUpBought.emit(_currentData)
			_on_mouse_exited()
			_currentData = null
			_sunCost.text = ""
			_moonCost.text = ""
			_title.text = ""
			_description.text = ""
			_canBuy = false
			_particles.emitting = false
