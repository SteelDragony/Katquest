package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Dialogue extends FlxGroup
{
	var currentTextIndex:Int = 0;
	var npcDialogue:Array<String> = new Array<String>();
	var currentText:FlxText;
	
	public function new(x:Float, y:Float, npcText:Array<String>) 
	{
		super();
		add( new FlxSprite(x - 52, y - 52, AssetPaths.text_bubble__png));
		add(currentText = new FlxText(x - 50, y - 50, 180, npcText[0], 8));
		currentText.color = 0x333333;
		currentText.alignment = "left";
		npcDialogue = npcText;
	}
	
	override public function update():Void 
	{
		super.update();

	}
	
	public function StepThroughText():Bool
	{
		if ( currentTextIndex < npcDialogue.length - 1)
		{
			currentTextIndex ++;
			currentText.text = npcDialogue[currentTextIndex];
			return false;
		}
		else
		{
			return true;
		}
	}
}