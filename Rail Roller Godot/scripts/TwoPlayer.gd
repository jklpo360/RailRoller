class_name TwoPlayer
extends Node2D

# Nodes
const self_scene = preload("res://scenes/two_player.tscn")

static func constructor()-> TwoPlayer:
	var obj = self_scene.instantiate()
	return obj
