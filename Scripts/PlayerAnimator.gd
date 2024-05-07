extends Node

const WALK_BLEND := "parameters/Walking/blend_amount"

@export var player: Player
@export var animationTree: AnimationTree

func _process(_delta: float):
	animationTree.set(WALK_BLEND, player.IsWalking)
