extends Control

@export var container: Control
@export var recipeTemplate: PackedScene

func _ready() -> void:
	DeliveryManager.Instance.OnRecipeSpawned.connect(_DeliveryManager_OnRecipeSpawned)
	DeliveryManager.Instance.OnRecipeCompleted.connect(_DeliveryManager_OnRecipeCompleted)
	
	UpdateVisual()

func _DeliveryManager_OnRecipeCompleted() -> void:
	UpdateVisual()

func _DeliveryManager_OnRecipeSpawned() -> void:
	UpdateVisual()

func UpdateVisual() -> void:
	for child in container.get_children():
		child.queue_free()
	
	for recipeRES in DeliveryManager.Instance.GetWaitingRecipeRESArray():
		var recipe := recipeTemplate.instantiate() as DeliveryManagerSingleUI
		recipe.visible = true
		container.add_child(recipe)
		recipe.SetRecipeRES(recipeRES)