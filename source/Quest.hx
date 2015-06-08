package ;
import flixel.FlxSprite;

/**
 * ...
 * @author Matthijs van Gelder
 */
class Quest
{
	var questGoal:Array<Collectible> = new Array<Collectible>();
	public var questText:String;
	public function new(goal:Array<Collectible>, journalText:String) 
	{
		questGoal = goal;
		questText = journalText;
	}
	
	public function checkCompletion(inventory:Array<FlxSprite>)
	{
		for ( i in questGoal)
		{
			if (inventory[inventory.indexOf(i)] != null)
			{
				trace("Goal complete");
			}
		}
	}
	
}