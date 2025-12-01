extends RigidBody3D

var move_speed = 5
var rotation_speed = 2

func _ready():
	contact_monitor = true
	max_contacts_reported = 10

func _process(delta):
	# wasd movement using inout map
	if not freeze:
		if Input.is_action_pressed("move_foward"):
			global_translate(Vector3(0,0,move_speed * delta))
		if Input.is_action_pressed("move_back"):
			global_translate(Vector3(0,0,-move_speed * delta))
		if Input.is_action_pressed("move_left"):
			global_translate(Vector3(move_speed * delta,0,0))
		if Input.is_action_pressed("move_right"):
			global_translate(Vector3(-move_speed * delta,0,0))
			#arrow rotation
		if Input.is_action_pressed("rotate_left"):
			rotate_y(rotation_speed*delta)
		if Input.is_action_pressed("rotate_right"):
			rotate_y(-rotation_speed*delta)
		
		#shoot using space bar
		if Input.is_action_pressed("shoot") and not freeze:
			apply_force(Vector3(0,0,150))
	#check collision
	for body in get_colliding_bodies():
		if body.name == "cue ball":
			freeze = true

#SAVE Function
func _input(event):
	if event.is_action_pressed("save"):
		save_game_state()
		print("Game Saved")

func save_game_state():
	var balls = get_tree().get_nodes_in_group("balls")
	SaveGame.save_balls(balls)
