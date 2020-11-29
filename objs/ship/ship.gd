extends KinematicBody

export var controlled = false

const THROTTLE_UP = 10
const THROTTLE_DOWN = 10

var throttle = 0
var direction = Vector3(0, 0, 1)
var velocity = Vector3()

func _ready():
  change_part("body", preload("res://objs/parts/bodies/body_basic.tscn").instance())
  change_part("cockpit", preload("res://objs/parts/cockpits/cockpit_bubble.tscn").instance())
  change_part("rear", preload("res://objs/parts/rears/rear_double.tscn").instance())
  change_wing(preload("res://objs/parts/wings/wing_basic.tscn"))
  position_parts()

# position cockpit, wings, rear in relation to body size
func position_parts():
  var parts = ["cockpit", "rear", "wing_left", "wing_right"]

  for part in parts:
    var part_node = $parts.get_node(part)
    if part_node:
      var body_pos = $parts/body.get_node(part).transform.origin
      var part_body_pos = part_node.get_node("part/body").transform.origin * part_node.get_node("part").scale

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

func is_moving():
  return throttle > 0.1 || throttle < 0.1

func _physics_process(delta):
  if controlled:
    player_input(delta)
  
  if is_moving():
    velocity = direction * throttle
    move_and_slide(velocity)


func _input(event):
  if !controlled:
    return
  
  if event is InputEventMouseMotion:
    pass


func player_input(delta):
  # acceleration/deceleration
  if Input.is_action_pressed("throttle_up"):
    throttle += THROTTLE_UP * delta
  elif Input.is_action_pressed("throttle_down"):
    throttle -= THROTTLE_DOWN * delta
  
  # pitch
  
  
  
  # yaw
  
  # roll
  pass
