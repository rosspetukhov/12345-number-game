#the code for three cirles with numbers, that can be rotated

extends Area2D

onready var tween:Tween=$Tween
onready var n0=$Numbers
onready var n1=$Numbers2
onready var n2=$Numbers3
onready var n3=$Numbers4
onready var n4=$Numbers5
onready var n5=$Numbers6
onready var n6=$Numbers7
onready var n7=$Numbers8

var previous_rotation = Vector2()
var is_dragging = false
var status_array=[]
var numbers
var l2d1=462
var l2d2=327
var l1d1=324
var l1d2=229
var l0d1=185
var l0d2=135
var position2=[Vector2(0,-l2d1),Vector2(l2d2, -l2d2),Vector2(l2d1,0),Vector2(l2d2, l2d2),Vector2(0, l2d1),Vector2(-l2d2, l2d2),Vector2(-l2d1, 0), Vector2(-l2d2, -l2d2)]
var position1=[Vector2(0,-l1d1),Vector2(l1d2, -l1d2),Vector2(l1d1,0),Vector2(l1d2, l1d2),Vector2(0, l1d1),Vector2(-l1d2, l1d2),Vector2(-l1d1, 0), Vector2(-l1d2, -l1d2)]
var position0=[Vector2(0,-l0d1),Vector2(l0d2, -l0d2),Vector2(l0d1,0),Vector2(l0d2, l0d2),Vector2(0, l0d1),Vector2(-l0d2, l0d2),Vector2(-l0d1, 0), Vector2(-l0d2, -l0d2)]
var mylayer
var positions
var update_needed=false
var update_needed2=false
var win_condition=false

func print_array():
	for i in range(8):
		numbers[i].position=positions[mylayer][i]
		if status_array[i]==0:
			numbers[i].modulate=Color(1,1,1,0)
		else:
			numbers[i].modulate=Color(1,1,1,1)
			numbers[i].print_value(status_array[i])
	
func _ready():
	numbers=[n0,n1,n2,n3,n4,n5,n6,n7]
	positions=[position0,position1,position2]
	
func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("UI_Touch"):
		get_tree().set_input_as_handled()
		previous_rotation = get_global_mouse_position().angle_to_point(position)
		is_dragging = true
		
func _input(event):
	if not is_dragging:
		return
	if event.is_action_released("UI_Touch"):
		previous_rotation = 0
		is_dragging = false
		var rot
		rot = rotation_degrees - floor(rotation_degrees/360)*360
		var buffer_array=[[],[],[],[],[],[],[],[]]
		var index_array=[0,1,2,3,4,5,6,7,0,1,2,3,4,5,6,7]
		#simplify later
		if rot>=22.5 and rot<67.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+7]]
		elif rot>=67.5 and rot<112.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+6]]
		elif rot>=112.5 and rot<157.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+5]]	
		elif rot>=157.5 and rot<202.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+4]]
		elif rot>=202.5 and rot<247.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+3]]
		elif rot>=247.5 and rot<292.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+2]]
		elif rot>=292.5 and rot<337.5:
			for i in range(8):
				buffer_array[i]=status_array[i]
			for i in range(8):
				status_array[i]=buffer_array[index_array[i+1]]
		rotation_degrees=0
		update_needed=true

	if is_dragging and event is InputEventMouseMotion:
		rotation += get_global_mouse_position().angle_to_point(position) - previous_rotation
		previous_rotation = get_global_mouse_position().angle_to_point(position)
		
func play_tween(row):
	if row!=null:
		for i in range(8):
			if row[i]:
				tween.interpolate_property(numbers[i], "position",positions[mylayer][i], positions[mylayer-1][i], 0.2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)	
				tween.start()
				
func tween_win():
	for i in range(8):
		tween.interpolate_property(numbers[i], "position",positions[0][i], Vector2(0,0), 0.2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)	
		tween.start()
		win_condition=true
		

func _on_Tween_all_completed():
	if not win_condition:
		update_needed=true
