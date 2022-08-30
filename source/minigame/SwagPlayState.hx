package minigame;

import minigame.Player;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class SwagPlayState extends MusicBeatState
{
    var hankBf:Player;

    var camion:FlxSprite;

    var score:Int;
    var text:FlxText;
    var combination:Int = 0;

    override public function create() {
      hankBf = new Player(0, 0, false);
      add(hankBf);

      text = new FlxText(300, 0, 0, 'score: 0', 32);
      add(text);
    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        this.text.text = 'score: ' + score;

        if (FlxG.keys.justPressed.E)
          {
            score += 500; 
          }
        
        if (FlxG.keys.justPressed.UP)  
          {
            if (combination == 0)
              combination = 1;
            else
              combination == 0;
          }
        if (FlxG.keys.justPressed.RIGHT)  
          {
            if (combination == 1)
              combination = 2;
            else
              combination == 0;
          }
          if (FlxG.keys.justPressed.LEFT)  
          {
            if (combination == 2)
              combination = 3;
            else
              combination == 0;
          }
          if (FlxG.keys.justPressed.W)  
          {
            if (combination == 3)
              combination = 4;
            else
              combination == 0;
          }
          if (FlxG.keys.justPressed.DOWN)  
          {
            if (combination == 5)
              combination = 5;
            else
              combination == 0;
          }
        
        if (combination == 5)
          {
           score += 5000000;  
          }
        if (FlxG.keys.justPressed.ESCAPE)
            {
             FlxG.switchState(new MainMenuState());
            }
    }
}