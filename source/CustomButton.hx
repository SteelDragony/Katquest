package ;
import flixel.ui.FlxButton;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Matthijs van Gelder
 */
class CustomButton extends FlxButton
{

	public function new(X:Float, Y:Float, ?Text:String, ?OnClick:Void->Void) 
	{
		super(X, Y, Text, OnClick);
		loadGraphic(AssetPaths.standard__png, false, 100, 35);
		onOver.callback = buttonHover;
		onDown.callback = buttonClick;
		onOut.callback = buttonOut;
		labelOffsets = [new FlxPoint(0,10),new FlxPoint(0,12),new FlxPoint(0,13)];
	}
	
	function buttonOut() 
	{
		loadGraphic(AssetPaths.standard__png);
	}
	
	function buttonHover()
	{
		loadGraphic(AssetPaths.hover__png);
	}
	
	function buttonClick()
	{
		loadGraphic(AssetPaths.click__png);
	}
}