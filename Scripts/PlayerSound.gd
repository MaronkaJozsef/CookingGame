extends AudioPlayerBase

@export var player: Player

var _footstepTimer: float
var _footstepTimerMax := 0.1

func _ready() -> void:
	player.OnPickedSomething.connect(_player_OnPickedSomething)

func _process(delta: float) -> void:
	_footstepTimer -= delta
	if (_footstepTimer <= 0):
		_footstepTimer = _footstepTimerMax
		
		if (player.IsWalking):
			PlaySoundFromArray(audioStreamRefsRES.footstep, 1.5)

func _player_OnPickedSomething() -> void:
	PlaySoundFromArray(audioStreamRefsRES.objectPickup)
