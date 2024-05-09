extends Node

@export var counter: BaseCounter
@export var visualGameObjects: Array[Node3D]

func _ready():
	Player.Instance.OnSelectedCounterChanged.connect(Player_OnSelectedCounterChanged)
	
func Player_OnSelectedCounterChanged(selectedCounter: BaseCounter):
	if (selectedCounter == counter):
		Show()
	else:
		Hide()

func Show():
	for obj in visualGameObjects:
		obj.visible = true

func Hide():
	for obj in visualGameObjects:
		obj.visible = false
