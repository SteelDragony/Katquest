package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;


/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _player:Player;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		add(new flixel.addons.display.FlxBackdrop(AssetPaths.background_draft__png, 1, 1, false, false ));
		add(new FlxText(30, 40, 100, "Its ALIVE"));
		_player = new Player(50, 50);
		add(_player);
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}