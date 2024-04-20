extends CharacterBody2D


@export var damage: float
@export var speed: float
@export var rotation_speed: float


var light_sources: Dictionary


func _process(delta: float) -> void:
	var movement = Vector2(
		Input.get_axis("mirror.move.left", "mirror.move.right"),
		Input.get_axis("mirror.move.up", "mirror.move.down")
	)
	
	position += movement * speed * delta
	
	var rotation = Input.get_axis("mirror.move.rotate.left", "mirror.move.rotate.right")
	$MirrorRoot.rotate(rotation * rotation_speed * delta)
	
	for light_source in light_sources:
		var direction: Vector2 = (position - light_source.position).normalized()
		var dot: = maxf(direction.dot(-$MirrorRoot.transform.y), 0)
		var length = 500 * dot
		var beam: Line2D = light_sources[light_source]
		var raycast: RayCast2D = beam.get_node("RayCast")
		var particles: GPUParticles2D = beam.get_node("ImpactParticles")
		raycast.target_position = -direction.reflect($MirrorRoot.transform.y) * length
		
		var collider = raycast.get_collider()
		if collider:
			collider.apply_damage(damage * delta)
			length = (collider.position - position).length()
		
		
		beam.points[1] = -direction.reflect($MirrorRoot.transform.y) * length
		
		particles.emitting = dot > 0.0
		particles.amount = 32 if collider else 8
		particles.position = beam.points[1]


func register_light(light_source) -> void:
	var beam = load("res://players/beam.tscn").instantiate()
	add_child(beam)
	light_sources[light_source] = beam


func unregister_light(light_source) -> void:
	var beam = light_sources[light_source]
	beam.queue_free()
	light_sources.erase(light_source)
