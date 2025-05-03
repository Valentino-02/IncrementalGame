class_name MusicManager
extends Node

enum MusicId {
	MainMenuTheme,
	GameTheme
}

const MUSIC_BUS_NAME = 'Music'

@export var preloadedMusic: Dictionary[MusicId , MusicResource]

@onready var _player : AudioStreamPlayer = $AudioStreamPlayer

var _musicBusIndex : int = -1 


func _ready() -> void:
	_setMusicBus()
	_setIds()


func getBusIndex() -> int:
	return _musicBusIndex

func play(id: MusicId, fadeInDuration: float = 0.0) -> void:
	var music : MusicResource = preloadedMusic.get(id) as MusicResource
	if music == null:
		push_error("Sfx Manager failed to find music with id ", id)
	_player.set_stream(music.stream)
	_player.pitch_scale = music.pitchScale
	_player.play()
	_fadeIn(music.volume, fadeInDuration)

func stop(fadeOutDuration: float = 0.0) -> void:
	await _fadeOut(fadeOutDuration)
	_player.stop()

func enableLowPass(duration:= 0.25) -> void:
	var tween = create_tween()
	var effect = AudioServer.get_bus_effect(_musicBusIndex, 0)
	tween.tween_property(effect, "cutoff_hz", Settings.LOW_PASS_HZ_VALUE, duration).set_trans(Tween.TRANS_LINEAR)

func disableLowPass(duration:= 0.5) -> void:
	var tween = create_tween()
	var effect = AudioServer.get_bus_effect(_musicBusIndex, 0)
	tween.tween_property(effect, "cutoff_hz", Settings.NORMAL_HZ_VALUE, duration).set_trans(Tween.TRANS_LINEAR)


func _fadeIn(targetVolume: float, duration:= 1.5) -> void:
	_player.volume_db = Settings.MIN_VOLUME
	var tween = get_tree().create_tween()
	tween.tween_property(_player, "volume_db", targetVolume, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _fadeOut(duration:= 1.5) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(_player, "volume_db", Settings.MIN_VOLUME, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished

func _setMusicBus() -> void:
	_musicBusIndex = AudioServer.get_bus_index(MUSIC_BUS_NAME)
	if _musicBusIndex == -1:
		push_error("Music Manager failed to find bus with name: ", MUSIC_BUS_NAME)
	_player.set_bus(MUSIC_BUS_NAME)

func _setIds() -> void:
	for id in preloadedMusic.keys():
		var music : MusicResource = preloadedMusic.get(id) as MusicResource
		music.setId(id)
