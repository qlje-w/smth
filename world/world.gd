extends Node3D

@export var shell = preload("res://shell/shell_scene.tscn")
@onready var character_body_3d = $Player
@onready var shell_spawner = $Player/head/anims/Camera3D/weapons/shotgun/spawner_Shell

func _ejection_shell() -> void:
	var speed_of_shell_local = shell_spawner.global_transform.basis * Vector3(0, 0, 5)
	var random_speed = randf_range(1, 1.3)
	
	if $Player.is_reloading:
		var shell_casing = shell.instantiate()
		shell_casing.global_transform = shell_spawner.global_transform
		add_child(shell_casing)
		shell_casing.linear_velocity = $Player.velocity + speed_of_shell_local * random_speed
