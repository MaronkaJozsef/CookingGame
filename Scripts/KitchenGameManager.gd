extends Node3D
class_name KitchenGameManager

signal OnStateChanged()
signal OnGamePaused()
signal OnGameUnpaused()

static var _instance: KitchenGameManager = null
static var Instance: KitchenGameManager:
	get: return _instance

enum State {
	WaitingToStart,
	CountdownToStart,
	GamePlaying,
	GameOver,
}


var _state: State
var _countdownToStartTimer := 3.0
var _gamePlayingTimer := 0.0
var _gamePlayingTimerMax := 30.0
var _isGamePaused = false

func _init() -> void:
	if (_instance):
		push_error("There is more than one KitchenGameManager instance")
	_instance = self
	
	_state = State.WaitingToStart

func _ready() -> void:
	GameInput.Instance.OnPauseAction.connect(_GameInput_OnPauseAction)
	GameInput.Instance.OnInteractAction.connect(_GameInput_OnInteractAction)

func _GameInput_OnPauseAction() -> void:
	TogglePauseGame()

func _GameInput_OnInteractAction() -> void:
	if (_state == State.WaitingToStart):
		_state = State.CountdownToStart
		OnStateChanged.emit()

func _process(delta: float) -> void:
	match _state:
		State.WaitingToStart:
			pass
		State.CountdownToStart:
			_countdownToStartTimer -= delta
			if (_countdownToStartTimer < 0.0):
				_state = State.GamePlaying
				_gamePlayingTimer = _gamePlayingTimerMax
				OnStateChanged.emit()
		
		State.GamePlaying:
			_gamePlayingTimer -= delta
			if (_gamePlayingTimer < 0.0):
				_state = State.GameOver
				OnStateChanged.emit()
		
		State.GameOver:
			pass

func _exit_tree() -> void:
	_instance = null

func IsGamePlaying() -> bool:
	return _state == State.GamePlaying

func IsCountdownToStartActive() -> bool:
	return _state == State.CountdownToStart

func GetCountdownToStartTimer() -> float:
	return _countdownToStartTimer

func IsGameOver() -> bool:
	return _state == State.GameOver

func GetGamePlayingTimerNormalized() -> float:
	return 1 - (_gamePlayingTimer / _gamePlayingTimerMax)

func TogglePauseGame() -> void:
	_isGamePaused = !_isGamePaused
	if (_isGamePaused):
		Engine.time_scale = 0.0

		OnGamePaused.emit()
	else:
		Engine.time_scale = 1.0
		
		OnGameUnpaused.emit()
