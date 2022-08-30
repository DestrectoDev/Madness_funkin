import flixel.*;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.filters.BlurFilter;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import flixel.util.*;

class SwagPauseSubState extends MusicBeatSubstate
{
    var pauseGrp:FlxTypedGroup<FlxSprite>;
    var pauseItems:Array<String> = ['resume', 'restart', 'main menu'];
    var pauseItem:FlxSprite;
    
    var camHUD:FlxCamera;

    var pauseBG:FlxSprite;

    var infoTxt:FlxText;

    var curSelected:Int = 0;
    public function new(x:Float, y:Float)
    {
        super();
        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF1E1E1E);
        bg.alpha = 0;
        bg.scrollFactor.set();
        // bg.visible = false;
        add(bg);
        FlxTween.tween(bg, {alpha: 0.5}, 0.4, {ease: FlxEase.quartInOut});

        pauseGrp = new FlxTypedGroup<FlxSprite>();
        add(pauseGrp);

        pauseBG = new FlxSprite(0, 57, Paths.image('pauseImages/pauseBG', 'madness'));
        pauseBG.antialiasing = true;
        pauseBG.screenCenter(X);
        add(pauseBG);

        infoTxt = new FlxText(93, 620, 0, "", 42);
        infoTxt.text += PlayState.SONG.song + ' - [' + CoolUtil.difficultyString() + ']';
        infoTxt.scrollFactor.set();
        infoTxt.setFormat(Paths.font("Agency FB Font.ttf"), 60, FlxColor.RED, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
        infoTxt.updateHitbox();
        add(infoTxt);

        var deathsCounter = new FlxText(infoTxt.x - 10, infoTxt.y - 40, '', 37);
        deathsCounter.text = 'DEATHS: ' + PlayState.deathsNumber;
        deathsCounter.scale.set(1.5, 0.8);
        deathsCounter.antialiasing = true;
        deathsCounter.setFormat(Paths.font('Agency FB Font.ttf'), 37, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
        add(deathsCounter);

        for (i in 0...pauseItems.length)
            {
            pauseItem = new FlxSprite(pauseBG.x + 572, pauseBG.y + 210);
            pauseItem.frames = Paths.getSparrowAtlas('pauseImages/pauseItems', 'madness');
            pauseItem.animation.addByPrefix('idle', pauseItems[i] + " boton", 24);
            pauseItem.animation.addByPrefix('select', pauseItems[i] + " select", 24);
            pauseItem.animation.play('idle');
            pauseItem.ID = i;
            pauseItem.screenCenter(X);
            pauseItem.x = 400 + (i * 130);
            pauseGrp.add(pauseItem);
            }
        changeSection();

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
        

    }
  override public function update(elapsed:Float)
    {
      super.update(elapsed);

      if (FlxG.keys.justPressed.B)
        FlxG.save.data.botplay = !FlxG.save.data.botplay;

      if (controls.UP_P)
        changeSection(-1);
      if (controls.DOWN_P)
        changeSection(1);
      if (controls.ACCEPT)
        {
          switch(pauseItems[curSelected])
          {
            case "resume":
                close();
                PlayState.isPause = false;
            case "restart":
                FlxG.resetState();
            case "main menu":
              PlayState.deathsNumber = 0;
              if (PlayState.isStoryMode)
                FlxG.switchState(new MainMenuState());
              else
                FlxG.switchState(new FreeplayState());
          }  
        }
    }
  public function changeSection(huh:Int = 0)
    {
        curSelected += huh;
        if (curSelected < 0)
            curSelected = pauseItems.length-1;
        if (curSelected >= pauseItems.length)
            curSelected = 0;

        pauseGrp.forEach(function(spr:FlxSprite)
        {
          spr.animation.play('idle');

          if (spr.ID == curSelected)
            spr.animation.play('select');
        });
     
    }
}