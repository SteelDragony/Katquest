package;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.FlxObject;
import flixel.FlxG.sound;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;


/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _playerSpawned:Bool = false;
	private var _currentArea:String = "bedroom";
	private var _player:Player;
	private var _hitTestObject:Collectible;
	private var _hitTestObject2:NPC;
	
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	
	private var _collisionLayer:FlxGroup = new FlxGroup();
	private var _backdrop:FlxGroup = new FlxGroup();
	private var _collectibles:FlxGroup = new FlxGroup();
	private var _npcs:FlxTypedGroup<FlxObject> = new FlxTypedGroup<FlxObject>();
	
	private var _inventory:Inventory = new Inventory();
	private var _dialogue:Dialogue;
	
	private var _invOpen:Bool = false;
	private var _dialogueOpen:Bool = false;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		add(_collisionLayer);
		add(_backdrop);
		add(_collectibles);
		add(_npcs);
		_map = new FlxOgmoLoader(AssetPaths.bedroom__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		_collisionLayer.add(_mWalls);
		_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.bedroom__png, 1, 1, false, false ));
		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		_npcs.add(_player);
		_hitTestObject = new Collectible(190, 250, AssetPaths.item1__png);
		_hitTestObject.immovable = true;
		_collectibles.add(_hitTestObject);
		_collectibles.add(new Collectible(350, 400, AssetPaths.item2__png));
		_collectibles.add(new Collectible(400, 420, AssetPaths.item3__png));
		_collectibles.add(new Collectible(300, 400, AssetPaths.item1__png));
		_collectibles.add(new Collectible(200, 500, AssetPaths.item3__png));
		for (i in 0 ...10)
		{
			_collectibles.add(new Collectible(Math.random() * 640, Math.random() * 360, AssetPaths.item1__png));
			_collectibles.add(new Collectible(Math.random() * 640, Math.random() * 360, AssetPaths.item2__png));
			_collectibles.add(new Collectible(Math.random() * 640, Math.random() * 360, AssetPaths.item3__png));
			
		}
		_hitTestObject2 = new NPC(300, 400);
		_hitTestObject2.loadGraphic(AssetPaths.NPC1_sprite__png, false, 256, 256);
		_hitTestObject2.setGraphicSize( -1, 64);
		_hitTestObject2.updateHitbox();
		_hitTestObject2.immovable = true;
		_hitTestObject2.convText = ["Oh ja, we zijn het komende weekend weg, dus hier heb je alvast wat Kibbels om de komende tijd rond te komen.", "Als je weg wil, kan je gewoon door de deur lopen!", "Vergeet de sleutels niet! [pick up keys(?)]"];
		_npcs.add(_hitTestObject2);
		_dialogue = new Dialogue(_player.x, _player.y, ["Hoi, eindelijk wakker?", "Eindelijk de eerste dag van de vakantie!", "Wat ben je eigenlijk van plan om te doen in de vakantie?", "Oh, terwijl je daarover na denkt, zou je mij en je vader wel even kunnen helpen?", "Als je naar [?] loopt met de pijltjestoetsen en op de spatiebalk drukt, gaat er wat gebeuren! Kijk zelf maar."]);
		add(_dialogue);
		_dialogueOpen = true;
		
		var _tuturialQuest = new Quest([_hitTestObject], "Clean up the correct banana peel");
		_inventory.addQuest(_tuturialQuest);
		
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
		if (!_dialogueOpen && !_invOpen)
		{
			_npcs.active = true;
			for (_collectible in _collectibles) 
			{
				FlxG.collide(_player, _collectible, addToInventory);
			}

			FlxG.collide(_player, _hitTestObject2, talkToNPC);
			FlxG.collide(_player, _mWalls);
			if (_player.x > 1000 && _player.facing == FlxObject.RIGHT)
			{
				switchArea("livingroom");
			}
			if (_player.x < 5 && _player.facing == FlxObject.LEFT)
			{
				switchArea("bedroom");
			}
			_npcs.sort(FlxSort.byY);
		}
		else
		{
			_npcs.active = false;
			if (FlxG.keys.anyJustPressed(["SPACE"]))
			{
				if (_dialogue.StepThroughText())
				{
					_dialogueOpen = false;
					_dialogue.destroy();
				}
			}
		}
			var _i = FlxG.keys.anyJustPressed(["I"]);
			if (_i) toggleInventory();
	}	
	
	private function toggleInventory()
	{
		if (_invOpen)
		{
			_invOpen = false;
			remove(_inventory);
		}
		else
		{
			_invOpen = true;
			add(_inventory);
		}
	}
	
	private function addToInventory(player:Player, object:Collectible) 
	{
		_collectibles.remove(object, true);
		_inventory.add(object);
	}
	
	private function talkToNPC(player:Player, npc:NPC)
	{
		if (FlxG.keys.anyJustPressed(["SPACE"]))
		{
			_dialogue = new Dialogue(npc.x, npc.y, npc.convText);
			add(_dialogue);
			_dialogueOpen = true;
		}
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player" && _playerSpawned == false)
		{
			_player.x = x;
			_player.y = y;
			_playerSpawned = true;
		}
		if (entityName == "bedroom_to_livingroom" && _currentArea == "livingroom")
		{
			_player.x = x;
			_player.y = y;
			_currentArea = "bedroom";
		}
		if (entityName == "livingroom_to_bedroom" && _currentArea == "bedroom")
		{
			_player.x = x;
			_player.y = y;
			_currentArea = "livingroom";
		}
	}
	
	private function switchArea(target:String)
	{
		switch (target) 
		{
			case "livingroom":
			{
				_map = new FlxOgmoLoader(AssetPaths.livingroom__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.livingroom__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
			}
			case "bedroom":
			{
				_map = new FlxOgmoLoader(AssetPaths.bedroom__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.bedroom__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
			}
		}

	}
}