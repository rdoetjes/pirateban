extends Node2D

static var level: int = 1
static var steps: int = 0
static var PlayField: TileMap
static var Player: CharacterBody2D

var TreasureScene: PackedScene = preload("res://Treasure.tscn")
var DoorScene: PackedScene = preload("res://Door.tscn")

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
	steps = 0
	var x: int = 0
	var y: int = 0
	var wall_tiles = [Vector2i(1,1), Vector2i(2,1), Vector2i(3,1), Vector2i(4,1)]
	var empty_tiles = [Vector2i(1,2), Vector2i(2,2), Vector2i(3,2), Vector2i(4,2)]
	
	delete_old_objects()
	
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
					var Door = DoorScene.instantiate()
					Door.set_grid_position(Vector2i(x, y))
					Door.name = "Door"+str(x)+"_"+str(y)
					add_child(Door)
				"T":
					PlayField.set_cell(0, Vector2i(x, y), 0, empty_tiles.pick_random())	
					var Treasure =  TreasureScene.instantiate()
					Treasure.name = "Treasure"+str(x)+"_"+str(y)
					Treasure.set_grid_position(Vector2i(x, y), false)
					add_child(Treasure) 
				"P":
					PlayField.set_cell(0, Vector2i(x, y), 0, empty_tiles.pick_random())	
					Player.set_grid_position(Vector2i(x, y), false)
				_:
					PlayField.set_cell(0, Vector2i(x, y), 0, empty_tiles.pick_random())	
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

func check_all_crates_in_exit() -> bool:
	var door_pos = []
	var treasure_pos = []
	
	for child in get_children():
		if child is Door:
			door_pos.push_back(child.position)
		if child is Treasure:
			treasure_pos.push_back(child.position)
	
	door_pos.sort()
	treasure_pos.sort()
	#This is convenient!!!
	if door_pos == treasure_pos:
		return true
	return false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	$UI/PanelContainer/HBoxContainer/StepsLbl.text = "STEPS: "+str(steps)
	if check_all_crates_in_exit():
		level += 1
		read_level()

func _on_check_button_pressed():
	if $AudioStreamPlayer2D.playing: 
		$AudioStreamPlayer2D.stop()
	else:
		$AudioStreamPlayer2D.play()

func delete_old_objects() -> void:
	for child in self.get_children():
		if child is Treasure || child is Door:
			child.queue_free()
