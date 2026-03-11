extends Node2D
var PlayerHere = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and PlayerHere:
		print("In")
		$Control.show()
		
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	PlayerHere = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	$Control.hide()
	PlayerHere = false
