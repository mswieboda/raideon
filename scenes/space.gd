extends Spatial

var thread: Thread
# var box = preload("res://objs/box/box.tscn")

const LINES = 31
const SPACING = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	thread = Thread.new()
# warning-ignore:return_value_discarded
	thread.start(self, "_create_box_grid")

func _create_box_grid(_data):
	var color = Color.rebeccapurple
	var thickness = 1.0
	var length = LINES * SPACING
	print(">>> _create_box_grid ", length)
	
	Line.draw("test", Vector3(-1, -1, -10), Vector3(-1, -1, 10), color, 10)
	
#	for x in LINES:
#		for y in LINES:
#			var id = "g" + ":" + str(x) + ":" + str(y) + ":"
#			print("id: ", id)
#			var a = Vector3(x, y, 0)
#			var delta = (LINES - 1) / 2.0 * SPACING
#			var b = a + Vector3(0, 0, length)
#			Line.draw(id, a, b, color, thickness)

func _exit_tree():
	thread.wait_to_finish()
