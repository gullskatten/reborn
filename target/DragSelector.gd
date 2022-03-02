extends Node2D


var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
const EMPTY_ARRAY = []
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.
var stylebox = StyleBoxFlat.new()


func _ready():
	stylebox.bg_color = Color(0.3,0.3,0.3,0.3)
	stylebox.border_color = Color.white
	stylebox.set_corner_radius_all(4)
	stylebox.set_border_width_all(1)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		if event.pressed:
			# We only want to start a drag if there's no selection.
			if selected.size() == 0:
				dragging = true
				drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			update()
			var drag_end = get_global_mouse_position()
			select_rect.extents = (drag_end - drag_start) / 2
		
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			
			for item in selected:
				print(item)
			
			selected = EMPTY_ARRAY
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	if dragging:
		draw_style_box(stylebox, Rect2(drag_start, get_global_mouse_position() - drag_start).abs())
