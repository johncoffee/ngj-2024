extends PathFollow3D

# player state stuff
var bullets: int = 1
# proxy for currently equipped weapon
func gunDamage():
	return 100

@export var speed: float = 10.0

var player_id: int


@onready var move_left_action: = "p%d.move.left" % player_id
@onready var move_right_action: = "p%d.move.right" % player_id
@onready var shoot_action: = "p%d.shoot" % player_id


func _ready() -> void:
	$Camera.current = false
	$Camera.cull_mask = 0b1 | 1 << player_id


func _process(delta: float) -> void:
	var movement_input: = Input.get_axis(move_left_action, move_right_action)
	progress += movement_input * speed * delta
	
	if Input.is_action_just_pressed(shoot_action):
		var collider = $RayCast.get_collider()
		
		if collider: collider.free()
	
func shoot():
	bullets -= 1
	var projectile = load("res://bullet/bullet.tscn")
	var bullet = projectile.instance()
	
	# find forward relative to gun
	bullet.velocity = Vector3(0, 0, -1)
	bullet.max_damage = gunDamage()
	assert($bullets is Sprite3D, "did you forget to add bullets container to main?")
	($bullets as Sprite3D).add_child(bullet)
