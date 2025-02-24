class_name FivePlayer
extends Node2D

# Nodes
const self_scene = preload("res://scenes/five_player.tscn")

static func constructor()-> FivePlayer:
	var obj = self_scene.instantiate()
	return obj
