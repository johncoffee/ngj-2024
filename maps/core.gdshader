shader_type canvas_item;

uniform float fill_amount;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (1.0 - UV.y > fill_amount) COLOR.a = 0.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
