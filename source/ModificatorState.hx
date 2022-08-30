package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
class ModificatorState extends MusicBeatState{

    var itemsGrp:FlxTypedGroup<Alphabet>;
    var item:Alphabet;
    var items:Array<String> = ['stage editor', 'character editor', 'dialogue editor', 'tu mama editor'];
    var curSelected:Int = 0;
    override public function create() {

        var bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bg.screenCenter();
        bg.color = 0xFF143838;
        add(bg);

        itemsGrp = new FlxTypedGroup<Alphabet>(); 
        add(itemsGrp);
        
        for (i in 0...items.length)
        {
            item = new Alphabet(0, 0, items[i], true, false);
            item.targetY = i;
            item.isMenuItem = true;
            itemsGrp.add(item);
        }
        changeItem(0);
    }
    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.UP_P)
            changeItem(-1);
        if (controls.DOWN_P)
            changeItem(1);
        if (controls.ACCEPT)
        {
            switch(items[curSelected])
            {

            }
       }
        if (controls.BACK)
            FlxG.switchState(new MainMenuState());
    }
    public function changeItem(sus:Int) {
        curSelected += sus;

        if (curSelected < 0)
           curSelected = items.length-1;
        if (curSelected >= items.length)
            curSelected = 0;

        for (item in itemsGrp.members)
            {
               item.alpha = 0.6;
               item.scale.set(1,1);
               if (item.ID == curSelected) 
                {
                item.alpha = 1;
                item.scale.set(1.15, 1.15);
                }
            }
    }
}