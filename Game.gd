extends Node2D

static var level: int = 0
static var steps: int = -1
static var PlayField: TileMap
static var Player: Area2D

func check_level_files() -> FileAccess:
	#iterate down the levels, when a level file can't be found to find the last level
	while not FileAccess.file_exists("res://levels/level"+str(level)+".txt"):
		level -= 1
		if level < 0:
			printerr("Could find valid level")
			get_tree().quit()
			return null
			
	var f = FileAccess.open("res://levels/level"+str(level)+".txt", FileAccess.READ)	
	if null == f:
		printerr("Could not read level"+str(level)+".txt")
		get_tree().quit()
		return null
	return f

func read_level() -> void:
	steps = -1
	var x: int = 0
	var y: int = 0
	var wall_tiles = [Vector2i(1,1), Vector2i(2,1), Vector2i(3,1), Vector2i(4,1)]
	
	var f = check_level_files()
	if null == f:
		return
		
	while not f.eof_reached():
		var line = f.get_line()
		for c in line:
			match(c):
				'W':
					PlayField.set_cell(0, Vector2i(x, y), 0, wall_tiles.pick_random())	
				"D":
					PlayField.set_cell(0, Vector2i(x, y), 0, Vector2i(6,4))	
				"T":
					PlayField.set_cell(0, Vector2i(x, y), 0, Vector2i(6,2))	
				"P":
					Player.set_grid_position(Vector2i(x, y), false)
				_:
					PlayField.set_cell(0, Vector2i(x, y), 0, Vector2i(3,5))	
			x += 1
		y += 1
		x = 0
	f.close()
	$UI/PanelContainer/HBoxContainer/LevelLbl.text = "LEVEL: "+str(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayField = $PlayField
	Player = $Player
	read_level()

func add_step() -> void:
	steps += 1

func add_level() -> void:
	level += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	$UI/PanelContainer/HBoxContainer/StepsLbl.text = "STEPS: "+str(steps)
