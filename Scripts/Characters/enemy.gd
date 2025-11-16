class_name Enemy extends CharacterBody2D

@export var _patrol_coords: Array[Marker2D] = []

@export var _player: Player = null

@export var _detect_area: Area2D = null

@export_range(0.0, 1_000.0, 0.01) var _speed: float = 100.0

var _current_index: int = 0

var _step: int = 1

func _enter_tree() -> void:
	if is_instance_valid(_detect_area):
		_detect_area.body_entered.connect(_on_body_entered)
		_detect_area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	_set_next_coord()

func _physics_process(_delta: float) -> void:
	var desired_position: Vector2 = _player.get_global_position() if is_instance_valid(
			_player) else _get_current_coord()
	if not desired_position.is_equal_approx(Vector2.INF):
		set_velocity(get_global_position().direction_to(desired_position) * _speed)
	
	velocity.y = 0.0
	
	move_and_slide()
	

func _get_current_coord() -> Vector2:
	var current_coord := Vector2.INF
	if _current_index >= 0 and _current_index < _patrol_coords.size():
		current_coord = _patrol_coords[_current_index].get_global_position()
	
	return current_coord

func _set_next_coord() -> void:
	if _patrol_coords.is_empty() or not is_equal_approx(get_global_position().x, 
			_patrol_coords[_current_index].get_global_position().x):
		return
	
	if _current_index + _step < 0:
		_step = 1
	elif _current_index + _step >= _patrol_coords.size():
		_step = -1
	
	_current_index += _step

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_player = body

func _on_body_exited(body: Node2D) -> void:
	if body == _player:
		_player = null
