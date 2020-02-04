extends KinematicBody2D

export(float) var jumpHeight: float = 200
export(float) var gravity: float = 300.0
export(float) var walkSpeed: float = 200

var dir: Vector2 = Vector2(1,0)
var velocity: Vector2 = Vector2()

func _physics_process(delta):
    
#Jump
    if is_on_floor():
        if Input.is_action_pressed("ui_jump"):
            velocity.y = -jumpHeight

#Cancels jump velocity if the player hits the ceilling
    if is_on_ceiling():
        velocity.y = 0.1* gravity

#Gravity and jump control
    if !is_on_floor():
        if Input.is_action_pressed('ui_jump'):
            velocity.y += delta * gravity / 2
        else:
            velocity.y += delta * gravity


#2-way movement
    if Input.is_action_pressed("move_left"):
        velocity.x = -walkSpeed
        dir.x = -1
        $Sprite.flip_h = false
    elif Input.is_action_pressed("move_right"):
        velocity.x =  walkSpeed
        dir.x = 1
        $Sprite.flip_h = true
    else:
        velocity.x = 0
#check looking direcktion
    if Input.is_action_pressed("move_up"):
        dir.y = -1
    elif Input.is_action_pressed("move_down"):
        dir.y = 1
    else:
        dir.y = 0
    move_and_slide(velocity, Vector2(0, -1))

    if Input.is_action_just_pressed("attack"):
        attack()

func attack() -> void:
	var attackCol: Area2D
	if dir.y == 0:
		$Side_Attack.position.x = abs($Side_Attack.position.x)*dir.x
		attackCol = $Side_Attack
	else:
		$Top_Attack.position.y = abs($Top_Attack.position.y)*dir.y
		attackCol = $Top_Attack
	var cols: Array = attackCol.get_overlapping_bodies()
	for collider in cols:
		collider.get_node("Health").damage(200)