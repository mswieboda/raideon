extends Control

var bodies = [
	preload("res://objs/parts/bodies/body_basic.tscn").instance(),
	preload("res://objs/parts/bodies/body_large.tscn").instance()
]

func _ready():
	$vbox/bodyList.connect("item_selected", self, "_body_list_selected")

	for body in bodies:
		$vbox/bodyList.add_item(body.part_name)

func _body_list_selected(index: int):
	print("selected: ", bodies[index].part_name)

	$Viewport/ship_preview/ship.change_part("body", bodies[index])

