extends BaseCounter
class_name StoveCounter

signal OnStateChanged(state: State)
signal OnProgressChanged(progressNormalized: float)

enum State {
	Idle,
	Frying,
	Fried,
	Burned
}

@export var fryingRecipeRESArray: Array[FryingRecipeRES]
@export var burningRecipeRESArray: Array[BurningRecipeRES]

var _state: State
var _fryingTimer: float
var _burningTimer: float
var _fryingRecipeRES: FryingRecipeRES
var _burningRecipeRES: BurningRecipeRES

func _ready() -> void:
	super._ready()
	_state = State.Idle
	Groups.AddTo(Groups.HasProgress, self)

func _process(delta: float) -> void:
	if (HasKitchenObject()):
		match _state:
			State.Idle:
				return
			State.Frying:
				_fryingTimer += delta

				OnProgressChanged.emit(_fryingTimer / _fryingRecipeRES.fryingTimerMax)

				if (_fryingTimer >= _fryingRecipeRES.fryingTimerMax):
					# Fried
					GetKitchenObject().DestroySelf()

					KitchenObject.SpawnKitchenObject(_fryingRecipeRES.output, self)

					_state = State.Fried
					_burningTimer = 0.0
					_burningRecipeRES = GetBurningRecipeRESWithInput(GetKitchenObject().GetKitchenObjectRES())

					OnStateChanged.emit(_state)

			State.Fried:
				_burningTimer += delta

				OnProgressChanged.emit(_burningTimer / _burningRecipeRES.burnTimerMax)

				if (_burningTimer >= _burningRecipeRES.burnTimerMax):
					# Burned
					GetKitchenObject().DestroySelf()

					KitchenObject.SpawnKitchenObject(_burningRecipeRES.output, self)

					_state = State.Burned

					OnProgressChanged.emit(0.0)

					OnStateChanged.emit(_state)

			State.Burned:
				return

func Interact(player: Player) -> void:
	if (!HasKitchenObject()):
		# There is no KitchenObject here
		if (player.HasKitchenObject()):
			# Player is carrying something
			if (HasRecipeWithInput(player.GetKitchenObject().GetKitchenObjectRES())):
				# Player carrying something that can be Fried
				player.GetKitchenObject().SetKitchenObjectParent(self)

				_fryingRecipeRES = GetFryingRecipeRESWithInput(GetKitchenObject().GetKitchenObjectRES())

				_state = State.Frying
				_fryingTimer = 0.0

				OnStateChanged.emit(_state)
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

					_state = State.Idle

					OnProgressChanged.emit(0)

					OnStateChanged.emit(_state)
		else:
			# Player is not carrying anything
			GetKitchenObject().SetKitchenObjectParent(player)

			_state = State.Idle

			OnProgressChanged.emit(0)

			OnStateChanged.emit(_state)

func HasRecipeWithInput(inputKitchenObjectRES: KitchenObjectRES) -> bool:
	return GetOutputForInput(inputKitchenObjectRES) != null

func GetOutputForInput(inputKitchenObjectRES: KitchenObjectRES) -> KitchenObjectRES:
	var fryingRecipeRES := GetFryingRecipeRESWithInput(inputKitchenObjectRES)
	return fryingRecipeRES.output if fryingRecipeRES else null

func GetFryingRecipeRESWithInput(inputKitchenObjectRES: KitchenObjectRES) -> FryingRecipeRES:
	for fryingRecipeRES in fryingRecipeRESArray:
		if (fryingRecipeRES.input == inputKitchenObjectRES):
			return fryingRecipeRES
	return null

func GetBurningRecipeRESWithInput(inputKitchenObjectRES: KitchenObjectRES) -> BurningRecipeRES:
	for burningRecipeRES in burningRecipeRESArray:
		if (burningRecipeRES.input == inputKitchenObjectRES):
			return burningRecipeRES
	return null

func IsFried() -> bool:
	return _state == State.Fried
