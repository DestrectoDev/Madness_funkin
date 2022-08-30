package minigame;

import flixel.*;

class Hand extends FlxSprite
{ 
  var gun:String = 'default';

  var gunboolean:Bool = false;
  public static var SPEED:Int = 500;
  public static var GRAVITY:Int = 400;
  
  public static var instance:Hand;

  public function new (x:Float, y:Float)
  {
    super(x, y);
    drag.x = SPEED * 5;

    frames = Paths.getSparrowAtlas('justGame/hank_FNF_Sprites', 'madness');
    animation.addByPrefix('idle', 'hand gun0', 24);
    animation.addByPrefix('walk', 'hand gun WALK', 24);
    animation.addByPrefix('justShoot', 'hand gun ATTACK', 24);
    animation.addByPrefix('shoot', 'hand gun SHOOT PRESSED', 24);

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
  var attackP = FlxG.mouse.justPressed;

  if (right || left)
      {
        playThing('walk');
      }
  else if (attack)
      {
        playThing('shoot');
      }
  else if (attackP)
      {
        playThing('justShoot');
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
   if (FlxG.mouse.x == width / - 2)
      {
       facing = FlxObject.LEFT; 
      }
   else if (FlxG.mouse.x == width / 2)  
    {
       facing = FlxObject.RIGHT; 
    }
    
    angle = FlxG.mouse.y + 400;

   }
  public function playThing(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
  {
    animation.play(AnimName, Force, Reversed, Frame);
  }
 override public function update(elapsed:Float)
    {
      super.update(elapsed);
      moveHank();
      if (FlxG.keys.justPressed.Q)
        {
          gunboolean = !gunboolean;
        }

        (gunboolean ? gun = 'default' : gun = 'gun');
    }
}