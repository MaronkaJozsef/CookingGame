extends Panel
class_name OptionsUI

static var _instance: OptionsUI = null
static var Instance: OptionsUI:
	get: return _instance

@export var soundEffectsButton: Button
@export var musicButton: Button
@export var closeButton: Button
@export var moveUpButton: Button
@export var moveDownButton: Button
@export var moveLeftButton: Button
@export var moveRightButton: Button
@export var interactButton: Button
@export var interactAlternateButton: Button
@export var pauseButton: Button
@export var gamepadInteractButton: Button
@export var gamepadInteractAlternateButton: Button
@export var gamepadPauseButton: Button

@export var pressToRebindKeyPanel: Panel

var _onCloseButtonAction: Callable

func _init() -> void:
	if (_instance):
		push_error("There is more than one OptionsUI instance")
	_instance = self

func _ready() -> void:
	soundEffectsButton.pressed.connect(func(): 
		SoundManager.Instance.ChangeVolume()
		UpdateVisual()
	)
	musicButton.pressed.connect(func(): 
		MusicManager.Instance.ChangeVolume()
		UpdateVisual()
	)
	closeButton.pressed.connect(func(): 
		hide()
		_onCloseButtonAction.call()
	)

	const Binding := GameInput.Binding
	moveUpButton.pressed.connect(RebindBinding.bind(Binding.MOVE_UP))
	moveDownButton.pressed.connect(RebindBinding.bind(Binding.MOVE_DOWN))
	moveLeftButton.pressed.connect(RebindBinding.bind(Binding.MOVE_LEFT))
	moveRightButton.pressed.connect(RebindBinding.bind(Binding.MOVE_RIGHT))
	interactButton.pressed.connect(RebindBinding.bind(Binding.INTERACT))
	interactAlternateButton.pressed.connect(RebindBinding.bind(Binding.INTERACT_ALTERNATE))
	pauseButton.pressed.connect(RebindBinding.bind(Binding.PAUSE))
	gamepadInteractButton.pressed.connect(RebindBinding.bind(Binding.INTERACT))
	gamepadInteractAlternateButton.pressed.connect(RebindBinding.bind(Binding.INTERACT_ALTERNATE))
	gamepadPauseButton.pressed.connect(RebindBinding.bind(Binding.PAUSE))

	KitchenGameManager.Instance.OnGameUnpaused.connect(_KitchenGameManager_OnGameUnpaused)
	
	UpdateVisual()

	pressToRebindKeyPanel.hide()
	hide()

func _KitchenGameManager_OnGameUnpaused() -> void:
	hide()

func _exit_tree() -> void:
	_instance = null

func UpdateVisual() -> void:
	soundEffectsButton.text = "Sound Effects: " + str(round(SoundManager.Instance.GetVolume() * 10.0))
	musicButton.text = "Music: " + str(round(MusicManager.Instance.GetVolume() * 10.0))
	
	const binding := GameInput.Binding
	var gameInput := GameInput.Instance
	const inputType := GameInput.InputType
	moveUpButton.text = gameInput.GetBindingText(binding.MOVE_UP)
	moveDownButton.text = gameInput.GetBindingText(binding.MOVE_DOWN)
	moveLeftButton.text = gameInput.GetBindingText(binding.MOVE_LEFT)
	moveRightButton.text = gameInput.GetBindingText(binding.MOVE_RIGHT)
	interactButton.text = gameInput.GetBindingText(binding.INTERACT)
	interactAlternateButton.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE)
	pauseButton.text = gameInput.GetBindingText(binding.PAUSE)
	gamepadInteractButton.text = gameInput.GetBindingText(binding.INTERACT, inputType.GAMEPAD)
	gamepadInteractAlternateButton.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE, inputType.GAMEPAD)
	gamepadPauseButton.text = gameInput.GetBindingText(binding.PAUSE, inputType.GAMEPAD)

func Show(onCloseButtonAction: Callable) -> void:
	_onCloseButtonAction = onCloseButtonAction

	show()

	soundEffectsButton.grab_focus()

func RebindBinding(binding: GameInput.Binding) -> void:
	pressToRebindKeyPanel.show()
	GameInput.Instance.RebindBinding(binding, func(): 
		pressToRebindKeyPanel.hide()
		UpdateVisual()
	)
