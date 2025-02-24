class_name SixPlayer
extends Node2D

# Nodes
const self_scene = preload("res://scenes/six_player.tscn")

static func constructor()-> SixPlayer:
	var obj = self_scene.instantiate()
	return obj
