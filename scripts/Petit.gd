extends KinematicBody2D

var is_entered = null
var speed = 100
var velocity = Vector2()
onready var obj = get_parent().get_node("Joueur")
export (PackedScene) var Projectile
onready var canon = $Canon
var legal = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var collision = move_and_collide(velocity* delta)
	
	if is_entered:
		var dir = (obj.global_position - global_position).normalized()
		rotation = dir.angle()
		velocity = Vector2(speed,0).rotated(rotation)
		velocity = velocity.normalized() * speed
		
		if legal:
			tirer()
			yield(get_tree().create_timer(2.0),"timeout")
			legal = true
			
		
		


func _on_Area2D_body_entered(body):
	if body.name=="Joueur":
		is_entered = true
		
		
func tirer():
		var p = Projectile.instance()
		p.creer(canon.global_position, rotation)
		get_parent().add_child(p)
		legal = false
		
func kaboom(collision):
	if collision:
		Global.restant -=1
		print(Global.restant)
		queue_free()
