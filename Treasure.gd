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
		var v: Vector2 = Vector2(new_pos.x*get_parent().grid_size+get_parent().grid_offset, new_pos.y*get_parent().grid_size+get_parent().grid_offset) - position
		ray.set_target_position(v)
		ray.force_raycast_update()
		if !ray.is_colliding() || ray.get_collider() is Door:
			var tween = create_tween()
			tween.tween_property(self, "position", Vector2(new_pos.x*get_parent().grid_size+get_parent().grid_offset, new_pos.y*get_parent().grid_size+get_parent().grid_offset), 0.15)
			grid_pos = new_pos
			return true
		return false
	else:
		position = Vector2(new_pos.x*get_parent().grid_size+get_parent().grid_offset, new_pos.y*get_parent().grid_size+get_parent().grid_offset)	
		grid_pos = new_pos
		return true
