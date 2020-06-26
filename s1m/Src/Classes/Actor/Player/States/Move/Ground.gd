extends State


func physics_process(delta: float) -> void:
	parent.move(owner.jump_gravity_default, delta)
	if not owner.is_on_floor():
		state_machine.transition_to("Move/Air")


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_machine.transition_to("Move/Air", {"jump_impulse": owner.jump_impulse})


func enter(_args: Dictionary) -> void:
	parent.is_snaping = true

