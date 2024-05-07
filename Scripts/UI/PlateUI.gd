extends Control

@export var plateKitchenObject: PlateKitchenObject
@export var iconTemplate: PlateIconsSingleUI

func _ready() -> void:
	plateKitchenObject.OnIngredientAdded.connect(onIngredientAdded)

func onIngredientAdded(_kitchenObjectRES: KitchenObjectRES) -> void:
	updateVisual()

func updateVisual() -> void:
	for child in get_children():
		if (child == iconTemplate):
			continue
		child.queue_free()
	
	for kitchenObjectRES in plateKitchenObject.GetKitchenObjectRESArray():
		var icon := iconTemplate.duplicate() as PlateIconsSingleUI
		icon.SetKitchenObjectRES(kitchenObjectRES)
		add_child(icon)
