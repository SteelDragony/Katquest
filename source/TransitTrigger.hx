package ;
import flixel.FlxSprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class TransitTrigger extends FlxSprite
{
	public var _target:String;
	public function new(x:Float, y:Float, targetString:String) 
	{
		super(x, y);
		_target = targetString;
		makeGraphic(50, 50, 0x00000000);
	}
	
}