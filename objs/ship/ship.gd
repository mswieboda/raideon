extends KinematicBody

export var controlled = false

const THROTTLE_UP = 10
const THROTTLE_DOWN = 10
const PITCH_MIN = 5
const YAW_MIN = 5
const PITCH_AMOUNT = 0.13
const YAW_AMOUNT = 0.13
const ROLL_AMOUNT = 69

var throttle = 0
var pitch = 0
var yaw = 0
var roll = 0
var direction = Vector3(0, 0, 1)
var velocity = Vector3()

func _ready():
  change_part("body", preload("res://objs/parts/bodies/body_basic.tscn").instance())
  change_part("cockpit", preload("res://objs/parts/cockpits/cockpit_bubble.tscn").instance())
  change_part("rear", preload("res://objs/parts/rears/rear_double.tscn").instance())
  change_wing(preload("res://objs/parts/wings/wing_basic.tscn"))
  position_parts()
  
  if controlled:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
  return abs(throttle) > 0.1

func _physics_process(delta):
  if controlled:
    player_input(delta)
    
    # TODO: temp allows mouse control to quit while testing
    if Input.is_action_just_pressed("ui_cancel"):
      Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
  
  movement(delta)

func rotate(axis, amount):
  rotate_object_local(axis, amount)
  direction = direction.rotated(axis, amount)

func movement(delta):
  # NOTE: Godot should rotate by x first, then y
  #       which is why yaw is rotated first here
  
  rotate(Vector3(0, 1, 0), -yaw * delta)
  rotate(Vector3(1, 0, 0), pitch * delta)
  rotate(Vector3(0, 0, 1), roll * delta)
  
  velocity = transform.basis.z * throttle
  
#  velocity = direction * throttle
  
  transform.orthonormalized()
  
  move_and_slide(velocity)
  
  # reset pitch, yaw, roll
  pitch = 0
  yaw = 0
  roll = 0

func _input(event):
  if !controlled:
    return
  
  if event is InputEventMouseMotion:
    var x = event.relative.x
    var y = event.relative.y
    
    if abs(y) > PITCH_MIN:
      pitch = y * PITCH_AMOUNT
    
    if abs(x) > YAW_MIN:
      yaw = x * YAW_AMOUNT

func player_input(delta):
  # acceleration/deceleration
  if Input.is_action_pressed("throttle_up"):
    throttle += THROTTLE_UP * delta
  elif Input.is_action_pressed("throttle_down"):
    throttle -= THROTTLE_DOWN * delta
  
  # roll (Q, E keys)
  if Input.is_action_pressed("roll_right"):
    roll += ROLL_AMOUNT * delta
  elif Input.is_action_pressed("roll_left"):
    roll -= ROLL_AMOUNT * delta

