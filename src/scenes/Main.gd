extends Node
## Entry point of the app.

func _ready() -> void:
	TransitionManager.changeToScene(TransitionManager.SceneId.MainMenu)
