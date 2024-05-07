extends Node3D

@export var _stoveCounter: StoveCounter

@onready var _stoveOnNode := $"StoveOnVisual" as Node3D
@onready var _particlesNode := $"SizzlingParticles" as Node3D

func _ready() -> void:
	_stoveOnNode.visible = false
	_particlesNode.visible = false
	_stoveCounter.OnStateChanged.connect(onStateChanged)

func onStateChanged(state: StoveCounter.State) -> void:
	var showVisual := state == StoveCounter.State.Frying || state == StoveCounter.State.Fried
	_stoveOnNode.visible = showVisual
	_particlesNode.visible = showVisual
