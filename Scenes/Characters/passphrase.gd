extends LineEdit



func _on_text_submitted(new_text: String) -> void:
	var tween=create_tween()
	new_text=new_text.to_upper()
	if new_text=="GRAPE":
		print("GO NEXT")
		tween.tween_property($"../../../StaticBody2D","position",Vector2($"../../../StaticBody2D".position.x,-180.0),0.5)
		await tween.finished 
		queue_free()
		
	pass # Replace with function body.
