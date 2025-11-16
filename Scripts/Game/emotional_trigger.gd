class_name EmotionalTrigger extends Area2D

@export var calm_mode: bool = true

func _enter_tree() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and is_instance_valid(StateEffect.instance):
		StateEffect.instance.set_state(calm_mode)

func _on_body_exited(body: Node2D) -> void:
	if body is Player and is_instance_valid(StateEffect.instance):
		StateEffect.instance.set_state(not calm_mode)
