#Nivel.gd
class_name Nivel
extends Node2D

## Atributos onready
onready var contenedor_proyectiles: Node

## Metodos
func _ready() -> void:
	conectar_seniales()
	crear_contenedores()
	
##Metodos custom
func conectar_seniales() -> void:
	Eventos.connect("disparo", self, "on_disparo")
	
func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	
func on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)
