extends CharacterBody2D

const JUMP_VELOCITY = -250.0
var Health = 100

func _ready() -> void:
	print(Health)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if Health <=0:
		queue_free()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = lerp(velocity.x, 0.0,0.05)

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if $Timer.is_stopped():
		if GameControl.JanitorPosX > global_position.x:
			velocity.x = -250
		else:
			velocity.x = 250
		velocity.y = JUMP_VELOCITY
		
		Health -= 25
		print("AHH HIT")
		print(Health)
		$Timer.start()
		pass # Replace with function body.
