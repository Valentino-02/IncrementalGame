extends CanvasLayer

enum SceneId {
	MainMenu,
	Game,
}

const TRANSITION_TIME = 2.0

@export var preloadedScenes: Dictionary[SceneId, PackedScene]

@onready var _colorRect: ColorRect = $ColorRect


func _ready() -> void:
	_colorRect.modulate.a = 0.0


func changeToScene(id: SceneId, transitionTime: float = TRANSITION_TIME) -> void:
	var scene = preloadedScenes.get(id) as PackedScene
	if scene == null:
		push_error("Transition Manager failed to find scene with id ", id)
	await _transitionIn(transitionTime/2)
	get_tree().change_scene_to_packed(scene)
	_transitionOut(transitionTime/2)


func _transitionIn(duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(_colorRect, "modulate:a", 1.0, duration)
	await tween.finished

func _transitionOut(duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(_colorRect, "modulate:a", 0.0, duration)
