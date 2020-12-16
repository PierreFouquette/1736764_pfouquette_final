extends KinematicBody2D

var vitesse = 200
var velocity = Vector2()
export (PackedScene) var Balle
onready var tire = $Tire
onready var audio = $TireJoueur

func _ready():
	
	pass # Replace with function body.
#Lors de la collision la hitbox est désactivé pendant 2 seconde et le joueur est ramené au centre de l'écran
func _physics_process(delta):
	get_input()
	var collision = move_and_collide(velocity*delta)
	
	
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		rotation = dir.angle()
		
	
	

#Déplacement+ tire
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("avance"):
		velocity.x += 1
		velocity = (velocity.normalized()*vitesse).rotated(rotation)
	if Input.is_action_pressed("recule"):
		velocity.x -= 1
		velocity = (velocity.normalized()*vitesse).rotated(rotation)
	if Input.is_action_pressed("droite"):
		velocity.y += 1
		velocity = (velocity.normalized()*vitesse).rotated(rotation)
	if Input.is_action_pressed("gauche"):
		velocity.y -= 1
		velocity = (velocity.normalized()*vitesse).rotated(rotation)
		
	if 	Input.is_action_just_pressed("tire"):
		var b = Balle.instance()
		b.creer(tire.global_position, rotation)
		get_parent().add_child(b)
		audio.play()
		
func faible(collision):
	if collision:
		Global.vie -= 5
		print(Global.vie)
		set_bar()
		if Global.vie <=0:
			Global.goto_scene("res://scenes/Fin.tscn")
		
func fort(collision):
	if collision:
		Global.vie -= 10
		print(Global.vie)
		set_bar()
		if Global.vie <=0:
			Global.goto_scene("res://scenes/Fin.tscn")

func set_bar():
	var restant = Global.vie
	get_node("CanvasLayer/Vie/bar").value = restant
	

