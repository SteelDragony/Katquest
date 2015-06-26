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
	public var _quests:Array<Quest> = new Array<Quest>();
	public var _Collectibles:Array<Collectible> = new Array<Collectible>();
	
	public function new() 
	{
		super();
		_background.loadGraphic(AssetPaths.inventory__png);
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
			//if (spr != _background)
			//{
				//spr.x = 452 + column * 60;
				//spr.y = 50 + row * 70;
				//column ++;
				//if ( column == 3)
				//{
					//column = 0;
					//row ++;
				//}
				//tempArray.push(spr);
			//}
		});
		for ( i in _Collectibles)
		{
			i.x = 432 + column * 68;
			i.y = 83 + row * 70;
			column ++;
			if ( column == 3)
			{
				column = 0;
				row ++;
			}
		}
        updateQuestCompletion();

	}
	
	public function updateQuestCompletion()
	{
		for (i in _quests)
		{
			i.checkCompletion(_Collectibles);
			i.questText.x = 50;
			i.questText.y = 80 + _quests.indexOf(i) * 20;
		}
	}
	
	public function addQuest(quest:Quest)
	{
		_quests.push(quest);

		add(quest.questText);
	}
	
	public function addCollectible(item:Collectible)
	{
		_Collectibles.push(item);
		add(item);
		updateQuestCompletion();
	}
}