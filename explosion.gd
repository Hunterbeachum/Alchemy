extends CharacterBody2D

@onready var _animation_player = $AnimationPlayer
var mouse_position = null

func _process(delta):
	if _animation_player.current_animation == "":
		hide()
	pass


func _on_player_explode():
	show()
	mouse_position = get_global_mouse_position()
	position = mouse_position
	_animation_player.play("explosion")
