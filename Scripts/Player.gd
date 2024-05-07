extends CharacterBody3D
class_name Player

signal OnPickedSomething()
signal OnSelectedCounterChanged(selectedCounter: BaseCounter)

static var _instance: Player = null
static var Instance: Player:
	get: return _instance

@export var MOVEMENT_SPEED := 200.0
@export var ROTATION_SPEED := 10
@export var input: GameInput
@export var interactRay: RayCast3D
@export var kitchenObjectHoldPoint: Marker3D

var _kitchenObject: KitchenObject
var _selectedCounter: BaseCounter
var _isWalking := false
var IsWalking: bool:
	get: return _isWalking

func _init():
	if (_instance):
		push_error("There is more than one Player instance")
	_instance = self
	Groups.AddTo(Groups.KitchenObjectParent, self)

func _exit_tree() -> void:
	_instance = null

func _ready() -> void:
	input.OnInteractAction.connect(onInteractAction)
	input.OnInteractAlternateAction.connect(onInteractAlternateAction)

func _process(delta: float) -> void:
	handleMovement(delta)
	handleInteractions()

func GetKitchenObjectFollowPosition() -> Vector3:
	return kitchenObjectHoldPoint.position

func GetKitchenObject() -> KitchenObject:
	return _kitchenObject

func SetKitchenObject(kitchenObject: KitchenObject) -> void:
	_kitchenObject = kitchenObject
	add_child(_kitchenObject)
	if (kitchenObject):
		OnPickedSomething.emit()

func ClearKitchenObject() -> void:
	remove_child(_kitchenObject)
	_kitchenObject = null

func HasKitchenObject() -> bool:
	return _kitchenObject != null

func handleMovement(delta: float) -> void:
	var inputVector := input.NormalizedMovementVector
	_isWalking = inputVector.length()
	
	if inputVector.length_squared() == 0: return
	
	inputVector = inputVector.normalized()
	var direction := Vector3(inputVector.x, 0, inputVector.y)
	velocity = direction * MOVEMENT_SPEED * delta

	move_and_slide()
	var angle = direction.signed_angle_to(transform.basis.z, Vector3.DOWN) * ROTATION_SPEED * delta
	transform.basis = Basis(Vector3.UP, angle) * transform.basis

func onInteractAction():
	if (!KitchenGameManager.Instance.IsGamePlaying()): return
	
	if (_selectedCounter):
		_selectedCounter.Interact(self)

func onInteractAlternateAction():
	if (!KitchenGameManager.Instance.IsGamePlaying()): return
	
	if (_selectedCounter):
		_selectedCounter.InteractAlternate(self)

func handleInteractions() -> void:
	setSelectedCounter(interactRay.get_collider())

func setSelectedCounter(selectedCounter: BaseCounter) -> void:
	_selectedCounter = selectedCounter;
	OnSelectedCounterChanged.emit(_selectedCounter)
