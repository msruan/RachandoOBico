extends Node2D

var allowed_levelup = false
@onready var player = get_node("/root/GaloFrito")

func _on_area_2d_body_entered(body):
	print("yesss")
	if body.has_method("player") and global.level2_completed == true:
		print("yesss queen")
		allowed_levelup = true
		$WaitTime.start()
		global.level2_completed = false

func _on_wait_time_timeout():
	get_tree().change_scene_to_file("res://levels/scenes/level3.tscn")
