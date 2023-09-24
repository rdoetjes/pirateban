extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_grid_position(pos : Vector2) -> void:
	$AnimatedSprite2D.position = Vector2(pos.x*32+16, pos.y*32+16)	
