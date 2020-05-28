#A template code for any level
extends Node2D

onready var admob = $Admob

var ads_file = "user://ads.save"
var ads_type

func _ready():
	var ads = File.new()
	if ads.file_exists(ads_file):
		ads.open(ads_file, File.READ)
		ads_type = ads.get_var()
		ads.close()
		if ads_type==1:
			admob.is_personalized=true
		elif ads_type==2:
			admob.is_personalized=false
	else:
		get_tree().change_scene("res://ConsentSettings/Consent1.tscn")
	
	admob.load_banner()
	
# warning-ignore:return_value_discarded
	get_tree().connect("screen_resized", self, "_on_resize")

# Admob callbacks
func _on_resize():
	admob.banner_resize()
