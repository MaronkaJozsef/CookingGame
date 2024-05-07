extends BaseCounterAudio

func _ready() -> void:
	(counter as TrashCounter).OnAnyObjectTrashed.connect(_trashCounter_OnAnyObjectTrashed)
	
func _trashCounter_OnAnyObjectTrashed() -> void:
	PlaySoundFromArray(audioStreamRefsRES.thrash)
