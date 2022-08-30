package minigame;

import flixel.*;
import minigame.*;
import minigame.Bullet.ProjectileType;
import flixel.addons.effects.FlxTrail;

class Land extends MusicBeatState{
  var player:Hank;
  var hand:Hand;
  var holdTimer:Float = 0;

  var bullett:Bullet;
  override public function create()
    {
      player = new Hank(30, 120);
      add(player);

      hand = new Hand(player.x + 20, player.y + 80);
      add(hand);
    }
  override public function update(elapsed:Float) {
    super.update(elapsed);

    if (controls.BACK)
    {       
     FlxG.switchState(new MainMenuState());
    }
    if (FlxG.mouse.justPressed)
      {
        holdTimer += 1;
        var mousePos = FlxG.mouse.getPosition();
        bullett = new Bullet(hand.x, hand.y, mousePos, ProjectileType.FIRE_BOLT);
        var evilTrail = new FlxTrail(bullett, null, 4, 10, 0.4, 0.069);
        evilTrail.color = 0xFFFF0000;
        add(evilTrail);
        add(bullett);
      }
    if (FlxG.mouse.pressed)
      {
        holdTimer = 0;
        var mousePos = FlxG.mouse.getPosition();
        bullett = new Bullet(hand.x + 330, hand.y + 120, mousePos, ProjectileType.FIRE_BOLT);
        var evilTrail = new FlxTrail(bullett, null, 4, 10, 0.4, 0.069);
        evilTrail.color = 0xFFFF0000;
        add(evilTrail);
        add(bullett);
      }
  }
}