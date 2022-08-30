package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

using StringTools;

class StaticStrums extends FlxSprite{
	private var noteData:Int = 0;
    private var player:Int = 0;
    public var skin:String = '';
    public var bfSkin:String;
    public var dadSkin:String;
    public function new(x:Float, y:Float, skin:String = 'madness_Notes', bfSkin:String, dadSkin:String, staticData:Int, player:Int) 
    {
        super(x, y);
        noteData = staticData;
        this.skin = skin;
        this.bfSkin = bfSkin;
        this.dadSkin = dadSkin;
        this.player = player;
        addStatic();
    }
    public function addStatic()
    {
            if (PlayState.SONG.noteStyle == 'pixel')
                {
                loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
                animation.add('green', [6]);
                animation.add('red', [7]);
                animation.add('blue', [5]);
                animation.add('purplel', [4]);

                setGraphicSize(Std.int(width * PlayState.daPixelZoom));
                updateHitbox();
                antialiasing = false;

                switch (Math.abs(noteData))
                {
                    case 0:
                        animation.add('static', [0]);
                        animation.add('pressed', [4, 8], 12, false);
                        animation.add('confirm', [12, 16], 24, false);
                    case 1:
                        animation.add('static', [1]);
                        animation.add('pressed', [5, 9], 12, false);
                        animation.add('confirm', [13, 17], 24, false);
                    case 2:
                        animation.add('static', [2]);
                        animation.add('pressed', [6, 10], 12, false);
                        animation.add('confirm', [14, 18], 12, false);
                    case 3:
                        animation.add('static', [3]);
                        animation.add('pressed', [7, 11], 12, false);
                        animation.add('confirm', [15, 19], 24, false);
                }
            }
            else
                {
                if (player == 0)
                frames = Paths.getSparrowAtlas('noteSkins/$dadSkin', 'madness');
                else  
                frames = Paths.getSparrowAtlas('noteSkins/$bfSkin', 'madness');
                animation.addByPrefix('green', 'arrowUP');
                animation.addByPrefix('blue', 'arrowDOWN');
                animation.addByPrefix('purple', 'arrowLEFT');
                animation.addByPrefix('red', 'arrowRIGHT');

                antialiasing = true;
                setGraphicSize(Std.int(width * 0.7));

                switch (Math.abs(noteData))
                {
                    case 0:
                        animation.addByPrefix('static', 'arrowLEFT');
                        animation.addByPrefix('pressed', 'left press', 24, false);
                        animation.addByPrefix('confirm', 'left confirm', 24, false);
                    case 1:
                        animation.addByPrefix('static', 'arrowDOWN');
                        animation.addByPrefix('pressed', 'down press', 24, false);
                        animation.addByPrefix('confirm', 'down confirm', 24, false);
                    case 2:
                        animation.addByPrefix('static', 'arrowUP');
                        animation.addByPrefix('pressed', 'up press', 24, false);
                        animation.addByPrefix('confirm', 'up confirm', 24, false);
                    case 3:
                        animation.addByPrefix('static', 'arrowRIGHT');
                        animation.addByPrefix('pressed', 'right press', 24, false);
                        animation.addByPrefix('confirm', 'right confirm', 24, false);
                }
            }
    }	
    public function setPositionStatic() {
		animation.play('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}
    override public function update(ea) {
        super.update(ea);
    }
}