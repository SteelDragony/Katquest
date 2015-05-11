package ;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Button extends Sprite
{

	public function new() 
	{
		super();
		drawGraphics();
	}
	
	function drawGraphics()
	{
		this.graphics.beginFill(0x000000);
		this.graphics.drawRect(0, 0, 200, 50);
		this.graphics.endFill();
	}
}