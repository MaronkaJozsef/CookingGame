extends Node
class_name GameInput

signal OnPauseAction()
signal OnInteractAction()
signal OnInteractAlternateAction()
signal OnBindingRebind()

enum Binding {
	MOVE_UP,
	MOVE_DOWN,
	MOVE_LEFT,
	MOVE_RIGHT,
	INTERACT,
	INTERACT_ALTERNATE,
	PAUSE
}

enum InputType {
	KEYBOARD,
	GAMEPAD
}

static var _instance: GameInput = null
static var Instance: GameInput:
	get: return _instance

@export var inputEventActions: InputEventActions

var _inputMapHandler: InputMapHandler

func _init():
	if (_instance):
		push_error("There is more than one GameInput instance")
	_instance = self

func _ready() -> void:
	_inputMapHandler = InputMapHandler.new(inputEventActions)
	_inputMapHandler.InputRebound.connect(func(): OnBindingRebind.emit())
	add_child(_inputMapHandler)
	_inputMapHandler.LoadInputMap()

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Interact")):
		OnInteractAction.emit()
	if (Input.is_action_just_pressed("InteractAlternate")):
		OnInteractAlternateAction.emit()
	if (Input.is_action_just_pressed("Pause")):
		OnPauseAction.emit()

func _exit_tree() -> void:
	_instance = null

var NormalizedMovementVector: Vector2:
	get: return Input.get_vector("left", "right", "up", "down").normalized()

func GetBindingText(binding: Binding, inputType: InputType = InputType.KEYBOARD) -> String:
	return _inputMapHandler.GetBindingText(binding, inputType)

func RebindBinding(binding: Binding, onActionRebound: Callable) -> void:
	_inputMapHandler.RebindBinding(binding, onActionRebound)

class InputMapHandler:
	extends Node
	
	signal InputRebound()
	
	const SAVE_FILE_INPUT_MAP := "user://InputMap.save"
	
	const BIND_ACTION_NAME_MAP := {
		Binding.MOVE_UP: &"up",
		Binding.MOVE_DOWN: &"down",
		Binding.MOVE_LEFT: &"left",
		Binding.MOVE_RIGHT: &"right",
		Binding.INTERACT: &"Interact",
		Binding.INTERACT_ALTERNATE: &"InteractAlternate",
		Binding.PAUSE: &"Pause"
	}

	const GAMEPAD_BUTTON_NAME := {
		JOY_BUTTON_A: "A",
		JOY_BUTTON_B: "B",
		JOY_BUTTON_X: "X",
		JOY_BUTTON_Y: "Y",
		JOY_BUTTON_BACK: "Back",
		JOY_BUTTON_GUIDE: "Guide",
		JOY_BUTTON_START: "Start",
		JOY_BUTTON_LEFT_STICK: "LStick",
		JOY_BUTTON_RIGHT_STICK: "RStick",
		JOY_BUTTON_LEFT_SHOULDER: "LS",
		JOY_BUTTON_RIGHT_SHOULDER: "RB",
		JOY_BUTTON_DPAD_UP: "PadUp",
		JOY_BUTTON_DPAD_DOWN: "PadDown",
		JOY_BUTTON_DPAD_LEFT: "PadLeft",
		JOY_BUTTON_DPAD_RIGHT: "PadRight",
		JOY_BUTTON_MISC1: "MISC",
		JOY_BUTTON_PADDLE1: "P1",
		JOY_BUTTON_PADDLE2: "P2",
		JOY_BUTTON_PADDLE3: "P3",
		JOY_BUTTON_PADDLE4: "P4"
	}
	
	var _inputEventActions: InputEventActions
	var _actionToRebind: StringName = ""
	var _actionRebindCallback: Callable
	
	func _init(inputEventActions: InputEventActions) -> void:
		_inputEventActions = inputEventActions
	
	func _input(event: InputEvent) -> void:
		if (_actionToRebind.length() == 0): return
	
		if event is InputEventKey || event is InputEventJoypadButton:
			RemoveExistingEvent(InputMap.action_get_events(_actionToRebind), event)
			InputMap.action_add_event(_actionToRebind, event)
			get_viewport().set_input_as_handled()
			SaveInputMap()
			_actionRebindCallback.call()
			_actionToRebind = &""
			InputRebound.emit()
	
	func GetBindingText(binding: Binding, inputType: InputType = InputType.KEYBOARD) -> String:
		var actionName := BIND_ACTION_NAME_MAP[binding] as StringName
		var events := InputMap.action_get_events(actionName)
		for event in events:
			if (event is InputEventKey && inputType == InputType.KEYBOARD):
				return event.as_text_physical_keycode()
			elif (event is InputEventJoypadButton && inputType == InputType.GAMEPAD):
				var index = event.get_button_index()
				if (GAMEPAD_BUTTON_NAME.has(index)):
					return GAMEPAD_BUTTON_NAME[index]
		
		return ""
	
	func RebindBinding(binding: Binding, onActionRebound: Callable) -> void:
		_actionRebindCallback = onActionRebound
		_actionToRebind = BIND_ACTION_NAME_MAP[binding]
	
	func RemoveExistingEvent(eventsArray: Array[InputEvent], newEvent: InputEvent) -> void:
		for actionEvent in eventsArray:
			var isBothKey := actionEvent is InputEventKey && newEvent is InputEventKey
			var isBothJoypad :=  actionEvent is InputEventJoypadButton && newEvent is InputEventJoypadButton
			if isBothKey || isBothJoypad:
				InputMap.action_erase_event(_actionToRebind, actionEvent)
	
	func SaveInputMap() -> void:
		_inputEventActions.inputEventActions.resize(BIND_ACTION_NAME_MAP.size())
		for id in BIND_ACTION_NAME_MAP:
			var events := InputMap.action_get_events(BIND_ACTION_NAME_MAP[id])
			_inputEventActions.inputEventActions[id] = events
		ResourceSaver.save(_inputEventActions)
	
	func LoadInputMap() -> void:
		for id in BIND_ACTION_NAME_MAP:
			var actionName = BIND_ACTION_NAME_MAP[id]
			InputMap.action_erase_events(actionName)
			for event in _inputEventActions.inputEventActions[id]:
				InputMap.action_add_event(actionName, event)
