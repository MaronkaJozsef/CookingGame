extends Panel
class_name OptionsUI

static var _instance: OptionsUI = null
static var Instance: OptionsUI:
	get: return _instance

@export var soundFXButton: Button
@export var musciButton: Button
@export var closeButton: Button
@export var pressToRebindKeyPanel: Panel

@export var moveUpButton: Button
@export var moveDownButton: Button
@export var moveLeftButton: Button
@export var moveRightButton: Button
@export var interactButton: Button
@export var interactAltButton: Button
@export var pauseButton: Button
@export var gamepadInteractButton: Button
@export var gamepadInteractAltButton: Button
@export var gamepadPauseButton: Button

var _onCloseButtonAction: Callable

func _init() -> void:
	if (_instance):
		push_error("There is more than one OptionsUI instance")
	_instance = self

func _ready() -> void:
	KitchenGameManager.Instance.OnGameUnpaused.connect(_KitchenGameManager_OnGameUnpaused)
	const Binding := GameInput.Binding
	moveUpButton.pressed.connect(RebindBinding.bind(Binding.MOVE_UP))
	moveDownButton.pressed.connect(RebindBinding.bind(Binding.MOVE_DOWN))
	moveLeftButton.pressed.connect(RebindBinding.bind(Binding.MOVE_LEFT))
	moveRightButton.pressed.connect(RebindBinding.bind(Binding.MOVE_RIGHT))
	interactButton.pressed.connect(RebindBinding.bind(Binding.INTERACT))
	interactAltButton.pressed.connect(RebindBinding.bind(Binding.INTERACT_ALTERNATE))
	pauseButton.pressed.connect(RebindBinding.bind(Binding.PAUSE))
	gamepadInteractButton.pressed.connect(RebindBinding.bind(Binding.INTERACT))
	gamepadInteractAltButton.pressed.connect(RebindBinding.bind(Binding.INTERACT_ALTERNATE))
	gamepadPauseButton.pressed.connect(RebindBinding.bind(Binding.PAUSE))
	
	soundFXButton.pressed.connect(func(): 
		SoundManager.Instance.ChangeVolume()
		UpdateVisual()
	)
	musciButton.pressed.connect(func(): 
		MusicManager.Instance.ChangeVolume()
		UpdateVisual()
	)
	closeButton.pressed.connect(func(): 
		hide()
		_onCloseButtonAction.call()
	)
	
	hide()
	UpdateVisual()

func _exit_tree() -> void:
	_instance = null

func UpdateVisual() -> void:
	musciButton.text = "Music: " + str(round(MusicManager.Instance.GetVolume() * 10.0))
	soundFXButton.text = "Sound Effects: " + str(round(SoundManager.Instance.GetVolume() * 10.0))
	
	const binding := GameInput.Binding
	const inputType := GameInput.InputType
	var gameInput := GameInput.Instance
	moveUpButton.text = gameInput.GetBindingText(binding.MOVE_UP)
	moveDownButton.text = gameInput.GetBindingText(binding.MOVE_DOWN)
	moveLeftButton.text = gameInput.GetBindingText(binding.MOVE_LEFT)
	moveRightButton.text = gameInput.GetBindingText(binding.MOVE_RIGHT)
	interactButton.text = gameInput.GetBindingText(binding.INTERACT)
	interactAltButton.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE)
	pauseButton.text = gameInput.GetBindingText(binding.PAUSE)
	gamepadInteractButton.text = gameInput.GetBindingText(binding.INTERACT, inputType.GAMEPAD)
	gamepadInteractAltButton.text = gameInput.GetBindingText(binding.INTERACT_ALTERNATE, inputType.GAMEPAD)
	gamepadPauseButton.text = gameInput.GetBindingText(binding.PAUSE, inputType.GAMEPAD)

func _KitchenGameManager_OnGameUnpaused() -> void:
	hide()

func Show(onCloseButtonAction: Callable) -> void:
	show()
	soundFXButton.grab_focus()
	_onCloseButtonAction = onCloseButtonAction

func RebindBinding(binding: GameInput.Binding) -> void:
	pressToRebindKeyPanel.show()
	GameInput.Instance.RebindBinding(binding, func(): 
		pressToRebindKeyPanel.hide()
		UpdateVisual()
	)
