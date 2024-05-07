extends BaseCounterAudio

func _ready() -> void:
	(counter as DeliveryCounter).OnRecipeFailed.connect(_DeliveryCounter_OnRecipeFailed)
	(counter as DeliveryCounter).OnRecipeSuccess.connect(_DeliveryCounter_OnRecipeSuccess)

func _DeliveryCounter_OnRecipeFailed() -> void:
	PlaySoundFromArray(audioStreamRefsRES.deliveryFail)

func _DeliveryCounter_OnRecipeSuccess() -> void:
	PlaySoundFromArray(audioStreamRefsRES.deliverySuccess)
