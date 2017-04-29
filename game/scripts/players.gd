extends TileMap

var selected setget set_selected, get_selected
var current_pos setget set_current_pos, get_current_pos

func _ready():
	current_pos = get_pos()
	set_selected(false)

func set_selected(value):
	selected = value

func get_selected():
	return selected

func set_current_pos(pos):
	current_pos = pos

func get_current_pos():
	return current_pos