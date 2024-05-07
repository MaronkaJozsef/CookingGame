extends TextureRect
class_name PlateIconsSingleUI

func SetKitchenObjectRES(kitchenObjectRES: KitchenObjectRES) -> void:
	visible = true
	texture = kitchenObjectRES.sprite
