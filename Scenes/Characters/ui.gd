extends Control

var equipped = Color(1.825, 1.825, 1.825, 1.0)
var unequipped = Color(1.0, 1.0, 1.0, 1.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		GameControl.CurrentWeapon = 1
		$Panel2.modulate = equipped
		$Panel.modulate = unequipped
		$Panel3.modulate = unequipped
	if GameControl.Shiv:
		$Panel/D1.show()
		if Input.is_action_just_pressed("2"):
			GameControl.CurrentWeapon = 2
			$Panel.modulate = equipped
			$Panel2.modulate = unequipped
			$Panel3.modulate = unequipped
	if GameControl.BB:
		$Panel3/Bunsen.show()
		if Input.is_action_just_pressed("3"):
			GameControl.CurrentWeapon = 3
			$Panel3.modulate = equipped
			$Panel2.modulate = unequipped
			$Panel.modulate = unequipped
	#else:
	#	$Panel3.modulate = Color(1.0, 1.0, 1.0, 1.0)
