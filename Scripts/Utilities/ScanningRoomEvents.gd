extends Node2D

const AnimationDuration := 5.0

var Package: Node
var PackageStartingPosition: Vector2
var ScannerDestination: Node
var EndScreenDestination= Node
var PackageDestination: Vector2
var ElapsedTime := 0.0
var XrayElapsedTime := 0.0
var XrayWaitTime := 5.0

var PackageReachedFirstDestination := false
var HasScanned := false
var PackageReachedFinalDestination := false


# Called when the node enters the scene tree for the first time.
func _ready():
	Package = get_node("%Package")
	ScannerDestination = get_node("%ScannerDestination")
	EndScreenDestination = get_node("%EndScreenDestination")

	PackageStartingPosition = Package.get_position()
	PackageDestination = Vector2(ScannerDestination.get_position().x, PackageStartingPosition.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ElapsedTime += delta
	
	if Package.get_position().x > PackageDestination.x:
		Package.position = PackageStartingPosition.lerp(PackageDestination, ElapsedTime)
	else:
		if PackageReachedFirstDestination == false:
			PackageReachedFirstDestination = true
		
		if HasScanned == true && PackageReachedFinalDestination == false:
			PackageReachedFinalDestination = true
			get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")

		if XrayWaitTime > 0 && XrayWaitTime <= 5 && HasScanned == false:
			XrayWaitTime -= delta
		elif XrayWaitTime <= 0 && HasScanned == false:
			ElapsedTime = 0.0
			HasScanned = true
			PackageStartingPosition = Package.get_position()
			PackageDestination = Vector2(EndScreenDestination.get_position().x, PackageStartingPosition.y)
