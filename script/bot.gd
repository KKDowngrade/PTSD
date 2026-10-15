extends CharacterBody2D

@export var speed: float = 255
@onready var color_rect: ColorRect = $ColorRect

@onready var ball: CharacterBody2D = $"../Ball"

var direction_y: float = 0

func _physics_process(delta: float) -> void:
	direction_y= sign(ball.global_position.y - global_position.y)
	velocity.y = direction_y * speed
	move_and_slide()


func _on_main_level_up() -> void:
	speed = speed * 1.1

func bounce_feedback() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "offset_transform_scale", Vector2.ONE, 0.3).from(Vector2(1.2, 2.0))
	
