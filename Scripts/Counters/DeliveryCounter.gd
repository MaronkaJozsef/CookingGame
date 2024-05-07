extends BaseCounter
class_name DeliveryCounter

signal OnRecipeFailed()
signal OnRecipeSuccess()

func Interact(player: Player) -> void:
	if (player.HasKitchenObject()):
		var plate = player.GetKitchenObject() as PlateKitchenObject
		if (plate):
			# Only accepts Plates
			if (DeliveryManager.Instance.DeliverRecipe(plate)):
				OnRecipeSuccess.emit() 
			else:
				OnRecipeFailed.emit()
			plate.DestroySelf()
