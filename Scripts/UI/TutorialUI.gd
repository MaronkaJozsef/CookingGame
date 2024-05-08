extends Panel

@export var keyMoveUpLabel: Label
@export var keyMoveDownLabel: Label
@export var keyMoveLeftLabel: Label
@export var keyMoveRightLabel: Label
@export var keyInteractLabel: Label
@export var keyInteractAlternateLabel: Label
@export var keyPauseLabel: Label
@export var keyGamepadInteractLabel: Label
@export var keyGamepadInteractAlternateLabel: Label
@export var keyGamepadPauseLabel: Label

func _ready() -> void:
	GameInput.Instance.OnBindingRebind.connect(_GameInput_OnBindingRebind)
	KitchenGameManager.Instance.OnStateChanged.connect(_KitchenGameManager_OnStateChanged)

	UpdateVisual()
	
	show()
	
func _KitchenGameManager_OnStateChanged() -> void:
	if (KitchenGameManager.Instance.IsCountdownToStartActive()):
		hide()

func _GameInput_OnBindingRebind() -> void:
	UpdateVisual()

func UpdateVisual() -> void:
	var gameInput := GameInput.Instance
	const binding := GameInput.Binding
	const inputType := GameInput.InputType
	keyMoveUpLabel.text = gameInput.GetBindingText(binding.MOVE_UP)
	keyMoveDownLabel.text = gameInput.GetBindingText(binding.MOVE_DOWN)
	keyMoveLeftLabel.text = gameInput.GetBindingText(binding.MOVE_LEFT)
	keyMoveRightLabel.text = gameInput.GetBindingText(binding.MOVE_RIGHT)
	keyInteractLabel.text = gameInput.GetBindingText(binding.INTERACT)
	keyInteractAlternateLabel.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE)
	keyPauseLabel.text = gameInput.GetBindingText(binding.PAUSE)
	keyGamepadInteractLabel.text = gameInput.GetBindingText(binding.INTERACT, inputType.GAMEPAD)
	keyGamepadInteractAlternateLabel.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE, inputType.GAMEPAD)
	keyGamepadPauseLabel.text = gameInput.GetBindingText(binding.PAUSE, inputType.GAMEPAD)