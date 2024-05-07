extends GPUParticles3D

@onready var _oldPosition := global_position

func _init() -> void:
	emitting = false

func _process(_delta: float) -> void:
	var moveVector := _oldPosition - global_position
	_oldPosition = global_position
	
	emitting = moveVector.length_squared() > 0
