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
	
	private var _unspawnedObjects:Array<Collectible> = new Array<Collectible>();
	private var _spawnableNpcs:Array<NPC> = new Array<NPC>();
	private var _quests:Array<Quest> = new Array<Quest>();
	// tuturial collectables
	private var _tuturialObj1:Collectible;
	private var _tuturialObj2:Collectible;
	private var _tuturialObj3:Collectible;
	// main quest collectables
	private var _metaalDetector:Collectible;
	private var _hengel:Collectible;
	private var _worm:Collectible;
	private var _ring:Collectible;
	private var _pen:Collectible;
	private var _paper:Collectible;
	private var _fish:Collectible;
	
	// tilemap vars
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	
	private var _collisionLayer:FlxGroup = new FlxGroup();
	private var _backdrop:FlxGroup = new FlxGroup();
	private var _collectibles:FlxGroup = new FlxGroup();
	private var _npcs:FlxTypedGroup<FlxObject> = new FlxTypedGroup<FlxObject>();
	private var _icons:FlxGroup = new FlxGroup();
	private var _transitTriggers:FlxGroup = new FlxGroup();
	
	private var _inventory:Inventory = new Inventory();
	private var _dialogue:Dialogue;
	
	private var _invOpen:Bool = false;
	private var _dialogueOpen:Bool = false;
	
	private var _yarn:FlxSprite;
	
	// npc vars
	private var _trashBin:NPC;
	private var _mom:NPC;
	private var _dad:NPC;
	private var _mia:NPC;
	private var _pippa:NPC;
	private var _hodor:NPC;
	private var _tommie:NPC;
	private var _bert:NPC;
	private var _vlekje:NPC;
	private var _lapje:NPC;
	private var _katy:NPC;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.fullscreen = true;
		add(_collisionLayer);
		add(_backdrop);
		add(_collectibles);
		add(_npcs);
		add(_icons);
		add(_transitTriggers);
		initNPCS();
		_map = new FlxOgmoLoader(AssetPaths.bedroom__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		_collisionLayer.add(_mWalls);
		_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.bedroom__png, 1, 1, false, false ));
		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		_npcs.add(_player);
		initCollectibles();
		
		_dialogue = new Dialogue(_player.x, _player.y, 
		["Goeiemorgen, ik dacht al dat ik je hoorde.",
		"Ik hoop dat je goed geslapen hebt, vandaag is je grote vakantie begonnen.",
		"Maar voordat je ergens heen gaat, zou k m’n troep maar ’s opruimen als ik jou was.",
		"Er ligt nog een bananenschil, visgraat en een snoeppapiertje van je in de andere kamer.",
		"Als je dat hebt weggegooid heeft je vader misschien nog wel wat voor je om je spaarpotje te vullen."]);
		add(_dialogue);
		_dialogueOpen = true;
		
		initQuests();
		
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
		super.create();
	}
	
	function initCollectibles()
	{
		_tuturialObj1 = new Collectible(0, 0, AssetPaths.item3__png, "object1");
		_tuturialObj2 = new Collectible(0, 0, AssetPaths.item2__png, "object2");
		_tuturialObj3 = new Collectible(0, 0, AssetPaths.item1__png, "object3");
		_unspawnedObjects = [_tuturialObj1, _tuturialObj2, _tuturialObj3];
		_metaalDetector = new Collectible(0, 0, AssetPaths.metal_detector__png, "notOnMap");
		_hengel = new Collectible(0, 0, AssetPaths.rod__png, "notOnMap");
		_worm = new Collectible(0, 0, AssetPaths.worm__png, "worm");
		_ring = new Collectible(0, 0, AssetPaths.ring__png, "notOnMap");
		_pen = new Collectible(0, 0, AssetPaths.pen__png, "notOnMap");
		_paper = new Collectible(0, 0, AssetPaths.paper__png, "notOnMap");
		_fish = new Collectible(0, 0, AssetPaths.fish__png, "notOnMap");
		_unspawnedObjects.push(_worm);
		
		_yarn = new FlxSprite(300, 200, AssetPaths.yarn__png);
	}
	
	/**
	 * create all npc instances to place on the map when needed
	 */
	function initNPCS()
	{
		_trashBin = new NPC("trashcan");
		_trashBin.loadGraphic(AssetPaths.trash__png, false, 32, 32);
		_trashBin.convText = ["Dat is de prullebak."];
		_trashBin.setHitbox(20, 20, 6, 6);
		_spawnableNpcs.push(_trashBin);
		
		_mom = new NPC("npc1");
		_mom.loadGraphic(AssetPaths.NPC8_sprite__png, false, 256, 256);
		_mom.setToSize();
		_mom.convText = ["Goeiemorgen, ik dacht al dat ik je hoorde.",
			"Ik hoop dat je goed geslapen hebt, vandaag is je grote vakantie begonnen.",
			"Maar voordat je ergens heen gaat, zou k m’n troep maar ’s opruimen als ik jou was.",
			"Er ligt nog een bananenschil, visgraat en een snoeppapiertje van je in de andere kamer.",
			"Als je dat hebt weggegooid heeft je vader misschien nog wel wat voor je om je spaarpotje te vullen."];
		_spawnableNpcs.push(_mom);
		
		_dad = new NPC("npc2");
		_dad.loadGraphic(AssetPaths.NPC1_sprite__png, false, 256, 256);
		_dad.setToSize();
		_dad.convText = ["Heb je al opgeruimd?", "Volgens mij zie ik nog wat van je liggen, kom maar terug als je echt opgeruimd hebt."];
		_spawnableNpcs.push(_dad);
		
		_mia = new NPC("mia");
		_mia.loadGraphic(AssetPaths.NPC5_sprite__png, false, 256, 256);
		_mia.setToSize();
		_mia.convText = ["Dus je doet klusjes deze zomer?",
			"Ik heb wel wat voor je. Kan jij mijn ring terug vinden?",
			"Ik ben hem vandaag kwijt geraakt en ik wil hem graag terug.",
			"Ik weet zeker dat ik hem voor het laatst zag bij de vijver."];
		_spawnableNpcs.push(_mia);
		
		_pippa = new NPC("pippa");
		_pippa.loadGraphic(AssetPaths.NPC6_sprite__png, false, 256, 256);
		_pippa.setToSize();
		_pippa.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_pippa);
		
		_hodor = new NPC("hodor");
		_hodor.loadGraphic(AssetPaths.NPC7_sprite__png, false, 256, 256);
		_hodor.setToSize();
		_hodor.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_hodor);
		
		_tommie = new NPC("tommie");
		_tommie.loadGraphic(AssetPaths.NPC3_sprite__png, false, 256, 256);
		_tommie.setToSize();
		_tommie.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_tommie);
		
		_bert = new NPC("bert");
		_bert.loadGraphic(AssetPaths.NPC5_sprite__png, false, 256, 256);
		_bert.setToSize();
		_bert.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_bert);
		
		_vlekje = new NPC("vlekje");
		_vlekje.loadGraphic(AssetPaths.NPC6_sprite__png, false, 256, 256);
		_vlekje.setToSize();
		_vlekje.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_vlekje);
		
		_lapje = new NPC("lapje");
		_lapje.loadGraphic(AssetPaths.NPC6_sprite__png, false, 256, 256);
		_lapje.setToSize();
		_lapje.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_lapje);
		
		_katy = new NPC("katy");
		_katy.loadGraphic(AssetPaths.NPC9_sprite__png, false, 256, 256);
		_katy.setToSize();
		_katy.convText = ["Of ik een ring gezien heb? Nee dat niet.",
			"Maar ik zag wel een vis wat glimmends opeten.",
			"Als je het zeker wilt weten zou ik die vis maar vangen.",
			"Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."];
		_spawnableNpcs.push(_katy);
		
	}
	
	function initQuests()
	{
		var _tuturialQuest = new Quest
		(
			"ruim de rommel op in de woonkamer",
			_mom,
			[
				{
					instructionText : "Ruim de rommel op die je in de woonkamer gemaakt hebt.",
					deliveryPoint : _trashBin,
					items : [_tuturialObj1, _tuturialObj2, _tuturialObj3],
					active : true,
					ready : false,
					complete : false,
					completionDialogue : ["Je gooit je rotzooi in de prullebak, tijd om je vader te vertellen dat je klaar bent."]
				},
				{
					instructionText : "Zeg je vader dat je klaar bent.",
					deliveryPoint : _dad,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Fijn dat je dat gedaan heb, hier heb je vast wat knabbels", "Wees voorzichtig buiten"]
				}
			]
		);
		_quests.push(_tuturialQuest);
		_inventory.addQuest(_tuturialQuest);
		var _ringQuest = new Quest
		(
			"vind de ring die Mia kwijt is geraakt.",
			_mia,
			[ 
				{
					instructionText : "Vraag of mischien iemand bij de vijver de ring heeft gezien.",
					deliveryPoint : _pippa,
					items : [],
					active : true,
					ready : false,
					complete : false,
					completionDialogue : ["Of ik een ring gezien heb? Nee dat niet.", "Maar ik zag wel een vis wat glimmends opeten.", "Als je het zeker wilt weten zou ik die vis maar vangen. Daar ga je een metaaldetector, een hengel en een worm voor nodig hebben."]
				},
				{
					instructionText : "Leen de metaaldetector bij de boerderij.",
					deliveryPoint : _hodor,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Jij wil de metaaldetector gebruiken?", "Nou dat weet ik zo niet. Ik heb het niet zo op oranje katten."]
				},
				{
					instructionText : "Kijk of je iemand kan vinden van de KJRW die je kan helpen",
					deliveryPoint : _tommie,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Het is discriminatie als je iets niet mag hebben vanwege je kleur.", "Ga naar het politiebureau en leg een verklaring af, dan lost dit probleem zich wel op."]
				},
				{
					instructionText : "Ga naar het politie bureau voor hulp.",
					deliveryPoint : _bert,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Wat vervelend allemaal. Ik zal eens met de boer gaan praten, als jij het dan nog een keer aan hem vraagt is het vast opgelost."]
				},
				{
					instructionText : "Probeer opnieuw de metaal detector te lenen.",
					deliveryPoint : _hodor,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Nou, ik zal hem dan toch maar aan je uitlenen dan.", "Hier heb je de metaaldetector."],
					reward : [_metaalDetector]
				},
				{
					instructionText : "Vraag of je de hengel van Vlekje mag lenen.",
					deliveryPoint : _vlekje,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Je wilt mijn hengel lenen? Ah, dan moet ik hem zoeken, maar mijn hoofd staat er nu niet naar.", "Mijn papa en mama gaan uit elkaar. Ik moet bij papa gaan wonen, maar dat wil ik niet. Wat moet ik doen?"]
				},
				{
					instructionText : "Kijk of je iemand kan vinden van de KJRW die je kan helpen",
					deliveryPoint : _tommie,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Scheidingen zijn lastig, maar als je vriend wil laten weten wat hij wil kan hij een brief schrijven.", " In de school zit iemand die kan helpen als je pen en papier regelt."]
				},
				{
					instructionText : "Haal pen en papier in de supermarkt",
					deliveryPoint : _lapje,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["1 papiertje en een pen, alsjeblieft en een goede dag."],
					reward : [_pen, _paper]
				},
				{
					instructionText : "Breng de pen en het papier naar de school zodat je vriend een brief kan schrijven.",
					deliveryPoint : _katy,
					items : [_pen, _paper],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Geen probleem, je kan tegen je vriend zeggen dat hij kan komen wanneer hij wil, ik zal zorgen dat alles in orde komt."]
				},
				{
					instructionText : "Ga terug naar je vriend Vlekje om te zeggen dat je geregeld hebt dat hij een brief kan schrijven.",
					deliveryPoint : _vlekje,
					items : [],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Dus je hebt dat allemaal geregeld voor mij?", "Dankjewel, ik zal gelijk naar de school terug gaan. Maar eerst, als dankjewel, hier heb je mijn hengel."],
					reward : [_hengel]
				},
				{
					instructionText : "Ga weer naar de vijver, vind een worm, en vraag hulp om de vis te vangen",
					deliveryPoint : _pippa,
					items : [_hengel, _worm, _metaalDetector],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Ik wil je best helpen een vis te vangen, let goed op hoe ik het doe.", "Nu kan je het zelf proben, doe je best!", "Wat een kanjer. Zou die de ring opgeslokt hebben?"],
					reward : [_fish]
				},
				{
					instructionText : "probeer samen met Pippa bij de vijver of de ring in deze vis zit.",
					deliveryPoint : _pippa,
					items : [_fish],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Oke, hou de metaal detector boven de vis.", "BEEP BEEP BEEP", "Ja Hoera, Gefeliciteerd! Je hebt de ring gevonden."],
					reward : [_ring]
				},
				{
					instructionText : "Breng de ring terug naar Mia",
					deliveryPoint : _mia,
					items : [_ring],
					active : false,
					ready : false,
					complete : false,
					completionDialogue : ["Dus je hebt al die moeite moeten doen om mijn ring te vinden?", "Wat lief. Hier heb je 40 knabbels voor al die moeite, en succes met je baantje."]
				}
				
			]
		);
		_quests.push(_ringQuest);
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

			_npcs.forEachOfType(NPC, function(npc:NPC)
			{
				FlxG.overlap(_player, npc, talkToNPC);
				FlxG.collide(_player, npc.collisionHitBox);
				if (!npc.talkedTo && !npc.talkIconSpawned)
				{
					
					_icons.add(npc.talkIcon = new FlxSprite(npc.x, npc.y, AssetPaths.SpeechBubble__png));
					//npc.talkIcon.setGraphicSize( -1, 32);
					//npc.talkIcon.updateHitbox();
					npc.talkIcon.setPosition(npc.x + 50, npc.y - 40);
					
					npc.talkIconSpawned = true;
				}
				else if (npc.talkedTo && npc.talkIconSpawned)
				{
					_icons.remove(npc.talkIcon);
					npc.talkIconSpawned = false;
				}
				// set correct talkIcon image
				for (quest in _quests) 
				{
					if (!_dialogueOpen && npc == quest.questStarter && _inventory._quests.indexOf(quest) == -1)
					{
						npc.talkIcon.loadGraphic(AssetPaths.Exclamation_mark__png);
						npc.talkedTo = false;
					}
					for (objective in quest.objectives) 
					{
						if (npc == objective.deliveryPoint && objective.ready && objective.active && !quest.complete)
						{
							npc.talkIcon.loadGraphic(AssetPaths.QuestionMark__png);
							npc.talkedTo = false;
						}
					}
				}
			});
			FlxG.collide(_player, _mWalls);
			FlxG.collide(_player, _yarn);
			FlxG.collide(_yarn, _mWalls);
			FlxG.overlap(_player, _transitTriggers, switchArea);
			//if (_player.x > 1000 && _player.facing == FlxObject.RIGHT)
			//{
				//switchArea("livingroom");
			//}
			//if (_player.x < 5 && _player.facing == FlxObject.LEFT)
			//{
				//switchArea("bedroom");
			//}
			//if (_player.y > 600 && _player.facing == FlxObject.DOWN && _currentArea != "worldmap")
			//{
				//switchArea("worldmap");
				//_currentArea = "worldmap";
			//}
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
					_inventory.updateQuestCompletion();
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
		_inventory.addCollectible(object);
	}
	
	private function talkToNPC(player:Player, npc:NPC)
	{
		if (FlxG.keys.anyJustPressed(["SPACE"]))
		{
			_inventory.updateQuestCompletion();
			for (quest in _quests)
			{
				if (!_dialogueOpen && npc == quest.questStarter && _inventory._quests.indexOf(quest) == -1)
				{
					_inventory.addQuest(quest);
				}
			}
			
			for (quest in _inventory._quests) 
			{
				for (objective in quest.objectives) 
				{
					if (!_dialogueOpen && npc == objective.deliveryPoint && objective.ready && objective.active && !quest.complete)
					{
						npc.convText = objective.completionDialogue;
						_dialogue = new Dialogue(player.x, player.y, objective.completionDialogue);
						for (i in objective.items) 
						{
							_inventory.remove(i, true);
							_inventory._Collectibles.remove(i);
						}
						add(_dialogue);
						_dialogueOpen = true;
						npc.talkedTo = true;
						objective.active = false;
						objective.ready = false;
						objective.complete = true;
						if (objective.reward != null)
						{
							for (item in objective.reward) 
							{
								_inventory.addCollectible(item);
							}
							
						}
					}
				}
			}
			if ( !_dialogueOpen)
			{
				_dialogue = new Dialogue(player.x, player.y, npc.convText);
				add(_dialogue);
				_dialogueOpen = true;
				npc.talkedTo = true;
			}
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
		// bedroom
		if (entityName == "bedroom_to_livingroom")
		{
			var _transit = new TransitTrigger(x, y, "livingroom");
			_transitTriggers.add(_transit);
		}
		else if (entityName == "from_livingroom_spawn" && _currentArea == "livingroom")
		{
			_player.x = x;
			_player.y = y;
		}
		// livingroom
		else if (entityName == "livingroom_to_bedroom")
		{
			var _transit = new TransitTrigger(x, y, "bedroom");
			_transitTriggers.add(_transit);
			
		}
		else if (entityName == "from_bedroom_spawn" && _currentArea == "bedroom")
		{
			_player.x = x;
			_player.y = y;

		}
		else if (entityName == "livingroom_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// school
		else if (entityName == "school_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// grocery store
		else if (entityName == "grocery_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// police station
		else if (entityName == "police_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// pond
		else if (entityName == "pond_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// friends house
		else if (entityName == "friend_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// farm
		else if (entityName == "farm_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		// kjrw building
		else if (entityName == "kjrw_to_outside")
		{
			var _transit = new TransitTrigger(x, y, "worldmap");
			_transitTriggers.add(_transit);
		}
		
		// generic
		else if (entityName == "from_outside_spawn" && _currentArea == "worldmap")
		{
			_player.x = x;
			_player.y = y;
		}
		// worldmap
		else if	(entityName == "outside_to_home")
		{
			var _transit = new TransitTrigger(x, y, "livingroom");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_farm")
		{
			var _transit = new TransitTrigger(x, y, "farm");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_police")
		{
			var _transit = new TransitTrigger(x, y, "police");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_pond")
		{
			var _transit = new TransitTrigger(x, y, "pond");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_store")
		{
			var _transit = new TransitTrigger(x, y, "store");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_friend")
		{
			var _transit = new TransitTrigger(x, y, "friend");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_school")
		{
			var _transit = new TransitTrigger(x, y, "school");
			_transitTriggers.add(_transit);
		}
		
		else if	(entityName == "outside_to_kjrw")
		{
			var _transit = new TransitTrigger(x, y, "kjrw");
			_transitTriggers.add(_transit);
		}
		// map enter points
		else if (entityName == "spawn_from_home" && _currentArea == "livingroom")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_police" && _currentArea == "police")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_pond" && _currentArea == "pond")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_kjrw" && _currentArea == "kjrw")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_friend" && _currentArea == "friend")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_farm" && _currentArea == "farm")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_grocery" && _currentArea == "store")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "spawn_from_school" && _currentArea == "school")
		{
			_player.x = x;
			_player.y = y;
		}
		
		for ( npc in _spawnableNpcs)
		{
			if (npc.name == entityName)
			{
				npc.x = x;
				npc.y = y;
				_npcs.add(npc);
				return;
			}
		}
		for ( i in _unspawnedObjects)
		{
			if ( i.name == entityName)
			{
				i.x = x;
				i.y = y;
				_collectibles.add(i);
				_unspawnedObjects.remove(i);
				return;
			}
		}
	}
	
	private function placeTrees(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "tree1")
		{
			var _tree = new FlxSprite(x, y, AssetPaths.tree1__png);
			_backdrop.add(_tree);
		}
		else if (entityName == "tree2")
		{
			var _tree = new FlxSprite(x, y, AssetPaths.tree2__png);
			_backdrop.add(_tree);
		}
		else if (entityName == "tree3")
		{
			var _tree = new FlxSprite(x, y, AssetPaths.tree3__png);
			_backdrop.add(_tree);
		}
		else if (entityName == "tree4")
		{
			var _tree = new FlxSprite(x, y, AssetPaths.tree4__png);
			_backdrop.add(_tree);
		}
		
	}
	
	private function switchArea(player:Player, trigger:TransitTrigger)
	{
		var target:String = trigger._target;
		_npcs.forEachOfType(NPC, function(_npc:NPC) { _icons.remove(_npc.talkIcon, true); _npc.talkIconSpawned = false; } );
		_npcs.clear();
		_npcs.add(_player);
		_collectibles.forEachOfType(Collectible, function(_collectible) { _unspawnedObjects.push(_collectible);} );
		_collectibles.clear();
		_transitTriggers.clear();
		_backdrop.clear();
		remove(_yarn);
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
				add(_yarn);
				_currentArea = "livingroom";
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
				_currentArea = "bedroom";
			}
			case "worldmap":
			{
				_map = new FlxOgmoLoader(AssetPaths.worldmap__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.world_tiles__png, 64, 64, "background");
				_backdrop.add(_visualTiles);
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.Small_houses__png, 166, 337, "smalll_houses");
				_backdrop.add(_visualTiles);
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.Houses_stairs__png, 487, 336, "houses_stairs");
				_backdrop.add(_visualTiles);
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.farm_ext__png, 333, 381, "farm");
				_backdrop.add(_visualTiles);
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.school_ext__png, 743, 417, "school");
				_backdrop.add(_visualTiles);
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.Winkel_ext__png, 167, 147, "grocery");
				_backdrop.add(_visualTiles);
				
				var _visualTiles:FlxTilemap = _map.loadTilemap(AssetPaths.kerk_ext__png, 316, 149, "church");
				_backdrop.add(_visualTiles);
				
				_map.loadEntities(placeEntities, "entities");
				_map.loadEntities(placeTrees, "tree_entities");
				_currentArea = "worldmap";
			}
			case "farm":
			{
				_map = new FlxOgmoLoader(AssetPaths.farm__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.farm__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_currentArea = "farm";
			}
			case "police":
			{
				_map = new FlxOgmoLoader(AssetPaths.police__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.police_station__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_currentArea = "police";
			}
			case "pond":
			{
				_map = new FlxOgmoLoader(AssetPaths.pond__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.pond__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_map.loadEntities(placeTrees, "tree_entities");
				_currentArea = "pond";
			}
			case "store":
			{
				_map = new FlxOgmoLoader(AssetPaths.grocery__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.grocery_store__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_currentArea = "store";
			}
			case "friend":
			{
				_map = new FlxOgmoLoader(AssetPaths.friend__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.friend_home__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_currentArea = "friend";
			}
			case "school":
			{
				_map = new FlxOgmoLoader(AssetPaths.school__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.school__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_currentArea = "school";
			}
			case "kjrw":
			{
				_map = new FlxOgmoLoader(AssetPaths.kjrw__oel);
				_collisionLayer.remove(_mWalls);
				_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 15, 15, "walls");
				_mWalls.setTileProperties(1, FlxObject.NONE);
				_mWalls.setTileProperties(2, FlxObject.ANY);
				_collisionLayer.add(_mWalls);
				_backdrop.clear();
				_backdrop.add(new flixel.addons.display.FlxBackdrop(AssetPaths.KJRW_quarters__png, 1, 1, false, false ));
				_map.loadEntities(placeEntities, "entities");
				_currentArea = "kjrw";
			}
		}
	}
}