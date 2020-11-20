extends Node2D

class Line:
	var id: String
	var color: Color
	var thickness: float
	var a = Vector2()
	var b = Vector2()

var lines
var camera

func _ready():
	camera = get_viewport().get_camera()
	lines = []
	set_process(true)

func _draw():
	for line in lines:
		print(">>> _draw line: ", line)
		draw_line(line.a, line.b, line.color, line.thickness)

func _process(delta):
	update()

func draw(id: String, vector_a: Vector3, vector_b: Vector3, color: Color, thickness: float):
	for line in lines:
		if line.id == id:
			line.color = color
			line.a = camera.unproject_position(vector_a)
			line.b = camera.unproject_position(vector_b)
			line.thickness = thickness
			return
	
	var new_line = Line.new()
	new_line.id = id
	new_line.color = color
	new_line.a = camera.unproject_position(vector_a)
	new_line.b = camera.unproject_position(vector_b)
	new_line.thickness = thickness
	
	lines.append(new_line)

func remove(id):
	var i = 0
	var found = false
	
	for line in lines:
		if line.id == id:
			found = true
			break
			i += 1
		
		if found:
			lines.remove(i)
