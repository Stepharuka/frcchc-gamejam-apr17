extends TileMap

var current_pos setget set_current_pos, get_current_pos

func _ready():
	current_pos = get_pos()

class SelectedUnit:
	var vector_coords
	var unit_type

var selected_unit

func select_unit(coords):
	selected_unit = SelectedUnit.new()
	selected_unit.vector_coords = coords
	selected_unit.unit_type = get_cellv(coords)
	set_cellv(coords,-1)

func place_selected_unit(coords):
	set_cellv(coords,selected_unit.unit_type)
	selected_unit = null

func change_selected_unit(coords):
	if selected_unit != null:
		place_selected_unit(selected_unit.vector_coords)
	select_unit(coords)

func get_selected_unit():
	return selected_unit

func set_current_pos(pos):
	current_pos = pos

func get_current_pos():
	return current_pos

func move_unit(oldcoords, newcoords): # both vars are Vector2
	var unit_type = get_cellv(oldcoords)
	set_cellv(oldcoords,-1)
	set_cellv(newcoords,unit_type)