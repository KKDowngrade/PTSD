extends Node2D

var score: int = 0
var experience: int = 0
var life: int = 10
var bot_score: int = 0
@onready var score_label: RichTextLabel = $HUD/ScoreLabel
@onready var countdown_label: RichTextLabel = $HUD/CountdownLabel
@onready var fail_sound: AudioStreamPlayer2D = $FailSound
@onready var point_sound: AudioStreamPlayer2D = $PointSound
@onready var countdown_numbers: AudioStreamPlayer2D = $CountdownNumbers
@onready var countdown_final: AudioStreamPlayer2D = $CountdownFinal
@onready var main: Node2D = $"."
@onready var sprite_2d: Sprite2D = $HUD/Sprite2D
@onready var death_screen: Control = $HUD/Death_Screen
@onready var powe_up_screen: Control = $HUD/PoweUpScreen

signal game_waited
signal game_started
signal game_over
signal pointed

func _ready() -> void:
	game_waited.emit()
	update_score()
	countdown_label.text = str("[color=red]3")
	countdown_numbers.play()
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[color=yellow]2")
	countdown_numbers.play()
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[color=green]1")
	countdown_numbers.play()
	await get_tree().create_timer(1).timeout
	countdown_label.text = str("[rainbow][wave]Vai!")
	countdown_final.play()
	await  get_tree().create_timer(0.6).timeout
	countdown_label.hide()
	game_started.emit()



func _on_goal_left_body_entered(body: Node2D) -> void:
	bot_score += 1
	life -= 1
	body.reset()
	fail_sound.play()
	update_score()


func _on_goal_right_body_entered(body: Node2D) -> void:
	
	
	if experience == 100:
		experience = 0
		powe_up_screen.show()
		score += 1
		point_sound.play()
		pointed.emit()
	score += 1
	experience += 10
	update_score()
	point_sound.play()
	pointed.emit()


func update_score() -> void:
	score_label.text = str("XP: ", experience)
	
func _process(delta: float) -> void:
	if experience == 100:
		experience = 0
		powe_up_screen.show()
	if life == 10:
		sprite_2d.set_frame(0)
	else:
		if life == 9:
			sprite_2d.set_frame(1)
		else:
			if life == 8:
				sprite_2d.set_frame(2)
			else:
				if life == 7:
					sprite_2d.set_frame(3)
				else:
					if life == 6:
						sprite_2d.set_frame(4)
					else:
						if life == 5:
							sprite_2d.set_frame(5)
						else:
							if life == 4:
								sprite_2d.set_frame(6)
							else:
								if life == 3:
									sprite_2d.set_frame(7)
								else:
									if life == 2:
										sprite_2d.set_frame(8)
									else:
										if life == 1:
											sprite_2d.set_frame(9)
										else:
											if life == 0:
												sprite_2d.set_frame(10)
												death_screen.show()
												game_over.emit()
