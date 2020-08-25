extends Control

export(float, 1, 10) var margin_scale: float = 1
export(float, 0, 5) var opening_time: float = 1
export(float, 0, 5) var closing_time: float = .5


#onready var _background_container_node := $BackgroundContainer
onready var _background_node := $Background
onready var _border_node := $Border
onready var _contents_node := $Contents
onready var _tween := $Tween

signal animation_ended()
signal opened()
signal closed()


func _ready() -> void:
	
	_background_node.rect_min_size = _border_node.rect_min_size * 2/3
	
	opening_animation()
	
	var texture_size = _background_node.texture.get_size()
	
	yield(self, "opened")
	
	
	# Compensate for ongoing direction.
	if _background_node.scroll_velocity.x > 0:
		_background_node.margin_right = -texture_size.x
	elif _background_node.scroll_velocity.x < 0:
		_background_node.margin_left = texture_size.x

	if _background_node.scroll_velocity.y > 0:
		_background_node.margin_bottom = -texture_size.y
	elif _background_node.scroll_velocity.y < 0:
		_background_node.margin_top = texture_size.y
	
	_contents_node.margin_bottom = - margin_scale * _border_node.patch_margin_bottom
	_contents_node.margin_left = margin_scale * _border_node.patch_margin_left
	_contents_node.margin_right = - margin_scale * _border_node.patch_margin_right
	_contents_node.margin_top = margin_scale * _border_node.patch_margin_top



func resize_animation(start_size: Vector2, final_size: Vector2, time: float = 1, hide: CanvasItem = _contents_node):
	if hide != null: hide.visible = false
	# Start opening animation.
	_tween.interpolate_property(self, "rect_size", start_size, final_size, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.interpolate_property(self, "rect_position", rect_position + final_size / 2, rect_position + start_size / 2, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	_tween.start()
	yield(_tween, "tween_all_completed") # Wait until the animation is over.
	# Animation is over.
	if hide != null: hide.visible = true
	emit_signal("animation_ended")


func opening_animation(time = opening_time):
	var prev_scrolling: bool = _background_node.scrolling
	_background_node.scrolling = false
	resize_animation(Vector2.ZERO, rect_size, time)
	yield(self, "animation_ended")
	emit_signal("opened")
	_background_node.scrolling = prev_scrolling


func closing_animation(time = opening_time):
	resize_animation(rect_size, Vector2.ZERO, time)
	yield(self, "animation_ended")
	emit_signal("closed")
