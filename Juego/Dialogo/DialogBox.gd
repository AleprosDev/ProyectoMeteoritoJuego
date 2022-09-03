tool
extends Control

var dialog = {
	"zona_fruta" : ["bananas", "manzanas", "peras"],
	"zona_verduras" : ["brocoli", "col", "esparrago"],
	"zona_provincia" : ["SantiagoDelEstero", "Tucuman", "Chaco"],
}

export var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

func _process(delta):
	$"Next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	
func load_dialog():
	if dialog_index < dialog.size() and $pla:
		finished = false
		$RichTextLabel.bbcode_text = dialog.zona_fruta[0]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween2.interpolate_property(
			$AudioStreamPlayer2D, "playing", 0, 1, 1,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		$Tween2.start()
	else:
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
