#EstacionRecarga.gd
class_name EstacionRecarga
extends Node2D

## Atributos Export
export var energia:float = 6.0
export var radio_energia_entregada:float = 0.05

## Atributos
var nave_player:Player = null
var player_en_zona:bool = false

## Atributos Onready
onready var carga_sfx:AudioStreamPlayer = $CargaSFX
onready var barra_energia:ProgressBar = $BarraEnergia

## Metodos
func _ready() -> void:
	barra_energia.max_value = energia
	barra_energia.value = energia

func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
	
	controlar_energia()
	
	if event.is_action("recarga_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	elif event.is_action("recarga_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)
	
	if event.is_action_released("recarga_laser"):
		Eventos.emit_signal("ocultar_energia_laser")
	elif event.is_action_released("recarga_escudo"):
		Eventos.emit_signal("ocultar_energia_escudo")

## Metodos Custom
func puede_recargar(event: InputEvent) -> bool:
	var hay_input = event.is_action("recarga_escudo") or event.is_action("recarga_laser")
	if hay_input and player_en_zona and energia > 0.0:
		if !carga_sfx.playing:
			carga_sfx.play()
		return true
	
	return false

func controlar_energia() -> void:
	energia -= radio_energia_entregada
	if energia <= 0.0:
		$VacioSFX.play()
		
	barra_energia.value = energia

## Señales Internas
func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body: Node) -> void:
	if body is Player:
		player_en_zona = true
		nave_player = body
		Eventos.emit_signal("detecto_zona_recarga", true)

func _on_AreaRecarga_body_exited(body: Node) -> void:
	if body is Player:
		player_en_zona = false
		Eventos.emit_signal("detecto_zona_recarga", false)
