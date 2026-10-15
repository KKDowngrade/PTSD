extends Node2D

var score: int = 0
var experience: int = 0
var life: int = 10
var bot_score: int = 0
var level: int = 1
var is_game_started = false

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
@onready var level_label: RichTextLabel = $HUD/LevelLabel
@onready var pause_menu: Control = $HUD/PauseMenu
@onready var score_particles_left: GPUParticles2D = %ScoreParticlesLeft
@onready var score_particle_right: GPUParticles2D = %ScoreParticleRight
@onready var camera: Camera2D = $Camera2D

signal game_waited
signal game_started
signal game_over
signal pointed
signal level_up
signal paused

func _ready() -> void:
	update_level()
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
	countdown_label.text = str("[rainbow][wave]Go!")
	countdown_final.play()
	await  get_tree().create_timer(0.6).timeout
	countdown_label.hide()
	is_game_started = true
	game_started.emit()

func _on_powe_up_screen_chosed() -> void:
	experience -= 100



func _on_goal_left_body_entered(body: Node2D) -> void:
	bot_score += 1
	life -= 1
	body.reset()
	fail_sound.play()
	score_particles_left.emitting = true
	goal_feedback(-40)



func _on_goal_right_body_entered(body: Node2D) -> void:
	
	
	if experience >= 100:

		point_sound.play()
		pointed.emit()
		powe_up_screen.open_choices()
		level += 1
		level_up.emit()
		update_level()
		score_particle_right.emitting = true
		goal_feedback(40)

	else:
		score += 1
		experience += 25 / level
		point_sound.play()
		body.reset()
		score_particle_right.emitting = true
		goal_feedback(40)

func update_level():
	level_label.text=str(level, "LV.")


	
func _process(delta: float) -> void:
	if life == 0:
		death_screen.show()
		game_over.emit()
	if Input.is_action_just_pressed("pause"):
		if is_game_started == false:
			return
		
		pause_menu.show()
		paused.emit()


func _on_powe_up_screen_full_life() -> void:
	life = 10


func goal_feedback(abc) -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(camera, "offset:x", 0, 0.4).from(abc)
	
