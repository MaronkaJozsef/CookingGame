extends BaseCounter
class_name PlatesCounter

signal OnPlateSpawned()
signal OnPlateRemoved()

@export var plateKitchenObjectRES: KitchenObjectRES

var _spawnPlateTimer: float
var _spawnPlateTimerMax: float = 4.0
var _platesSpawnedAmount: int = 0
var _platesSpawnedAmountMax: int = 4

func _process(delta: float) -> void:
	_spawnPlateTimer += delta
	if (_spawnPlateTimer > _spawnPlateTimerMax):
		_spawnPlateTimer = 0.0

		if (KitchenGameManager.Instance.IsGamePlaying() && _platesSpawnedAmount < _platesSpawnedAmountMax):
			_platesSpawnedAmount += 1

			OnPlateSpawned.emit()

func Interact(player: Player) -> void:
	if (!player.HasKitchenObject()):
		# Player is empty handed
		if (_platesSpawnedAmount > 0):
			# There's at least one plate here
			_platesSpawnedAmount -= 1

			KitchenObject.SpawnKitchenObject(plateKitchenObjectRES, player)
			
			OnPlateRemoved.emit()
