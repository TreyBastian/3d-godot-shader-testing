extends Node

@export var mob_scene: PackedScene


func _ready() -> void:
	$UserInterface/Retry.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")

	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	mob.initalize(mob_spawn_location.position, player_position)
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
	add_child(mob)


func _on_player_hit() -> void:
	$MobTimer.stop()
	$UserInterface/Retry.show()
