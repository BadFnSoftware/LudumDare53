extends Node

const DEBUG := false
const VERBOSE := false

const TICK_RATE := 1 # In seconds
const TICKS_PER_MINUTE := 60
const SECONDS_WIN_CONDITION := 600
const MINUTES_PER_HOUR := 60
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

var NumEnvelopesSortedNode: Node
var NumPackagesSortedNode: Node
var NumSortingMistakesNode: Node
var NumDangerousPackagesSortedNode: Node
var NumDangerousPackageSortingMistakesNode: Node
var EndPanel: Node

var ClockMinutesNode: Node
var ClockSecondsNode: Node

var UpdateJobFuncs: UpdateJobFuncsClass
var TickJobFuncs: TickJobFuncsClass
var MinuteJobFuncs: MinuteJobFuncsClass
var HourlyJobFuncs: HourlyJobFuncsClass
var DailyJobFuncs: DailyJobFuncsClass
var WeeklyJobFuncs: WeeklyJobFuncsClass
var MonthlyJobFuncs: MonthlyJobFuncsClass
var YearlyJobFuncs: YearlyJobFuncsClass

var UpdateJobs := []
var TickJobs := [ "updateDisplayClock" ]
var MinuteTickJobs := [ "updateDisplayClock" ]
var HourlyTickJobs := []
var DailyTickJobs := []
var WeeklyTickJobs := []
var MonthlyTickJobs := []
var YearlyTickJobs := []
