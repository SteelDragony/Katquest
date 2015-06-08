package ;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Inventory extends FlxTypedGroup<FlxSprite>
{
	var _background:FlxSprite = new FlxSprite();
	var _quests:Array<Quest> = new Array<Quest>();
	
	public function new() 
	{
		super();
		_background.loadGraphic(AssetPaths.Menu__png);
		_background.setGraphicSize(640, 360);
		_background.updateHitbox();
		add(_background);
		
	}
	
	override public function update():Void 
	{
		super.update();
		var column:Int = 0;
		var row:Int = 0;
		
		var tempArray:Array<FlxSprite> = new Array<FlxSprite>();
		
		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set();
			if (spr != _background)
			{
				spr.x = 452 + column * 60;
				spr.y = 50 + row * 70;
				column ++;
				if ( column == 3)
				{
					column = 0;
					row ++;
				}
				tempArray.push(spr);
			}
        });
		for (i in _quests)
		{
			i.checkCompletion(tempArray);
		}
	}
	
	public function addQuest(quest:Quest)
	{
		_quests.push(quest);
		var questText:FlxText = new FlxText(50, 50, 300, quest.questText);
		add(questText);
	}
}