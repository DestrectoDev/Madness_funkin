package minigame;

import flixel.*;

class Zombie extends FlxSprite
{
  public static var instance:Zombie;
  public var scaleShit:Float =  0.14;
  var mouse = FlxG.mouse;
  public var counterZ:Int = 1;
  public function new(x:Float, y:Float, scaleShit:Float)
  {
    super(x, y);

    frames = Paths.getSparrowAtlas('zombieGame/thingZombie', 'madness');
    animation.addByPrefix('appear', 'acercamiento 1', 24);
    animation.play('appear');

    updateHitbox();

    this.scaleShit = scaleShit;
  }

  override public function update(elaps:Float)
    {
     super.update(elaps);
     scale.set(scaleShit, scaleShit);

     if (FlxG.random.bool(1))
        {
            counterZ = 3;
        }
     else if (FlxG.random.bool(5))
        {
            counterZ = 2;
        }
    else if (FlxG.random.bool(20))
        {
            counterZ = 1;
        }
    }
}