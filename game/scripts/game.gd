extends CanvasLayer

var TILE_SIZE = 64
var cursor_pos = Vector2(0,0)

onready var terrain_map = get_node("Level 1/Base Layer Terrain")
onready var players_node = get_node("Level 1/Player Units")
onready var enemies_node = get_node("Level 1/Enemy Units")

func _ready():
	# set_process(true)
	set_process_input(true)

func _input(event):
	#if event.type == InputEvent.MOUSE_MOTION: # Set mouse cursor.
		#set_ui_cursor(ui_map.world_to_map(event.pos))
	if (event.type == InputEvent.MOUSE_BUTTON and not event.is_pressed()):
		var target_tile = terrain_map.world_to_map(event.pos)
		var move_pos = terrain_map.map_to_world(target_tile)
		if terrain_map.is_passable(target_tile):
			pass
			players_node.move_unit(Vector2(players_node.get_used_cells()[0]),target_tile)