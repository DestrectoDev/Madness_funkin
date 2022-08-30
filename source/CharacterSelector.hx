import flixel.*;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.*;
import flixel.text.FlxText;

class CharacterSelector extends MusicBeatState{
    var char:Character;
    var charGrp:FlxTypedGroup<Character>;
    public static var charName:Array<String> = ['bf', 'moai', 'pico'];

    public static var charValue:String = 'moai';

    public static var curSelected:Int = 0;

    var bar:FlxSprite;
    var colorBar:FlxColor; 

    var arrowR:FlxSprite;
    var arrowL:FlxSprite;

    var healthIcon:HealthIcon;
    var iconGrp:FlxTypedGroup<HealthIcon>;
    override public function create()
        {

         var bg = new FlxSprite(0, 8, Paths.image('charSelector/characterBG', 'madness'));
         bg.screenCenter();
         add(bg);

         charGrp = new FlxTypedGroup<Character>();
         add(charGrp);

         iconGrp = new FlxTypedGroup<HealthIcon>();
         add(iconGrp);
  
         bar = new FlxSprite(FlxG.width + 40, FlxG.height / 2);
         add(bar);

         for (i in 0...charName.length)
            {
              char = new Character(20, 80, charName[i], true);
              char.ID = i;
              charGrp.add(char);

              healthIcon = new HealthIcon(charName[i], true, char.animIcon);
              healthIcon.ID = i;
              iconGrp.add(healthIcon);
            }
        bar.color = char.iconColor;
        
        healthIcon.x = bar.width / 3;
        healthIcon.y = bar.height / 2;

         var tex = Paths.getSparrowAtlas('charSelector/arrowSelectors', 'madness');
         arrowR = new FlxSprite(char.x - 20, char.y);
         arrowR.frames = tex;
         arrowR.animation.addByPrefix('static', 'arrowR instancia ', 24);
         arrowR.animation.addByPrefix('pressed', 'pressedR instancia ', 24);
         arrowR.animation.play('static');
         arrowR.updateHitbox();
         arrowR.antialiasing = true;
         add(arrowR);

         arrowL = new FlxSprite(arrowR.x + 80, arrowR.y);
         arrowL.frames = tex;
         arrowL.animation.addByPrefix('static', 'arrowL instancia ', 24);
         arrowL.animation.addByPrefix('pressed', 'pressedL instancia ', 24);
         arrowL.animation.play('static');
         arrowL.updateHitbox();
         arrowL.antialiasing = true;
         add(arrowL);
         changeChar();
        }
    override public function update(elapsed:Float)
        {
         super.update(elapsed);

         var leftP = controls.LEFT_P;
         var left = controls.LEFT;
         var leftR = controls.LEFT_R;
         var upP = controls.LEFT_P;
         var up = controls.LEFT;
         var upR = controls.LEFT_R;
         var downP = controls.LEFT_P;
         var down = controls.LEFT;
         var downR = controls.LEFT_R;
         var rightP = controls.LEFT_P;
         var right = controls.LEFT;
         var rightR = controls.LEFT_R;
        
         
        if (right){
          arrowR.animation.play('press');
        } if (rightR){
          arrowR.animation.play('static');
        }

        if(left){
            arrowL.animation.play('press');
        } if (leftR){
            arrowL.animation.play('static');
        }

        if (controls.LEFT_P)
            changeChar(-1);
        if (controls.RIGHT_P)
            changeChar(1);

        if (controls.ACCEPT)
            {
            //   trace(charName[curSelected]);
              trace(charName[FlxG.save.data.curSelected]);

              charName[curSelected];

              FlxG.save.data.charValue = charName[FlxG.save.data.curSelected];
              new FlxTimer().start(1, function(name:FlxTimer)
                {
                 FlxG.switchState(new MainMenuState());
                });
            }
         
          

         if (controls.BACK)
            {
             FlxG.switchState(new MainMenuState());
            }
        }
    public function changeChar(change:Int = 0)
    {
        FlxG.save.data.curSelected += change;
        
        if (FlxG.save.data.curSelected < 0)
            FlxG.save.data.curSelected = charName.length - 1;
        if (FlxG.save.data.curSelected >= charName.length)
            FlxG.save.data.curSelected = 0;

        for (item in charGrp.members)
        {
            item.visible = false;
            if (item.ID == FlxG.save.data.curSelected) 
            {
                item.visible = true;  
            }
        }
    }
}