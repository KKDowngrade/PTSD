extends Control

signal despaused


func _ready() -> void:
	hide()


func _on_continue_button_pressed() -> void:
	hide()
	despaused.emit()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	hide()
	despaused.emit()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_quit_button_pressed() -> void:
		get_tree().quit()
