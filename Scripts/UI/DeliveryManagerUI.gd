extends Control

@export var container: Control
@export var recipeTemplate: PackedScene

func _ready() -> void:
	updateVisual()
	DeliveryManager.Instance.OnRecipeSpawned.connect(onRecipeSpawned)
	DeliveryManager.Instance.OnRecipeCompleted.connect(onRecipeCompleted)

func updateVisual() -> void:
	for child in container.get_children():
		child.queue_free()
	
	for recipeRES in DeliveryManager.Instance.GetWaitingRecipeRESArray():
		var recipe := recipeTemplate.instantiate() as DeliveryManagerSingleUI
		recipe.visible = true
		container.add_child(recipe)
		recipe.SetRecipeRES(recipeRES)

func onRecipeCompleted() -> void:
	updateVisual()

func onRecipeSpawned() -> void:
	updateVisual()
