extends Control

var max_scroll_length = 0

@onready var command_processor = $CommandProcessor
@onready var output_ui = $Background/MarginContainer/Columns/Rows/OutputPanel/OutputUI
@onready var history_rows = $Background/MarginContainer/Columns/Rows/OutputPanel/OutputUI/Rows/Scroll/HistoryRows

@onready var room_manager = $RoomManager
@onready var player = $Player


@export_multiline var intro_text: String
@export_multiline var devil_intro_text: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	command_processor.room_changed.connect($Background/MarginContainer/Columns/SidePanel.on_room_changed)
	
	output_ui.post_message ("(type 'help' to see available commands.)\n\n%s\n\n%s" % [intro_text, Types.wrap_devil_text(devil_intro_text)])
	var first_response = command_processor.initialize(room_manager.get_child(0), player)
	output_ui.post_message  (first_response)


func _on_input_text_submitted(input_text: String) -> void:
	if input_text.is_empty():
		return
	output_ui.post_message(Types.wrap_input_text("> " + input_text))
	var response = command_processor.process_command(input_text)
	output_ui.create_response (input_text, response)
	if player.failed_chalice:
		player.die("What an unfortunate fate... to fall to such a simple drinking puzzle? I guess all that is left is to watch your life fade away...")
	elif player.next_chalice_index == 4:
		output_ui.post_message(Types.wrap_devil_text("Very good! You have avoided death... for now. But will you continue to succeed? For you must remember: your life is at stake!\n\nFor your next task, you must find a weapon: there are multiple to be found. You may choose one, then offer it to me for your final judgment!"))
		player.next_chalice_index = 5
	if player.offer_state == 1:
		player.die("That's a shame... I surely thought you would guess right! But oh well, maybe the next one will succeed. As for you? Goodbye.")
	elif player.offer_state == 2:
		player.die("Congratulations! You are the first human that has come this far in my experiments. Unfortunately, you must still die. More was to be prepared before you arrived, but you have come too soon. So in reality, is it really my fault that you die here and now?\n\nWelp. It's time. Just know there was nothing left to do. Goodbye!")
