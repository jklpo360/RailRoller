class_name FourPlayer
extends Node2D

# Nodes
const self_scene = preload("res://scenes/four_player.tscn")

static func constructor()-> FourPlayer:
	var obj = self_scene.instantiate()
	return obj
