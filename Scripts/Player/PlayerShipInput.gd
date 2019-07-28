extends Node

export (NodePath) var shipPath
export (NodePath) var followCamera

var ship = null
var cam = null
var switch = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if followCamera:
		cam = get_node(followCamera)
		
	if shipPath:
		setShip(get_node(shipPath))
		
func setShip(newShip):
	if ship:
		ship.releaseControl()
		
	ship = newShip
	cam.setTarget(ship)
	ship.takeControl()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_PERIOD) && !switch:
		switch = true
		var ships = get_tree().get_nodes_in_group("ship")
		var next = 0
		
		if ship:
			next = (ships.find(ship) + 1) % ships.size()
		
		setShip(ships[next])
	elif !Input.is_key_pressed(KEY_PERIOD):
		switch = false
	
	if !ship:
		return
		
	var thrust = 0
	var torque = 0
	
	if Input.is_action_pressed("ship_thrust"):
		thrust += 1
		
	if Input.is_action_pressed("ship_cw"):
		torque += 1
	
	if Input.is_action_pressed("ship_ccw"):
		torque += -1
	
	ship.setThrust(thrust)
	ship.setTorque(torque)
