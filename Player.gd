extends Area2D

var grid_pos: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if (grid_pos.y > 0):
			grid_pos.y -= 1
			set_grid_position(grid_pos, true)
			
	if Input.is_action_just_pressed("ui_down"):
		if (grid_pos.y < 9):
			grid_pos.y += 1
			set_grid_position(grid_pos, true)
	
	if Input.is_action_just_pressed("ui_left"):
		if (grid_pos.x > 0):
			grid_pos.x -= 1
			set_grid_position(grid_pos, true)
	
	if Input.is_action_just_pressed("ui_right"):
		if (grid_pos.x < 19):
			grid_pos.x += 1
			set_grid_position(grid_pos, true)
	
	if Input.is_action_just_pressed("restart"):
		get_parent().read_level()
	
	if Input.is_action_just_pressed("end"):
		get_tree().quit()

func set_grid_position(new_pos : Vector2i, use_tween: bool) -> void:
	if use_tween:
		var tween = create_tween()
		tween.tween_property($Sprite2D, "position", Vector2(new_pos.x*32+16, new_pos.y*32+16), 0.15)
	else:
		$Sprite2D.position = Vector2(new_pos.x*32+16, new_pos.y*32+16)	
	grid_pos = new_pos
	get_parent().add_step()
