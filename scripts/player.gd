extends KinematicBody

var speed = 500
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()

#camera control
var camera
var third_person = false
var view_sensitivity = 0.2
var yaw = 0
var pitch = 0

var pos_label

func _process(delta):
	pos_label.text = ("%s %s" % [self.translation.x, self.translation.z])

func _ready():
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = get_node("yaw/Camera")
	pos_label = get_node("poslabel")

func _enter_scene():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _exit_scene():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var aim = get_node("yaw").get_global_transform().basis
	
	direction = Vector3()
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		direction -= aim[0]
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		direction += aim[0]
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		direction -= aim[2]
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		direction += aim[2]
	
	direction = direction.normalized()
	direction = direction * speed * delta
	
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
		
	#jump
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 10
		
func change_pov():
	if not third_person:
		third_person = true
		camera.translate(Vector3(0,0.75,1.5))
		camera.rotate_x(deg2rad(-30))
	else:
		third_person = false
		camera.rotate_x(deg2rad(30))
		camera.translate(Vector3(0,-0.75,-1.5))
	pass
		
func _input(ie):
	if ie is InputEventKey and Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		pass
	if ie is InputEventKey and Input.is_key_pressed(KEY_C):
		change_pov()
		pass
	
	if ie is InputEventKey and Input.is_key_pressed(KEY_F):
		OS.window_fullscreen = not OS.window_fullscreen
		get_node("crosshair/Label").visible = not get_node("crosshair/Label").visible
		pass
		
	#mouse movement
	if ie is InputEventMouseMotion:
		yaw = fmod(yaw - ie.relative.x * view_sensitivity, 360)
		pitch = max(min(pitch - ie.relative.y * view_sensitivity, 90), -90)
		set_rotation(Vector3(0, deg2rad(yaw), 0))
		camera.set_rotation(Vector3(deg2rad(pitch), 0, 0))