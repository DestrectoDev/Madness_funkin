package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class OldMenu extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story campaing', 'arena combat', 'character selector', 'playlist', 'settings', 'quit'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;


	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.1" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;
    
	public static var mode:Bool = true;
	var oss:FlxSprite;
	var hovered:Int = 0;
	// menu shit
	var story:FlxSprite;
	var arena:FlxSprite;
	var fefe:FlxSprite;
	var char:FlxSprite;
	var playlist:FlxSprite;
	var settings:FlxSprite;
	var quit:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('MENU_102_bpm'));
		}

		quit = new FlxSprite(Paths.image('cursor', 'madness'));
		quit.x = 300000;
		add(quit);

		persistentUpdate = persistentDraw = true;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		
		oss = new FlxSprite(0, 0).loadGraphic(Paths.image('mainMenu/bg', 'madness'));
		oss.scrollFactor.x = 0;
		oss.scrollFactor.y = 0.10;
		oss.y -= 186;
		oss.x -= 52;
		oss.updateHitbox();
		oss.scale.set(0.95,0.95);
		oss.antialiasing = true;
		add(oss);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('mainMenu/options', 'madness');

		for (i in 0...optionShit.length)
		{
			menuItem = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			menuItem.y = 60 + (i * 45);
			menuItem.scale.set(0.96,0.96);
			switch (menuItem.ID)
			{
			  case 5:	
				menuItem.y = menuItem.y + 55 + (i * 10); 
			  case 6:
				menuItem.y = menuItem.y + 40 + (i * 10);
			}
		}

		firstStart = false;
	// if (mode)
	// 	{
	// 	var de = Paths.getSparrowAtlas('mainMenu/options', 'madness');

	// 	story =  new FlxSprite(0, 0);
	// 	story.frames = de;
	// 	story.animation.addByPrefix('idle', 'story campaing basic', 24);
	// 	story.animation.addByPrefix('select', 'story campaing white', 24);
	// 	story.updateHitbox();
	// 	story.scrollFactor.set();
	// 	story.screenCenter(X);
	// 	add(story);
  
	// 	arena =new FlxSprite(0, 50);
	// 	arena.frames = de;
	// 	arena.animation.addByPrefix('idle', 'arena combat basic', 24);
	// 	arena.animation.addByPrefix('select', 'arena combat basic', 24);
	// 	arena.scrollFactor.set();
	// 	arena.updateHitbox();
	// 	arena.screenCenter(X);
	// 	add(arena);
		
	// 	char = new FlxSprite(0, 100);
	// 	char.frames = de;
	// 	char.animation.addByPrefix('idle', 'character selector basic', 24);
	// 	char.animation.addByPrefix('select', 'character selector white', 24);
	// 	char.updateHitbox();
	// 	char.scrollFactor.set();
	// 	char.screenCenter(X);
  
	// 	add(char);
  
	// 	playlist = new FlxSprite(0, 150);
	// 	playlist.frames = de;
	// 	playlist.animation.addByPrefix('idle', 'playlist basic', 24);
	// 	playlist.animation.addByPrefix('select', 'playlist white', 24);
	// 	playlist.animation.addByPrefix('block', 'playlist block basic', 24);
	// 	playlist.animation.addByPrefix('no bitches', 'playlist block white');
	// 	playlist.updateHitbox();
	// 	playlist.scrollFactor.set();
	// 	playlist.screenCenter(X);
  
	// 	add(playlist);
  
	// 	settings = new FlxSprite(0, 200);
	// 	settings.frames = de;
	// 	settings.animation.addByPrefix('idle', 'settings basic', 24);
	// 	settings.animation.addByPrefix('select', 'settings white', 24);
	// 	settings.updateHitbox();
	// 	settings.scrollFactor.set();
	// 	settings.screenCenter(X);
	// 	add(settings);
		
	// 	quit = new FlxSprite(0, 260);
	// 	quit.frames = de;
	// 	quit.animation.addByPrefix('idle', 'quit basic', 24);
	// 	quit.animation.addByPrefix('select', 'quit white', 24);
	// 	quit.updateHitbox();
	// 	quit.scrollFactor.set();
	// 	quit.screenCenter(X);
	// 	add(quit);
	// 	}
	// 	FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;
    var menuItem:FlxSprite;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		FlxG.mouse.visible = true;
		FlxG.mouse.load(quit.pixels);

		trace ('imagen de atras [' + oss.x + ', ', oss.y + ']');

		if (FlxG.keys.justPressed.SEVEN)
			{
				FlxG.switchState(new ModificatorState());
			}
		if (FlxG.keys.justPressed.SIX)
			{
			 FlxG.switchState(new minigame.SwagPlayState());
			}
		if (FlxG.keys.justPressed.FIVE)
			FlxG.switchState(new NickNameState());
		if (FlxG.keys.justPressed.THREE)
			FlxG.switchState(new minigame.Forest());
		if (FlxG.keys.justPressed.TWO)
		    FlxG.switchState(new minigame.Land());
		if (FlxG.keys.justPressed.FOUR)
			FlxG.switchState(new StageEditor());
		if (FlxG.keys.justPressed.ALT)
			 mode = !mode;

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT|| (FlxG.mouse.overlaps(menuItem) && FlxG.mouse.justPressed))
			{
				if (optionShit[curSelected] == 'donate')
				{
					fancyOpenURL("https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (FlxG.save.data.flashing)
						FlxG.camera.flash(FlxColor.RED, 0.5);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		 

			if (FlxG.mouse.overlaps(spr))
				hovered = (spr.ID);
			  if (spr.ID == (hovered))
			  spr.animation.play('selected');
		 	 else
			  spr.animation.play('idle');
		
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (hovered)
		{
		  case 0:
		  FlxG.state.openSubState(new DiffSelectionSubState());
		  trace("Story Menu Selected");
		  case 1:
		  case 2:
		  case 3:
			FlxG.switchState(new FreeplayState());

			trace("Freeplay Menu Selected");
		  case 4:
			FlxG.switchState(new OptionsMenu());
		  case 5:
		  case 6:	
		}
		switch (daChoice)
		{
			case 'story campaing':
				FlxG.state.openSubState(new DiffSelectionSubState());
				trace("Story Menu Selected");
			case 'playlist':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'settings':
				FlxG.switchState(new OptionsMenu());
			case 'quit':
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
			if (curSelected >= menuItems.length)
				curSelected = 0;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
