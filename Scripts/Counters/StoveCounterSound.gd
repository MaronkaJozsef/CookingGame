extends BaseCounterAudio

var _warningSoundTimer := 0.0
var _playWarningSound := false

func _ready() -> void:
	(counter as StoveCounter).OnStateChanged.connect(_stoveCounter_OnStateChanged)
	(counter as StoveCounter).OnProgressChanged.connect(_StoveCounter_OnProgressChange)

func _process(delta: float) -> void:
	if (_playWarningSound):
		_warningSoundTimer -= delta
		if (_warningSoundTimer <= 0.0):
			const warningSoundTimerMax := 0.2
			_warningSoundTimer = warningSoundTimerMax
			PlaySound(audioStreamRefsRES.warning[1], 0.5)

func _stoveCounter_OnStateChanged(state: StoveCounter.State) -> void:
	var playSound := state == StoveCounter.State.Frying || state == StoveCounter.State.Fried
	if (playSound):
		PlaySound(audioStreamRefsRES.stoveSizzle)
	else:
		stop()

func _StoveCounter_OnProgressChange(progressNormalized: float) -> void:
	const burnShowProgressAmount := 0.5
	_playWarningSound = (counter as StoveCounter).IsFried() && progressNormalized >= burnShowProgressAmount
