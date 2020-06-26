tool
class_name DialogBox
extends Control

export(Array, String) var text := [] setget _set_text
var page := -1 setget _set_page
export var character_show_time := 0.01

var visible_characters := 0 setget _set_visible_characters


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and visible:
		play_next_page()


func play_next_page() -> void:
	self.page += 1
	self.visible_characters = 0
	if page != -1:
		$Tween.interpolate_property(
			self,
			"visible_character",
			0,
			len(text[page]),
			len(text[page])*character_show_time
		)


func _set_text(val: Array) -> void:
	text = val
	self.page = 0


func _set_page(val: int) -> void:
	if not Engine.is_editor_hint():
		$Tween.stop_all()
	page = (int(max(-1,val))+1)%(len(text)+1)-1
	if page == -1:
		$Text.text = ""
		hide()
	else:
		show()
		self.visible_characters = len(text[page])
		$Text.text = text[page]


func _set_visible_characters(val: int) -> void:
	visible_characters = int(clamp(0, val, len(text[page])))
	$Text.visible_characters = visible_characters
