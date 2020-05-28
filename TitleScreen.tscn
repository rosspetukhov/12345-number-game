extends Node2D

onready var anim:AnimationPlayer=$AnimationPlayer
onready var click_sound: AudioStreamPlayer=$Click_sound

var ads_file = "user://ads.save"

func _ready():
	
	var ads = File.new()
	if ads.file_exists(ads_file):
		ads.open(ads_file, File.READ)
		var ads_type
		ads_type = ads.get_var()
		ads.close()
	else:
		get_tree().change_scene("res://ConsentSettings/Regions.tscn")

func _on_Quit_button_button_up():
	click_sound.play()
	anim.play("quick_change")
	yield(anim, "animation_finished")
	get_tree().quit()

func _on_Play_button_button_up():
	click_sound.play()
	anim.play("quick_change")
	yield(anim, "animation_finished")
	get_tree().change_scene("res://Levels/Levels.tscn")

func _on_Settings_button_button_up():
	click_sound.play()
	anim.play("quick_change")
	yield(anim, "animation_finished")
	get_tree().change_scene("res://ConsentSettings/Settings.tscn")
