class_name MoonLight
extends Light2D

## The color of the night state.
export (Color) var color_night = Color(1.0, 1.0, 1.0, 1.0)
## The energy value of the night state.
##
## The larger the value, the stronger the light.
export (float) var energy_night = 1.0
## The color of the dawn state.
export (Color) var color_dawn = Color(1.0, 1.0, 1.0, 1.0)
## The energy value of the dawn state.
##
## The larger the value, the stronger the light.
export (float) var energy_dawn = 0.0
## The color of the day state.
export (Color) var color_day = Color(1.0, 1.0, 1.0, 1.0)
## The energy value of the day state.
##
## The larger the value, the stronger the light.
export (float) var energy_day = 0.0
## The color of the dusk state.
export (Color) var color_dusk = Color(1.0, 1.0, 1.0, 1.0)
## The energy value of the dusk state.
##
## The larger the value, the stronger the light.
export (float) var energy_dusk = 0.0
## Enables the `MoonLight` node movement.
export (bool) var move_moon = false
## The `DayNightCycle` node which the moon will sync with.
##
## The `MoonLight` node will only show if there is a `DayNightCycle` node assigned to it.
export (NodePath) var cycle_sync_node_path
## Disables the `MoonLight` node movement.
export (bool) var static_moon = true
## If `true`, the position of the `MoonLight` node is determined by @link_name {hour_position}.
##
## If `false`, the position of the `MoonLight` node is determined by its position.
##
## It only works when @link_name {static_moon} is enabled.
export (bool) var use_hour_position = false
## The hour of the day, in a 24-hour clock, to position the `MoonLight` node (0-23).
export (int, 0, 23) var hour_position = 0

var window_x: float = ProjectSettings.get_setting("display/window/size/width")
var window_y: float = ProjectSettings.get_setting("display/window/size/height")

var window_center := Vector2(window_x / 2, window_y / 2)
var radius_x: float = window_x / 2.10
var radius_y: float = window_y / 2.15

## The moon light path is a `Curve2D`.
##
## The default path is like the one in the following image.
## @link_img {../../../example_images/moon_light_path.png}
##
## A new path can be set by changing the `Curve2D`.
var path := Curve2D.new()

var speed: float
var hour_step: float
var moon_position: float

var cycle_sync_node: Node
var delay: float = 0.0

onready var color_transition_tween = $ColorTransitionTween
onready var energy_transition_tween = $EnergyTransitionTween


func _ready():
	if static_moon and move_moon or not static_moon and not move_moon:
		printerr("--------------------")
		printerr("ERROR!")
		printerr("File: '%s.gd'." % self.name)
		printerr(
			(
				"Message: The 'static_moon' and 'move_moon' variables can't"
				+ " both be set to 'true' or 'false' at the same time."
			)
		)
		printerr("--------------------")

		# Reset the path so in case there is a 'DebugOverlay' node,
		# there won't be any options for the 'MoonLight' node.
		cycle_sync_node_path = ""

		return

	# Connect signals.
	var current_hour_changed_signal = InTime.connect(
		"current_hour_changed", self, "_on_current_hour_changed"
	)

	var current_cycle_changed_signal = InTime.connect(
		"current_cycle_changed", self, "_on_current_cycle_changed"
	)

	var time_manually_changed_signal = InTime.connect(
		"time_manually_changed", self, "_on_time_manually_changed"
	)

	var time_freezed_signal = InTime.connect("time_freezed", self, "_on_time_freezed")

	# Check if signals are connected correctly.
	if current_hour_changed_signal != OK:
		printerr(current_hour_changed_signal)

	if current_cycle_changed_signal != OK:
		printerr(current_cycle_changed_signal)

	if time_manually_changed_signal != OK:
		printerr(time_manually_changed_signal)

	if time_freezed_signal != OK:
		printerr(time_freezed_signal)

	# Create the path.
	path.add_point(window_center + Vector2(0, -radius_y), Vector2(-radius_x, 0))
	path.add_point(window_center + Vector2(radius_x, 0), Vector2(0, -radius_y))
	path.add_point(window_center + Vector2(0, radius_y), Vector2(radius_x, 0))
	path.add_point(window_center + Vector2(-radius_x, 0), Vector2(0, radius_y))
	path.add_point(window_center + Vector2(0, -radius_y), Vector2(-radius_x, 0))

	# Sync the speed with in-game time.
	speed = (
		path.get_baked_points().size()
		/ (float(InTime.SECONDS_IN_A_DAY) / InTime.IN_GAME_SECONDS_PER_REAL_TIME_SECONDS)
	)

	# Divide the path into hours.
	hour_step = path.get_baked_points().size() / float(InTime.HOURS_IN_A_DAY)

	if move_moon:
		if cycle_sync_node_path:
			cycle_sync_node = get_node(cycle_sync_node_path)

			# Sync the delay with the cycle.
			delay = cycle_sync_node.delay

			# Make it visible in case it's hidden in the editor.
			visible = true

			moon_position = hour_step * InTime.get_current_hour()
			position = path.get_baked_points()[moon_position]
		else:
			printerr("--------------------")
			printerr("ERROR!")
			printerr("File: '%s.gd'." % self.name)
			printerr(
				(
					"Message: The '"
					+ str(self.name)
					+ "' node isn't"
					+ " sync with any 'DayNightCycle' node."
					+ " Use the 'cycle_sync_node_path' variable in the '"
					+ str(self.name)
					+ "' node to sync it with a 'DayNightCycle' node."
				)
			)
			printerr("--------------------")

			visible = false

			return
	elif static_moon:
		set_physics_process(false)

		# Make it visible in case it's hidden in the editor.
		visible = true

		if use_hour_position:
			moon_position = hour_step * hour_position
			position = path.get_baked_points()[moon_position]

	# Set the current cycle state.
	match InTime.current_cycle:
		InTime.CycleState.NIGHT:
			color = color_night
			energy = energy_night
		InTime.CycleState.DAWN:
			color = color_dawn
			energy = energy_dawn
		InTime.CycleState.DAY:
			color = color_day
			energy = energy_day
		InTime.CycleState.DUSK:
			color = color_dusk
			energy = energy_dusk


func _physics_process(delta):
	_move_moon(delta)


# PRIVATE FUNCTIONS
# -----------------
func _move_moon(delta):
	if moon_position + (delta * speed) >= path.get_baked_points().size():
		moon_position += (delta * speed) - path.get_baked_points().size()
	else:
		position = path.get_baked_points()[moon_position]
		moon_position += delta * speed


# CALLBACKS
# ---------
func _on_current_cycle_changed(_c):
	match InTime.current_cycle:
		InTime.CycleState.NIGHT:
			if not InTime.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

				color_transition_tween.interpolate_property(
					self,
					"color",
					color_dusk,
					color_night,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_dusk,
					energy_night,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_night
				energy = energy_night
		InTime.CycleState.DAWN:
			if not InTime.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

				color_transition_tween.interpolate_property(
					self,
					"color",
					color_night,
					color_dawn,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_night,
					energy_dawn,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_dawn
				energy = energy_dawn
		InTime.CycleState.DAY:
			if not InTime.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

				color_transition_tween.interpolate_property(
					self,
					"color",
					color_dawn,
					color_day,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_dawn,
					energy_day,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_day
				energy = energy_day
		InTime.CycleState.DUSK:
			if not InTime.changing_time_manually:
				if delay > 0:
					yield(get_tree().create_timer(delay), "timeout")

				color_transition_tween.interpolate_property(
					self,
					"color",
					color_day,
					color_dusk,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				color_transition_tween.start()

				energy_transition_tween.interpolate_property(
					self,
					"energy",
					energy_day,
					energy_dusk,
					InTime.state_transition_duration,
					Tween.TRANS_SINE,
					Tween.EASE_OUT
				)
				energy_transition_tween.start()
			else:
				color_transition_tween.stop_all()
				energy_transition_tween.stop_all()

				color = color_dusk
				energy = energy_dusk


func _on_current_hour_changed():
	if InTime.changing_time_manually and move_moon:
		moon_position = hour_step * InTime.get_current_hour()
		position = path.get_baked_points()[moon_position]


func _on_time_manually_changed():
	if not InTime.freeze_time and move_moon:
		set_physics_process(not InTime.changing_time_manually)


func _on_time_freezed():
	if move_moon:
		set_physics_process(not InTime.freeze_time)
