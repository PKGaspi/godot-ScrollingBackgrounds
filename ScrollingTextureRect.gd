class_name ScrollingTextureRect
extends TextureRect


export var scroll_velocity: Vector2 = Vector2.ZERO
export var scrolling: bool = true

var progress: Vector2 = Vector2.ZERO




func _process(delta):
	
	if texture == null: return
	
	var texture_size = texture.get_size()
	
	if !scrolling or texture_size == Vector2.ZERO: 
		return
	
	rect_position += scroll_velocity * delta
	progress += scroll_velocity * delta
	
	
	while abs(progress.x) >= texture_size.x:
		progress.x -= texture_size.x * sign(scroll_velocity.x)
		rect_position.x -= texture_size.x * sign(scroll_velocity.x)
		
	while abs(progress.y) >= texture_size.y:
		progress.y -= texture_size.y * sign(scroll_velocity.y)
		rect_position.y -= texture_size.y * sign(scroll_velocity.y)
