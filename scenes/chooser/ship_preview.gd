extends Spatial

const ROTATION_SPEED = 0.69

func _process(delta):
	$ship.rotate(Vector3(0, 1, 0), -ROTATION_SPEED * delta)
