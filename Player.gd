extends Area2D

var grid_pos: Vector2i
var enable_input: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_game_input()

func process_input()-> void:
	if Input.is_action_just_pressed("ui_up"):
		if (grid_pos.y > 0):
			grid_pos.y -= 1
			set_grid_position(grid_pos, true)			
	elif Input.is_action_just_pressed("ui_down"):
		if (grid_pos.y < 9):
			grid_pos.y += 1
			set_grid_position(grid_pos, true)
	elif Input.is_action_just_pressed("ui_left"):
		if (grid_pos.x > 0):
			grid_pos.x -= 1
			set_grid_position(grid_pos, true)
	elif Input.is_action_just_pressed("ui_right"):
		if (grid_pos.x < 19):
			grid_pos.x += 1
			set_grid_position(grid_pos, true)
	
	elif Input.is_action_just_pressed("restart"):
		get_parent().read_level()
	
	elif Input.is_action_just_pressed("end"):
		get_tree().quit()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	if enable_input:
		process_input()

func enable_game_input() -> void:
	enable_input = true
	
func disable_game_input() -> void:
	enable_input = false

func set_grid_position(new_pos : Vector2i, use_tween: bool) -> void:
	if use_tween:
		disable_game_input()
		var tween = create_tween()
		tween.connect("finished", enable_game_input)
		tween.tween_property($Sprite2D, "position", Vector2(new_pos.x*32+16, new_pos.y*32+16), 0.15)
	else:
		$Sprite2D.position = Vector2(new_pos.x*32+16, new_pos.y*32+16)	
	grid_pos = new_pos
	get_parent().add_step()
