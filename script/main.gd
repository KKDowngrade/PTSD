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

func _on_powe_up_screen_chosed() -> void:
	experience -= 100



func _on_goal_left_body_entered(body: Node2D) -> void:
	bot_score += 1
	life -= 1
	body.reset()
	fail_sound.play()



func _on_goal_right_body_entered(body: Node2D) -> void:
	
	
	if experience == 100:

		point_sound.play()
		pointed.emit()
		powe_up_screen.show()

	else:
		score += 1
		experience += 10

		point_sound.play()
		body.reset()



	
func _process(delta: float) -> void:
	if life == 0:
		sprite_2d.set_frame(10)
		death_screen.show()
		game_over.emit()
