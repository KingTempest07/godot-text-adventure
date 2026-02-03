extends Control

var max_scroll_length = 0

@onready var command_processor = $CommandProcessor
@onready var output_ui = $Background/MarginContainer/Columns/Rows/OutputPanel/OutputUI
@onready var history_rows = $Background/MarginContainer/Columns/Rows/OutputPanel/OutputUI/Rows/Scroll/HistoryRows

@onready var room_manager = $RoomManager
@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	command_processor.room_changed.connect($Background/MarginContainer/Columns/SidePanel.on_room_changed)
	
	output_ui.post_message ("Welcome to Bork!, a game of introductory development and low cunning. \nType 'help' to see available commands.")
	var first_response = command_processor.initialize(room_manager.get_child(0), player)
	output_ui.post_message  (first_response)


func _on_input_text_submitted(input_text: String) -> void:
	if input_text.is_empty():
		return
	output_ui.post_message(Types.wrap_input_text("> " + input_text))
	var response = command_processor.process_command(input_text)
	output_ui.create_response (input_text, response)
