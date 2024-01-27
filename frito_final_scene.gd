extends Node2D

@onready var man_animation = $Old_man
var played = true
@onready var corn = $corn
@onready var galinho = $Galinho
@onready var botao = $Button
@onready var texto = preload("res://texto_box_final.tscn")
@onready var root = $"."
@onready var morto = $Morto
@onready var transition = $Transition
@onready var cor = $ColorRect

func _ready():
	transition.play("fade_in")
	corn.visible = false
	if played:
		play_man()
		play_dialog1()

func play_man():
	var tween = create_tween()
	tween.parallel().tween_property(man_animation,"position",$Morto.position - Vector2(-30,0),2)
	tween.parallel().tween_property(man_animation,"frame",3,2)
	tween.tween_property(man_animation,"animation","idle",2)
	$Timer.start()
	played = false

func play_dialog1():
	var texto_instace1 = texto.instantiate()
	root.add_child(texto_instace1)
	
func play_reaction1():
	morto.visible = false
	var tween = create_tween()
	tween.tween_property(galinho,"animation","rise",2)
	tween.parallel().tween_property(galinho,"frame",7,1.5)
	tween.parallel().tween_property(galinho,"position",$Morto.position,2)
	tween.tween_property(galinho,"animation","idle",2)
	tween.tween_property(galinho,"frame",4,3)
	#tween.connect("finished",play_fade_out)

func _on_timer_timeout():
	play_reaction1()

func play_fade_out():
	var tween = create_tween()
	tween.tween_property(cor,"self_modulate",Color(0,0,0),2)