extends KinematicBody2D

onready var label:Label=$Label

func print_value(input):
	label.text="%s" %input
