extends Spatial


func _ready():
	position_parts()

# position cockpit, wings, rear in relation to body size
func position_parts():
	var parts = ["cockpit", "rear", "wing_left"]
	var body_xform = $body.transform.origin

	for part in parts:
		var part_node = get_node(part)
		var body_part = $body.get_node(part).transform.origin
		var part_body = part_node.get_node("body").transform.origin

		part_node.transform.origin = body_part - part_body

