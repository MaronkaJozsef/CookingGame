extends Node3D

const IDLE_ANIMATION := "CuttingCounterIdle"
const CUTTING_ANIMATION := "CuttingCounterCut"

@export var cuttingCounter: CuttingCounter

@onready var _animationPlayer := $"AnimationPlayer" as AnimationPlayer

func _ready() -> void:
	_animationPlayer.play(IDLE_ANIMATION)
	cuttingCounter.OnCut.connect(_CuttingCounter_OnCut)

func _CuttingCounter_OnCut() -> void:
	_animationPlayer.play(CUTTING_ANIMATION)
