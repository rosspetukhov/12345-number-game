#Main item to control the 3 circles - layer 0, 1 and 2

extends Area2D

onready var layer0: Area2D=$Layer0
onready var layer1: Area2D=$Layer1
onready var layer2: Area2D=$Layer2
onready var win_sound: AudioStreamPlayer=$Win_sound
onready var click_sound: AudioStreamPlayer=$Click_sound
onready var target_label:Label=$Target
onready var lvl_label:Label=$Lvl
onready var anim:AnimationPlayer=$AnimationPlayer
export var next_scene: PackedScene

export var level=0
var last_save_data
export var win_value=0

var save_file = "user://file.save"

export var game_array=[[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]

func _ready():
	layer0.mylayer=0
	layer1.mylayer=1
	layer2.mylayer=2
	print_results()
	var lvl_label_text:String="Lvl "+str(level)
	lvl_label.text="%s" %lvl_label_text
	target_label.text="%s" %score_keeping()

	var f = File.new()
	f.open(save_file, File.READ)
	last_save_data = f.get_var()
	f.close()
	
func print_results():
	layer0.status_array=game_array[0]
	layer1.status_array=game_array[1]
	layer2.status_array=game_array[2]
	layer0.print_array()
	layer1.print_array()
	layer2.print_array()
	
func _physics_process(_delta):
	if layer0.update_needed or layer1.update_needed or layer2.update_needed:
		click_sound.play()
		layer0.update_needed=false
		layer1.update_needed=false 
		layer2.update_needed=false
		print_results()
		check_win()
		target_label.text="%s" %score_keeping()
		
func score_keeping():
	var current_score:String
	var layer0_score=0
	for i in range(8):
		layer0_score+=game_array[0][i]
	current_score=str(layer0_score)+"/"+str(win_value)
	return current_score
		
func check_win():
	var layer0_sum=0
	for i in range(8):
		layer0_sum+=game_array[0][i]
	if  layer0_sum==win_value:
		save_game(level)
		layer0.tween_win()
		load_next_scene()
		win_sound.play()
	check_results()
		
func check_results():
	var rows_affected_l2=[false,false,false,false,false,false,false,false,]
	var rows_affected_l1=[false,false,false,false,false,false,false,false,]
	for i in range(8):
		if game_array[1][i]!=0 and game_array[2][i]!=0:
			game_array[1][i]=game_array[1][i]+game_array[2][i]
			game_array[2][i]=0
			rows_affected_l2[i]=true
	
		if game_array[1][i]!=0 and game_array[0][i]!=0:
			game_array[0][i]=game_array[0][i]+game_array[1][i]
			game_array[1][i]=0
			rows_affected_l1[i]=true
	layer0.status_array=game_array[0]
	layer1.status_array=game_array[1]
	layer2.status_array=game_array[2]
	layer2.play_tween(rows_affected_l2)
	layer1.play_tween(rows_affected_l1)

func save_game(input):
	if last_save_data<=input:
		var f = File.new()
		f.open(save_file, File.WRITE)
		f.store_var(input+1)
		f.close()
	
func load_next_scene()->void:
	anim.play("change_scene")
	yield(anim, "animation_finished")
	get_tree().change_scene_to(next_scene)

func _on_Restart_button_up():
	click_sound.play()
	anim.play("quick_change")
	yield(anim, "animation_finished")
	get_tree().reload_current_scene()

func _on_Menu_button_up():
	click_sound.play()
	anim.play("quick_change")
	yield(anim, "animation_finished")
	get_tree().change_scene("res://SourceCode/TitleScreen.tscn")
