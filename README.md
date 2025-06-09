# Godot Multiplayer Demo
Made with Godot v4.4.1.stable.official [49a5bc7b6]

Direct connection Godot multiplayer demo requiring host port-forwarding. Still in development.

## Personal Style Guide
- All self-defined functions use PascalCasing.
- All built-in engine functions are _snake_casing and .snake_casing().
- Node variables use PascalCasing (helps to remember we are referencing nodes
when we see these variables in the script and to separate them from 
int/float/bool variables of similar name).
- Constants (including pre-loaded scenes and assets) are SCREAMING_SNAKE_CASING.
- All other variables are snake_casing.

## Newcomer GDScript notes
- When instantiating a child scene follow this line of loading it into parent scene:
  
	var child_scene: Object = CHILD_SCENE.instantiate()

	add_child(child_scene)

	child_scene.position = PositionNode.global_position

	** Follow with any code setting values to child_scene **
