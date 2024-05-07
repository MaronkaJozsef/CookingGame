extends Sprite3D

@export var stoveCounter: StoveCounter

func _ready() -> void:
	stoveCounter.OnProgressChanged.connect(_StoveCounter_OnProgressChange)
	hide()

func _StoveCounter_OnProgressChange(progressNormalized: float) -> void:
	const burnShowProgressAmount := 0.5
	var shouldShow := stoveCounter.IsFried() && progressNormalized >= burnShowProgressAmount
	if (shouldShow):
		show()
	else:
		hide()
