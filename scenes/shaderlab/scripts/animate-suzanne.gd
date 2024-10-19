extends CSGMesh3D

const rotation_duration : float = 1.0;
var   elasped_time      : float = 0.0;

var origin      : Vector3 = Vector3.ZERO;
var orientation : Vector3 = Vector3.ZERO;

func _ready() -> void:
	origin      = self.transform.origin;
	orientation = self.rotation;

func _process(delta: float) -> void:
	elasped_time += delta;

	self.transform.origin.x = origin.x - sin(elasped_time) * 0.125;
	self.transform.origin.y = origin.y + sin(elasped_time) * 0.25;

	self.rotation.y = orientation.y + elasped_time * 0.5;
	self.rotation.z = orientation.z + elasped_time * 0.25
