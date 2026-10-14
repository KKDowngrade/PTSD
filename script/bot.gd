extends CharacterBody2D

@export var speed: float = 255

@onready var ball: CharacterBody2D = $"../Ball"

var direction_y: float = 0

func _physics_process(delta: float) -> void:
	direction_y= sign(ball.global_position.y - global_position.y)
	velocity.y = direction_y * speed
	move_and_slide()


func _on_main_level_up() -> void:
	speed = speed * 1.1
