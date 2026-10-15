extends CharacterBody2D
@onready var color_rect: ColorRect = $ColorRect
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var speed = 400
var is_game_started:bool = false
var is_game_paused: bool = false
var alive:bool = true
var normal_height = 60
var height_multiplier = 1.0



func _physics_process(delta: float) -> void:
	if is_game_started == false:
		return
		
	if alive == false:
		return
		
	if is_game_paused == true:
		return
		
	var v_direction: float = Input.get_axis("p1_move_up", "p1_move_down")
	velocity.y = v_direction * speed
	move_and_slide()

func att_size():
	color_rect.size.y = normal_height * height_multiplier
	collision_shape_2d.shape.size.y = normal_height * height_multiplier
func grow_up():
	height_multiplier += 0.1
	att_size()
func grow_up50():
	height_multiplier += 0.5
	att_size()

func _on_main_game_started() -> void:
	is_game_started = true


func _on_main_game_over() -> void:
	alive = false


func _on_powe_up_screen_size_up() -> void:
	grow_up()


func _on_powe_up_screen_racket_speed_up() -> void:
	speed = speed * 1.1
	print(speed)


func _on_main_paused() -> void:
	is_game_paused = true


func _on_pause_menu_despaused() -> void:
	is_game_paused = false


func _on_powe_up_screen_size_up_50() -> void:
	grow_up50()


func _on_powe_up_screen_racket_speed_up_50() -> void:
	speed = speed * 1.5


func bounce_feedback() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "offset_transform_scale", Vector2.ONE, 0.3).from(Vector2(1.2, 2.0))
	
