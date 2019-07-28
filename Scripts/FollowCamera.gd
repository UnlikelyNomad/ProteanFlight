extends Camera2D

class_name FollowCamera2D

export(NodePath) var targetPath

var target:Node2D = null

export var velocityZoom = 0.001
export var velocityPan = 0.2

export var zoomLerp = 0.5
export var panLerp = 0.5

export var baseZoom = 1.0

var physics = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if targetPath:
		setTarget(get_node(targetPath))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if physics || !target:
		return
	
	position = target.position
	
func _physics_process(delta):
	if !physics || !target:
		return
	
	var pos = target.position
	var vel = target.get_linear_velocity()
	var pan
	
	if velocityPan > 0:
		pan = vel * velocityPan
		pos += pan
		
	if velocityZoom > 0:
		var zoom = vel.length() * velocityZoom + baseZoom
		set_zoom(lerp(get_zoom(), Vector2(zoom, zoom), zoomLerp))
	else:
		set_zoom(Vector2(baseZoom, baseZoom))
	
	position = lerp(position, pos, panLerp)
	#print(pan)

func setTarget(newTarget):
	target = newTarget
	physics = target.is_in_group("physics")