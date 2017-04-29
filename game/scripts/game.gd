extends CanvasLayer

var TILE_SIZE = 64
var cursor_pos = Vector2(0,0)

onready var terrain_map = get_node("Level 1/Base Layer Terrain")
onready var players_node = get_node("Level 1/Player Units")
onready var enemies_node = get_node("Level 1/Enemy Units")

func _ready():
#	set_process(true)
	set_process_input(true)


func _input(event):
	#if event.type == InputEvent.MOUSE_MOTION: # Set mouse cursor.
		#set_ui_cursor(ui_map.world_to_map(event.pos))
	if (event.type == InputEvent.MOUSE_BUTTON):
		if event.is_pressed():
			if players_node.get_cellv(players_node.world_to_map(event.pos)) != -1:
				players_node.change_selected_unit(players_node.world_to_map(event.pos))
				get_node("Cursor Unit").show()
		else:
			var target_tile = terrain_map.world_to_map(event.pos)
			if players_node.get_selected_unit() != null:
				if terrain_map.is_passable(target_tile):
					players_node.place_selected_unit(target_tile)
					get_node("Cursor Unit").hide()
			else:
				if players_node.get_selected_unit() != null:
					players_node.place_selected_unit(players_node.get_selected_unit().vector_coords)
	elif (event.type == InputEvent.MOUSE_MOTION):
		if players_node.get_selected_unit() != null:
			get_node("Cursor Unit").set_pos(event.pos)