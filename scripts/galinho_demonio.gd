extends CharacterBody2D

#Detection
var attack_mode = false

#Motion
var speed = 2
var gravity = 20

#Player
@onready var player = get_node("/root/Level1/GaloFrito")

#Combat System
var health = 200
var player_inattack_range = false
var damage_rate = 20
var can_take_damage = true


func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	take_damage()
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if attack_mode:
		var target_position = (player.position.x - position.x)
		velocity.x = target_position * speed
	move_and_slide()

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		attack_mode = true
	
func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		attack_mode = false

func enemy():
	pass

func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_range = true

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_range = false

func take_damage():
	if player_inattack_range == true and global.player_current_attack == true:
		if can_take_damage == true:
			health -= damage_rate
			$TakeDamageCoolDown.start()
			can_take_damage = false
			if health <= 0:
				self.queue_free()
	print("ANJO HEALTH", health)


func _on_take_damage_cool_down_timeout():
	can_take_damage = true
