extends Control

@export var plateKitchenObject: PlateKitchenObject
@export var iconTemplate: PlateIconsSingleUI

func _ready() -> void:
	plateKitchenObject.OnIngredientAdded.connect(_PlateKitchenObject_OnIngredientAdded)

func _PlateKitchenObject_OnIngredientAdded(_kitchenObjectRES: KitchenObjectRES) -> void:
	UpdateVisual()

func UpdateVisual() -> void:
	for child in get_children():
		if (child == iconTemplate): continue
		child.queue_free()
	
	for kitchenObjectRES in plateKitchenObject.GetKitchenObjectRESArray():
		var icon := iconTemplate.duplicate() as PlateIconsSingleUI
		icon.SetKitchenObjectRES(kitchenObjectRES)
		add_child(icon)
