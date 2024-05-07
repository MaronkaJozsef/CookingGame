extends Control

const NUMBER_POPUP_ANIMATION := "NumberPopup"

@export var countdownText: Label
@export var animationPlayer: AnimationPlayer
@export var gameStartCountdownUISound: GameStartCountdownUISound

var _previousCountdownNumber := -1

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	KitchenGameManager.Instance.OnStateChanged.connect(_kitchenGameManager_OnStateChanged)

func _process(_delta: float) -> void:
	var countdownNumber := ceili(KitchenGameManager.Instance.GetCountdownToStartTimer())
	countdownText.text = str(countdownNumber)
	
	if (_previousCountdownNumber != countdownNumber):
		_previousCountdownNumber = countdownNumber
		animationPlayer.play(NUMBER_POPUP_ANIMATION)
		gameStartCountdownUISound.PlayCountdownSound()

func _kitchenGameManager_OnStateChanged() -> void:
	var isActive := KitchenGameManager.Instance.IsCountdownToStartActive()
	process_mode = PROCESS_MODE_ALWAYS if isActive else PROCESS_MODE_DISABLED
	countdownText.visible = isActive
