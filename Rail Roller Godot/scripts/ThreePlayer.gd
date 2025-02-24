class_name ThreePlayer
extends Node2D

# Nodes
const self_scene = preload("res://scenes/three_player.tscn")

static func constructor()-> ThreePlayer:
	var obj = self_scene.instantiate()
	return obj
