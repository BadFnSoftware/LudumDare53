extends Node

const DEBUG := false
const VERBOSE := false

const TICK_RATE := 2 # In seconds
const TICKS_PER_HOUR := 2
const HOURS_PER_DAY := 24
const DAYS_PER_WEEK := 7
const DAYS_PER_MONTH := 30
const WEEKS_PER_YEAR := 52
const MONTHS_PER_YEAR := 12
const DAYS_PER_YEAR := 365

const AvailableGenderTypes = {
	"MALE": "Male",
	"FEMALE": "Female",
}

enum GenderTypes { MALE, FEMALE }

var Player: PlayerClass
var TickerData: Ticks

var UpdateJobFuncs: UpdateJobClass
var TickJobFuncs: TickJobClass
var HourlyJobFuncs: HourlyJobClass
var DailyJobFuncs: DailyJobClass
var WeeklyJobFuncs: WeeklyJobClass
var MonthlyJobFuncs: MonthlyJobClass
var YearlyJobFuncs: YearlyJobClass

var UpdateJobs := []
var TickJobs := []
var HourlyTickJobs := []
var DailyTickJobs := []
var WeeklyTickJobs := []
var MonthlyTickJobs := []
var YearlyTickJobs := []
