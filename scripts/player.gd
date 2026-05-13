extends CharacterBody2D

const SPEED = 100.0
const JUMP_FORCE = -300.0

var is_jumping = false
var camera: Camera2D

@onready var animation = $Anim as AnimatedSprite2D

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_FORCE
        is_jumping = true
    elif is_on_floor():
        is_jumping = false

    var direction := Input.get_axis("ui_left", "ui_right")
    
    if direction != 0:
        velocity.x = direction * SPEED
        animation.scale.x = direction
        if !is_jumping:
            animation.play("run")
    elif is_jumping:
        animation.play("jump")
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        animation.play("idle")

    move_and_slide()
    
    # Seguir câmera enquanto vivo
    if camera:
        camera.global_position = global_position

func _on_hurtbox_body_entered(body: Node2D) -> void:
    if body.is_in_group("enemies"):
        queue_free()

func follow_camera(cam: Camera2D) -> void:
    camera = cam