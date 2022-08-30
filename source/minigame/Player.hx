package minigame;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Player extends FlxSprite
{
 public var flipped:Bool = false;
 public static var instance:Player;
 public var SPEED:Int = 500;
 var jump = FlxG.keys.anyPressed([X, SPACE]);

 public function new(x:Float, y:Float, flipped:Bool = false) {
    super(x, y);
    this.flipped = flipped;

    frames = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
    animation.addByPrefix('idle', 'BF idle dance', 24, false);
    animation.addByPrefix('up', 'BF NOTE UP0', 24, false);
    animation.addByPrefix('move', 'BF NOTE LEFT0', 24, false);
    animation.addByPrefix('down', 'BF NOTE DOWN0', 24, false);

    animation.addByPrefix('attack', 'boyfriend attack', 24);
    animation.addByPrefix('jump', 'boyfriend dodge', 24, false);

		updateHitbox();

    scale.set(0.60, 0.60);

    drag.x = SPEED * 5;
    drag.y = SPEED * 5;
 }    
 public function move() {
    var right = FlxG.keys.anyPressed([RIGHT, D]);
    // if (FlxG.save.data.rightBind != '')
    //     {
    //       right = FlxG.keys.anyPressed([RIGHT, D, FlxG.save.data.rigthBind]);
    //     }
    var left = FlxG.keys.anyPressed([LEFT, A]);
    var up = FlxG.keys.anyPressed([UP, W]);
    var down = FlxG.keys.anyPressed([DOWN, S]);
    var attack = FlxG.mouse.pressed;

    if (attack)
      {
        animation.play('attack', FlxG.random.int(24, 30));
      }
    else if (right || left)
        {
          animation.play('walk');
        }
    else if (up)
        {
          animation.play('up');
        }
    else if (down)
        {
          animation.play('down');
        }
    else
        animation.play('idle');
        {
            setFacingFlip(FlxObject.LEFT, false, false);
			setFacingFlip(FlxObject.RIGHT, true, false);  
        }
    if (right && left || up && down)
        {
           velocity.x = 0;
           velocity.y = 0; 
        }
    else if (right)
        {
          velocity.x = SPEED; 
          facing = FlxObject.RIGHT; 
        }
    else if (left)
        {
          velocity.x = -SPEED;  
          facing = FlxObject.LEFT;
        }
    else if (up)
        {
          velocity.y = -SPEED;  
        }
    else if (down)
        {
           velocity.y = SPEED; 
        }

 }
 public function jumping() {
    if (jump)
        {
          //nothing literally xD
          velocity.y -= 9;
          animation.play('jump');
        }
 }
 override public function update(elapsed:Float) {
    super.update(elapsed);

    move();
    jumping();
 }
}