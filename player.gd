extends Node3D


@export var speed: float = 10.0


var player_id: int


@onready var move_left_action: = "p%d.move.left" % player_id
@onready var move_right_action: = "p%d.move.right" % player_id
@onready var shoot_action: = "p%d.shoot" % player_id


func _process(delta: float) -> void:
    var movement_input: = Input.get_axis(move_right_action, move_left_action)
    translate(Vector3.RIGHT * movement_input * speed * delta)
