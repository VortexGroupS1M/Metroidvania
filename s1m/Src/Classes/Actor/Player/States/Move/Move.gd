extends State

const SNAPING_VECTOR := Vector2(0,5)

var velocity := Vector2.ZERO
var acceleraion := Vector2.ZERO
var is_snaping := true

onready var animation_player: AnimationPlayer = owner.get_node("AnimationPlayer")
onready var sprite: Sprite = owner.get_node("Sprite")


func move(new_y_acceleration: int, delta: float) -> void:
	var direction = get_direction()
	if direction == 0:
		animation_player.play("Idle")
	else:
		animation_player.play("Run")
	if velocity.x != 0:
		sprite.flip_h = direction < 0
	velocity = owner.move_and_slide_with_snap(
		velocity + acceleraion*delta/2,
		SNAPING_VECTOR if is_snaping else Vector2.ZERO,
		Vector2.UP
	) - acceleraion*delta/2
	var new_acceleration := Vector2(_get_x_acceleration(delta, direction), new_y_acceleration)
	velocity.y += (acceleraion.y+new_acceleration.y)*delta/2
	velocity.x += new_acceleration.x*delta
	acceleraion = new_acceleration


func unhandled_input(_event: InputEvent) -> void:
	pass


func enter(_args: Dictionary) -> void:
	pass


func exit() -> void:
	pass


func _get_x_acceleration(delta: float, direction: float) -> int:
	var res := 0
	var factor: float = 1 if abs(velocity.x) < owner.MAX_SPEED else .1
	res = factor*min(
		owner.acceleration,
		abs(direction*owner.MAX_SPEED-velocity.x)/delta
	)*sign(direction*owner.MAX_SPEED-velocity.x)
	return res


func get_direction() -> float:
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
