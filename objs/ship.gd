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
	if part == "wing":
		change_part("wing_left", node)

		var node_flipped = node
		# flip wing for right and add
		# https://godotengine.org/qa/3953/want-flip-character-the-horizontal-axis-but-whats-the-best-way
		change_part("wing_right", node_flipped)
		return

	$parts.remove_child($parts.get_node(part))
	node.set_name(part)
	$parts.add_child(node)
	position_parts()
