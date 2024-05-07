extends Node
class_name Groups

const HasProgress := "HasProgress"
const Interactable := "Interactable"
const KitchenObjectParent := "KitchenObjectParent"

static func AddTo(groupName: String, node: Node) -> void:
	match groupName:
		Interactable:
			assert(node.has_method("Interact"), "The script has no \"Interact\" method")
		
		KitchenObjectParent:
			assert(node.has_method("GetKitchenObjectFollowPosition"), "The script has no \"GetKitchenObjectFollowPosition\" method")
			assert(node.has_method("GetKitchenObject"), "The script has no \"GetKitchenObject\" method")
			assert(node.has_method("SetKitchenObject"), "The script has no \"SetKitchenObject\" method")
			assert(node.has_method("ClearKitchenObject"), "The script has no \"ClearKitchenObject\" method")
			assert(node.has_method("HasKitchenObject"), "The script has no \"HasKitchenObject\" method")
		
		HasProgress:
			assert(node.has_signal("OnProgressChanged"), "The script has no \"OnProgressChange\" signal")
		
		_:
			var template = "%s Does not exist"
			assert(false, template % groupName)
	
	node.add_to_group(groupName)
