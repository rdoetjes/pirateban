extends Area2D

class_name Door
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_grid_position(pos : Vector2) -> void:
	position = Vector2(pos.x*get_parent().grid_size+get_parent().grid_offset, pos.y*get_parent().grid_size+get_parent().grid_offset)	
