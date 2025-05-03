class_name Game
extends Node2D

var _worldState := WorldState.new()


func _ready() -> void:
	AudioManager.music.play(MusicManager.MusicId.GameTheme)


func _on_timer_timeout() -> void:
	SignalBus.tickAdvanced.emit()
