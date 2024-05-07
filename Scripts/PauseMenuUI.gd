extends Panel

@export var resumeButton: Button
@export var optionsButton: Button
@export var mainMenuButton: Button

func _ready() -> void:
	mainMenuButton.pressed.connect(func(): Loader.Load(Loader.Scene.MainMenuScene))
	resumeButton.pressed.connect(func(): KitchenGameManager.Instance.TogglePauseGame())
	optionsButton.pressed.connect(func(): 
		hide()
		OptionsUI.Instance.Show(Show)
	)
	
	KitchenGameManager.Instance.OnGamePaused.connect(_KitchenGameManager_OnGamePaused)
	KitchenGameManager.Instance.OnGameUnpaused.connect(_KitchenGameManager_OnGameUnpaused)
	hide()
	
func _KitchenGameManager_OnGamePaused() -> void:
	Show()

func _KitchenGameManager_OnGameUnpaused() -> void:
	hide()

func Show() -> void:
	show()
	resumeButton.grab_focus()
