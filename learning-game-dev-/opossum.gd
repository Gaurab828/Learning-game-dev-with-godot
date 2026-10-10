extends CharacterBody2D
var player
var chase=false
var speed=200

func _physics_process(delta:float)->void:
	velocity += get_gravity()*delta
	if chase==true:
		if get_node("AnimatedSprite2D").animation !="death":
			get_node("AnimatedSprite2D").play("run")
		player=get_node("../../player/player")
		var direction = (player.position - self.position).normalized()
		if direction.x>0:
			get_node("AnimatedSprite2D").flip_h=true
		else:
			get_node("AnimatedSprite2D").flip_h=false
			
		velocity.x= direction.x * speed
	else:
		get_node("AnimatedSprite2D").play("run")
		if get_node("AnimatedSprite2D").flip_h==true and position.x>=3550:
			velocity.x=5
			if position.x >= 4050:
				get_node("AnimatedSprite2D").flip_h=false
		if position.x<=4050 and get_node("AnimatedSprite2D").flip_h==false:
			velocity.x=-5
			if position.x<=3550:
				get_node("AnimatedSprite2D").flip_h=true
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "player":
		chase=true
func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name=="player":
		chase=false
		
func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name=="player":
		get_node("AnimatedSprite2D").play("death")
		await get_node("AnimatedSprite2D").animation_finished
		queue_free()


func _on_playercollision_body_entered(body: Node2D) -> void:
	if body.name=="player":
		Game.playerHP-=2
