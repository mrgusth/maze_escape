extends "res://Character/Character.gd"


signal moved
signal dead
signal key_grab
signal win

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.scale = Vector2(1,1) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$Footsteps.play()
					emit_signal('moved')


func _on_Character_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		$CollisionShape2D.disabled = true
		set_process(false)
		$Lose.play()
		$AnimationPlayer.play("die")
		yield($Lose, 'finished')
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'key_red':
			emit_signal('key_grab')
		if area.type == 'star':
			emit_signal('win')
