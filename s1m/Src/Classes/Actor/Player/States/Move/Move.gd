extends State

const SNAPING_VECTOR := Vector2(0,5)

var velocity := Vector2.ZERO
var acceleraion := Vector2.ZERO
var is_snaping := true


func move(new_y_acceleration: int, delta: float) -> void:
	KinematicBody2D
	velocity = owner.move_and_slide_with_snap(
		velocity + acceleraion*delta/2,
		SNAPING_VECTOR if is_snaping else Vector2.ZERO,
		Vector2.UP
	) - acceleraion*delta/2
	var new_acceleration := Vector2(_get_x_acceleration(delta), new_y_acceleration)
	velocity.y += (acceleraion.y+new_acceleration.y)*delta/2
	velocity.x += new_acceleration.x*delta
	acceleraion = new_acceleration


func unhandled_input(_event: InputEvent) -> void:
	pass


func enter(_args: Dictionary) -> void:
	pass


func exit() -> void:
	pass


func _get_x_acceleration(delta: float) -> int:
	var res := 0
	var dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var factor: float = 1 if abs(velocity.x) < owner.MAX_SPEED else .1
	res = factor*min(
		owner.acceleration,
		abs(dir*owner.MAX_SPEED-velocity.x)/delta
	)*sign(dir*owner.MAX_SPEED-velocity.x)
	return res
