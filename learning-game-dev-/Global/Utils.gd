extends Node

const SAVE_PATH = "res://savegame.bin" #change res to users for releasing 

func saveGame()->void:
	var file=FileAccess.open(SAVE_PATH,FileAccess.WRITE) 
	var data: Dictionary ={
		"playerHP":Game.playerHP,
		"Gold":Game.Gold,
		"wins":Game.game_completed
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame()->void:
	var file=FileAccess.open(SAVE_PATH,FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP =current_line["playerHP"]
				Game.Gold = current_line["Gold"]
				Game.game_completed = current_line["wins"]
