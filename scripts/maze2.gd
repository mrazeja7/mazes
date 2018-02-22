extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var animation = false
var frames_left = 90
var frame_offset = 30
var frames_since_start = 0
var movement = Vector3(0, 0.05, 0)
var direction = -1
var destroy = false


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func start_animation(dest, dir):
	self.animation = true
	self.destroy = dest
	self.direction = dir
	self.translation -= frames_left * movement * direction
	pass
	
func _process(delta):
	if animation:
		frames_since_start += 1
		if frames_since_start <= frame_offset:
			return
		frames_left -= 1
		if frames_left <= 0.0:
			if destroy:
				self.queue_free()
				return
			animation = false
		self.translation += movement * direction
		pass
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
