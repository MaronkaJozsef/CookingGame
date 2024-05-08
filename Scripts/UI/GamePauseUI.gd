extends Panel

@export var resumeButton: Button
@export var mainMenuButton: Button
@export var optionsButton: Button

func _ready() -> void:
	resumeButton.pressed.connect(func(): KitchenGameManager.Instance.TogglePauseGame())
	mainMenuButton.pressed.connect(func(): Loader.Load(Loader.Scene.MainMenuScene))
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
	resumeButton.grab_focus()
	
	show()
