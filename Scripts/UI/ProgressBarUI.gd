extends Node3D

@export var counter: Node3D
@export var progressBar: ProgressBar

func _ready() -> void:
	_hide()
	counter.OnProgressChanged.connect(onProgressChange)

func onProgressChange(progressNomalized: float) -> void:
	progressBar.value = progressNomalized * 100
	_show() if progressNomalized > 0 && progressNomalized < 1 else _hide()

func _show() -> void:
	progressBar.visible = true

func _hide() -> void:
	progressBar.visible = false
