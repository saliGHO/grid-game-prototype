extends CharacterBody2D

@export var game: Node2D
@export var path_previz: Line2D 
@export var player: CharacterBody2D


var grid: AStarGrid2D
var path_to_player: Array
var turn_counter: int = 1
var turns_to_move: int = 2

func setup(_grid: AStarGrid2D):
	grid = _grid
	player.player_did_action.connect(_move_ai)
	path_previz.global_position = Vector2(game.tile_size/2.0,game.tile_size/2.0)

func _move_ai():
	path_to_player = grid.get_point_path(global_position / grid.cell_size, player.global_position / grid.cell_size)
	path_previz.points = path_to_player
	
	if turn_counter != turns_to_move:
		turn_counter += 1
	else:
		if path_to_player.size() > 1:
			path_to_player.remove_at(0)
			var go_to_pos: Vector2 = path_to_player[0] + Vector2(game.tile_size/4.0,game.tile_size/4.0)
			
			if go_to_pos.x != global_position.x:
				$AiSprite.flip_h = false if go_to_pos.x > global_position.x else true
			
			global_position = go_to_pos
			
			path_previz.points = path_to_player
			
			turn_counter = 1
			
			var tween = create_tween()
			tween.tween_property(self,"position", position, 0.02)
			tween.tween_property(self,"scale", Vector2(0.9,1.1),0.05)
			tween.tween_property(self, "scale", Vector2(1.1,0.9),0.05)
			tween.tween_property(self, "scale", Vector2(1,1),0.05)
