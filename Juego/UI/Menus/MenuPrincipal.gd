#MenuPrincipal.gd
extends Node

export(String, FILE, "*.tscn") var nivel_inicial = ""

func _ready() -> void:
#	OS.set_window_fullscreen(true)
	MusicaJuego.play_musica(MusicaJuego.get_lista_musicas().menu_principal)


func _on_Salir_pressed() -> void:
	get_tree().quit()


func _on_Jugar_pressed()  -> void:
	MusicaJuego.play_boton()
	get_tree().change_scene(nivel_inicial)
