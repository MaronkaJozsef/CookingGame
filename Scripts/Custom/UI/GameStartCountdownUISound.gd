extends AudioPlayerBase
class_name GameStartCountdownUISound

func PlayCountdownSound() -> void:
	PlaySound(audioStreamRefsRES.warning[0])
