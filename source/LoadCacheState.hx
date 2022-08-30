import flixel.*;
import flixel.util.*;
class LoadCacheState extends MusicBeatState
{
  var key = FlxG.keys;  

  var loadSpr:FlxSprite;
  var blockAss:Bool = false;

  var randomLoading:Array<String> = ['loadTest', 'loadOne'];
  var loadScreen:FlxSprite;
  override public function create()  
    {
        loadScreen = new FlxSprite(0, 0, Paths.image('loadingScreen/' + randomLoading[FlxG.random.int(0, 1)], 'madness'));
        // loadScreen.screenCenter();
        loadScreen.alpha = 0;
        loadScreen.scale.set(0.5, 0.5);
        add(loadScreen);

      loadSpr = new FlxSprite(0, 20);
      loadSpr.frames = Paths.getSparrowAtlas('loadingScreen/madnessloading', 'madness');
      loadSpr.animation.addByPrefix('static', 'loadingStatic', 24);
      loadSpr.animation.addByPrefix('load', 'loadingAnimationDone', 24);
      loadSpr.animation.addByPrefix('complete', 'complete anim', 24);
      loadSpr.animation.play('static');
      add(loadSpr);

      new FlxTimer().start(0.5, function(tmr:FlxTimer)
        {
         loadSpr.animation.play('load');
         loadSpr.animation.finishCallback = function(name) loadSpr.animation.play('complete');
        });
      blockAss = false;
    }
    var scaleP:Float = 0.75;
override public function update(elapsed:Float)
    {
      super.update(elapsed);
      if (scaleP <= 5)
		scaleP += elapsed / 5;
	    
		loadScreen.alpha += elapsed;
	    
		loadScreen.scale.set(scaleP, scaleP);

      if (key.justPressed.ENTER)
        {
         blockAss = !blockAss;       
        }
      
        onLoad(blockAss);
    }
 public function onLoad(block:Bool = false)
    {
    if (FlxG.sound.music != null)
      FlxG.sound.music.stop();
    if (block)
        LoadingState.loadAndSwitchState(new PlayState(), true);
    }
}