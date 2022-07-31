extends Node

var item_data: Dictionary

func _ready():
	item_data = loadData("res://data/item_db.json")

func get_item(id) -> Item:
	return item_data[id]

func loadData(file_path):
	var json_data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_data = JSON.parse(file_data.get_as_text())
	file_data.close()
	
	var items = {}

	for key in json_data.result.keys():
		var item = Item.new()
		
		for attr in json_data.result[key]:
			item[attr] = json_data.result[key][attr]
			items[item.id] = item
			
	return items
