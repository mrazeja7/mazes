extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.get_node("Area").set_meta("type","usable")
	self.get_node("Area").set_meta("name","button")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func use(object):
	print(object.get_meta("name")," is attempting to use button")
	
	var moving_wall = get_tree().get_root().get_node("maze/walls/moving_wall")
	print(moving_wall)
	moving_wall.move_by = Vector3(0,0.25,0)
	pass