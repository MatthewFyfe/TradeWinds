extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_DemoButton_pressed():
	get_tree().change_scene("res://Scenes/Demo.tscn")


func _on_LevelButton1_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")


func _on_LevelButton2_pressed():
	get_tree().change_scene("res://Scenes/Level2.tscn")


func _on_LevelButton3_pressed():
	get_tree().change_scene("res://Scenes/Level3.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
