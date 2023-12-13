extends MarginContainer

var ship: CharacterBody3D
var throttle: Label

# Called when the node enters the scene tree for the first time.
func _ready():
  ship = get_parent()
  throttle = $vbox/throttle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  throttle.text = str(ship.throttle)
