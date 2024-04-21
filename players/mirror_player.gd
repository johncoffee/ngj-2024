extends CharacterBody2D


signal dead


@export var health: = 100
@export var damage: float
@export var speed: float
@export var rotation_speed: float


var light_sources: Dictionary
var current_health: float:
	set(value):
		value = clampf(value, 0, health)
		if is_equal_approx(value, current_health): return
		current_health = value
		
		if is_equal_approx(0.0, current_health):
			dead.emit()
			set_process(false)


func _ready() -> void:
	current_health = health
	$Health.max_value = health


var rotation_input: float


func _process(delta: float) -> void:
	$Health.value = current_health
	
	var movement = Vector2(
		Input.get_axis("mirror.move.left", "mirror.move.right"),
		Input.get_axis("mirror.move.up", "mirror.move.down")
	)
	
	update_animations(movement, delta)
	
	velocity = movement * speed
	move_and_slide()
	
	var new_rotation_input = Input.get_axis("mirror.move.rotate.left", "mirror.move.rotate.right")
	if is_zero_approx(new_rotation_input): rotation_input = new_rotation_input
	else: rotation_input = lerpf(rotation_input, new_rotation_input, delta * 2)
	$MirrorRoot.rotate(rotation_input * rotation_speed * delta)
	
	for light_source in light_sources:
		var direction: Vector2 = (position - light_source.position).normalized()
		var dot: = maxf(direction.dot(-$MirrorRoot.transform.y), 0)
		var length = 500 * dot
		var beam: Line2D = light_sources[light_source]
		var raycast: RayCast2D = beam.get_node("RayCast")
		var particles: GPUParticles2D = beam.get_node("ImpactParticles")
		raycast.target_position = -direction.reflect($MirrorRoot.transform.y) * length
		
		var collider = raycast.get_collider()
		if collider and collider.has_method("apply_charge"):
			collider.apply_charge(damage * delta)
			length = (collider.position - position).length()
		
		beam.points[1] = -direction.reflect($MirrorRoot.transform.y) * length
		
		particles.emitting = dot > 0.0 and collider
		particles.position = beam.points[1]


func register_light(light_source) -> void:
	var beam = load("res://players/beam.tscn").instantiate()
	add_child(beam)
	light_sources[light_source] = beam


func unregister_light(light_source) -> void:
	var beam = light_sources[light_source]
	beam.queue_free()
	light_sources.erase(light_source)


func update_animations(input: Vector2, delta: float) -> void:
	if input.length_squared() < 0.0001: $AnimationPlayer.play("hovering")
	else: $AnimationPlayer.play("flying")
	input.y *= -1
	$RedRockets.rotation = lerp_angle($RedRockets.rotation, input.angle_to(Vector2.DOWN), delta * 10)


func apply_damage(value: float) -> void:
	current_health -= value
