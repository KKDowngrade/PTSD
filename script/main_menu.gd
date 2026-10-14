extends Control
@onready var change_screen_button: Button = $VBoxContainer/ChangeScreenButton
var fullscreen: bool = false


func _process(delta: float) -> void:
	if fullscreen == false:
		change_screen_button.text=str("Fullscreen")
	else:
		change_screen_button.text=str("Windowed")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_change_screen_button_pressed() -> void:
	if fullscreen == false:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
