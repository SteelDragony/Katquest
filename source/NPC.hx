package ;

import flixel.addons.display.FlxNestedSprite;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class NPC extends FlxNestedSprite
{
	public var name:String;
	public var talkedTo:Bool = false;
	public var talkIcon:FlxSprite;
	public var talkIconSpawned:Bool = false;
	public var collisionHitBox:FlxNestedSprite;
	
	public var convText:Array<String>;
	
	
	
	public function new(MapEntitieName:String, X:Float=0, Y:Float=0,  ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		name = MapEntitieName;
		this.set_immovable(true);
		talkIcon = new FlxSprite(X, Y, AssetPaths.SpeechBubble__png);
		collisionHitBox = new FlxNestedSprite();
		collisionHitBox.makeGraphic(32, 64, 0x00000000);
		collisionHitBox.relativeX = 125;
		collisionHitBox.relativeY = 125;
		collisionHitBox.immovable = true;
		add(collisionHitBox);
		
	}
	
	public function setToSize()
	{
		this.setGraphicSize( 40, 80);
		this.updateHitbox();
		this.setGraphicSize( -1, 64);
	}
	
	public function setHitbox(sizeX:Int, sizeY:Int, relX:Float, relY:Float)
	{
		collisionHitBox.makeGraphic(sizeX, sizeY, 0x00000000);
		collisionHitBox.relativeX = relX;
		collisionHitBox.relativeY = relY;
	}
}