extends Node2D

var speed = 400
var screen_size = DisplayServer.window_get_size()

#var score = Screen.score




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var player_size = $PlayerSprite.texture.get_size() * $PlayerSprite.scale
	var border = screen_size - Vector2i(player_size.x, player_size.y)
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1*speed
	if Input.is_action_pressed("move_down"):
		velocity.y += 1*speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1*speed
	if Input.is_action_pressed("move_right"):
		velocity.x += 1*speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	
	position = position.clamp(Vector2.ZERO, border)
	




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("dots"):
		body.queue_free()
		get_parent().update_score(1)
		if get_parent().score % 5 == 0:
			speed *= 1.1
	if body.is_in_group("bad_dots"):
		body.queue_free()
		get_parent().update_health(1)
		
		#print(score)
	
