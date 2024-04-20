extends Node

#EnemyEvents.enemy_died.emit()
# Called when the node enters the scene tree for the first time.


func _ready():
	EnemyEvents.enemy_died.connect(_handle_enemy_died)

func _handle_enemy_died():
	var ui = get_node("../UI/Test-ui/GameUI/UIManager")
	if ui is UIManager:
		ui.increment_score()
