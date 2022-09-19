extends Resource
class_name Quest

export var id := ""
export var quest_name := ""
export var description := ""
export(int, "Common", "Uncommon", "Rare", "Epic", "Legendary") var type
export var rewards := false
export var objective := 1
