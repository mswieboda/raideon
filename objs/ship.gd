extends Spatial


func _ready():
	position_parts()

# position cockpit, wings, rear in relation to body size
func position_parts():
	var parts = ["cockpit", "rear", "wing_left", "wing_right"]

	for part in parts:
		var part_node = $parts.get_node(part)
		var body_part = $parts/body.get_node(part).transform.origin
		var part_body = part_node.get_node("body").transform.origin * part_node.scale

		part_node.transform.origin = body_part - part_body

func change_part(part: String, node: Spatial):
	$parts.remove_child($parts.get_node(part))
	node.set_name(part)
	$parts.add_child(node)
	position_parts()

func change_wing(resource: PackedScene):
	var wing_left = resource.instance()
	var wing_right = resource.instance()
	
	flip_wing(wing_right)
	change_part("wing_left", wing_left)
	change_part("wing_right", wing_right)

func flip_wing(node: Spatial):
	# scale z to -1
	# rotate y 180
	node.scale.z = -1
	node.rotate_y(180)

