extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.register_light(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	body.unregister_light(self)
