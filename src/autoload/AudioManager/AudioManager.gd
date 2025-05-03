extends Node

@onready var music : MusicManager = %MusicManager
@onready var sfx : SfxManager = %SfxManager


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	setMusicVolume(Settings.DEFAULT_MUSIC_VOLUME)
	setSfxVolume(Settings.DEFAULT_SFX_VOLUME)


func setMusicVolume(value: float) -> void:
	AudioServer.set_bus_volume_db(music.getBusIndex(), linear_to_db(value))
	
func setSfxVolume(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx.getBusIndex(), linear_to_db(value))

func getMusicVolume():
	return db_to_linear(AudioServer.get_bus_volume_db(music.getBusIndex()))
	
func getSfxVolume():
	return db_to_linear(AudioServer.get_bus_volume_db(sfx.getBusIndex()))
