package ;
import flixel.FlxObject;

/**
 * @author Matthijs van Gelder
 */

typedef QuestGoal =
{
	var instructionText:String;
	var deliveryPoint:FlxObject;
	var items:Array<Collectible>;
	var active:Bool;
	var ready:Bool;
	var complete:Bool;
	var completionDialogue:Array<String>;
	@:optional var reward:Array<Collectible>;
	@:optional var kibbleReward:Int;
}