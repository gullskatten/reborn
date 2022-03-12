extends WorkerState

var nearestTargetVector = Vector2.ZERO
var con = null

func enter(_msg := {}) -> void:
	print("Seeking next target..")
	worker.seekTimer.start(10.0)
	worker.velocity = Vector2.ZERO
	if not worker.resourceDetectionZone.is_connected("body_entered", self, "add_target"):
		con = worker.resourceDetectionZone.connect("body_entered", self, "add_target")
		worker.resourceDetectionZone.monitoring = true
		worker.resourceDetectionZone.monitorable = true
		
func add_target(body):
	if nearestTargetVector == Vector2.ZERO:
		nearestTargetVector = body.global_position
	else:
		nearestTargetVector = body.global_position if worker.global_position.distance_to(nearestTargetVector) > worker.global_position.distance_to(body.global_position) else nearestTargetVector
			
func update(delta: float) -> void:
	if nearestTargetVector != Vector2.ZERO:
		if !worker.seekTimer.is_stopped():
			worker.seekTimer.stop()
		
		if worker.resourceDetectionZone.is_connected("body_entered", self, "add_target"):
			worker.resourceDetectionZone.disconnect("body_entered", self, "add_target")
			worker.resourceDetectionZone.monitoring = false
			worker.resourceDetectionZone.monitorable = false
			con = null
			
		worker.accelerate_to_point(nearestTargetVector, delta)
	
		if worker.global_position.distance_to(nearestTargetVector) <= 4:
			nearestTargetVector = Vector2.ZERO
			print("Attempting to seek again!")
			state_machine.transition_to("Seek")
			# TODO: Could change to state "ActiveSeek" 
			# (a state where the worker is actively moving around and seeking for hits.
