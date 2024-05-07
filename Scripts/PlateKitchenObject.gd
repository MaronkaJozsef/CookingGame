extends KitchenObject
class_name PlateKitchenObject

signal OnIngredientAdded(kitchenObjectRES: KitchenObjectRES)

@export var validKitchenObjectRESArray: Array[KitchenObjectRES]

var _kitchenObjectRESArray: Array[KitchenObjectRES] = []

func TryAddIngredient(kitchenObjRES: KitchenObjectRES) -> bool:
	if (!validKitchenObjectRESArray.has(kitchenObjRES)):
		return false
	if (_kitchenObjectRESArray.has(kitchenObjRES)): 
		return false
	
	_kitchenObjectRESArray.append(kitchenObjRES)
	OnIngredientAdded.emit(kitchenObjRES)
	return true

func GetKitchenObjectRESArray() -> Array[KitchenObjectRES]:
	return _kitchenObjectRESArray
