extends Camera3D

@export var noise: FastNoiseLite
@export var speed: float
@export var rotationXMax: float
@export var rotationYMax: float
@export var rotationZMax: float

var _time: float

@onready var _initialRotation := rotation_degrees

func _process(delta: float) -> void:
	_time += delta
	rotation_degrees.x = _initialRotation.x + _getNoiseFromSeed(0) * rotationXMax
	rotation_degrees.y = _initialRotation.y + _getNoiseFromSeed(1) * rotationYMax
	rotation_degrees.z = _initialRotation.z + _getNoiseFromSeed(2) * rotationZMax

func _getNoiseFromSeed(seed: int) -> float:
	noise.seed = seed
	return noise.get_noise_1d(_time * speed)
