package minigame;

import flixel.*;

class Hank extends FlxSprite
{ 
  public static var SPEED:Int = 500;
  public static var GRAVITY:Int = 400;
  
  public static var instance:Hank;

  var hand:FlxSprite;

  public function new (x:Float, y:Float)
  {
    super(x, y);

    drag.x = SPEED * 5;

    frames = Paths.getSparrowAtlas('justGame/hank_FNF_Sprites', 'madness');
    animation.addByPrefix('idle', 'hank idle', 24);
    animation.addByPrefix('walk', 'hank walk', 24);
    // animation.addByPrefix('death', 'hank dead');
    // animation.addByPrefix('jump', 'hank jump', 24);
    // animation.addByPrefix('dobleJump', 'hank doble jump', 24);
    // animation.addByPrefix('attack 1', 'hank attack 1', 24);
    // animation.addByPrefix('attack 2', 'hank attack 2', 24);
    // animation.addByPrefix('attack jump', 'hank attack jump');
    // animation.addByPrefix('shoot', 'hank shootin', 24);

    updateHitbox();
    scale.set(0.40, 0.40);

    antialiasing = true;
  }

 public function moveHank() {
  var right = FlxG.keys.anyPressed([RIGHT, D]);
  // if (FlxG.save.data.rightBind != '')
  //     {
  //       right = FlxG.keys.anyPressed([RIGHT, D, FlxG.save.data.rigthBind]);
  //     }
  
  var left = FlxG.keys.anyPressed([LEFT, A]);
  var attack = FlxG.mouse.pressed;

  if (right || left)
      {
        playThing('walk');
      }
  
  else
      playThing('idle');
      {
      setFacingFlip(FlxObject.LEFT, false, false);
      setFacingFlip(FlxObject.RIGHT, true, false);  
      }
  if (right && left)
      {
         velocity.x = 0;
         velocity.y = 0; 
      }
  else if (right)
      {
        velocity.x = SPEED; 
        // facing = FlxObject.RIGHT; 
      }
  else if (left)
      {
        velocity.x = -SPEED;  
        // facing = FlxObject.LEFT;
      }
  else if (right && flipX == false)
      {
        playThing('walk', true, true, 24);
      }
  else if (left && flipX == true)
    {
      playThing('walk', true, true, 24);
    }
   if (FlxG.mouse.x == x - 34)
      {
        flipX = false; 
      }
   else if (FlxG.mouse.x == x + 34)  
    {
      flipX = true; 
    }
   }
  public function playThing(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
  {
    animation.play(AnimName, Force, Reversed, Frame);
  }
 override public function update(elapsed:Float)
    {
      super.update(elapsed);
      moveHank();
    }
}