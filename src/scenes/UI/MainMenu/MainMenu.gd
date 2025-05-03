class_name MainMenu
extends CanvasLayer


func _ready() -> void:
	AudioManager.music.play(AudioManager.MusicId.MainMenuTheme)


func _on_start_game_button_pressed() -> void:
	AudioManager.sfx.play(AudioManager.SfxId.Click)
	TransitionManager.changeToScene(TransitionManager.SceneId.Game)
	AudioManager.music.stop()
