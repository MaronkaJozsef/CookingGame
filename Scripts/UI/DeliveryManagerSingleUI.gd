extends PanelContainer
class_name DeliveryManagerSingleUI

@export var recipeNameLabel: Label
@export var iconContainer: HBoxContainer
@export var iconTexture: TextureRect

func _ready() -> void:
	iconTexture.visible = false

func SetRecipeRES(recipeRES: RecipeRES) -> void:
	recipeNameLabel.text = recipeRES.recipeName
	
	for kitchenObjectRES in recipeRES.kitchenObjectRESArray:
		var icon := iconTexture.duplicate() as TextureRect
		icon.visible = true
		icon.texture = kitchenObjectRES.sprite
		iconContainer.add_child(icon)
