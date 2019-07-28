extends "res://Scripts/GravityBody.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var forceThrust = 10
export var forceTorque = 20

var thrust = 0
var torque = 0

export var curThrust = Vector2(0, 0)
export var curTorque = 0

var playerControl = false

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	add_to_group("physics")
	add_to_group("ship")

func takeControl():
	playerControl = true

func releaseControl():
	playerControl = false

func setThrust(newThrust):
	thrust = newThrust

func setTorque(newTorque):
	torque = newTorque

func _physics_process(delta):
	add_central_force(-curThrust)
	curThrust = Vector2(thrust * forceThrust, 0).rotated(rotation)
	add_central_force(curThrust)
	
	$Exhaust.emitting = thrust > 0
	
	add_torque(-curTorque)
	curTorque = torque * forceTorque
	add_torque(curTorque)
