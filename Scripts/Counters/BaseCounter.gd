extends StaticBody3D
class_name BaseCounter

signal OnAnyObjectPlacedHere()

@export var counterTopPoint: Marker3D

var _kitchenObject: KitchenObject

func _ready() -> void:
	Groups.AddTo(Groups.Interactable, self)
	Groups.AddTo(Groups.KitchenObjectParent, self)

func Interact(_player: Player) -> void:
	push_error("BaseCounter.Interact();")
	
func InteractAlternate(_player: Player) -> void:
	pass

func GetKitchenObjectFollowPosition() -> Vector3:
	return counterTopPoint.position

func SetKitchenObject(kitchenObject: KitchenObject) -> void:
	_kitchenObject = kitchenObject
	
	add_child(_kitchenObject)
	if (kitchenObject):
		OnAnyObjectPlacedHere.emit()

func GetKitchenObject() -> KitchenObject:
	return _kitchenObject

func ClearKitchenObject() -> void:
	remove_child(_kitchenObject)
	_kitchenObject = null

func HasKitchenObject() -> bool:
	return _kitchenObject != null
