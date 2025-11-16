class_name StateEffect extends ColorRect

static var instance: StateEffect = null

static var current_state: bool = true

@export var calm_color := Color.WHITE

@export var blind_color := Color.BLACK

func _init() -> void:
	instance = self

func _enter_tree() -> void:
	set_color(calm_color if current_state else blind_color)

func set_state(calm_state: bool) -> void:
	current_state = calm_state
	set_color(calm_color if calm_state else blind_color)
