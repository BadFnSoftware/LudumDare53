extends Node

var TickProcessor: Node


func _ready():
	TickProcessor = preload("res://Scripts/Utilities/TickProcessor.gd").new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Vars.TickerData.GameInProgress:
		Vars.TickerData.Tick -= delta

		TickProcessor.processUpdate()

		if Vars.TickerData.Tick <= 0:
			TickProcessor.processTick()

			Vars.TickerData.Tick = Vars.TickerData.CurrentTickRate
