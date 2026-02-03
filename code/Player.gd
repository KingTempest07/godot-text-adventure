extends Node
class_name Player

signal inventory_changed
var inventory: Array = []


var next_chalice_index:= 0
const correct_chalices_order:= ["blue chalice", "green chalice", "red chalice", "black chalice"]
var failed_chalice:= false

var offer_state:= 0


func take_item (item: Item):
	inventory.append(item)
	inventory_changed.emit()
	
func drop_item (item: Item):
	inventory.erase(item)
	inventory_changed.emit()
	
	
func get_inventory_list() -> String:
	var item_string = "You are holding "
	if inventory.size() == 0:
		item_string = "nothing."
	for item in inventory:
		item_string += item.item_name
	return item_string


func die(cause_of_death: String):
	$"../Background/MarginContainer/Columns/Rows/OutputPanel/OutputUI".post_message(Types.wrap_text(cause_of_death, Types.COLOR_DEVIL))
	$"../Background/MarginContainer/Columns/Rows/OutputPanel/OutputUI".post_message("You have died.\nPlease restart the game.")
