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
import flixel.addons.editors.pex.FlxPexParser;
import flixel.effects.particles.FlxEmitter;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var emitter:FlxEmitter;
	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story campaing', 'arena combat', 'character selector', 'playlist', 'settings', 'quit', 'madness'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	public static var block:Bool = false;

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;
	var menuItem:FlxSprite;
	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.1" + nightly;
	public static var gameVer:String = "0.2.7.1";
	var selector:FlxSprite;
	var selectedSomethin:Bool = false;

	var preference_:Bool = false;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;
    var assCursor:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		if (block)
			optionShit == ['story campaing', 'arena combat', 'character selector', 'playlist block', 'settings', 'quit', 'madness'];
		else
			optionShit == ['story campaing', 'arena combat', 'character selector', 'playlist', 'settings', 'quit', 'madness'];
			

		assCursor = new FlxSprite(0).loadGraphic(Paths.image('cursor', 'madness'));
		assCursor.updateHitbox();
		add(assCursor);

		persistentUpdate = persistentDraw = true;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		var oss:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('mainMenu/bg', 'madness'));
		oss.screenCenter(X);
		oss.scrollFactor.x = 0;
		oss.scrollFactor.y = 0.10;
		oss.y -= 180;
		oss.setGraphicSize(Std.int(oss.width * 1));
		add(oss);

		emitter = new FlxEmitter(FlxG.width / 2, FlxG.height / 2);
		initEmitter();
	    emitter.start(false, 0.01);
		add(emitter);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('mainMenu/options', 'madness');

		for (i in 0...optionShit.length - 3)
		{
			menuItem = new FlxSprite(0, 90);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.y += 330;
			menuItem.updateHitbox();
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scale.set(0.87, 0.87);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			
			if (firstStart)
				FlxTween.tween(menuItem,{y: 140 + (i * 70)},1 + (i * 0.55) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
					}});
			else
				menuItem.y = 140 + (i * 70);
		}

		    var ass = new FlxSprite(20, 170);
			ass.frames = tex;
			ass.animation.addByPrefix('idle', optionShit[6] + " basic", 24);
			ass.animation.addByPrefix('selected', optionShit[6] + " white", 24);
			ass.animation.play('idle');
			ass.ID = 6;
			ass.y += 330;
			ass.updateHitbox();
			// menuItem.screenCenter(X);
			menuItems.add(ass);
			ass.scale.set(0.87, 0.87);
			ass.scrollFactor.set();
			ass.antialiasing = true;

			var a1ss = new FlxSprite(0, 80);
			a1ss.frames = tex;
			a1ss.animation.addByPrefix('idle', optionShit[4] + " basic", 24);
			a1ss.animation.addByPrefix('selected', optionShit[4] + " white", 24);
			a1ss.animation.play('idle');
			a1ss.ID = 4;
			a1ss.updateHitbox();
			a1ss.y = menuItem.y + 60;
			menuItem.screenCenter(X);
			menuItems.add(a1ss);
			a1ss.scale.set(0.87, 0.87);
			a1ss.scrollFactor.set();
			a1ss.antialiasing = true;

			var efe = new FlxSprite(0, 80);
			efe.frames = tex;
			efe.animation.addByPrefix('idle', optionShit[5] + " basic", 24);
			efe.animation.addByPrefix('selected', optionShit[5] + " white", 24);
			efe.animation.play('idle');
			efe.ID = 5;
			efe.updateHitbox();
			efe.y = menuItem.y + 110;
			efe.screenCenter(X);
			menuItems.add(efe);
			efe.scale.set(0.87, 0.87);
			efe.scrollFactor.set();
			efe.antialiasing = true;

		firstStart = false;


		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		super.create();
	}

	function initEmitter(scale:Float = 1):Void
		{
			FlxPexParser.parse("assets/data/particle.pex", Paths.image("texture", 'madness'), emitter, scale);
		}

	override function update(elapsed:Float)
	{
		FlxG.mouse.visible = true;
		emitter.setPosition(FlxG.mouse.x + 40, FlxG.mouse.y + 19);
		FlxG.mouse.load(assCursor.pixels);

		if (FlxG.keys.justPressed.B)
			{
			  block = !block;	
			}
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();

		if (FlxG.mouse.justPressed)
			initEmitter(1.8);
		else if (FlxG.mouse.justReleased)
			initEmitter(0.8);

		if (FlxG.keys.justPressed.SEVEN)
			{
				FlxG.switchState(new ModificatorState());
			}
		if (FlxG.keys.justPressed.SIX)
			{
			}
		if (FlxG.keys.justPressed.FIVE)
			FlxG.switchState(new NickNameState());
		if (FlxG.keys.justPressed.THREE)
			FlxG.switchState(new minigame.Forest());
		if (FlxG.keys.justPressed.FOUR)
			FlxG.switchState(new StageEditor());

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		
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

			if (controls.ACCEPT || FlxG.mouse.justPressed && FlxG.mouse.overlaps(menuItem))
			{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					
					menuItems.forEach(function(spr:FlxSprite)
					{
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
					});
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			if (spr.ID != 6)
			 spr.screenCenter(X);
		});
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];
		
		if (block)
			{
			switch (daChoice)
			{
				case 'story campaing':
					FlxG.switchState(new StoryMenuState());
					trace("Story Menu Selected");
				case 'arena combat':
					FlxG.switchState(new minigame.SwagPlayState());
				case 'playlist':
					FlxG.camera.shake(0.007, 1);
					selectedSomethin = false;
					trace("Freeplay Menu Selected");
				case 'settings':
					FlxG.switchState(new OptionsMenu());
				case 'madness':
					FlxG.switchState(new minigame.Land());
				case 'character selector':
					FlxG.switchState(new CharacterSelector());
				case 'quit':
					#if desktop
					Sys.exit(0);
					#end
	
					throw ("SEE TYOU NEXT TIME!");
	
			}
		}
		else{
		switch (daChoice)
		{
			case 'story campaing':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'arena combat':
				FlxG.switchState(new minigame.SwagPlayState());
			case 'settings':
				FlxG.switchState(new OptionsMenu());
			case 'playlist':
				FlxG.switchState(new FreeplayState());
				trace("Freeplay Menu Selected");
			case 'character selector':
				FlxG.switchState(new CharacterSelector());
			case 'madness':
				FlxG.switchState(new minigame.Land());
			case 'quit':
				#if desktop
				Sys.exit(0);
				#end

				throw ("SEE TYOU NEXT TIME!");
		}
		}
	
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
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
