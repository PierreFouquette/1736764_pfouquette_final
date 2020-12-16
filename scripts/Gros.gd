extends KinematicBody2D

var is_entered = null
const speed = 100
var velocity = Vector2()
onready var obj = get_parent().get_node("Joueur")
export (PackedScene) var Projectile
onready var canon = $Canon
onready var canon2 = $Canon2
onready var canon3 = $Canon3

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
		
		var p2 = Projectile.instance()
		p2.creer(canon2.global_position, rotation + 0.5)
		get_parent().add_child(p2)
		
		var p3 = Projectile.instance()
		p3.creer(canon3.global_position, rotation - 0.5)
		get_parent().add_child(p3)
		legal = false
		
func kaboom(collision):
	if collision:
		Global.restant -=1
		queue_free()
		
