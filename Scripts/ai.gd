extends CharacterBody2D

@export var player_node: CharacterBody2D

const turns_to_move: int = 1

var grid: AStarGrid2D

var current_cell: Vector2i
var target_cell: Vector2i
var move_pts: Array

func setup(_grid: AStarGrid2D):
	grid = _grid
	current_cell = pos_to_cell(global_position)
	target_cell = current_cell

func pos_to_cell(pos: Vector2):
	return pos / grid.cell_size

	
