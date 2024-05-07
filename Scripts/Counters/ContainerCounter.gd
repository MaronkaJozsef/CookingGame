@tool
extends BaseCounter
class_name ContainerCounter

signal OnPlayerGrabbedObject()

@export var kitchenObjectRES: KitchenObjectRES

func Interact(player: Player) -> void:
	if (!player.HasKitchenObject()):
		# Player is not carrying anything
		KitchenObject.SpawnKitchenObject(kitchenObjectRES, player)
		OnPlayerGrabbedObject.emit()

# To automatically set icon of visual
func GetKitchenObjectRes() -> KitchenObjectRES:
	return kitchenObjectRES
