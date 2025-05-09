extends Node2D


var dragging = false  # Are we currently dragging?
var pressed = false
var selected = []  # Array of selected units.
var targets = []

const EMPTY_ARRAY = []
var drag_start = Vector2.ZERO  # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.
var stylebox = StyleBoxFlat.new()

func _ready():
	set_process_input(true)
	stylebox.bg_color = Color(0.3,0.3,0.3,0.3)
	stylebox.border_color = Color.white
	stylebox.set_corner_radius_all(4)
	stylebox.set_border_width_all(1)
	
func _input(event):
	if event.get_action_strength("ui_cancel") == 1:
		CurrentTarget.cancel_targets()
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.doubleclick:
		CurrentTarget.cancel_targets()
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		if event.pressed:
			# We only want to start a drag if there's no selection.
			if CurrentTarget.target != null:
				move_target_to_position(CurrentTarget.target)
				var resource_clicked = find_first_resource_clicked()
				if resource_clicked != null:
					assign_resource(CurrentTarget.target, resource_clicked.resourceType)
			if !CurrentTarget.targets.empty():
				var resource_clicked = find_first_resource_clicked()
				for target in CurrentTarget.targets:
					move_target_to_position(target)
					if resource_clicked != null:
						assign_resource(target, resource_clicked.resourceType)
			elif selected == EMPTY_ARRAY:
				dragging = true
				drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			update()
			var drag_end = get_global_mouse_position()
			select_rect.extents = (drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.collide_with_areas = false
			query.collide_with_bodies = true
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			
			if selected != EMPTY_ARRAY:
				for item in selected:
					if item is Dictionary:
						var colliding = item.get("collider")
						if colliding.is_in_group("selectable"):
							var target: TargetInfo = colliding.get_node("TargetButton/TargetInfo")
							if(target != null):
								if colliding.has_method("set_selected"):
									colliding.set_selected(true)
								targets.push_front(target)

				if targets != EMPTY_ARRAY:
					CurrentTarget.set_multi_target(targets)
				
				targets.clear()
				selected.clear()
			
	if event is InputEventMouseMotion and dragging:
		update()

func find_first_resource_clicked() -> CollectableResource:
	var space = get_world_2d().direct_space_state
	var bodies_at_click = space.intersect_point(get_global_mouse_position(), 1, [], 0x00000100, true, false)
	if not bodies_at_click.empty():
		var colliding = bodies_at_click[0].get("collider")
		if colliding.get_parent() is CollectableResource:
			return colliding.get_parent()
	
	return null
	
func move_target_to_position(target):
	if target.ref_node && target.ref_node.has_method("set_target_position"):
		target.ref_node.set_target_position(get_global_mouse_position())

func assign_resource(target: TargetInfo, resourceType: String):
	if target.ref_node && target.ref_node.has_method("set_assigned_resource_type"):
		target.ref_node.set_assigned_resource_type(resourceType)

func _draw():
	if dragging:
		draw_style_box(stylebox, Rect2(drag_start, get_global_mouse_position() - drag_start).abs())
