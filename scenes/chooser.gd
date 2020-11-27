extends Control

var parts_path = "res://objs/parts/"
var parts = {
	"body": { "dir": "bodies", "nodes": [] },
	"cockpit": { "dir": "cockpits", "nodes": [] },
	"rear": { "dir": "rears", "nodes": [] },
	"wing": { "dir": "wings", "resources": [] }
}


func _ready():
# warning-ignore:return_value_discarded
	$vbox/body_list.connect("item_selected", self, "_body_list_selected")
# warning-ignore:return_value_discarded
	$vbox/cockpit_list.connect("item_selected", self, "_cockpit_list_selected")
# warning-ignore:return_value_discarded
	$vbox/rear_list.connect("item_selected", self, "_rear_list_selected")
# warning-ignore:return_value_discarded
	$vbox/wing_list.connect("item_selected", self, "_wing_list_selected")

	for part_key in parts:
		var part = parts[part_key]
		var part_path = parts_path + part["dir"] + "/"

		for file in Util.get_files_in_directory(part_path):
			var resource = load(part_path + file)
			var node = resource.instance()

			if part_key == "wing":
				part["resources"].append(resource)
			else:
				part["nodes"].append(node)
			print(">>> getting ", part_key + "_list")
			$vbox.get_node(part_key + "_list").add_item(node.part_name)

func list_selected(part_key: String, index: int):
	var node = parts[part_key]["nodes"][index]
	$Viewport/ship_preview/ship.change_part(part_key, node)

func _body_list_selected(index: int):
	list_selected("body", index)

func _cockpit_list_selected(index: int):
	list_selected("cockpit", index)

func _rear_list_selected(index: int):
	list_selected("rear", index)

func _wing_list_selected(index: int):
	var resource = parts["wing"]["resources"][index]
	$Viewport/ship_preview/ship.change_wing(resource)
