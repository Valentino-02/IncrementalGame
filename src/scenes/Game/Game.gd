class_name Game
extends Node2D


func _ready() -> void:
	AudioManager.music.play(MusicManager.MusicId.GameTheme)
