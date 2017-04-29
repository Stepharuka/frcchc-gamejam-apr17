extends Node2D

var cursor_pos = Vector2(0,0)
var camera
var ui_map
var terrain_map
var player_node
var player_data = {
	"location": null
}

func _ready():
	set_process(true)
	set_process_input(true)
	#camera = get_node("Map/Map_Camera")
	#camera.make_current()
	ui_map = get_node("Map/UI")
	terrain_map = get_node("Map")
	player_node = get_node("Map/Player")
	player_data["location"] = terrain_map.world_to_map(player_node.get_pos())

func _process(delta):
	pass

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION: # Set mouse cursor.
		set_ui_cursor(ui_map.world_to_map(event.pos))
	if (event.type == InputEvent.MOUSE_BUTTON and not event.is_pressed()):
		var x = event.x-(event.x%16)
		var y = event.y-(event.y%16)
		if (((x / 16) % 2) == 0):
			x += 16
		if (((y / 16) % 2) == 0):
			y += 16
		var move_pos = Vector2(x, y)
		if can_move(move_pos):
			player_node.set_pos(move_pos)
			player_data["location"] = terrain_map.world_to_map(move_pos)

func set_ui_cursor(pos):
	ui_map.set_cellv(cursor_pos,-1)
	cursor_pos = pos
	ui_map.set_cellv(cursor_pos,0)

func can_move(move_pos):
	var map_pos = terrain_map.world_to_map(move_pos)
	var move_dist = distance_between_tiles(map_pos, player_data["location"])
	if (move_dist <= 2): # How many tiles player can move
		if (move_pos.x > 16 and move_pos.x < 240): # x-cord bounds (based on map)
			if (move_pos.y > 16 and move_pos.y < 240): # y-cord bounds (based on map)
				return true
	return false

func distance_between_tiles(pos_a, pos_b):
	var distance_x = (pos_b.x-pos_a.x)
	var distance_y = (pos_b.y-pos_a.y)
	if distance_x < 0:
		distance_x = -distance_x
	if distance_y < 0:
		distance_y = -distance_y
	return distance_x + distance_y