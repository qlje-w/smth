extends CharacterBody3D

const speed = 3.5
@onready var nav = $NavigationAgent3D
var player = null
@export var player_path : NodePath

func _getting_shot() -> void:
	queue_free()

func _ready() -> void:
	player = get_node(player_path)
	
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	nav.set_target_position(player.global_transform.origin)
	var next_pos = nav.get_next_path_position()
	var current_pos = global_transform.origin
	velocity = (next_pos - current_pos).normalized() * speed
	
	move_and_slide()
