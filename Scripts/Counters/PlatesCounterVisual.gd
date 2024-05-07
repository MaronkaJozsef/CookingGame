extends Node3D

@export var platesCounter: PlatesCounter
@export var counterTopPoint: Marker3D
@export var plateVisualPrefab: PackedScene

var _plateVisualNode3DArray: Array[Node3D] = []

func _ready() -> void:
	platesCounter.OnPlateSpawned.connect(_PlatesCounter_OnPlateSpawned)
	platesCounter.OnPlateRemoved.connect(_PlatesCounter_OnPlateRemoved)
	
func _PlatesCounter_OnPlateRemoved() -> void:
	var plate := _plateVisualNode3DArray.pop_back() as Node3D
	plate.queue_free()

func _PlatesCounter_OnPlateSpawned() -> void:
	var plate := plateVisualPrefab.instantiate() as Node3D
	counterTopPoint.add_child(plate)

	var plateOffsetY := 0.1
	plate.position.y = plateOffsetY * _plateVisualNode3DArray.size()

	_plateVisualNode3DArray.push_back(plate)
