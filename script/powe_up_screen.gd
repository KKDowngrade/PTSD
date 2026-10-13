extends Control
signal size_up
signal chosed

func _ready() -> void:
	hide()



func _on_size_up_button_pressed() -> void:
	size_up.emit()
	hide()
	chosed.emit()
