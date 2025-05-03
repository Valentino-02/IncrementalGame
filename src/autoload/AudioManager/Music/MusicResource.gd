class_name MusicResource
extends Resource

@export var stream : AudioStream
@export_range(-40, 20) var volume: float = 0 
@export_range(0.0, 4.0,.01) var pitchScale: float = 1.0 

var _id : AudioManager.MusicId 

func setId(id: AudioManager.MusicId) -> void:
	_id = id
