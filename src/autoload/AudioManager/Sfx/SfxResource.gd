class_name SfxResource
extends Resource

@export var stream : AudioStream 
@export_range(-40, 20) var volume: float = 0 
@export_range(0.0, 4.0,.01) var pitchScale: float = 1.0 
@export_range(0, 10) var limit: int = 5 

var _count: int = 0 
var _id : AudioManager.SfxId 

func setId(id: AudioManager.SfxId) -> void:
	_id = id

func addCount() -> void:
	_count += 1

func shouldPlay() -> bool:
	return _count < limit

func _onAudioFinished() -> void:
	_count = max(0, _count -1)
