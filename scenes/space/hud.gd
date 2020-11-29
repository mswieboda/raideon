extends MarginContainer

var ship: KinematicBody
var speed: Label

# Called when the node enters the scene tree for the first time.
func _ready():
  ship = get_parent()
  speed = $vbox/speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  speed.text = str(ship.speed)
