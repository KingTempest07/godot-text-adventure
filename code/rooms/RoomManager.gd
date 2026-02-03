extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Entrance.connect_exit_unlocked("north", $Library)
	$Entrance.connect_exit_unlocked("east", $Chalices)
	$Entrance.connect_exit_unlocked("west", $Bodies)
	
	var colors = load_item_resource("colors")
	var the_devil = load_item_resource("the_devil")
	var art_of_battle = load_item_resource("art_of_battle")
	$Library.add_item(colors)
	$Library.add_item(the_devil)
	$Library.add_item(art_of_battle)
	
	var red_chalice = load_item_resource("red_chalice")
	var blue_chalice = load_item_resource("blue_chalice")
	var green_chalice = load_item_resource("green_chalice")
	var black_chalice = load_item_resource("black_chalice")
	var white_chalice = load_item_resource("white_chalice")
	$Chalices.add_item(red_chalice)
	$Chalices.add_item(blue_chalice)
	$Chalices.add_item(green_chalice)
	$Chalices.add_item(black_chalice)
	$Chalices.add_item(white_chalice)
	
	var dagger = load_item_resource("dagger")
	var shield = load_item_resource("shield")
	var crossbow = load_item_resource("crossbow")
	$Bodies.add_item(dagger)
	$Bodies.add_item(shield)
	$Bodies.add_item(crossbow)
	
	#$HouseRoom.connect_exit_unlocked("east", $FrontPorch)
	#
	#var locked_exit = $FrontPorch.connect_exit_locked("north", $ShedRoom)
	#
	#var key = load_item_resource("key")
	#key.use_value = locked_exit	
	#$FrontPorch.add_item(key)
	#
	#var potion = load_item_resource("potion")
	#$ShedRoom.add_item(potion)
#
	#var monster = load_npc_resource("monster")
	#$ShedRoom.add_npc(monster)
	#monster.quest_reward = "mmmm!"
	
func load_item_resource(item_name):
	return load ("res://items/" + item_name + ".tres")
	
func load_npc_resource(npc):
	return load ("res://npc/" + npc + ".tres")
	
