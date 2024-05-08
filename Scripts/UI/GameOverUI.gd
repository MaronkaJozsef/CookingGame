extends Control

@export var recipesDeliveredText: Label

func _ready() -> void:
	KitchenGameManager.Instance.OnStateChanged.connect(kitchenGameManager_OnStateChanged)
	
	hide()

func kitchenGameManager_OnStateChanged() -> void:
	if (KitchenGameManager.Instance.IsGameOver()):
		show()
		
		recipesDeliveredText.text = str(DeliveryManager.Instance.GetSuccessfulRecipesAmount())
	else:
		hide()
