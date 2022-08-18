extends Resource
class_name Item

export var id := ""
export var item_name := ""
export var description := ""
export var icon : Texture
export(int, "Common", "Uncommon", "Rare", "Epic", "Legendary") var rarity
export var sellable := false
export var stacksize := 1
