extends Node

signal response_generated (response_text)
signal room_changed (new_room)

var current_room = null
var player = null

func initialize(starting_room, player_character) -> String:
	self.player = player_character
	return change_room(starting_room)
	

func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "I don't think you typed anything."
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = input.lstrip(words[0]).lstrip(" ").to_lower()
	match first_word:
		"go": 
			return go(second_word)
		"take":
			return take(second_word)
		"inventory":
			return inventory()
		"read":
			return read(second_word)
		"drink":
			return drink(second_word)
		"offer":
			return offer (second_word)
		"help":
			return help()
		"quit":
			get_tree().quit()
			return ("Quitting")
		_: 
			return Types.wrap_error_text("I did not understand %s" %first_word)
		
func take(item_name: String) -> String:
	if item_name == "":
		return Types.wrap_text("What did you want to take?", Types.COLOR_SYSTEM)
		
	for item in current_room.items:
		if item_name.to_lower() == item.item_name.to_lower():
			player.take_item(item)
			current_room.remove_item(item)
			if item is BookItem:
				return "You take the book \"%s\"." % item.item_name
			if item.item_type == Types.ItemTypes.WEAPON:
				for item1 in current_room.items:
					current_room.remove_item(item1)
				return "You take the %s. Mysteriously, all the other weapons in the room disappeared. Did you make the right choice?" % item_name
			return "You take the " + item_name + "."
			
	return "There is no " + item_name + " here."


func drop(item_name: String) -> String:
	if item_name == "":
		return "What did you want to drop?"
		
	for item in player.inventory:
		if item_name.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			return "You drop the " + item_name + "."
			
	return "You have no " + item_name + "."
		
		
func inventory() -> String:
	return player.get_inventory_list()
			
func go (direction: String) -> String:
	if direction == "":
		return "Where did you want to go?"
		
	if current_room.exits.keys().has(direction):
		var exit = current_room.exits[direction]
		if exit.is_locked:
			return "It's locked."
			
		var response_text = "\n".join(["You go %s" % direction, change_room(exit.get_destination_room(current_room))])
		return response_text
	else:
		return "You cannot go that way."
	
func read(item_name: String) -> String:
	if item_name == "":
		return "What book did you want to read?"
	
	for item in player.inventory:
		if item_name.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.ItemTypes.BOOK:
					return "You read \"%s\":\n\n%s" % [item.item_name, Types.wrap_text((item as BookItem).book_text, Types.COLOR_SPEECH)]
				_: 
					return "Invalid item type " + item.item_type
	return "You do not have a book named \"" + item_name +"\"."
	
func drink(item_name: String) -> String:
	if item_name == "":
		return "What did you want to drink?"
	
	for item in player.inventory:
		if item_name.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.ItemTypes.CHALICE:
					player.drop_item(item)
					player.failed_chalice = Player.correct_chalices_order[player.next_chalice_index] != item.item_name
					player.next_chalice_index += 1
					return "You drank the %s." % item.item_name
				_: 
					return "Invalid item type " + item.item_type
	return "You do not have the " + item_name +"."
	
	
func offer(item_name: String) -> String:
	if item_name == "":
		return "What did you want to offer?"
	
	for item in player.inventory:
		if item_name.to_lower() == item.item_name.to_lower():
			if item.item_name == "white chalice":
				player.offer_state = 2
			elif item.item_type != Types.ItemTypes.WEAPON:
				return "You must offer a valid weapon."
			else:
				player.offer_state = 1
			return "You offer the %s to the devil." % item_name
	
	return  "You do not have the " + item_name +"."
	
	
func help() -> String:
	return "Commands are one or two words. Available commands are: \n   go [location], \n   take [item],"  \
		+ "\n   read [item],\n   drink [item],\n   offer [item],\n   inventory,\n   help"
	
func change_room(new_room: Room) -> String:
	current_room = new_room
	room_changed.emit (new_room)
	return new_room.get_full_description()
