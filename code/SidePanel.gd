extends PanelContainer

@onready var room_name = $MarginContainer/ScrollContainer/Rows/RoomArea/RoomNameLabel
@onready var room_description = $MarginContainer/ScrollContainer/Rows/RoomArea/RoomDescriptionLabel
@onready var exit_label = $MarginContainer/ScrollContainer/Rows/ListArea/ExitLabel


func on_room_changed(new_room:Room):
	
	room_name.text = new_room.room_name
	room_description.text = new_room.room_description
	
	exit_label.text = new_room.get_exit_description()
	
	_update_text()
	
	
func _update_text():
	var text:= ""
	for i in len(%Player.inventory):
		text += %Player.inventory[i].item_name
		if i != len(%Player.inventory) - 1:
			text += ", "
	$MarginContainer/ScrollContainer/Rows/ListArea/InventoryText.text = text
	
	text = ""
	for i in len(%CommandProcessor.current_room.items):
		text += %CommandProcessor.current_room.items[i].item_name
		if i != len(%CommandProcessor.current_room.items) - 1:
			text += ", "
	$MarginContainer/ScrollContainer/Rows/ListArea/ItemsText.text = text


func _ready():
	%Player.inventory_changed.connect(_update_text)


func _process(delta: float) -> void:
	if len(%Player.inventory):
		$MarginContainer/ScrollContainer/Rows/ListArea/InventoryLabel.show()
		$MarginContainer/ScrollContainer/Rows/ListArea/InventoryText.show()
	else:
		$MarginContainer/ScrollContainer/Rows/ListArea/InventoryLabel.hide()
		$MarginContainer/ScrollContainer/Rows/ListArea/InventoryText.hide()
	
	if len(%CommandProcessor.current_room.items):
		$MarginContainer/ScrollContainer/Rows/ListArea/ItemsLabel.show()
		$MarginContainer/ScrollContainer/Rows/ListArea/ItemsText.show()
	else:
		$MarginContainer/ScrollContainer/Rows/ListArea/ItemsLabel.hide()
		$MarginContainer/ScrollContainer/Rows/ListArea/ItemsText.hide()
	
	if len(%CommandProcessor.current_room.npcs):
		$MarginContainer/ScrollContainer/Rows/ListArea/NPCLabel.show()
		$MarginContainer/ScrollContainer/Rows/ListArea/NPCText.show()
	else:
		$MarginContainer/ScrollContainer/Rows/ListArea/NPCLabel.hide()
		$MarginContainer/ScrollContainer/Rows/ListArea/NPCText.hide()
