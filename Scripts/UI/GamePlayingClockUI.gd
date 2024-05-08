extends CenterContainer

@export var timerProgressBar: TextureProgressBar

func _process(_delta: float) -> void:
	timerProgressBar.value = KitchenGameManager.Instance.GetGamePlayingTimerNormalized()
