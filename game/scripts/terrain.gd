extends TileMap

func _ready():
	pass

func is_passable(coords): # coords is a Vector2
	if get_cellv(coords) != -1 and get_node("Terrain Features").get_cellv(coords) == -1:
		return true
	else:
		return false