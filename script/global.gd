extends Node

var levels = ['res://Levels/Level1.tscn','res://Levels/Level2.tscn','res://Levels/Level3.tscn']
var current_level

var start_screen = 'res://ui/StartScreen.tscn'
var end_screen = 'res://ui/EndScreen.tscn'

var score
var highscore = 0
var score_file = 'user://highscore.txt'

func setup():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		highscore = int(content)
		f.close()

func new_game():
	current_level = -1
	score = 0
	next_level()

func game_over():
	if score > highscore:
		highscore = score
		save_score()
	get_tree().change_scene(end_screen)
	
func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(highscore))
	f.close()

func next_level():
	current_level += 1
	if current_level >= Global.levels.size():
		game_over()
	else:
		get_tree().change_scene(levels[current_level])
		
# Called when the node enters the scene tree for the first time.
func _ready():
	setup() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
