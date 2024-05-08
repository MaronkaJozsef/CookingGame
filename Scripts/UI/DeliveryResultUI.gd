extends Sprite3D

const SUCCESS_ANIMATION := "Success"
const FAIL_ANIMATION := "Fail"

@export var backgroundPanel: Panel
@export var iconTexture: TextureRect
@export var messageLabel: Label
@export var successTexture: Texture2D
@export var failedTexture: Texture2D
@export var animationPlayer: AnimationPlayer
# Color variables are missing compared to the Unity version 
# because it is easier to set it in the animation

func _ready() -> void:
	DeliveryManager.Instance.OnRecipeSuccess.connect(_DeliveryManager_OnRecipeSuccess)
	DeliveryManager.Instance.OnRecipeFailed.connect(_DeliveryManager_OnRecipeFailed)

func _DeliveryManager_OnRecipeSuccess() -> void:
	animationPlayer.play(SUCCESS_ANIMATION)
	iconTexture.texture = successTexture
	messageLabel.text = "DELIVERY\nSUCCESS"

func _DeliveryManager_OnRecipeFailed() -> void:
	animationPlayer.play(FAIL_ANIMATION)
	iconTexture.texture = failedTexture
	messageLabel.text = "DELIVERY\nFAILED"
