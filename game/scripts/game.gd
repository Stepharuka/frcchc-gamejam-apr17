extends CanvasLayer

var TILE_SIZE = 64
var cursor_pos = Vector2(0,0)
var terrain_map
var players_node
var enemies_node

func _ready():
	# set_process(true)
	set_process_input(true)
	terrain_map = get_node("Level 1/Base Layer Terrain")
	players_node = get_node("Level 1/Player Units")
	enemies_node = get_node("Level 1/Enemy Units")

func _input(event):
	#if event.type == InputEvent.MOUSE_MOTION: # Set mouse cursor.
		#set_ui_cursor(ui_map.world_to_map(event.pos))
	if (event.type == InputEvent.MOUSE_BUTTON and not event.is_pressed()):
		var x = event.x-(event.x%TILE_SIZE)
		var y = event.y-(event.y%TILE_SIZE)
		print(x,", ",y)
		#if (((x / TILE_SIZE) % 2) == 0):
			#x += TILE_SIZE
		#if (((y / TILE_SIZE) % 2) == 0):
			#y += TILE_SIZE
		var move_pos = Vector2(x, y)
		if is_valid_map_pos(calculate_tilemap_size(terrain_map), move_pos):
			players_node.set_pos(move_pos)

func calculate_tilemap_size(tilemap):
    # Get list of all positions where there is a tile
    var used_cells = tilemap.get_used_cells()

    # If there are none, return null result
    if used_cells.size() == 0:
        return {x=0, y=0, width=0, height=0}

    # Take first cell as reference
    var min_x = used_cells[0].x
    var min_y = used_cells[0].y
    var max_x = min_x
    var max_y = min_y

    # Find bounds
    for i in range(1, used_cells.size()):

        var pos = used_cells[i]

        if pos.x < min_x:
            min_x = pos.x
        elif pos.x > max_x:
            max_x = pos.x

        if pos.y < min_y:
            min_y = pos.y
        elif pos.y > max_y:
            max_y = pos.y

    # Return resulting bounds
    return {
        "x_min": min_x,
        "y_min": min_y,
        "x_max": max_x - min_x + 1,
        "y_max": max_y - min_y + 1
    }

func is_valid_map_pos(tilemap_dims, pos):
	if (pos.x > (tilemap_dims["x_min"]*TILE_SIZE) and pos.x < ((tilemap_dims["x_max"]*TILE_SIZE)-64)): # x-cord bounds (based on map)
		if (pos.y > (tilemap_dims["y_min"]*TILE_SIZE) and pos.y < ((tilemap_dims["y_max"]*TILE_SIZE)-64)): # y-cord bounds (based on map)
			return true
	return false