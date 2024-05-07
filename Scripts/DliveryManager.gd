extends Node3D
class_name DeliveryManager

signal OnRecipeSpawned()
signal OnRecipeCompleted()
signal OnRecipeSuccess()
signal OnRecipeFailed()

static var _instance: DeliveryManager = null
static var Instance: DeliveryManager:
	get: return _instance

@export var recipeArrayRES: RecipeArrayRES

var _waitingRecpieRESArray: Array[RecipeRES]
var _spawnRecipeTimer: float
var _spawnRecipeTimerMax: float = 4
var _waitingRecipesMax: int = 4
var _successfulRecipesAmount: int = 0

func _init() -> void:
	if (_instance):
		push_error("There is more than one DliveryManager instance")
	_instance = self

func _ready() -> void:
	_waitingRecpieRESArray = []

func _process(delta: float) -> void:
	_spawnRecipeTimer -= delta
	if (_spawnRecipeTimer <= 0):
		_spawnRecipeTimer = _spawnRecipeTimerMax
		
		if (KitchenGameManager.Instance.IsGamePlaying() && _waitingRecpieRESArray.size() < _waitingRecipesMax):
			var waitingRecipeRES := recipeArrayRES.recipeRESArray.pick_random() as RecipeRES
			_waitingRecpieRESArray.append(waitingRecipeRES)
			OnRecipeSpawned.emit()

func _exit_tree() -> void:
	_instance = null

func DeliverRecipe(plateKitchenObject: PlateKitchenObject) -> bool:
	for waitingRecipeRES in _waitingRecpieRESArray:
		if (waitingRecipeRES.kitchenObjectRESArray.size() == plateKitchenObject.GetKitchenObjectRESArray().size()):
			var plateContentsMatchesRecipe := true
			for recipeKitchenObjectRES in waitingRecipeRES.kitchenObjectRESArray:
				if (plateKitchenObject.GetKitchenObjectRESArray().find(recipeKitchenObjectRES) == -1):
					plateContentsMatchesRecipe = false
					break
			
			if (plateContentsMatchesRecipe):
				_waitingRecpieRESArray.erase(waitingRecipeRES)
				OnRecipeCompleted.emit()
				OnRecipeSuccess.emit()
				_successfulRecipesAmount += 1
				return true
	
	# No matches found!
	# Player did not deliver a correct recipe
	OnRecipeFailed.emit()
	return false

func GetWaitingRecipeRESArray() -> Array[RecipeRES]:
	return _waitingRecpieRESArray

func GetSuccessfulRecipesAmount() -> int:
	return _successfulRecipesAmount
