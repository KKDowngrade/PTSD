extends Control
@onready var change_screen_button: Button = $VBoxContainer/ChangeScreenButton
var fullscreen: bool = false
@onready var click_sound: AudioStreamPlayer2D = $ClickSound


func _process(delta: float) -> void:
	if fullscreen == false:
		change_screen_button.text=str("Fullscreen")
	else:
		change_screen_button.text=str("Windowed")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")
	click_sound.play()


func _on_change_screen_button_pressed() -> void:
	if fullscreen == false:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		click_sound.play()
	else:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		click_sound.play()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	click_sound.play()
