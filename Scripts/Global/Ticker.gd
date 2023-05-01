extends Node


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Vars.TickerData.TickDelta = delta

	if Vars.TickerData.GameInProgress:
		if Vars.DEBUG == true && Vars.VERBOSE:
			print(Vars.TickerData.Tick)
			print(delta)

		Vars.TickerData.Tick -= delta

		TickProcessor.processUpdate()

		if Vars.TickerData.Tick <= 0:
			TickProcessor.processTick()

			Vars.TickerData.Tick = Vars.TICK_RATE
