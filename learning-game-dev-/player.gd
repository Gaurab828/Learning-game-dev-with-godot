extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var a=1
@onready var anim= get_node("AnimationPlayer")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		a=1
	if Input.is_action_just_pressed("ui_up") and a==1: 
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		a-=1
		
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction == 0:
		pass
	elif direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
	if velocity.y > 0:
		anim.play("fall")
	move_and_slide()

	if Game.playerHP<=0 || position.y>700 || (position.x>1650 && position.x<2250 && position.y> 370 && position.y<425) or (position.x>4200 && position.x<4825 && position.y>450) or (position.x>3725 && position.x<4450 && position.y>200 && position.y<275 or (position.x>3325 && position.x<3475 && position.y>450)):
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
	if position.x>5550:
		queue_free()
		Game.game_completed+=1
		get_tree().change_scene_to_file("res://main.tscn")
	
