extends ProgressBar

const IDLE_ANIMATION := "Idle"
const FLASH_ANIMATION := "Flash"

@export var stoveCounter: StoveCounter
@export var animationPlayer: AnimationPlayer

func _ready() -> void:
	stoveCounter.OnProgressChanged.connect(_StoveCounter_OnProgressChange)
	
	animationPlayer.play(IDLE_ANIMATION)

func _StoveCounter_OnProgressChange(progressNormalized: float) -> void:
	const burnShowProgressAmount := 0.5
	var shouldShow := stoveCounter.IsFried() && progressNormalized >= burnShowProgressAmount
	
	animationPlayer.play(FLASH_ANIMATION if shouldShow else IDLE_ANIMATION)