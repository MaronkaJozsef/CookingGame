extends Node3D

@export var plateKitchenObject: PlateKitchenObject
@export var kitchenObjectRESArray: Array[KitchenObjectRES]
@export var kitchenObjectNodeArray: Array[Node3D]

func _ready() -> void:
	plateKitchenObject.OnIngredientAdded.connect(_PlateKitchenObject_OnIngredientAdded)
	
	for node in kitchenObjectNodeArray:
		node.visible = false

func _PlateKitchenObject_OnIngredientAdded(kitchenObjectRES: KitchenObjectRES) -> void:
	var index = kitchenObjectRESArray.find(kitchenObjectRES)
	kitchenObjectNodeArray[index].visible = true
