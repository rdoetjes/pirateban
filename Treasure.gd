extends Area2D

class_name  Treasure

var grid_pos: Vector2i
var ray: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	ray = $RayCast2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func set_grid_position(new_pos : Vector2i, use_tween: bool) -> bool:
	if use_tween:
		var v: Vector2 = Vector2(new_pos.x*32+16, new_pos.y*32+16) - position
		ray.set_target_position(v)
		ray.force_raycast_update()
		if !ray.is_colliding():
			var tween = create_tween()
			tween.tween_property(self, "position", Vector2(new_pos.x*32+16, new_pos.y*32+16), 0.15)
			grid_pos = new_pos
			return true
		return false
	else:
		position = Vector2(new_pos.x*32+16, new_pos.y*32+16)	
		grid_pos = new_pos
		return true
