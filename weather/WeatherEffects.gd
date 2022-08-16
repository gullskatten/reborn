extends Control

enum WeatherType {
	SUN,
	RAIN,
	FOG,
	RAIN_FOG
}

var current_weather = WeatherType.SUN
var current_iteration := 0
var wanted_iterations := 1
const MAX_ITERATIONS = 5

func _ready():
	InTime.connect("current_cycle_changed", self, "update_weather")
	wanted_iterations = int(rand_range(1, MAX_ITERATIONS))
	update_weather(InTime.current_cycle)

func get_random_weather():
	var next = WeatherType.values()
	next.shuffle()
	return next.pop_front()

func update_weather(cycle):
	if current_iteration < wanted_iterations:
		current_iteration += 1
		return
	
	current_iteration = 0
	wanted_iterations = int(rand_range(1, MAX_ITERATIONS))
	
	current_weather = get_random_weather()
	
	match current_weather:
		WeatherType.SUN:
			$Rain.should_show = false
			$Rain.visible = false
			$Fog.visible = false
		WeatherType.RAIN:
			$Rain.should_show = true
			$Rain.visible = true
		WeatherType.FOG:
			$Rain.should_show = false
			$Rain.visible = false
			$Fog.visible = true
		WeatherType.RAIN_FOG:
			$Rain.should_show = true
			$Rain.visible = true
			$Fog.visible = true
			
	match cycle:
		InTime.CycleState.DAWN:
			pass
		InTime.CycleState.DAY:
			pass
		InTime.CycleState.DUSK:
			pass
		InTime.CycleState.NIGHT:
			pass
	
	print(WeatherType.keys()[current_weather])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
