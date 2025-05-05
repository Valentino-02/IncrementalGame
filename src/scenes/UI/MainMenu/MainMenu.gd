class_name MainMenu
extends CanvasLayer


func _ready() -> void:
	AudioManager.music.play(MusicManager.MusicId.MainMenuTheme)
	if TransitionManager.shouldWin:
		$Label.show()
		$StartGameButton.hide()

func _on_start_game_button_pressed() -> void:
	AudioManager.sfx.play(SfxManager.SfxId.Click)
	TransitionManager.changeToScene(TransitionManager.SceneId.Game)
	AudioManager.music.stop()
