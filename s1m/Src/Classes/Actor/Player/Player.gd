extends Actor

const JUMP_MAX_HEIGHT := 160
const JUMP_MAX_LENGTH := 250
const JUMP_LENGTH_TO_MAX_HEIGHT := 140
const JUMP_MIN_HEIGHT := 80
const MAX_SPEED := 250
const ACCELERATION_TIME := 0.05


var jump_impulse: int
var jump_gravity_start: int
var jump_gravity_release: int
var jump_gravity_default: int
var acceleration: int


func _init() -> void:
	#Calculate the jump impulse and gravities based on the constants
	jump_gravity_start = 2*int((JUMP_MAX_HEIGHT*pow(MAX_SPEED,2))/pow(JUMP_LENGTH_TO_MAX_HEIGHT,2))
	jump_impulse = int(JUMP_LENGTH_TO_MAX_HEIGHT*jump_gravity_start/float(MAX_SPEED))
	jump_gravity_release = 2*int(pow(jump_impulse,2)/(2*JUMP_MIN_HEIGHT))
	jump_gravity_default = 2*int(JUMP_MAX_HEIGHT*pow(MAX_SPEED,2)/pow(JUMP_MAX_LENGTH-JUMP_LENGTH_TO_MAX_HEIGHT,2))
	acceleration = int(MAX_SPEED/ACCELERATION_TIME)
	var jump_min_length := int(
		pow(jump_impulse,2)/(jump_gravity_release) +
		MAX_SPEED*sqrt(JUMP_MAX_HEIGHT*2/float(jump_gravity_release))
		)
	print("The minimum jump length is ", jump_min_length)
