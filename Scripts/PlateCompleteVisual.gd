extends Node3D

@export var plateKitchenObject: PlateKitchenObject
@export var kitchenObjectRESArray: Array[KitchenObjectRES]
@export var kitchenObjectNodeArray: Array[Node3D]

func _ready() -> void:
	plateKitchenObject.OnIngredientAdded.connect(onIngredientAdded)
	for node in kitchenObjectNodeArray:
		node.visible = false

func onIngredientAdded(kitchenObjectRES: KitchenObjectRES) -> void:
	var index = kitchenObjectRESArray.find(kitchenObjectRES)
	kitchenObjectNodeArray[index].visible = true
