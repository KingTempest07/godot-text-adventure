extends MarginContainer

class_name OutputUI

const _InputResponse = preload("res://input/InputResponse.tscn")
const Response = preload("res://input/Response.tscn")


var max_scroll_length := 0
@export var max_lines_remembered: int = 30

@onready var history_rows = $Rows/Scroll/HistoryRows
@onready var scroll = $Rows/Scroll
@onready var scroll_bar: VScrollBar = scroll.get_v_scroll_bar()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_bar.changed.connect(_on_scroll_bar_changed)
	max_scroll_length = scroll_bar.max_value

##### API

	
func create_response (input_text, response_text):
	var input_response = _InputResponse.instantiate()
	input_response.set_text(input_text, response_text)

	var response = Response.instantiate()
	response.text = response_text
	
	# if we want to make the the fields onready, we need to add before setting text.
	_add_response_to_game_history(response)


# Display text without echoing user input
func post_message(message_text):
	var response = Response.instantiate()
	response.text = message_text
	_add_response_to_game_history(response)


##### Private functions
func _on_scroll_bar_changed():
	# Only scroll down if new text is added
	if max_scroll_length != scroll_bar.max_value:
		max_scroll_length = scroll_bar.max_value
		scroll.scroll_vertical = max_scroll_length

func _delete_history_beyond_limit():
	if max_lines_remembered != -1 and history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()

	
func _add_response_to_game_history(response: Control):
	history_rows.add_child(response)
	_delete_history_beyond_limit()
