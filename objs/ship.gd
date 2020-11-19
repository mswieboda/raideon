extends Spatial


func _ready():
	position_parts()

# position cockpit, wings, rear in relation to body size
func position_parts():
	var parts = ["cockpit", "rear", "wing_left", "wing_right"]

	for part in parts:
		var part_node = $parts.get_node(part)
		var body_part = $parts/body.get_node(part).transform.origin
		var part_body = part_node.get_node("body").transform.origin

		part_node.transform.origin = body_part - part_body

func change_part(part: String, node: Spatial):
	$parts.remove_child($parts.get_node(part))
	node.set_name(part)
	$parts.add_child(node)
	position_parts()
