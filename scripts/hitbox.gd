extends Area2D

func _on_body_entered(body: Node2D) -> void:
    if body.name == "Player":
        body.velocity.y = body.JUMP_FORCE
        var anim_player = owner.get_node("Anim") as AnimationPlayer
        if anim_player:
            anim_player.play("hurt")