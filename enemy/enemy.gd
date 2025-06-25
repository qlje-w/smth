extends CharacterBody3D

const speed = 3.5
@onready var nav = $NavigationAgent3D
var player = null
@export var player_path : NodePath
var player_seen = false

func _getting_shot() -> void:
	queue_free()

func _ready() -> void:
	player = get_node(player_path)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
	if player_seen == true:
		velocity = Vector3.ZERO
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		nav.set_target_position(player.global_transform.origin)
		var next_pos = nav.get_next_path_position()
		var current_pos = global_transform.origin
		velocity = (next_pos - current_pos).normalized() * speed
	
	move_and_slide()
	
func _process(delta: float) -> void:
	pass
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_seen = true
