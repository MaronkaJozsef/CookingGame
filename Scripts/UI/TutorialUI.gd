extends Panel

@export var keyMoveUpText: Label
@export var keyMoveDownText: Label
@export var keyMoveLeftText: Label
@export var keyMoveRightText: Label
@export var keyInteractText: Label
@export var keyInteractAlternateText: Label
@export var keyPauseText: Label
@export var keyGamepadInteractText: Label
@export var keyGamepadInteractAlternateText: Label
@export var keyGamepadPauseText: Label

func _ready() -> void:
	GameInput.Instance.OnBindingRebind.connect(_GameInput_OnBindingRebind)
	KitchenGameManager.Instance.OnStateChanged.connect(_KitchenGameManager_OnStateChanged)
	UpdateVisual()
	Show()
	
func _GameInput_OnBindingRebind() -> void:
	UpdateVisual()

func _KitchenGameManager_OnStateChanged() -> void:
	if (KitchenGameManager.Instance.IsCountdownToStartActive()):
		Hide()

func UpdateVisual() -> void:
	var gameInput := GameInput.Instance
	const binding := GameInput.Binding
	const inputType := GameInput.InputType
	keyMoveUpText.text = gameInput.GetBindingText(binding.MOVE_UP)
	keyMoveDownText.text = gameInput.GetBindingText(binding.MOVE_DOWN)
	keyMoveLeftText.text = gameInput.GetBindingText(binding.MOVE_LEFT)
	keyMoveRightText.text = gameInput.GetBindingText(binding.MOVE_RIGHT)
	keyInteractText.text = gameInput.GetBindingText(binding.INTERACT)
	keyInteractAlternateText.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE)
	keyPauseText.text = gameInput.GetBindingText(binding.PAUSE)
	keyGamepadInteractText.text = gameInput.GetBindingText(binding.INTERACT, inputType.GAMEPAD)
	keyGamepadInteractAlternateText.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE, inputType.GAMEPAD)
	keyGamepadPauseText.text = gameInput.GetBindingText(binding.PAUSE, inputType.GAMEPAD)

func Show() -> void:
	show()

func Hide() -> void:
	hide()
