extends Control


signal size_up
signal chosed
signal ball_speed_up
signal racket_speed_up
signal super_ball
signal full_life
signal size_up50
signal racket_speed_up50
signal bounce_speed_up50
signal size_up100
signal racket_speed_up100
signal bounce_speed_up100



var racket_size = 100
var racket_speed = 100
var bounce_speed = 100


@onready var racket_sizeT: RichTextLabel = $PanelContainer2/VBoxContainer/RacketSize
@onready var racket_speedT: RichTextLabel = $PanelContainer2/VBoxContainer/RacketSpeed
@onready var bounce_speedT: RichTextLabel = $PanelContainer2/VBoxContainer/BounceSpeeed
@export var option_buttons: Array[Button] = []
@onready var click_sound: AudioStreamPlayer2D = $ClickSound


func _ready() -> void:
	hide()
	update_active()
	
func update_active():
	racket_sizeT.text=str("Racket Size ", racket_size, "%")
	racket_speedT.text=str("Racket Speed ", racket_speed, "%")
	bounce_speedT.text=str("Bounce Speed ", bounce_speed, "%")



func _on_size_up_button_pressed() -> void:
	size_up.emit()
	racket_size += 10
	update_active()
	hide()
	chosed.emit()
	click_sound.play()


func _on_racket_speed_up_button_pressed() -> void:
	racket_speed_up.emit()
	chosed.emit()
	racket_speed += 10
	update_active()
	hide()
	click_sound.play()


func _on_super_ball_button_pressed() -> void:
	super_ball.emit()
	chosed.emit()
	bounce_speed += 10
	update_active()
	hide()
	click_sound.play()


func _on_full_life_button_pressed() -> void:
	full_life.emit()
	chosed.emit()
	hide()
	click_sound.play()
	
	
func open_choices():
	var shuffled_buttons = option_buttons.duplicate()
	shuffled_buttons.shuffle()
	
	for button in option_buttons:
		button.hide()
	for i in range(min(3, shuffled_buttons.size())):
		shuffled_buttons[i].show()
	show()


func _on_size_up_50_pressed() -> void:
	size_up50.emit()
	racket_size += 50
	update_active()
	hide()
	chosed.emit()
	click_sound.play()


func _on_speed_up_50_pressed() -> void:
	racket_speed_up50.emit()
	chosed.emit()
	racket_speed += 50
	update_active()
	hide()
	click_sound.play()


func _on_bounce_speed_50_pressed() -> void:
	bounce_speed_up50.emit()
	chosed.emit()
	bounce_speed += 50
	update_active()
	hide()
	click_sound.play()


func _on_size_up_100_pressed() -> void:
	size_up100.emit()
	racket_size += 100
	update_active()
	hide()
	chosed.emit()
	click_sound.play()


func _on_speed_up_100_pressed() -> void:
	racket_speed_up100.emit()
	chosed.emit()
	racket_speed += 100
	update_active()
	hide()
	click_sound.play()


func _on_bounce_speed_100_pressed() -> void:
	bounce_speed_up100.emit()
	chosed.emit()
	bounce_speed += 100
	update_active()
	hide()
	click_sound.play()
