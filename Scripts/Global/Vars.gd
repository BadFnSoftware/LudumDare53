extends Node

const DEBUG := false
const VERBOSE := false

const TICK_RATE := 1 # In seconds
const PLAY_CLOCK := 1 # In seconds
const TICKS_PER_MINUTE := 60
const SECONDS_WIN_CONDITION := 600
const MINUTES_PER_HOUR := 60
const HOURS_PER_DAY := 24
const DAYS_PER_WEEK := 7
const DAYS_PER_MONTH := 30
const WEEKS_PER_YEAR := 52
const MONTHS_PER_YEAR := 12
const DAYS_PER_YEAR := 365

var Player: Player
var TickerData: Ticks

var XrayWaitTime := 1.25 # In seconds
var XrayWaitTimeRemaining := XrayWaitTime

var ToastWaitTime := 1.5 # In seconds
var ToastWaitTimeRemaining := ToastWaitTime

var NumEnvelopesSortedNode: Node
var NumPackagesSortedNode: Node
var NumSortingMistakesNode: Node
var NumDangerousPackagesSortedNode: Node
var NumDangerousPackageSortingMistakesNode: Node
var NumNotSortedNode: Node
var NumPackagesReportedNode: Node
var NumPackagesReportedMistakesNode: Node
var EndPanel: Node

var EndGameNumEnvelopesSortedNode: Node
var EndGameNumPackagesSortedNode: Node
var EndGameNumSortingMistakesNode: Node
var EndGameNumDangerousPackagesSortedNode: Node
var EndGameNumDangerousPackageSortingMistakesNode: Node
var EndGameNumNotSortedNode: Node
var EndGameNumPackagesReportedNode: Node
var EndGameNumPackagesReportedMistakesNode: Node
var EndGameNumHappyCustomersNode: Node
var EndGameNumContentCustomersNode: Node
var EndGameNumAngryCustomersNode: Node
var EndGameOverallGradeNode: Node
var EndGameYourFiredTextNode: Node
var EndGameOverallGrade: String
var EndGameIsFired := false

var ScanningButton: Node
var ScanningButtonBackground: Node
var ClockMinutesNode: Node
var ClockSecondsNode: Node
var CustomerModelNode: Node

var BestResponseTextNode: Node
var GoodResponseTextNode: Node
var BadResponseTextNode: Node
var WorstResponseTextNode: Node
var CustomerDialogNode: Node

var UpdateJobFuncs: UpdateJobFuncsClass
var TickJobFuncs: TickJobFuncsClass
var MinuteJobFuncs: MinuteJobFuncsClass
var HourlyJobFuncs: HourlyJobFuncsClass
var DailyJobFuncs: DailyJobFuncsClass
var WeeklyJobFuncs: WeeklyJobFuncsClass
var MonthlyJobFuncs: MonthlyJobFuncsClass
var YearlyJobFuncs: YearlyJobFuncsClass

var UpdateJobs := [ "processToastNotifications" ]
var TickJobs := [ "updateDisplayClock" ]
var MinuteTickJobs := [ "updateDisplayClock" ]
var HourlyTickJobs := []
var DailyTickJobs := []
var WeeklyTickJobs := []
var MonthlyTickJobs := []
var YearlyTickJobs := []
