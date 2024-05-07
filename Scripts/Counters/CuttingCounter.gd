extends BaseCounter
class_name CuttingCounter

signal OnCut()
signal OnProgressChanged(progressNormalized: float)

@export var CuttingRecipeRESArray: Array[CuttingRecipeRES]

var _cuttingProgress: int

func _ready() -> void:
	super._ready()
	Groups.AddTo(Groups.HasProgress, self)

func Interact(player: Player) -> void:
	if (!HasKitchenObject()):
		# There is no KitchenObject here
		if (player.HasKitchenObject()):
			# Player is carrying something
			if (HasRecipeWithInput(player.GetKitchenObject().GetKitchenObjectRES())):
				# Player carrying something that can be Cut
				player.GetKitchenObject().SetKitchenObjectParent(self)
				_cuttingProgress = 0
				OnProgressChanged.emit(0)
		else:
			# Player not carrying anything
			pass
	else:
		# There is a KitchenObject here
		if (player.HasKitchenObject()):
			# Player is carrying something
			var plate := player.GetKitchenObject() as PlateKitchenObject
			if (plate != null):
				# Player is holding a Plate
				if (plate.TryAddIngredient(GetKitchenObject().GetKitchenObjectRES())):
					GetKitchenObject().DestroySelf()
		else:
			# Player is not carrying anything
			GetKitchenObject().SetKitchenObjectParent(player)

func InteractAlternate(_player: Player) -> void:
	if (HasKitchenObject() && HasRecipeWithInput(GetKitchenObject().GetKitchenObjectRES())):
		# There is a KitchenObject here AND it can be cut
		_cuttingProgress += 1

		OnCut.emit()

		var cuttingRecipeRes := GetCuttingRecipeRESWithInput(GetKitchenObject().GetKitchenObjectRES())
		OnProgressChanged.emit(_cuttingProgress / (cuttingRecipeRes.cuttingProgressMax as float))
		
		if (_cuttingProgress >= cuttingRecipeRes.cuttingProgressMax):
			var outputKitchenObjectRES := GetOutputForInput(GetKitchenObject().GetKitchenObjectRES())
			
			GetKitchenObject().DestroySelf()
			
			KitchenObject.SpawnKitchenObject(outputKitchenObjectRES, self)

func HasRecipeWithInput(inputKitchenObjectRES: KitchenObjectRES) -> bool:
	return GetOutputForInput(inputKitchenObjectRES) != null

func GetOutputForInput(inputKitchenObjectRES: KitchenObjectRES) -> KitchenObjectRES:
	var cuttingRecipe := GetCuttingRecipeRESWithInput(inputKitchenObjectRES)
	return cuttingRecipe.output if cuttingRecipe else null

func GetCuttingRecipeRESWithInput(inputKitchenObjectRES: KitchenObjectRES) -> CuttingRecipeRES:
	for cuttingRecipeRES in CuttingRecipeRESArray:
		if (cuttingRecipeRES.input == inputKitchenObjectRES):
			return cuttingRecipeRES
	return null
