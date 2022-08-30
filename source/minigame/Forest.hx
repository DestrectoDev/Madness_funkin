package minigame;

import flixel.animation.FlxAnimationController;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

class Forest extends MusicBeatState{
   
   var mouse = FlxG.mouse;
   var lintern:FlxSprite;

   var zombie:Zombie;
   var zombieJaw:Zombie;
   var zombieCircle:Zombie;
   var scaleShit:Float;

   var health:Bool = true;
   var swagCursor:FlxSprite;

   var ass:FlxAnimationController;
   override public function create()
   {
     //    for (i in 0...FlxG.random.int(0, 3)) 
    // {
    zombie = new Zombie(50, 50, scaleShit);
    // zombie.scaleShit = scaleShit;
    // zombie.scale.set(scaleShit, scaleShit);
    add(zombie);

    zombieJaw = new Zombie(0, 0, scaleShit);
    add(zombieJaw);

    zombieCircle = new Zombie(0, 0, scaleShit);
    add(zombieCircle);

    swagCursor = new FlxSprite(0,0);
    swagCursor.frames = Paths.getSparrowAtlas('zombieGame/cursor', 'madness');
    swagCursor.animation.addByPrefix('idle', 'idle instancia', 24);
    swagCursor.animation.addByPrefix('prefix', 'pressed instancia', 24);
    swagCursor.animation.play('idle');
    swagCursor.updateHitbox();
    add(swagCursor);
    // }
    lintern = new FlxSprite(0, 0, Paths.image('zombieGame/lintern', 'madness'));
    lintern.alpha = 0.7;
    lintern.visible = false;
    lintern.screenCenter(Y);
    lintern.scale.set(0.85, 0.85);
    add(lintern);
   }

   function killZombie()
    {
      if (mouse.overlaps(zombie) && mouse.justPressed)
        {
		 FlxG.camera.flash(FlxColor.WHITE, 0.8);
        //  zombie.visible = false;
         scaleShit = 0.14;
        }
    }

   override public function update(elapsed:Float) {
    super.update(elapsed);

    mouse.load(swagCursor);
    // mouse.visible = true;
    killZombie();
    if (mouse.pressed)
        {swagCursor.animation.play('prefix');}
    if (mouse.justReleased)
        {swagCursor.animation.play('idle');}

      if (!mouse.overlaps(zombie) && mouse.justPressed)
        {
         new FlxTimer().start(FlxG.random.float(2, 4), function(tmr:FlxTimer)
            {
              zombie.visible = true; 
            });
        }

 if (scaleShit > 10)
    scaleShit += elapsed * 1.5;

    // zombie.x = FlxG.random.float(0, 20);
    // zombieCircle.x = FlxG.random.float(40, 12);
    // zombieJaw.x = FlxG.random.float(50, 32);

    lintern.x = mouse.x - 850;
    
    swagCursor.x = mouse.x - 9;
    swagCursor.y = mouse.y - 3;

    if (scaleShit == 2)
        {
         health = false; 
        }

    if (FlxG.keys.justPressed.F)
        {
          lintern.visible = !lintern.visible;  
        }
    if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new MainMenuState());
     if (!health)   
        {
          add(new FlxSprite(0, 0).makeGraphic(50, 50, FlxColor.RED).screenCenter());
          new FlxTimer().start(2, function(tmr:FlxTimer)
            {
                FlxG.switchState(new MainMenuState());
            });
        }
   } 
    
}