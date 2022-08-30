package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;

using StringTools;

class DiffSelectionSubState extends MusicBeatSubstate
{
  var difficultySpr:FlxSprite;
  var difficultyArray:Array<String> = ['hard', 'normal', 'easy'];
  var diffGrp:FlxTypedGroup<FlxSprite>;

  var curSelected:Int = 0;

  override public function create() 
  {
     super.create();

     diffGrp = new FlxTypedGroup<FlxSprite>();
     add(diffGrp);

     var tex = Paths.getSparrowAtlas('mainMenu/dificultySpr', 'madness');

     for (x in 0...difficultyArray.length)
        {
          difficultySpr = new FlxSprite(0, 20);
          difficultySpr.frames = tex;
          difficultySpr.animation.addByPrefix('static', difficultyArray[x] + " static", 24);
          difficultySpr.animation.addByPrefix('selected', difficultyArray[x] + " selected", 24);
          difficultySpr.animation.play('static');
          difficultySpr.screenCenter(X); 
          difficultySpr.y = 40 + (50 * x);
          diffGrp.add(difficultySpr);
        }

  }
  override public function update(aorn:Float)
  {
    super.update(aorn);

    trace(curSelected);

    if (controls.UP_P/* || controls.LEFT_P*/)
        changeItem(-1);
    if (controls.DOWN_P/* || controls.RIGHT_P*/)
        changeItem(1);
    if (controls.ACCEPT)
        {
          switch(difficultyArray[curSelected])  
          {
            case 'hard':
                FlxG.switchState(new StoryMenuState());
          }
        }
  }

  public function changeItem(sus:Int = 0)
  {
     curSelected += sus;      
  
     if (curSelected < 0)
        curSelected = difficultyArray.length - 1;
     if (curSelected >= difficultyArray.length)
        curSelected = 0;
     
     var bullShit:Int = 0;
     diffGrp.forEach(function(spr:FlxSprite)
	{
    
        spr.animation.play('static');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
			}
    });
  }
}

