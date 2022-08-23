tool
extends ParallaxBackground

export var color_fondo:Color = Color(0.035294, 0.054902, 0.145098)

func _ready() -> void:
	$ColorRect.color = color_fondo

func _process(_delta: float) -> void:
	if Engine.editor_hint:
		$ColorRect.color = color_fondo
