package ;

import flixel.FlxSprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class NPC extends FlxSprite
{
	
	public var convText:Array<String>;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	
}