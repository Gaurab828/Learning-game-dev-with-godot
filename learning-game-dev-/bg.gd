extends ParallaxBackground

var scrolling_speed = 100
# This chunck of code makes the bg look like its moving.
func _process(delta: float) ->void:
	scroll_offset.x -= scrolling_speed * delta
	
