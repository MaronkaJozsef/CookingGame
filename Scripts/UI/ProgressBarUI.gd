extends Node3D

@export var counter: Node3D
@export var progressBar: ProgressBar

func _ready() -> void:
	Hide()
	counter.OnProgressChanged.connect(_HasProgress_OnProgressChange)

func _HasProgress_OnProgressChange(progressNomalized: float) -> void:
	progressBar.value = progressNomalized * 100
	
	if (progressNomalized == 0.0 || progressNomalized == 1.0):
		Hide()
	else:
		Show()

func Show() -> void:
	progressBar.visible = true

func Hide() -> void:
	progressBar.visible = false
