extends Spatial


func _ready():
	change_part("body", preload("res://objs/parts/bodies/body_basic.tscn").instance())
	change_wing(preload("res://objs/parts/wings/wing_basic.tscn"))
	position_parts()

# position cockpit, wings, rear in relation to body size
func position_parts():
	var parts = ["cockpit", "rear", "wing_left", "wing_right"]

	for part in parts:
		var part_node = $parts.get_node(part)
		if part_node:
			var body_pos = $parts/body.get_node(part).transform.origin
			var part_body_pos = part_node.get_node("part/body").transform.origin

			part_body_pos *= part_node.get_node("part").scale

			if part == "wing_left" || part == "wing_right":
				print(">>> ", part, " part_node scale z: ", part_node.get_node("part").scale.z)

			part_node.transform.origin = body_pos - part_body_pos

func change_part(part: String, node: Spatial):
	var old_node = $parts.get_node(part)

	if old_node:
		$parts.remove_child(old_node)

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
	var part = node.get_node("part")
	part.scale.x = -1
