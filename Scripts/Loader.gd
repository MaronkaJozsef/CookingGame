extends Node

enum Scene {
	MainMenuScene,
	GameScene,
	LoadingScene
}

var _targetScene: String
var _sceneMap = {
	Scene.GameScene: "res://Scenes/Game.tscn",
	Scene.MainMenuScene: "res://Scenes/MainMenu.tscn",
	Scene.LoadingScene: "res://Scenes/Loading.tscn"
}

func _init() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	var status := ResourceLoader.load_threaded_get_status(_targetScene)
	if (status == ResourceLoader.THREAD_LOAD_LOADED):
		get_tree().change_scene_to_file(_targetScene)
		process_mode = Node.PROCESS_MODE_DISABLED

func Load(targetScene: Scene) -> void:
	_targetScene = _sceneMap[targetScene]
	ResourceLoader.load_threaded_request(_targetScene)
	
	get_tree().change_scene_to_file(_sceneMap[Scene.LoadingScene])
	process_mode = Node.PROCESS_MODE_INHERIT
