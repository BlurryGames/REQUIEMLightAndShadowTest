class_name Player extends CharacterBody2D

@export_range(0.0, 1_000.0, 0.01) var speed: float = 200.0

@export_range(-1_000.0, 0.0, 0.01) var jump_force: float = -600.0

func _physics_process(delta: float) -> void:
	set_velocity(Vector2(Input.get_axis("move_left", "move_right") * speed, get_velocity().y))
	if not is_on_floor():
		velocity.y += get_gravity().length() * delta
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
