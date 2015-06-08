package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	private var _btnPlay:FlxButton;
	private var _backdrop:FlxSprite;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		_backdrop = new FlxSprite(0, 0, AssetPaths.Afbeelding1__png);
		_backdrop.setGraphicSize(640, 360);
		_backdrop.updateHitbox();
		trace(_backdrop.width, _backdrop.height);
		add(_backdrop);
		
		_btnPlay = new FlxButton(20, 20, "Test Button", testfunction);
		_btnPlay.loadGraphic(AssetPaths.standard__png, false, 100, 35);
		_btnPlay.onOver.callback = buttonHover;
		_btnPlay.onDown.callback = buttonClick;
		_btnPlay.onOut.callback = buttonOut;
		add(_btnPlay);
		_btnPlay.screenCenter();
		super.create();
	}
	
	function buttonOut() 
	{
		_btnPlay.loadGraphic(AssetPaths.standard__png);
	}
	
	function buttonHover()
	{
		_btnPlay.loadGraphic(AssetPaths.hover__png);
	}
	
	function buttonClick()
	{
		_btnPlay.loadGraphic(AssetPaths.click__png);
	}
	
	function testfunction()
	{
		FlxG.switchState(new PlayState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		_btnPlay = FlxDestroyUtil.destroy(_btnPlay);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}