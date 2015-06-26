package ;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
/**
 * ...
 * @author Matthijs van Gelder
 */
class Quest
{
	public var objectives:Array<QuestGoal>;
	public var questStarter:NPC;
	public var questText:FlxText = new FlxText(50, 50, 300, "error, quest text not initialized properly");
	public var complete:Bool = false;
	private var currentObjective:Int = 0;
	
	public function new(journalText:String, questGiver:NPC, goals:Array<QuestGoal> ) 
	{
		//questGoal = goal;
		//objective1 = { deliveryPoint : goal[0], items : goal, complete : false };
		questStarter = questGiver;
		objectives = goals;
		questText.text = journalText;
	}
	
	public function checkCompletion(inventory:Array<Collectible>)
	{
		if (!complete)
		{
/*			complete = true;
			var prevComplete:Bool = true;
			for ( objective in objectives) 
			{
				if ( prevComplete) objective.active = true;
				for ( i in objective.items)
				{
					if (inventory[inventory.indexOf(i)] != null && objective.active)
					{
						objective.ready = true;
						prevComplete = true;
					}
					else if( objective.active)
					{
						objective.ready = false;
						prevComplete = false;
					}
				}
				if (!objective.complete)
				{
					complete = false;
				}
			}*/
			if (objectives[currentObjective].complete) 
			{
				if (objectives[currentObjective + 1] != null)
				{
					currentObjective ++;
				}
				else
				{
					complete = true;
				}
			}
			if (objectives[currentObjective] != null)
			{
				var objective = objectives[currentObjective];
				questText.text = objective.instructionText;
				objective.active = true;
				objective.ready = true;
				for ( i in objective.items)
				{
					if (inventory[inventory.indexOf(i)] != null && objective.active && objective.ready)
					{
						objective.ready = true;
					}
					else if( objective.active)
					{
						objective.ready = false;
					}
				}
				if ( objective.ready)
				{
					questText.text = questText.text + " Complete!";
				}
			}
			if (complete)
			{
				questText.text = questText.text + " Complete!";
			}
		}
	}
	
}