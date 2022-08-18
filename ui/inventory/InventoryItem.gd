extends Node2D

var item
var item_quantity

func _ready():
	$TextureRect.rect_rotation = rand_range(0, 20)
	_update_icon()

func set_item(new_item, qt):
	item = new_item
	item_quantity = qt
	_update_icon()
	
func _update_icon():
	if item && item.icon:
		$TextureRect.texture = item.icon
		var stack_size = int(item.stacksize)
		$Label.visible = stack_size > 1
		$Label.text = String(item_quantity)
	
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
