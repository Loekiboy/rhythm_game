extends Area2D

var t = 0.0

func _ready():
	mouse_entered.connect(_on_mouse_entered)
func _process(delta):
	t += delta
func _on_mouse_entered():
	
	
	print("Mouse entered zone. Time is: ", t)
