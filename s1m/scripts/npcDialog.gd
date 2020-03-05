extends RichTextLabel

onready var Player = get_parent().get_parent().get_node("Player")
onready var Dummy = get_parent().get_parent().get_node("Dummy")


var dialog: Array = ["This is text.", "This is page 2 :D", "Goodbye!"]
var page: int = 0


func _ready() -> void:
	get_parent().hide()
	


func showDialog() -> void:
	page = 0
	get_parent().show()
	set_bbcode(dialog[page])
	set_visible_characters(0)


func hideDialog() -> void:
	get_parent().hide()

func _input(event) -> void:
	if Input.is_mouse_button_pressed(2):
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())
	


func _on_Timer_timeout() -> void:
	set_visible_characters(get_visible_characters()+1)


