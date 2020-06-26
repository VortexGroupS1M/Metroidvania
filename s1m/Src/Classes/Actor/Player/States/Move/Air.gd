extends State

var gravity := 0
var is_jumping := false


func physics_process(delta: float) -> void:
	parent.move(gravity, delta)
	if is_jumping and parent.velocity.y > 0:
		is_jumping = false
		gravity = owner.jump_gravity_default
	if owner.is_on_floor():
		if $PreJumpTimer.time_left > 0:
			state_machine.transition_to("Move/Air", {"jump_impulse": owner.jump_impulse})
		else:
			state_machine.transition_to("Move/Ground")


func unhandled_input(event: InputEvent) -> void:
	if is_jumping and event.is_action_released("jump"):
		gravity = owner.jump_gravity_release
	if event.is_action_pressed("jump"):
		if $KyoteTimer.time_left > 0:
			state_machine.transition_to("Move/Air", {"jump_impulse": owner.jump_impulse})
		else:
			$PreJumpTimer.start()


func enter(args: Dictionary) -> void:
	parent.is_snaping = false
	is_jumping = false
	gravity = owner.jump_gravity_default
	$KyoteTimer.start()
	match args:
		{"jump_impulse": var jump_impulse}:
			$KyoteTimer.stop()
			is_jumping = true
			gravity = owner.jump_gravity_start
			parent.velocity.y = -jump_impulse 


func exit() -> void:
	pass
