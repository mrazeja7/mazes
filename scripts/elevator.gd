extends Spatial

var move = false
var move_by = Vector3(0, 0.025, 0)
var direction_switch_interval = 3.0
var since_direction_switch = 0
var direction = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	var color = Color(255,255,255)
#	var mat = SpatialMaterial.new()
#	mat.albedo_color = color
#	self.get_node("MeshInstance").get_mesh().set_material(mat)
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
#	print(delta)
	print(move)
	if move == true:
		since_direction_switch += delta
		if (since_direction_switch > direction_switch_interval):
			since_direction_switch = 0.0
			direction *= -1
		var tmp = self.translation
		tmp += direction * move_by
		self.translation = tmp
		pass
