extends CharacterBody2D
@onready var ball_touch: AudioStreamPlayer2D = $BallTouch

var speed = 400
var speed_multiplier = 1
var actual_speed = 400
var direction = Vector2(-1, -1).normalized()

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	move_and_slide()
	
	if get_last_slide_collision() != null:
		var normal = get_last_slide_collision().get_normal()
		direction = direction.bounce(normal)
		ball_touch.play()


func reset() -> void:
	global_position = Vector2(558, 311)
	speed = 0
	await get_tree().create_timer(0.6).timeout
	speed = actual_speed
	print("reset")

func _on_main_game_waited() -> void:
	speed = 0


func _on_main_game_started() -> void:
	speed = actual_speed



func _on_main_game_over() -> void:
	global_position = Vector2(558, 311)
	speed = 0


func _on_main_pointed() -> void:
	global_position = Vector2(558, 311)
	speed = 0


func _on_powe_up_screen_chosed() -> void:
	speed = actual_speed

func att_speed():
	actual_speed = actual_speed * speed_multiplier

func _on_powe_up_screen_ball_speed_up() -> void:
	speed_multiplier += 0.1
	att_speed()
