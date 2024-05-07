extends Control

@export var playButton: Button
@export var quitButton: Button
@export_file("*.tscn") var gameScene: String

func _ready() -> void:
	playButton.grab_focus()
	Engine.time_scale = 1.0
	playButton.pressed.connect(func(): Loader.Load(Loader.Scene.GameScene))
	quitButton.pressed.connect(func(): get_tree().quit())
