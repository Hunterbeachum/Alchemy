extends Button
signal pick_up_item

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = Button.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item1_pressed():
	pick_up_item.emit(self._get_item1_animation())


func _get_item1_animation():
	return "bomb" # TODO make this method return the item located in item1
