extends Control
signal size_up
signal chosed
signal ball_speed_up

func _ready() -> void:
	hide()



func _on_size_up_button_pressed() -> void:
	size_up.emit()
	hide()
	chosed.emit()


func _on_ball_speed_up_botton_pressed() -> void:
	ball_speed_up.emit()
	chosed.emit()
	hide()
