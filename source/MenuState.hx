package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
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
	
	private var _btnPlay:CustomButton;
	private var _btnSound:CustomButton;
	private var _backdrop:FlxSprite;
	private var _logo:FlxSprite;
	private var _controlInstuctions:FlxSprite;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		_backdrop = new FlxSprite(0, 0, AssetPaths.Afbeelding1__png);
		_backdrop.setGraphicSize(640, 360);
		_backdrop.updateHitbox();
		add(_backdrop);
		
		_logo = new FlxSprite(0, 0, AssetPaths.Catquest_Logo__png);
		_logo.setGraphicSize(-1, 128);
		_logo.updateHitbox();
		_logo.screenCenter();
		_logo.y = 30;
		add(_logo);
		
		//_controlInstuctions = new FlxSprite(400, 160, AssetPaths.controls__png);
		//add(_controlInstuctions);
		
		_btnPlay = new CustomButton(20, 20, "Start", startGame);
		add(_btnPlay);
		_btnPlay.screenCenter();
		_btnPlay.y = 140;
		
		_btnSound = new CustomButton(0, 0, "Toggle Music", toggleMusic);
		add(_btnSound);
		_btnSound.screenCenter();
		_btnSound.y = 180;
		
		FlxG.sound.playMusic(AssetPaths.menu_music__mp3);
		super.create();
	}
	
	function toggleMusic() 
	{
		if (FlxG.sound.music.volume == 1)
		{
			FlxG.sound.music.fadeOut();
		}
		else if (FlxG.sound.music.volume == 0)
		{
			FlxG.sound.music.fadeIn();
		}
		
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
	
	function startGame()
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