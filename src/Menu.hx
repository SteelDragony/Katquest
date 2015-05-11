package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Menu extends Sprite
{

	public function new() 
	{
		super();
		drawBackground();
		
		var buttonTest:Button = new Button();
		addChild(buttonTest);
	}
	
	function drawBackground()
	{
		var background:Bitmap = new Bitmap(Assets.getBitmapData("img/mainMenuBg.jpg"));
		addChildAt(background, 0);
	}
}