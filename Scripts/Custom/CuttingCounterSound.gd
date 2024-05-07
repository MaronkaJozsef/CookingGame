extends BaseCounterAudio

func _ready() -> void:
	(counter as CuttingCounter).OnCut.connect(_cuttingCounter_OnCut)

func _cuttingCounter_OnCut() -> void:
	PlaySoundFromArray(audioStreamRefsRES.chop)
