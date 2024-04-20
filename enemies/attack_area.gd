extends Area2D


var attack_tween: Tween


func _on_body_entered(body: Node2D) -> void:
	if not owner: return
	if body != owner.target: return
	attack_tween = create_tween()
	attack_tween.bind_node(self).set_loops() \
		.tween_callback(func(): body.apply_damage(owner.damage)) \
		.set_delay(1.0)


func _on_body_exited(body: Node2D) -> void:
	if not owner: return
	if body != owner.target: return
	attack_tween.kill()
	attack_tween = null
