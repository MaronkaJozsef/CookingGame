extends Sprite3D

const SUCCESS_ANIMATION := "Success"
const FAIL_ANIMATION := "Fail"

@export var backgroundPanel: Panel
@export var iconTexture: TextureRect
@export var messageLabel: Label
@export var successTexture: Texture2D
@export var failedTexture: Texture2D
@export var animationPlayer: AnimationPlayer

func _ready() -> void:
	DeliveryManager.Instance.OnRecipeSuccess.connect(_DeliveryManager_OnRecipeSuccess)
	DeliveryManager.Instance.OnRecipeFailed.connect(_DeliveryManager_OnRecipeFailed)

func _DeliveryManager_OnRecipeSuccess() -> void:
	iconTexture.texture = successTexture
	messageLabel.text = "DELIVERY\nSUCCESS"
	animationPlayer.play(SUCCESS_ANIMATION)

func _DeliveryManager_OnRecipeFailed() -> void:
	iconTexture.texture = failedTexture
	messageLabel.text = "DELIVERY\nFAILED"
	animationPlayer.play(FAIL_ANIMATION)
