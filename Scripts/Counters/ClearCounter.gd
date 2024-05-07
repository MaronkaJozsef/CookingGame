extends BaseCounter
class_name ClearCounter

func Interact(player: Player) -> void:
	if (!HasKitchenObject()):
		# There is no KitchenObject here
		if (player.HasKitchenObject()):
			# Player is carrying something
			player.GetKitchenObject().SetKitchenObjectParent(self)
		else:
			# Player not carrying anything
			pass
	else:
		# There is a KitchenObject here
		if (player.HasKitchenObject()):
			# Player is carrying something
			var plate := player.GetKitchenObject() as PlateKitchenObject
			if (plate != null):
				# Player is holding a Plate
				if (plate.TryAddIngredient(GetKitchenObject().GetKitchenObjectRES())):
					GetKitchenObject().DestroySelf()
			else:
				# Player is not carrying Plate but something else
				var plateOnCounter := GetKitchenObject() as PlateKitchenObject
				if (plateOnCounter != null):
					# Counter is holding a Plate
					if (plateOnCounter.TryAddIngredient(player.GetKitchenObject().GetKitchenObjectRES())):
						player.GetKitchenObject().DestroySelf()
		else:
			# Player is not carrying anything
			GetKitchenObject().SetKitchenObjectParent(player)
