package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/bedroom.oel", __ASSET__assets_data_bedroom_oel);
		type.set ("assets/data/bedroom.oel", AssetType.TEXT);
		className.set ("assets/data/bedroom_old.oel", __ASSET__assets_data_bedroom_old_oel);
		type.set ("assets/data/bedroom_old.oel", AssetType.TEXT);
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/farm.oel", __ASSET__assets_data_farm_oel);
		type.set ("assets/data/farm.oel", AssetType.TEXT);
		className.set ("assets/data/friend.oel", __ASSET__assets_data_friend_oel);
		type.set ("assets/data/friend.oel", AssetType.TEXT);
		className.set ("assets/data/grocery.oel", __ASSET__assets_data_grocery_oel);
		type.set ("assets/data/grocery.oel", AssetType.TEXT);
		className.set ("assets/data/kjrw.oel", __ASSET__assets_data_kjrw_oel);
		type.set ("assets/data/kjrw.oel", AssetType.TEXT);
		className.set ("assets/data/livingroom.oel", __ASSET__assets_data_livingroom_oel);
		type.set ("assets/data/livingroom.oel", AssetType.TEXT);
		className.set ("assets/data/livingroom_old.oel", __ASSET__assets_data_livingroom_old_oel);
		type.set ("assets/data/livingroom_old.oel", AssetType.TEXT);
		className.set ("assets/data/police.oel", __ASSET__assets_data_police_oel);
		type.set ("assets/data/police.oel", AssetType.TEXT);
		className.set ("assets/data/pond.oel", __ASSET__assets_data_pond_oel);
		type.set ("assets/data/pond.oel", AssetType.TEXT);
		className.set ("assets/data/school.oel", __ASSET__assets_data_school_oel);
		type.set ("assets/data/school.oel", AssetType.TEXT);
		className.set ("assets/data/worldmap.oel", __ASSET__assets_data_worldmap_oel);
		type.set ("assets/data/worldmap.oel", AssetType.TEXT);
		className.set ("assets/data/worldmap_old.oel", __ASSET__assets_data_worldmap_old_oel);
		type.set ("assets/data/worldmap_old.oel", AssetType.TEXT);
		className.set ("assets/images/Afbeelding1.png", __ASSET__assets_images_afbeelding1_png);
		type.set ("assets/images/Afbeelding1.png", AssetType.IMAGE);
		className.set ("assets/images/background_draft.png", __ASSET__assets_images_background_draft_png);
		type.set ("assets/images/background_draft.png", AssetType.IMAGE);
		className.set ("assets/images/bedroom.png", __ASSET__assets_images_bedroom_png);
		type.set ("assets/images/bedroom.png", AssetType.IMAGE);
		className.set ("assets/images/bedroom_old.png", __ASSET__assets_images_bedroom_old_png);
		type.set ("assets/images/bedroom_old.png", AssetType.IMAGE);
		className.set ("assets/images/Catquest_Logo.png", __ASSET__assets_images_catquest_logo_png);
		type.set ("assets/images/Catquest_Logo.png", AssetType.IMAGE);
		className.set ("assets/images/chest+coins.png", __ASSET__assets_images_chest_coins_png);
		type.set ("assets/images/chest+coins.png", AssetType.IMAGE);
		className.set ("assets/images/click.png", __ASSET__assets_images_click_png);
		type.set ("assets/images/click.png", AssetType.IMAGE);
		className.set ("assets/images/controls.png", __ASSET__assets_images_controls_png);
		type.set ("assets/images/controls.png", AssetType.IMAGE);
		className.set ("assets/images/Exclamation_mark.png", __ASSET__assets_images_exclamation_mark_png);
		type.set ("assets/images/Exclamation_mark.png", AssetType.IMAGE);
		className.set ("assets/images/farm.png", __ASSET__assets_images_farm_png);
		type.set ("assets/images/farm.png", AssetType.IMAGE);
		className.set ("assets/images/farm_ext.png", __ASSET__assets_images_farm_ext_png);
		type.set ("assets/images/farm_ext.png", AssetType.IMAGE);
		className.set ("assets/images/fish.png", __ASSET__assets_images_fish_png);
		type.set ("assets/images/fish.png", AssetType.IMAGE);
		className.set ("assets/images/friend-home.png", __ASSET__assets_images_friend_home_png);
		type.set ("assets/images/friend-home.png", AssetType.IMAGE);
		className.set ("assets/images/grocery_store.png", __ASSET__assets_images_grocery_store_png);
		type.set ("assets/images/grocery_store.png", AssetType.IMAGE);
		className.set ("assets/images/Houses_stairs.png", __ASSET__assets_images_houses_stairs_png);
		type.set ("assets/images/Houses_stairs.png", AssetType.IMAGE);
		className.set ("assets/images/hover.png", __ASSET__assets_images_hover_png);
		type.set ("assets/images/hover.png", AssetType.IMAGE);
		className.set ("assets/images/hover_resized.png", __ASSET__assets_images_hover_resized_png);
		type.set ("assets/images/hover_resized.png", AssetType.IMAGE);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/inventory.png", __ASSET__assets_images_inventory_png);
		type.set ("assets/images/inventory.png", AssetType.IMAGE);
		className.set ("assets/images/item1.png", __ASSET__assets_images_item1_png);
		type.set ("assets/images/item1.png", AssetType.IMAGE);
		className.set ("assets/images/item2.png", __ASSET__assets_images_item2_png);
		type.set ("assets/images/item2.png", AssetType.IMAGE);
		className.set ("assets/images/item3.png", __ASSET__assets_images_item3_png);
		type.set ("assets/images/item3.png", AssetType.IMAGE);
		className.set ("assets/images/kerk_ext.png", __ASSET__assets_images_kerk_ext_png);
		type.set ("assets/images/kerk_ext.png", AssetType.IMAGE);
		className.set ("assets/images/KJRW-quarters.png", __ASSET__assets_images_kjrw_quarters_png);
		type.set ("assets/images/KJRW-quarters.png", AssetType.IMAGE);
		className.set ("assets/images/KJRW_Megaphone.png", __ASSET__assets_images_kjrw_megaphone_png);
		type.set ("assets/images/KJRW_Megaphone.png", AssetType.IMAGE);
		className.set ("assets/images/LightBulb.png", __ASSET__assets_images_lightbulb_png);
		type.set ("assets/images/LightBulb.png", AssetType.IMAGE);
		className.set ("assets/images/livingroom.png", __ASSET__assets_images_livingroom_png);
		type.set ("assets/images/livingroom.png", AssetType.IMAGE);
		className.set ("assets/images/livingroom_old.png", __ASSET__assets_images_livingroom_old_png);
		type.set ("assets/images/livingroom_old.png", AssetType.IMAGE);
		className.set ("assets/images/Menu.png", __ASSET__assets_images_menu_png);
		type.set ("assets/images/Menu.png", AssetType.IMAGE);
		className.set ("assets/images/metal_detector.png", __ASSET__assets_images_metal_detector_png);
		type.set ("assets/images/metal_detector.png", AssetType.IMAGE);
		className.set ("assets/images/NPC1_sprite.png", __ASSET__assets_images_npc1_sprite_png);
		type.set ("assets/images/NPC1_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC2_sprite.png", __ASSET__assets_images_npc2_sprite_png);
		type.set ("assets/images/NPC2_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC3_sprite.png", __ASSET__assets_images_npc3_sprite_png);
		type.set ("assets/images/NPC3_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC4_sprite.png", __ASSET__assets_images_npc4_sprite_png);
		type.set ("assets/images/NPC4_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC5_sprite.png", __ASSET__assets_images_npc5_sprite_png);
		type.set ("assets/images/NPC5_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC6_sprite.png", __ASSET__assets_images_npc6_sprite_png);
		type.set ("assets/images/NPC6_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC7_sprite.png", __ASSET__assets_images_npc7_sprite_png);
		type.set ("assets/images/NPC7_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC8_sprite.png", __ASSET__assets_images_npc8_sprite_png);
		type.set ("assets/images/NPC8_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/NPC9_sprite.png", __ASSET__assets_images_npc9_sprite_png);
		type.set ("assets/images/NPC9_sprite.png", AssetType.IMAGE);
		className.set ("assets/images/paper.png", __ASSET__assets_images_paper_png);
		type.set ("assets/images/paper.png", AssetType.IMAGE);
		className.set ("assets/images/pen.png", __ASSET__assets_images_pen_png);
		type.set ("assets/images/pen.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/player_character.png", __ASSET__assets_images_player_character_png);
		type.set ("assets/images/player_character.png", AssetType.IMAGE);
		className.set ("assets/images/police-station.png", __ASSET__assets_images_police_station_png);
		type.set ("assets/images/police-station.png", AssetType.IMAGE);
		className.set ("assets/images/pond.png", __ASSET__assets_images_pond_png);
		type.set ("assets/images/pond.png", AssetType.IMAGE);
		className.set ("assets/images/QuestionMark.png", __ASSET__assets_images_questionmark_png);
		type.set ("assets/images/QuestionMark.png", AssetType.IMAGE);
		className.set ("assets/images/ring.png", __ASSET__assets_images_ring_png);
		type.set ("assets/images/ring.png", AssetType.IMAGE);
		className.set ("assets/images/rod.png", __ASSET__assets_images_rod_png);
		type.set ("assets/images/rod.png", AssetType.IMAGE);
		className.set ("assets/images/school.png", __ASSET__assets_images_school_png);
		type.set ("assets/images/school.png", AssetType.IMAGE);
		className.set ("assets/images/school_ext.png", __ASSET__assets_images_school_ext_png);
		type.set ("assets/images/school_ext.png", AssetType.IMAGE);
		className.set ("assets/images/Small_houses.png", __ASSET__assets_images_small_houses_png);
		type.set ("assets/images/Small_houses.png", AssetType.IMAGE);
		className.set ("assets/images/SpeechBubble.png", __ASSET__assets_images_speechbubble_png);
		type.set ("assets/images/SpeechBubble.png", AssetType.IMAGE);
		className.set ("assets/images/standard.png", __ASSET__assets_images_standard_png);
		type.set ("assets/images/standard.png", AssetType.IMAGE);
		className.set ("assets/images/standard_resized.png", __ASSET__assets_images_standard_resized_png);
		type.set ("assets/images/standard_resized.png", AssetType.IMAGE);
		className.set ("assets/images/text_bubble.png", __ASSET__assets_images_text_bubble_png);
		type.set ("assets/images/text_bubble.png", AssetType.IMAGE);
		className.set ("assets/images/Thumbs_Up_redone.png", __ASSET__assets_images_thumbs_up_redone_png);
		type.set ("assets/images/Thumbs_Up_redone.png", AssetType.IMAGE);
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		className.set ("assets/images/trash.png", __ASSET__assets_images_trash_png);
		type.set ("assets/images/trash.png", AssetType.IMAGE);
		className.set ("assets/images/tree1.png", __ASSET__assets_images_tree1_png);
		type.set ("assets/images/tree1.png", AssetType.IMAGE);
		className.set ("assets/images/tree2.png", __ASSET__assets_images_tree2_png);
		type.set ("assets/images/tree2.png", AssetType.IMAGE);
		className.set ("assets/images/tree3.png", __ASSET__assets_images_tree3_png);
		type.set ("assets/images/tree3.png", AssetType.IMAGE);
		className.set ("assets/images/tree4.png", __ASSET__assets_images_tree4_png);
		type.set ("assets/images/tree4.png", AssetType.IMAGE);
		className.set ("assets/images/Winkel_ext.png", __ASSET__assets_images_winkel_ext_png);
		type.set ("assets/images/Winkel_ext.png", AssetType.IMAGE);
		className.set ("assets/images/world_tiles.png", __ASSET__assets_images_world_tiles_png);
		type.set ("assets/images/world_tiles.png", AssetType.IMAGE);
		className.set ("assets/images/world_tiles_OLD.png", __ASSET__assets_images_world_tiles_old_png);
		type.set ("assets/images/world_tiles_OLD.png", AssetType.IMAGE);
		className.set ("assets/images/worm.png", __ASSET__assets_images_worm_png);
		type.set ("assets/images/worm.png", AssetType.IMAGE);
		className.set ("assets/images/yarn.png", __ASSET__assets_images_yarn_png);
		type.set ("assets/images/yarn.png", AssetType.IMAGE);
		className.set ("assets/music/menu_music.mp3", __ASSET__assets_music_menu_music_mp3);
		type.set ("assets/music/menu_music.mp3", AssetType.MUSIC);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/bird_chirping.mp3", __ASSET__assets_sounds_bird_chirping_mp3);
		type.set ("assets/sounds/bird_chirping.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/click_sound.wav", __ASSET__assets_sounds_click_sound_wav);
		type.set ("assets/sounds/click_sound.wav", AssetType.SOUND);
		className.set ("assets/sounds/crowd_chatter_large_outdoor_event.mp3", __ASSET__assets_sounds_crowd_chatter_large_outdoor_event_mp3);
		type.set ("assets/sounds/crowd_chatter_large_outdoor_event.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/footsteps.mp3", __ASSET__assets_sounds_footsteps_mp3);
		type.set ("assets/sounds/footsteps.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/footstepsLeaves.mp3", __ASSET__assets_sounds_footstepsleaves_mp3);
		type.set ("assets/sounds/footstepsLeaves.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/footsteps_on_forest_pathway_dry_clear_of_debris_001.mp3", __ASSET__assets_sounds_footsteps_on_forest_pathway_dry_clear_of_debris_001_mp3);
		type.set ("assets/sounds/footsteps_on_forest_pathway_dry_clear_of_debris_001.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/nature_ambience_bird_noise_and_river_close_by_version_1_.mp3", __ASSET__assets_sounds_nature_ambience_bird_noise_and_river_close_by_version_1__mp3);
		type.set ("assets/sounds/nature_ambience_bird_noise_and_river_close_by_version_1_.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/river_flowing.mp3", __ASSET__assets_sounds_river_flowing_mp3);
		type.set ("assets/sounds/river_flowing.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/river_sound.mp3", __ASSET__assets_sounds_river_sound_mp3);
		type.set ("assets/sounds/river_sound.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/spider_tarantula_walk_on_leaves.wav", __ASSET__assets_sounds_spider_tarantula_walk_on_leaves_wav);
		type.set ("assets/sounds/spider_tarantula_walk_on_leaves.wav", AssetType.SOUND);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/bedroom.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/bedroom_old.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/farm.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/friend.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/grocery.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/kjrw.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/livingroom.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/livingroom_old.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/police.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/pond.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/school.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/worldmap.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/worldmap_old.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/Afbeelding1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/background_draft.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bedroom.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/bedroom_old.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Catquest_Logo.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/chest+coins.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/click.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/controls.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Exclamation_mark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/farm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/farm_ext.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fish.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/friend-home.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/grocery_store.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Houses_stairs.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hover.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/hover_resized.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/inventory.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/item1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/item2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/item3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/kerk_ext.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/KJRW-quarters.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/KJRW_Megaphone.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/LightBulb.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/livingroom.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/livingroom_old.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Menu.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/metal_detector.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC1_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC2_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC3_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC4_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC5_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC6_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC7_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC8_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/NPC9_sprite.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/paper.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/pen.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player_character.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/police-station.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/pond.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/QuestionMark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ring.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/rod.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/school.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/school_ext.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Small_houses.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/SpeechBubble.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/standard.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/standard_resized.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/text_bubble.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Thumbs_Up_redone.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/trash.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tree1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tree2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tree3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tree4.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Winkel_ext.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/world_tiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/world_tiles_OLD.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/worm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/yarn.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/menu_music.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/bird_chirping.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/click_sound.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/crowd_chatter_large_outdoor_event.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/footsteps.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/footstepsLeaves.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/footsteps_on_forest_pathway_dry_clear_of_debris_001.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/nature_ambience_bird_noise_and_river_close_by_version_1_.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/river_flowing.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/river_sound.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/spider_tarantula_walk_on_leaves.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		
		
		var assetsPrefix = ApplicationMain.config.assetsPrefix;
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/bedroom.oel", __ASSET__assets_data_bedroom_oel);
		type.set ("assets/data/bedroom.oel", AssetType.TEXT);
		
		className.set ("assets/data/bedroom_old.oel", __ASSET__assets_data_bedroom_old_oel);
		type.set ("assets/data/bedroom_old.oel", AssetType.TEXT);
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/farm.oel", __ASSET__assets_data_farm_oel);
		type.set ("assets/data/farm.oel", AssetType.TEXT);
		
		className.set ("assets/data/friend.oel", __ASSET__assets_data_friend_oel);
		type.set ("assets/data/friend.oel", AssetType.TEXT);
		
		className.set ("assets/data/grocery.oel", __ASSET__assets_data_grocery_oel);
		type.set ("assets/data/grocery.oel", AssetType.TEXT);
		
		className.set ("assets/data/kjrw.oel", __ASSET__assets_data_kjrw_oel);
		type.set ("assets/data/kjrw.oel", AssetType.TEXT);
		
		className.set ("assets/data/livingroom.oel", __ASSET__assets_data_livingroom_oel);
		type.set ("assets/data/livingroom.oel", AssetType.TEXT);
		
		className.set ("assets/data/livingroom_old.oel", __ASSET__assets_data_livingroom_old_oel);
		type.set ("assets/data/livingroom_old.oel", AssetType.TEXT);
		
		className.set ("assets/data/police.oel", __ASSET__assets_data_police_oel);
		type.set ("assets/data/police.oel", AssetType.TEXT);
		
		className.set ("assets/data/pond.oel", __ASSET__assets_data_pond_oel);
		type.set ("assets/data/pond.oel", AssetType.TEXT);
		
		className.set ("assets/data/school.oel", __ASSET__assets_data_school_oel);
		type.set ("assets/data/school.oel", AssetType.TEXT);
		
		className.set ("assets/data/worldmap.oel", __ASSET__assets_data_worldmap_oel);
		type.set ("assets/data/worldmap.oel", AssetType.TEXT);
		
		className.set ("assets/data/worldmap_old.oel", __ASSET__assets_data_worldmap_old_oel);
		type.set ("assets/data/worldmap_old.oel", AssetType.TEXT);
		
		className.set ("assets/images/Afbeelding1.png", __ASSET__assets_images_afbeelding1_png);
		type.set ("assets/images/Afbeelding1.png", AssetType.IMAGE);
		
		className.set ("assets/images/background_draft.png", __ASSET__assets_images_background_draft_png);
		type.set ("assets/images/background_draft.png", AssetType.IMAGE);
		
		className.set ("assets/images/bedroom.png", __ASSET__assets_images_bedroom_png);
		type.set ("assets/images/bedroom.png", AssetType.IMAGE);
		
		className.set ("assets/images/bedroom_old.png", __ASSET__assets_images_bedroom_old_png);
		type.set ("assets/images/bedroom_old.png", AssetType.IMAGE);
		
		className.set ("assets/images/Catquest_Logo.png", __ASSET__assets_images_catquest_logo_png);
		type.set ("assets/images/Catquest_Logo.png", AssetType.IMAGE);
		
		className.set ("assets/images/chest+coins.png", __ASSET__assets_images_chest_coins_png);
		type.set ("assets/images/chest+coins.png", AssetType.IMAGE);
		
		className.set ("assets/images/click.png", __ASSET__assets_images_click_png);
		type.set ("assets/images/click.png", AssetType.IMAGE);
		
		className.set ("assets/images/controls.png", __ASSET__assets_images_controls_png);
		type.set ("assets/images/controls.png", AssetType.IMAGE);
		
		className.set ("assets/images/Exclamation_mark.png", __ASSET__assets_images_exclamation_mark_png);
		type.set ("assets/images/Exclamation_mark.png", AssetType.IMAGE);
		
		className.set ("assets/images/farm.png", __ASSET__assets_images_farm_png);
		type.set ("assets/images/farm.png", AssetType.IMAGE);
		
		className.set ("assets/images/farm_ext.png", __ASSET__assets_images_farm_ext_png);
		type.set ("assets/images/farm_ext.png", AssetType.IMAGE);
		
		className.set ("assets/images/fish.png", __ASSET__assets_images_fish_png);
		type.set ("assets/images/fish.png", AssetType.IMAGE);
		
		className.set ("assets/images/friend-home.png", __ASSET__assets_images_friend_home_png);
		type.set ("assets/images/friend-home.png", AssetType.IMAGE);
		
		className.set ("assets/images/grocery_store.png", __ASSET__assets_images_grocery_store_png);
		type.set ("assets/images/grocery_store.png", AssetType.IMAGE);
		
		className.set ("assets/images/Houses_stairs.png", __ASSET__assets_images_houses_stairs_png);
		type.set ("assets/images/Houses_stairs.png", AssetType.IMAGE);
		
		className.set ("assets/images/hover.png", __ASSET__assets_images_hover_png);
		type.set ("assets/images/hover.png", AssetType.IMAGE);
		
		className.set ("assets/images/hover_resized.png", __ASSET__assets_images_hover_resized_png);
		type.set ("assets/images/hover_resized.png", AssetType.IMAGE);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/inventory.png", __ASSET__assets_images_inventory_png);
		type.set ("assets/images/inventory.png", AssetType.IMAGE);
		
		className.set ("assets/images/item1.png", __ASSET__assets_images_item1_png);
		type.set ("assets/images/item1.png", AssetType.IMAGE);
		
		className.set ("assets/images/item2.png", __ASSET__assets_images_item2_png);
		type.set ("assets/images/item2.png", AssetType.IMAGE);
		
		className.set ("assets/images/item3.png", __ASSET__assets_images_item3_png);
		type.set ("assets/images/item3.png", AssetType.IMAGE);
		
		className.set ("assets/images/kerk_ext.png", __ASSET__assets_images_kerk_ext_png);
		type.set ("assets/images/kerk_ext.png", AssetType.IMAGE);
		
		className.set ("assets/images/KJRW-quarters.png", __ASSET__assets_images_kjrw_quarters_png);
		type.set ("assets/images/KJRW-quarters.png", AssetType.IMAGE);
		
		className.set ("assets/images/KJRW_Megaphone.png", __ASSET__assets_images_kjrw_megaphone_png);
		type.set ("assets/images/KJRW_Megaphone.png", AssetType.IMAGE);
		
		className.set ("assets/images/LightBulb.png", __ASSET__assets_images_lightbulb_png);
		type.set ("assets/images/LightBulb.png", AssetType.IMAGE);
		
		className.set ("assets/images/livingroom.png", __ASSET__assets_images_livingroom_png);
		type.set ("assets/images/livingroom.png", AssetType.IMAGE);
		
		className.set ("assets/images/livingroom_old.png", __ASSET__assets_images_livingroom_old_png);
		type.set ("assets/images/livingroom_old.png", AssetType.IMAGE);
		
		className.set ("assets/images/Menu.png", __ASSET__assets_images_menu_png);
		type.set ("assets/images/Menu.png", AssetType.IMAGE);
		
		className.set ("assets/images/metal_detector.png", __ASSET__assets_images_metal_detector_png);
		type.set ("assets/images/metal_detector.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC1_sprite.png", __ASSET__assets_images_npc1_sprite_png);
		type.set ("assets/images/NPC1_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC2_sprite.png", __ASSET__assets_images_npc2_sprite_png);
		type.set ("assets/images/NPC2_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC3_sprite.png", __ASSET__assets_images_npc3_sprite_png);
		type.set ("assets/images/NPC3_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC4_sprite.png", __ASSET__assets_images_npc4_sprite_png);
		type.set ("assets/images/NPC4_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC5_sprite.png", __ASSET__assets_images_npc5_sprite_png);
		type.set ("assets/images/NPC5_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC6_sprite.png", __ASSET__assets_images_npc6_sprite_png);
		type.set ("assets/images/NPC6_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC7_sprite.png", __ASSET__assets_images_npc7_sprite_png);
		type.set ("assets/images/NPC7_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC8_sprite.png", __ASSET__assets_images_npc8_sprite_png);
		type.set ("assets/images/NPC8_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/NPC9_sprite.png", __ASSET__assets_images_npc9_sprite_png);
		type.set ("assets/images/NPC9_sprite.png", AssetType.IMAGE);
		
		className.set ("assets/images/paper.png", __ASSET__assets_images_paper_png);
		type.set ("assets/images/paper.png", AssetType.IMAGE);
		
		className.set ("assets/images/pen.png", __ASSET__assets_images_pen_png);
		type.set ("assets/images/pen.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/player_character.png", __ASSET__assets_images_player_character_png);
		type.set ("assets/images/player_character.png", AssetType.IMAGE);
		
		className.set ("assets/images/police-station.png", __ASSET__assets_images_police_station_png);
		type.set ("assets/images/police-station.png", AssetType.IMAGE);
		
		className.set ("assets/images/pond.png", __ASSET__assets_images_pond_png);
		type.set ("assets/images/pond.png", AssetType.IMAGE);
		
		className.set ("assets/images/QuestionMark.png", __ASSET__assets_images_questionmark_png);
		type.set ("assets/images/QuestionMark.png", AssetType.IMAGE);
		
		className.set ("assets/images/ring.png", __ASSET__assets_images_ring_png);
		type.set ("assets/images/ring.png", AssetType.IMAGE);
		
		className.set ("assets/images/rod.png", __ASSET__assets_images_rod_png);
		type.set ("assets/images/rod.png", AssetType.IMAGE);
		
		className.set ("assets/images/school.png", __ASSET__assets_images_school_png);
		type.set ("assets/images/school.png", AssetType.IMAGE);
		
		className.set ("assets/images/school_ext.png", __ASSET__assets_images_school_ext_png);
		type.set ("assets/images/school_ext.png", AssetType.IMAGE);
		
		className.set ("assets/images/Small_houses.png", __ASSET__assets_images_small_houses_png);
		type.set ("assets/images/Small_houses.png", AssetType.IMAGE);
		
		className.set ("assets/images/SpeechBubble.png", __ASSET__assets_images_speechbubble_png);
		type.set ("assets/images/SpeechBubble.png", AssetType.IMAGE);
		
		className.set ("assets/images/standard.png", __ASSET__assets_images_standard_png);
		type.set ("assets/images/standard.png", AssetType.IMAGE);
		
		className.set ("assets/images/standard_resized.png", __ASSET__assets_images_standard_resized_png);
		type.set ("assets/images/standard_resized.png", AssetType.IMAGE);
		
		className.set ("assets/images/text_bubble.png", __ASSET__assets_images_text_bubble_png);
		type.set ("assets/images/text_bubble.png", AssetType.IMAGE);
		
		className.set ("assets/images/Thumbs_Up_redone.png", __ASSET__assets_images_thumbs_up_redone_png);
		type.set ("assets/images/Thumbs_Up_redone.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		
		className.set ("assets/images/trash.png", __ASSET__assets_images_trash_png);
		type.set ("assets/images/trash.png", AssetType.IMAGE);
		
		className.set ("assets/images/tree1.png", __ASSET__assets_images_tree1_png);
		type.set ("assets/images/tree1.png", AssetType.IMAGE);
		
		className.set ("assets/images/tree2.png", __ASSET__assets_images_tree2_png);
		type.set ("assets/images/tree2.png", AssetType.IMAGE);
		
		className.set ("assets/images/tree3.png", __ASSET__assets_images_tree3_png);
		type.set ("assets/images/tree3.png", AssetType.IMAGE);
		
		className.set ("assets/images/tree4.png", __ASSET__assets_images_tree4_png);
		type.set ("assets/images/tree4.png", AssetType.IMAGE);
		
		className.set ("assets/images/Winkel_ext.png", __ASSET__assets_images_winkel_ext_png);
		type.set ("assets/images/Winkel_ext.png", AssetType.IMAGE);
		
		className.set ("assets/images/world_tiles.png", __ASSET__assets_images_world_tiles_png);
		type.set ("assets/images/world_tiles.png", AssetType.IMAGE);
		
		className.set ("assets/images/world_tiles_OLD.png", __ASSET__assets_images_world_tiles_old_png);
		type.set ("assets/images/world_tiles_OLD.png", AssetType.IMAGE);
		
		className.set ("assets/images/worm.png", __ASSET__assets_images_worm_png);
		type.set ("assets/images/worm.png", AssetType.IMAGE);
		
		className.set ("assets/images/yarn.png", __ASSET__assets_images_yarn_png);
		type.set ("assets/images/yarn.png", AssetType.IMAGE);
		
		className.set ("assets/music/menu_music.mp3", __ASSET__assets_music_menu_music_mp3);
		type.set ("assets/music/menu_music.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/bird_chirping.mp3", __ASSET__assets_sounds_bird_chirping_mp3);
		type.set ("assets/sounds/bird_chirping.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/click_sound.wav", __ASSET__assets_sounds_click_sound_wav);
		type.set ("assets/sounds/click_sound.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/crowd_chatter_large_outdoor_event.mp3", __ASSET__assets_sounds_crowd_chatter_large_outdoor_event_mp3);
		type.set ("assets/sounds/crowd_chatter_large_outdoor_event.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/footsteps.mp3", __ASSET__assets_sounds_footsteps_mp3);
		type.set ("assets/sounds/footsteps.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/footstepsLeaves.mp3", __ASSET__assets_sounds_footstepsleaves_mp3);
		type.set ("assets/sounds/footstepsLeaves.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/footsteps_on_forest_pathway_dry_clear_of_debris_001.mp3", __ASSET__assets_sounds_footsteps_on_forest_pathway_dry_clear_of_debris_001_mp3);
		type.set ("assets/sounds/footsteps_on_forest_pathway_dry_clear_of_debris_001.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/nature_ambience_bird_noise_and_river_close_by_version_1_.mp3", __ASSET__assets_sounds_nature_ambience_bird_noise_and_river_close_by_version_1__mp3);
		type.set ("assets/sounds/nature_ambience_bird_noise_and_river_close_by_version_1_.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/river_flowing.mp3", __ASSET__assets_sounds_river_flowing_mp3);
		type.set ("assets/sounds/river_flowing.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/river_sound.mp3", __ASSET__assets_sounds_river_sound_mp3);
		type.set ("assets/sounds/river_sound.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/spider_tarantula_walk_on_leaves.wav", __ASSET__assets_sounds_spider_tarantula_walk_on_leaves_wav);
		type.set ("assets/sounds/spider_tarantula_walk_on_leaves.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash)
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				handler (audioBuffer);
				
			});
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			handler (getAudioBuffer (id));
			
		}
		#else
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || html5)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_bedroom_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_bedroom_old_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_farm_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_friend_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_grocery_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_kjrw_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_livingroom_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_livingroom_old_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_police_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_pond_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_school_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_worldmap_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_worldmap_old_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_afbeelding1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_background_draft_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bedroom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bedroom_old_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_catquest_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_chest_coins_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_click_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_controls_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_exclamation_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_farm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_farm_ext_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_fish_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_friend_home_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_grocery_store_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_houses_stairs_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hover_resized_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_inventory_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_item1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_item2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_item3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_kerk_ext_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_kjrw_quarters_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_kjrw_megaphone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_lightbulb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_livingroom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_livingroom_old_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_metal_detector_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc1_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc2_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc3_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc4_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc5_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc6_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc7_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc8_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_npc9_sprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_paper_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_character_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_police_station_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pond_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_questionmark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ring_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rod_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_school_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_school_ext_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_small_houses_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_speechbubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_standard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_standard_resized_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_text_bubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_thumbs_up_redone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_trash_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tree1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tree2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tree3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tree4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_winkel_ext_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_world_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_world_tiles_old_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_worm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_yarn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_menu_music_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_bird_chirping_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_click_sound_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_crowd_chatter_large_outdoor_event_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_footsteps_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_footstepsleaves_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_footsteps_on_forest_pathway_dry_clear_of_debris_001_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_nature_ambience_bird_noise_and_river_close_by_version_1__mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_river_flowing_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_river_sound_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_spider_tarantula_walk_on_leaves_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5



































































































#else



#if (windows || mac || linux)


@:file("assets/data/bedroom.oel") #if display private #end class __ASSET__assets_data_bedroom_oel extends lime.utils.ByteArray {}
@:file("assets/data/bedroom_old.oel") #if display private #end class __ASSET__assets_data_bedroom_old_oel extends lime.utils.ByteArray {}
@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/data/farm.oel") #if display private #end class __ASSET__assets_data_farm_oel extends lime.utils.ByteArray {}
@:file("assets/data/friend.oel") #if display private #end class __ASSET__assets_data_friend_oel extends lime.utils.ByteArray {}
@:file("assets/data/grocery.oel") #if display private #end class __ASSET__assets_data_grocery_oel extends lime.utils.ByteArray {}
@:file("assets/data/kjrw.oel") #if display private #end class __ASSET__assets_data_kjrw_oel extends lime.utils.ByteArray {}
@:file("assets/data/livingroom.oel") #if display private #end class __ASSET__assets_data_livingroom_oel extends lime.utils.ByteArray {}
@:file("assets/data/livingroom_old.oel") #if display private #end class __ASSET__assets_data_livingroom_old_oel extends lime.utils.ByteArray {}
@:file("assets/data/police.oel") #if display private #end class __ASSET__assets_data_police_oel extends lime.utils.ByteArray {}
@:file("assets/data/pond.oel") #if display private #end class __ASSET__assets_data_pond_oel extends lime.utils.ByteArray {}
@:file("assets/data/school.oel") #if display private #end class __ASSET__assets_data_school_oel extends lime.utils.ByteArray {}
@:file("assets/data/worldmap.oel") #if display private #end class __ASSET__assets_data_worldmap_oel extends lime.utils.ByteArray {}
@:file("assets/data/worldmap_old.oel") #if display private #end class __ASSET__assets_data_worldmap_old_oel extends lime.utils.ByteArray {}
@:image("assets/images/Afbeelding1.png") #if display private #end class __ASSET__assets_images_afbeelding1_png extends lime.graphics.Image {}
@:image("assets/images/background_draft.png") #if display private #end class __ASSET__assets_images_background_draft_png extends lime.graphics.Image {}
@:image("assets/images/bedroom.png") #if display private #end class __ASSET__assets_images_bedroom_png extends lime.graphics.Image {}
@:image("assets/images/bedroom_old.png") #if display private #end class __ASSET__assets_images_bedroom_old_png extends lime.graphics.Image {}
@:image("assets/images/Catquest_Logo.png") #if display private #end class __ASSET__assets_images_catquest_logo_png extends lime.graphics.Image {}
@:image("assets/images/chest+coins.png") #if display private #end class __ASSET__assets_images_chest_coins_png extends lime.graphics.Image {}
@:image("assets/images/click.png") #if display private #end class __ASSET__assets_images_click_png extends lime.graphics.Image {}
@:image("assets/images/controls.png") #if display private #end class __ASSET__assets_images_controls_png extends lime.graphics.Image {}
@:image("assets/images/Exclamation_mark.png") #if display private #end class __ASSET__assets_images_exclamation_mark_png extends lime.graphics.Image {}
@:image("assets/images/farm.png") #if display private #end class __ASSET__assets_images_farm_png extends lime.graphics.Image {}
@:image("assets/images/farm_ext.png") #if display private #end class __ASSET__assets_images_farm_ext_png extends lime.graphics.Image {}
@:image("assets/images/fish.png") #if display private #end class __ASSET__assets_images_fish_png extends lime.graphics.Image {}
@:image("assets/images/friend-home.png") #if display private #end class __ASSET__assets_images_friend_home_png extends lime.graphics.Image {}
@:image("assets/images/grocery_store.png") #if display private #end class __ASSET__assets_images_grocery_store_png extends lime.graphics.Image {}
@:image("assets/images/Houses_stairs.png") #if display private #end class __ASSET__assets_images_houses_stairs_png extends lime.graphics.Image {}
@:image("assets/images/hover.png") #if display private #end class __ASSET__assets_images_hover_png extends lime.graphics.Image {}
@:image("assets/images/hover_resized.png") #if display private #end class __ASSET__assets_images_hover_resized_png extends lime.graphics.Image {}
@:file("assets/images/images-go-here.txt") #if display private #end class __ASSET__assets_images_images_go_here_txt extends lime.utils.ByteArray {}
@:image("assets/images/inventory.png") #if display private #end class __ASSET__assets_images_inventory_png extends lime.graphics.Image {}
@:image("assets/images/item1.png") #if display private #end class __ASSET__assets_images_item1_png extends lime.graphics.Image {}
@:image("assets/images/item2.png") #if display private #end class __ASSET__assets_images_item2_png extends lime.graphics.Image {}
@:image("assets/images/item3.png") #if display private #end class __ASSET__assets_images_item3_png extends lime.graphics.Image {}
@:image("assets/images/kerk_ext.png") #if display private #end class __ASSET__assets_images_kerk_ext_png extends lime.graphics.Image {}
@:image("assets/images/KJRW-quarters.png") #if display private #end class __ASSET__assets_images_kjrw_quarters_png extends lime.graphics.Image {}
@:image("assets/images/KJRW_Megaphone.png") #if display private #end class __ASSET__assets_images_kjrw_megaphone_png extends lime.graphics.Image {}
@:image("assets/images/LightBulb.png") #if display private #end class __ASSET__assets_images_lightbulb_png extends lime.graphics.Image {}
@:image("assets/images/livingroom.png") #if display private #end class __ASSET__assets_images_livingroom_png extends lime.graphics.Image {}
@:image("assets/images/livingroom_old.png") #if display private #end class __ASSET__assets_images_livingroom_old_png extends lime.graphics.Image {}
@:image("assets/images/Menu.png") #if display private #end class __ASSET__assets_images_menu_png extends lime.graphics.Image {}
@:image("assets/images/metal_detector.png") #if display private #end class __ASSET__assets_images_metal_detector_png extends lime.graphics.Image {}
@:image("assets/images/NPC1_sprite.png") #if display private #end class __ASSET__assets_images_npc1_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC2_sprite.png") #if display private #end class __ASSET__assets_images_npc2_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC3_sprite.png") #if display private #end class __ASSET__assets_images_npc3_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC4_sprite.png") #if display private #end class __ASSET__assets_images_npc4_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC5_sprite.png") #if display private #end class __ASSET__assets_images_npc5_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC6_sprite.png") #if display private #end class __ASSET__assets_images_npc6_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC7_sprite.png") #if display private #end class __ASSET__assets_images_npc7_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC8_sprite.png") #if display private #end class __ASSET__assets_images_npc8_sprite_png extends lime.graphics.Image {}
@:image("assets/images/NPC9_sprite.png") #if display private #end class __ASSET__assets_images_npc9_sprite_png extends lime.graphics.Image {}
@:image("assets/images/paper.png") #if display private #end class __ASSET__assets_images_paper_png extends lime.graphics.Image {}
@:image("assets/images/pen.png") #if display private #end class __ASSET__assets_images_pen_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:image("assets/images/player_character.png") #if display private #end class __ASSET__assets_images_player_character_png extends lime.graphics.Image {}
@:image("assets/images/police-station.png") #if display private #end class __ASSET__assets_images_police_station_png extends lime.graphics.Image {}
@:image("assets/images/pond.png") #if display private #end class __ASSET__assets_images_pond_png extends lime.graphics.Image {}
@:image("assets/images/QuestionMark.png") #if display private #end class __ASSET__assets_images_questionmark_png extends lime.graphics.Image {}
@:image("assets/images/ring.png") #if display private #end class __ASSET__assets_images_ring_png extends lime.graphics.Image {}
@:image("assets/images/rod.png") #if display private #end class __ASSET__assets_images_rod_png extends lime.graphics.Image {}
@:image("assets/images/school.png") #if display private #end class __ASSET__assets_images_school_png extends lime.graphics.Image {}
@:image("assets/images/school_ext.png") #if display private #end class __ASSET__assets_images_school_ext_png extends lime.graphics.Image {}
@:image("assets/images/Small_houses.png") #if display private #end class __ASSET__assets_images_small_houses_png extends lime.graphics.Image {}
@:image("assets/images/SpeechBubble.png") #if display private #end class __ASSET__assets_images_speechbubble_png extends lime.graphics.Image {}
@:image("assets/images/standard.png") #if display private #end class __ASSET__assets_images_standard_png extends lime.graphics.Image {}
@:image("assets/images/standard_resized.png") #if display private #end class __ASSET__assets_images_standard_resized_png extends lime.graphics.Image {}
@:image("assets/images/text_bubble.png") #if display private #end class __ASSET__assets_images_text_bubble_png extends lime.graphics.Image {}
@:image("assets/images/Thumbs_Up_redone.png") #if display private #end class __ASSET__assets_images_thumbs_up_redone_png extends lime.graphics.Image {}
@:image("assets/images/tiles.png") #if display private #end class __ASSET__assets_images_tiles_png extends lime.graphics.Image {}
@:image("assets/images/trash.png") #if display private #end class __ASSET__assets_images_trash_png extends lime.graphics.Image {}
@:image("assets/images/tree1.png") #if display private #end class __ASSET__assets_images_tree1_png extends lime.graphics.Image {}
@:image("assets/images/tree2.png") #if display private #end class __ASSET__assets_images_tree2_png extends lime.graphics.Image {}
@:image("assets/images/tree3.png") #if display private #end class __ASSET__assets_images_tree3_png extends lime.graphics.Image {}
@:image("assets/images/tree4.png") #if display private #end class __ASSET__assets_images_tree4_png extends lime.graphics.Image {}
@:image("assets/images/Winkel_ext.png") #if display private #end class __ASSET__assets_images_winkel_ext_png extends lime.graphics.Image {}
@:image("assets/images/world_tiles.png") #if display private #end class __ASSET__assets_images_world_tiles_png extends lime.graphics.Image {}
@:image("assets/images/world_tiles_OLD.png") #if display private #end class __ASSET__assets_images_world_tiles_old_png extends lime.graphics.Image {}
@:image("assets/images/worm.png") #if display private #end class __ASSET__assets_images_worm_png extends lime.graphics.Image {}
@:image("assets/images/yarn.png") #if display private #end class __ASSET__assets_images_yarn_png extends lime.graphics.Image {}
@:file("assets/music/menu_music.mp3") #if display private #end class __ASSET__assets_music_menu_music_mp3 extends lime.utils.ByteArray {}
@:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/sounds/bird_chirping.mp3") #if display private #end class __ASSET__assets_sounds_bird_chirping_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/click_sound.wav") #if display private #end class __ASSET__assets_sounds_click_sound_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/crowd_chatter_large_outdoor_event.mp3") #if display private #end class __ASSET__assets_sounds_crowd_chatter_large_outdoor_event_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/footsteps.mp3") #if display private #end class __ASSET__assets_sounds_footsteps_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/footstepsLeaves.mp3") #if display private #end class __ASSET__assets_sounds_footstepsleaves_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/footsteps_on_forest_pathway_dry_clear_of_debris_001.mp3") #if display private #end class __ASSET__assets_sounds_footsteps_on_forest_pathway_dry_clear_of_debris_001_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/nature_ambience_bird_noise_and_river_close_by_version_1_.mp3") #if display private #end class __ASSET__assets_sounds_nature_ambience_bird_noise_and_river_close_by_version_1__mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/river_flowing.mp3") #if display private #end class __ASSET__assets_sounds_river_flowing_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/river_sound.mp3") #if display private #end class __ASSET__assets_sounds_river_sound_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.ByteArray {}
@:file("assets/sounds/spider_tarantula_walk_on_leaves.wav") #if display private #end class __ASSET__assets_sounds_spider_tarantula_walk_on_leaves_wav extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/3,3,8/assets/sounds/beep.mp3") #if display private #end class __ASSET__assets_sounds_beep_mp3 extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/3,3,8/assets/sounds/flixel.mp3") #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends lime.utils.ByteArray {}



#end

#if openfl

#end

#end
#end

