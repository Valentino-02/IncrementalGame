class_name SfxManager
extends Node2D

const SFX_BUS_NAME = 'Sfx'

@export var preloadedSfx: Dictionary[AudioManager.SfxId, SfxResource]

var _sfxBusIndex : int = -1


func _ready() -> void:
	_setSfxBus()


func getBusIndex() -> int:
	return _sfxBusIndex

func playAtPosition(id: AudioManager.SfxId, pos: Vector2) -> void:
	var sfx : SfxResource = preloadedSfx.get(id) as SfxResource
	if sfx == null:
		push_error("Sfx Manager failed to find sfx with id ", id)
	if not sfx.shouldPlay() :
		return
	
	sfx.addCount()
	var player2D := AudioStreamPlayer2D.new()
	player2D.set_bus(SFX_BUS_NAME)
	player2D.position = pos
	player2D.stream = sfx.sound_effect
	player2D.volume_db = sfx.volume
	player2D.pitch_scale = sfx.pitch_scale
	player2D.finished.connect(sfx._onAudioFinished)
	player2D.finished.connect(player2D.queue_free)
	add_child(player2D)
	player2D.play()

func play(id: AudioManager.SfxId) -> void:
	var sfx : SfxResource = preloadedSfx.get(id) as SfxResource
	if sfx == null:
		push_error("Sfx Manager failed to find sfx with id ", id)
	if not sfx.shouldPlay() :
		return
	
	sfx.addCount()
	var player := AudioStreamPlayer.new()
	player.set_bus(SFX_BUS_NAME)
	player.stream = sfx.stream
	player.volume_db = sfx.volume
	player.pitch_scale = sfx.pitchScale
	player.finished.connect(sfx._onAudioFinished)
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()


func _setSfxBus() -> void:
	_sfxBusIndex = AudioServer.get_bus_index(SFX_BUS_NAME)
	if _sfxBusIndex == -1:
		push_error("Sfx Manager failed to find bus with name: ", SFX_BUS_NAME)

func _setIds() -> void:
	for id in preloadedSfx.keys():
		var sfx : SfxResource = preloadedSfx.get(id) as SfxResource
		sfx.setId(id)
