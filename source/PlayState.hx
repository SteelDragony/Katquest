package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;


/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _player:Player;
	private var _hitTestObject:FlxSprite;
	private var _hitTestObject2:FlxSprite;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		add(new flixel.addons.display.FlxBackdrop(AssetPaths.background_draft__png, 1, 1, false, false ));
		add(new FlxText(30, 40, 100, "Its ALIVE"));
		_player = new Player(50, 50);
		add(_player);
		_hitTestObject = new FlxSprite(200, 200);
		_hitTestObject.makeGraphic(20, 20, FlxColor.RED);
		_hitTestObject.immovable = false;
		_hitTestObject.drag.x = _hitTestObject.drag.y = 200;
		add(_hitTestObject);
		_hitTestObject2 = new FlxSprite(200, 300);
		_hitTestObject2.makeGraphic(20, 20, FlxColor.GREEN);
		_hitTestObject2.immovable = true;
		add(_hitTestObject2);

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
		FlxG.collide(_player, _hitTestObject);
		FlxG.collide(_player, _hitTestObject2, talkToNPC);
	}	
	
	private function talkToNPC(player:Player, npc:FlxSprite)
	{
		add(new FlxText(npc.x, npc.y - 30, 200, "Hi there, are you talking to me right meow?", 20));
	}
}