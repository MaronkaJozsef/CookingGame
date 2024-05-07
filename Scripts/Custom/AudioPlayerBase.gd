extends AudioStreamPlayer3D
class_name AudioPlayerBase

@export var audioStreamRefsRES: AudioStreamRefsRES

func PlaySound(sound: AudioStream, volume: float = 1.0) -> void:
	stream = sound
	position = position
	volume_db = linear_to_db(volume * SoundManager.Instance.GetVolume())
	play()

func PlaySoundFromArray(sounds: Array[AudioStream], volume: float = 1.0) -> void:
	PlaySound(sounds.pick_random(), volume)
