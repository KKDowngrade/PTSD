extends CharacterBody2D
@onready var ball_touch: AudioStreamPlayer2D = $BallTouch
@onready var color_rect: ColorRect = $ColorRect
@onready var fire_particles: GPUParticles2D = $FireParticles

var speed = 400
var speed_multiplier = 1
var actual_speed = 400
var direction = Vector2(-1, -1).normalized()
var super_ball: bool = false
var bounce_multiplier = 1

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	move_and_slide()
	
	if get_last_slide_collision() != null:
		var normal = get_last_slide_collision().get_normal()
		direction = direction.bounce(normal)
		ball_touch.play()
		bounce_feedback()
		
		var obj = get_last_slide_collision().get_collider()
		if obj.has_method("bounce_feedback"):
			obj.bounce_feedback()


func reset() -> void:
	fire_particles.emitting = false
	global_position = Vector2(558, 311)
	speed = 0
	await get_tree().create_timer(0.6).timeout
	speed = actual_speed
	

func bounce_feedback() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "offset_transform_scale", Vector2.ONE, 0.3).from(Vector2.ONE * 1.5)
	


func _on_main_game_waited() -> void:
	speed = 0


func _on_main_game_started() -> void:
	speed = actual_speed



func _on_main_game_over() -> void:
	global_position = Vector2(558, 311)
	speed = 0


func _on_main_pointed() -> void:
	global_position = Vector2(558, 311)
	fire_particles.emitting = false
	speed = 0


func _on_powe_up_screen_chosed() -> void:
	speed = actual_speed

func att_speed():
	actual_speed = actual_speed * speed_multiplier


func _on_main_level_up() -> void:
	actual_speed = actual_speed * 1.1


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if super_ball == true:
		fire_particles.amount = 64 * bounce_multiplier
		fire_particles.emitting = true
		speed = actual_speed * bounce_multiplier


func _on_powe_up_screen_super_ball() -> void:
	bounce_multiplier += 0.1
	super_ball = true


func _on_main_paused() -> void:
	speed = 0


func _on_pause_menu_despaused() -> void:
	speed = actual_speed


func _on_powe_up_screen_bounce_speed_up_50() -> void:
	bounce_multiplier += 0.5
	super_ball = true
