extends KinematicBody2D

const speed: int = 300;
const gravityC: int = 10;
const gravAcc: int = 15;
const horizontalLerp: float = .2;
const jumpForce: int = 250;
const jumpFloat: int = 0;
const jumpTime: float = .4;

var kyoteJump: int = 0;
var isJumping: bool = false;
var jump: bool = false;
var vel: Vector2 = Vector2(0,0);
var gravDefier: int = 0;
var dir: Vector2 = Vector2(1,0)

func _physics_process(delta):
	gravDefier = max(0, gravDefier - gravAcc);
	var move: Vector2 = Vector2(0,0);
	if Input.is_action_pressed("move_left"):
		move.x -= 1;
		dir.x = -1
		$Sprite.flip_h = false
	if Input.is_action_pressed("move_right"):
		move.x += 1;
		dir.x = 1
		$Sprite.flip_h = true
	
	if Input.is_action_just_pressed("ui_jump"):
		jump();
    
	if is_on_floor() and jump:
		jump = false;
		vel.y -= jumpForce;
		stopJump();
	
	if isJumping:
		gravDefier = gravityC-1;
		if Input.is_action_just_released("ui_jump"):
			#gravDefier = gravityC + jumpFloat;
			isJumping = false;
	
	vel.y += gravityC - gravDefier;
	vel.x = vel.x + min(50, lerp(vel.x, speed*move.x, horizontalLerp)-vel.x);
	
	vel = move_and_slide(vel, Vector2(0,-1));
	if Input.is_action_pressed("move_up"):
		dir.y = -1
	elif Input.is_action_pressed("move_down"):
		dir.y = 1
	else:
		dir.y = 0
	if Input.is_action_just_pressed("attack"):
		attack()

func jump() -> void:
	jump = true;
	yield(get_tree().create_timer(.1), "timeout");
	jump = false;

func stopJump() -> void:
	isJumping = true;
	yield(get_tree().create_timer(jumpTime), "timeout");
	isJumping = false;

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