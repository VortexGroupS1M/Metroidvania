#Class for delegating engine functions to `State` nodes 
class_name Statemachine
extends Node


export var _initial_state : NodePath

var state: State


func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	transition_to(_initial_state)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


#Transition to a new `State` at `state_path` and parses `args` if the state is valid
func transition_to(state_path: String, args: Dictionary = {}) -> void:
	if not has_node(state_path) or not get_node(state_path) is State:
		return
	
	if state:
		state.exit()
	state = get_node(state_path)
	#print(state.name)
	state.enter(args)
