extends CharacterBody2D

const tilesize = 16

var inputs = {
	"key_up" : Vector2.UP,
	"key_down" : Vector2.DOWN,
	"key_left" : Vector2.LEFT,
	"key_right" : Vector2.RIGHT,
}

func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if event.is_action_pressed("key_left"):
				$AnimatedSprite2D.flip_h = true
			elif event.is_action_pressed("key_right"):
				$AnimatedSprite2D.flip_h = false
			move(dir)


func move(dir):
	var vector_pos = inputs[dir]*tilesize
	
	var tween = create_tween()
	tween.tween_property(self,"position", position + vector_pos, 0.02)
	tween.tween_property(self,"scale", Vector2(0.9,1.1),0.05)
	tween.tween_property(self, "scale", Vector2(1.1,0.9),0.05)
	tween.tween_property(self, "scale", Vector2(1,1),0.05)
