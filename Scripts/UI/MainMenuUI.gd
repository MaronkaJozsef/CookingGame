extends Control

@export var playButton: Button
@export var quitButton: Button
@export_file("*.tscn") var gameScene: String

func _ready() -> void:
	playButton.grab_focus()
	
	playButton.pressed.connect(func(): Loader.Load(Loader.Scene.GameScene))
	quitButton.pressed.connect(func(): get_tree().quit())

	Engine.time_scale = 1.0
