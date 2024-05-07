extends AudioPlayerBase
class_name BaseCounterAudio

@export var counter: BaseCounter

func _ready() -> void:
	counter.OnAnyObjectPlacedHere.connect(_BaseCounter_OnAnyObjectPlacedHere)

func _BaseCounter_OnAnyObjectPlacedHere() -> void:
	PlaySoundFromArray(audioStreamRefsRES.objectDrop)
