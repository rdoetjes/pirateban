extends Area2D

var grid_pos: Vector2i
var enable_input: bool = true
var ray: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray = $RayCast2D
	enable_game_input()

func process_input()-> void:
	if Input.is_action_just_pressed("ui_up"):
		if (grid_pos.y > 0):
			set_grid_position(Vector2i(grid_pos.x, grid_pos.y-1), true)
	elif Input.is_action_just_pressed("ui_down"):
		if (grid_pos.y < get_parent().HEIGHT - 1):
			set_grid_position(Vector2i(grid_pos.x, grid_pos.y+1), true)
	elif Input.is_action_just_pressed("ui_left"):
		if (grid_pos.x > 0):
			set_grid_position(Vector2i(grid_pos.x-1, grid_pos.y), true)
	elif Input.is_action_just_pressed("ui_right"):
		if (grid_pos.x < get_parent().WIDTH - 1):
			set_grid_position(Vector2i(grid_pos.x+1,grid_pos.y), true)
	
	elif Input.is_action_just_pressed("restart"):
		get_parent().read_level()
	
	elif Input.is_action_just_pressed("end"):
		get_tree().quit()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass

func enable_game_input() -> void:
	enable_input = true
	
func disable_game_input() -> void:
	enable_input = false

func move_anim(new_pos: Vector2i):
	disable_game_input()
	var tween = create_tween()
	tween.connect("finished", enable_game_input)
	tween.tween_property(self, "position", Vector2(new_pos.x*get_parent().cell_size+get_parent().half_cell_size, new_pos.y*get_parent().cell_size+get_parent().half_cell_size), 0.15)
	get_parent().add_step()
	grid_pos = new_pos

func set_grid_position(new_pos: Vector2i, use_tween: bool) -> void:
	if use_tween:
		var v: Vector2=Vector2(new_pos.x*get_parent().cell_size+16, new_pos.y*get_parent().cell_size+16)-position
		ray.set_target_position(v)
		ray.force_raycast_update()
		if !ray.is_colliding() || ray.get_collider() is Door:
			move_anim(new_pos)
		elif ray.get_collider( ) is Treasure:
			var t: Treasure = ray.get_collider()
			var vt: Vector2i = new_pos - grid_pos
			if t.set_grid_position(Vector2i(t.grid_pos.x+vt.x,t.grid_pos.y+vt.y), true):
				move_anim(new_pos)
	else:
		position = Vector2(new_pos.x*get_parent().cell_size+get_parent().half_cell_size, new_pos.y*get_parent().cell_size+get_parent().half_cell_size)	
		grid_pos = new_pos
	
func _physics_process(_delta):
	if enable_input:
		process_input()
