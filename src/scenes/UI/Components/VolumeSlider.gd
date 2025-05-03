class_name VolumeSlider
extends VBoxContainer

enum AudioType {
	Music,
	Sfx
}

@export var type : AudioType = AudioType.Music

@onready var _slider : HSlider = $HSlider
@onready var _label : Label = $Label


func _ready():
	if type == AudioType.Music: 
		_slider.set_value_no_signal(AudioManager.getMusicVolume())
		_label.text = "Music"
	elif type == AudioType.Sfx: 
		_slider.set_value_no_signal(AudioManager.getSfxVolume())
		_label.text = "Sfx"


func _on_h_slider_value_changed(value: float) -> void:
	AudioManager.sfx.play(SfxManager.SfxId.Click)
	if type == AudioType.Music:
		AudioManager.setMusicVolume(value)
	elif type == AudioType.Sfx: 
		AudioManager.setSfxVolume(value)
