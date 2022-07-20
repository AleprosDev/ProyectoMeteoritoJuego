extends Node2D

func _ready() -> void:
	Eventos.connect("disparo", self, "on_disparo")
	
func on_disparo(proyectil:Proyectil) -> void:
	add_child(proyectil)
