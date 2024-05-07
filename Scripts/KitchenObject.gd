extends Node3D
class_name KitchenObject

static func SpawnKitchenObject(kitchenObjRES: KitchenObjectRES, parent: Node) -> KitchenObject:
	var prefab := load(kitchenObjRES.prefabPath) as PackedScene
	var kitchenObject := prefab.instantiate() as KitchenObject
	kitchenObject.SetKitchenObjectParent(parent)
	return kitchenObject

@export var kitchenObjectRES: KitchenObjectRES

var _kitchenObjectParent: Node

func GetKitchenObjectRES() -> KitchenObjectRES:
	return kitchenObjectRES

func SetKitchenObjectParent(kitchenObjectParent: Node) -> void:
	assert(kitchenObjectParent.is_in_group(Groups.KitchenObjectParent))
	
	if (_kitchenObjectParent != null):
		_kitchenObjectParent.ClearKitchenObject()
	
	if (kitchenObjectParent.HasKitchenObject()):
		push_error("Counter already has a KitchenObject")
	
	_kitchenObjectParent = kitchenObjectParent
	_kitchenObjectParent.SetKitchenObject(self)
	position = _kitchenObjectParent.GetKitchenObjectFollowPosition()

func GetKitchenObjectParent() -> Node:
	return _kitchenObjectParent

func DestroySelf() -> void:
	_kitchenObjectParent.ClearKitchenObject()
	queue_free()
