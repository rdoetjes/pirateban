extends Area2D

class_name  Treasure

static var grid_pos: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_grid_position(new_pos : Vector2i, use_tween: bool) -> void:
	if use_tween:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create($Sprite2D.position, Vector2(new_pos.x*32+16, new_pos.y*32+16),1)
		var result = space_state.intersect_ray(query)
		if result.is_empty():
			var tween = create_tween()
			tween.tween_property($Sprite2D, "position", Vector2(new_pos.x*32+16, new_pos.y*32+16), 0.15)
			grid_pos = new_pos
	else:
		$AnimatedSprite2D.position = Vector2(new_pos.x*32+16, new_pos.y*32+16)	
		grid_pos = new_pos
