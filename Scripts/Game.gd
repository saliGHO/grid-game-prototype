extends Node2D

@onready var map: TileMapLayer = $Map/TileMapLayer
@export var tile_size: = 16

var astar_grid: AStarGrid2D

func _ready() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.cell_size = Vector2(tile_size, tile_size)
	astar_grid.region = Rect2(Vector2.ZERO, ceil(get_viewport_rect().size / astar_grid.cell_size))
	astar_grid.update()
	
	for id in map.get_used_cells():
		var data = map.get_cell_tile_data(id)
		if data and data.get_custom_data("obstacle"):
			astar_grid.set_point_solid(id)
	
	%GridDisplay.grid = astar_grid
	%AI.setup(astar_grid)
