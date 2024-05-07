extends BaseCounter
class_name TrashCounter

signal OnAnyObjectTrashed()

func Interact(player: Player) -> void:
	if (player.HasKitchenObject()):
		player.GetKitchenObject().DestroySelf()
		
		OnAnyObjectTrashed.emit()
	
