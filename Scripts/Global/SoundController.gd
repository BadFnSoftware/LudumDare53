extends Node

var BaseSoundPath = "res://Assets/Sounds/"

var ButtonPress1: AudioStream
var ButtonPress2: AudioStream
var Drum: AudioStream
var EnvelopePickup: AudioStream
var EnvelopePutDown: AudioStream
var PackagePickup: AudioStream
var PackagePutDown: AudioStream
var Pluck: AudioStream
var Wah: AudioStream
var XrayBelt: AudioStream
var XrayLoop: AudioStream

var AvailSounds := {}


# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonPress1 = load(BaseSoundPath + "/button_press_01.wav")
	ButtonPress2 = load(BaseSoundPath + "/button_press_02.wav")
	Drum = load(BaseSoundPath + "/drum_sound.wav")
	EnvelopePickup = load(BaseSoundPath + "/letter_pickup.wav")
	EnvelopePutDown = load(BaseSoundPath + "/letter_putdown.wav")
	PackagePickup = load(BaseSoundPath + "/package_pickup.wav")
	PackagePutDown = load(BaseSoundPath + "/package_putdown.wav")
	Pluck = load(BaseSoundPath + "/pluck_sound.wav")
	Wah = load(BaseSoundPath + "/wah.wav")
	XrayBelt = load(BaseSoundPath + "/xray_belt.wav")
	XrayLoop = load(BaseSoundPath + "/xray_loop.wav")
	
	AvailSounds = {
		"buttonpress1": ButtonPress1,
		"buttonpress2": ButtonPress2,
		"drum": Drum,
		"envelopepickup": EnvelopePickup,
		"envelopeputdown": EnvelopePutDown,
		"packagepickup": PackagePickup,
		"packageputdown": PackagePutDown,
		"pluck": Pluck,
		"wah": Wah,
		"xraybelt": XrayBelt,
		"xrayloop": XrayLoop,
	}


func playSound(sound):
	print(sound)
	var Player = AudioStreamPlayer.new()
	print(Player)
	
	Player.stream = AvailSounds[sound]
	Player.play()


func startSoundLoop(sound):
	var SoundPlayer = AudioStreamPlayer.new()

	SoundPlayer.stream = sound
	SoundPlayer.autoplay = true
	SoundPlayer.loop = true

	add_child(SoundPlayer)


func stop_sound_loop():
	var SoundPlayer = get_node("AudioStreamPlayer")

	SoundPlayer.stop()
	SoundPlayer.queue_free()
