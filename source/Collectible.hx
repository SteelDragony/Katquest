package ;

import flixel.FlxSprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Collectible extends FlxSprite
{
	public var name:String;
	var spawned:Bool = false;
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic, mapName:String) 
	{
		super(X, Y, SimpleGraphic);
		name = mapName;
		immovable = true;
	}
	
}