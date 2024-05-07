# Ensures that icon is set in the editor as well
@tool
extends Node3D

const LID_OPEN_CLOSE_ANIM := "LidOpenClose"

@export var containerCounter: ContainerCounter

@onready var _animationPlayer := $"AnimationPlayer" as AnimationPlayer
@onready var _kitchenObjectSprite := $"Lid/SpriteRenderer" as Sprite3D

func _ready() -> void:
	containerCounter.OnPlayerGrabbedObject.connect(_ContainerCounter_OnPlayerGrabbedObject)
	_kitchenObjectSprite.texture = containerCounter.GetKitchenObjectRes().sprite
	
func _ContainerCounter_OnPlayerGrabbedObject():
	_animationPlayer.play(LID_OPEN_CLOSE_ANIM)
