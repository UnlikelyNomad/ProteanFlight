extends RigidBody2D

class_name GravityBody2D

var G = 2000

var gravSources = []

export var gravity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	add_to_group("gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	add_central_force(-1 * gravity)
	
	gravity = Vector2(0, 0)
	
	for source in gravSources:
		var d = source.position - position
		var g = G * source.mass * mass
		var f = d.normalized() * g / d.length_squared()
		gravity += f
		
	add_central_force(gravity)
	
func addGravSource(source):
	gravSources.push_back(source)
	
func removeGravSource(source):
	gravSources.erase(source)