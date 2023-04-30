extends Node


func processUpdate():
	processJobs("update")


func processTick():
	if Vars.DEBUG:
		print("Current second: ", Vars.TickerData.CurrentSecond)
		print("Current minute: ", Vars.TickerData.CurrentMinute)
		print("Current hour: ", Vars.TickerData.CurrentHour)
		print("Current day: ", Vars.TickerData.CurrentDay)
		print("Current week: ", Vars.TickerData.CurrentWeek)
		print("Current month: ", Vars.TickerData.CurrentMonth)
		print("Current year: ", Vars.TickerData.CurrentYear)
		print("Total seconds played: ", Vars.TickerData.TotalSecondsPlayed)
		print("Total minutes played: ", Vars.TickerData.TotalMinutesPlayed)
		print("Total hours played: ", Vars.TickerData.TotalHoursPlayed)
		print("Total days played: ", Vars.TickerData.TotalDaysPlayed)
		print("Total weeks played: ", Vars.TickerData.TotalWeeksPlayed)
		print("Total months played: ", Vars.TickerData.TotalMonthsPlayed)
		print("Total years played: ", Vars.TickerData.TotalYearsPlayed)
		print("Current seconds left: ", Vars.TickerData.CurrentSecondsLeft)
		print("Current minutes left: ", Vars.TickerData.CurrentMinutesLeft)
		print("Current tick timer: ", Vars.TickerData.TickTimer)
		print("Current tick: ", Vars.TickerData.Tick)

	Vars.TickerData.TickTimer += 1
	Vars.TickerData.TotalSecondsPlayed += 1
	
	if Vars.TickerData.CurrentSecondsLeft > 0:
		Vars.TickerData.CurrentSecondsLeft -= 1
	elif Vars.TickerData.CurrentSecondsLeft <= 0:
		Vars.TickerData.CurrentSecondsLeft = 59

	processJobs("tick")
	
	if Vars.TickerData.CurrentMinutesLeft <= 0 && Vars.TickerData.CurrentSecondsLeft <= 0 && Vars.TickerData.TotalSecondsPlayed <= Vars.SECONDS_WIN_CONDITION:
		CommonUtils.setEndPanelDisplay()
		Vars.EndPanel.visible = true

	if Vars.TickerData.TickTimer >= Vars.TICKS_PER_MINUTE:
		processMinute()


func processMinute():
	Vars.TickerData.TickTimer = 0
	Vars.TickerData.MinuteTickTimer += 1
	Vars.TickerData.CurrentMinute += 1
	Vars.TickerData.TotalMinutesPlayed += 1
	Vars.TickerData.CurrentMinutesLeft -= 1

	processJobs("minute")
	
	if Vars.TickerData.CurrentMinutesLeft <= 0 && Vars.TickerData.CurrentSecondsLeft <= 0 && Vars.TickerData.TotalSecondsPlayed <= Vars.SECONDS_WIN_CONDITION:
		CommonUtils.setEndPanelDisplay()
		Vars.EndPanel.visible = true

	if Vars.TickerData.MinuteTickTimer == Vars.MINUTES_PER_HOUR:
		processHour()


func processHour():
	Vars.TickerData.HourTickTimer += 1
	Vars.TickerData.CurrentHour += 1
	Vars.TickerData.TotalHoursPlayed += 1

	processJobs("hourly")

	if Vars.TickerData.HourTickTimer == Vars.HOURS_PER_DAY:
		processDay()


func processDay():
	Vars.TickerData.HourTickTimer = 0
	Vars.TickerData.CurrentHour = 0
	Vars.TickerData.CurrentDay += 1
	Vars.TickerData.TotalDaysPlayed += 1
	Vars.TickerData.DayTickTimer += 1
	Vars.TickerData.WeekTickTimer += 1

	processJobs("daily")

	if Vars.TickerData.WeekTickTimer == Vars.DAYS_PER_WEEK:
		processWeek()

	if Vars.TickerData.DayTickTimer == Vars.DAYS_PER_MONTH:
		processMonth()


func processWeek():
	Vars.TickerData.WeekTickTimer = 0
	Vars.TickerData.WeekPayTickTimer += 1
	Vars.TickerData.CurrentWeek += 1
	Vars.TickerData.TotalWeeksPlayed += 1

	processJobs("weekly")

	if Vars.TickerData.WeekPayTickTimer == 2:
		Vars.TickerData.WeekPayTickTimer = 0


func processMonth():
	Vars.TickerData.DayTickTimer = 0
	Vars.TickerData.MonthTickTimer += 1
	Vars.TickerData.CurrentDay = 1
	Vars.TickerData.CurrentMonth += 1
	Vars.TickerData.TotalMonthsPlayed += 1

	processJobs("monthly")

	if Vars.TickerData.MonthTickTimer == Vars.MONTHS_PER_YEAR:
		processYear()


func processYear():
	Vars.TickerData.MonthTickTimer = 0
	Vars.TickerData.CurrentMonth = 1
	Vars.TickerData.CurrentYear += 1
	Vars.TickerData.TotalYearsPlayed += 1

	processJobs("yearly")


func processJobs(jobType):
	var jobClass
	var jobFuncs = []

	match jobType:
		"update":
			if Vars.DEBUG && Vars.VERBOSE:
				print("Processing update jobs")

			jobClass = Vars.UpdateJobFuncs
			jobFuncs = Vars.UpdateJobs
		"tick":
			if Vars.DEBUG:
				print("Processing tick jobs")

			jobClass = Vars.TickJobFuncs
			jobFuncs = Vars.TickJobs
		"minute":
			if Vars.DEBUG:
				print("Processing minute jobs")

			jobClass = Vars.MinuteJobFuncs
			jobFuncs = Vars.HourlyTickJobs
		"hourly":
			if Vars.DEBUG:
				print("Processing hourly jobs")

			jobClass = Vars.HourlyJobFuncs
			jobFuncs = Vars.HourlyTickJobs
		"daily":
			if Vars.DEBUG:
				print("Processing daily jobs")

			jobClass = Vars.DailyJobFuncs
			jobFuncs = Vars.DailyTickJobs
		"weekly":
			if Vars.DEBUG:
				print("Processing weekly jobs")

			jobClass = Vars.WeeklyJobFuncs
			jobFuncs = Vars.WeeklyTickJobs
		"monthly":
			if Vars.DEBUG:
				print("Processing monthly jobs")

			jobClass = Vars.MonthlyJobFuncs
			jobFuncs = Vars.MonthlyTickJobs
		"yearly":
			if Vars.DEBUG:
				print("Processing yearly jobs")

			jobClass = Vars.YearlyJobFuncs
			jobFuncs = Vars.YearlyTickJobs

	if !jobFuncs.is_empty():
		for i in jobFuncs.size():
			Callable(jobClass, jobFuncs[i]).call()
