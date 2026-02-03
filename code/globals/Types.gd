extends Node

enum ItemTypes {
	KEY,
	QUEST_ITEM,
	BOOK,
	CHALICE,
	WEAPON
}

const COLOR_NPC = Color("#ff9a94")
const COLOR_ITEM = Color("#94b9ff")
const COLOR_SPEECH = Color("c3ff94")
const COLOR_LOCATION = Color("faff94")
const COLOR_SYSTEM = Color("#ffd394")
const COLOR_INPUT = Color("52ab58ff")
const COLOR_DEVIL = Color("c21012ff")

func wrap_error_text(text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_SYSTEM.to_html(), text]

func wrap_text(text: String, txt_color: Color):
	return "[color=#%s]%s[/color]" % [txt_color.to_html(), text]

func wrap_input_text(text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_INPUT.to_html(), text]
	
func wrap_devil_text(text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_DEVIL.to_html(), text]
