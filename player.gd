extends Area2D
var screen_size
var mouse_position = null
var held_item = null
var item_effects = {"bomb": "damage_effect"}

signal hit
signal explode
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	_reset_model()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	position = mouse_position
	position = position.clamp(Vector2.ZERO, screen_size)
	$AnimatedSprite2D.play()
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	if Input.is_action_pressed("click"):
		if held_item != null:
			use_item(held_item)


func _reset_model():
	$AnimatedSprite2D.animation = "wisp"
	held_item = null


func _on_body_entered(body):
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(1.0).timeout
	$CollisionShape2D.set_deferred("enabled", true)


# Change the player animation to indicate the currently held item.
func _on_item_1_pick_up_item(item):
	held_item = item
	if item == null:
		_reset_model()
	else:
		$AnimatedSprite2D.animation = item

# TODO Reference the dictionary of held item effects.
func use_item(held_item):
	if held_item == "bomb":
		$CollisionShape2D.set_deferred("disabled", true)
		explode.emit()
		_reset_model()

