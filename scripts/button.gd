extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var swapped = false
var set1
var set2
var wall_parent

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.get_node("Area").set_meta("type","usable")
	self.get_node("Area").set_meta("name","button")
	set1 = get_tree().get_root().get_node("maze/walls/maze1")
	set2 = get_tree().get_root().get_node("maze/walls/maze2")
	wall_parent = get_tree().get_root().get_node("maze/walls")
#	print(set1)
#	print(set2)
	wall_parent.remove_child(set2)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func swap_walls():
	if not swapped:
		swapped = true
#		wall_parent.remove_child(set1)
		wall_parent.add_child(set2)
#		set2.visible = true
#		set1 = null
		set1.start_animation(true, -1)
		set2.start_animation(false, 1)
#		set1.animation = true
#		set1.destroy = true
#		set2.animation = true
#		set1.destroy = false
#		set2.direction = 1
	#	var walls = get_nodes_in_group("../walls/maze1")
	#	print(walls)
	pass

func use(object):
	print(object.get_meta("name")," is attempting to use button")
	swap_walls()
#	var elevator = get_tree().get_root().get_node("maze/walls/elevator")
#	print(elevator)
#	elevator.move = true
#	var light = get_tree().get_root().get_node("maze/DirectionalLight")
#	light.light_energy = 0
	pass