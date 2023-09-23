extends Node2D

var level: int = 1
var steps: int = -1
var PlayField: TileMap
var Player: Area2D

func read_level() -> void:
	var x: int = 0
	var y: int = 0
	var wall_tiles = [Vector2i(1,1), Vector2i(2,1), Vector2i(3,1), Vector2i(4,1)]
	var f = FileAccess.open("res://levels/level"+str(level)+".txt", FileAccess.READ)
	
	if null == f:
		printerr("Could not read level"+str(level)+".txt")
		get_tree().quit()
		return # why do I need this? I called quit!
		
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
					Player.set_grid_position(Vector2i(x, y))
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

func add_step():
	steps += 1

func add_level():
	level += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$UI/PanelContainer/HBoxContainer/StepsLbl.text = "STEPS: "+str(steps)
	pass
