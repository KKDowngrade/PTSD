extends Control
signal size_up
signal chosed
signal ball_speed_up
signal racket_speed_up
signal super_ball


func _ready() -> void:
	hide()



func _on_size_up_button_pressed() -> void:
	size_up.emit()
	hide()
	chosed.emit()


func _on_racket_speed_up_button_pressed() -> void:
	racket_speed_up.emit()
	chosed.emit()
	hide()


func _on_super_ball_button_pressed() -> void:
	super_ball.emit()
	chosed.emit()
	hide()
