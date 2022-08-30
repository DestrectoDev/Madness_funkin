package;

import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
    public var isPlayer:Bool = false;
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;
	public var isAnimated:Bool = false;
	public var winIcon:Bool = false;
	public function new(char:String = 'bf', isPlayer:Bool = false, isAnimated:Bool = false)
	{
		super();
		this.isPlayer = isPlayer;
		this.isAnimated = isAnimated;
		
		changeIcon(char);
		scrollFactor.set();
	}
	public function changeIcon(char:String)
		{
			if (char != 'bf-pixel' && char != 'bf-old'&& char != 'hank-grunt' && !char.startsWith('tricky'))
				char = char.split("-")[0];
	
			if (isAnimated)
			{
             frames = Paths.getSparrowAtlas('icons/icon-' + char + '_animated');
			 animation.addByPrefix('normal', char + '-normal', 24);
			 animation.addByPrefix('losing', char + '-losing', 24);
			 if (winIcon)
				animation.addByPrefix('wining', char + '-wining', 24);
			}
			else
			{
			if (char == 'hank-grunt')
			loadGraphic(Paths.image('icons/icon-' + char), true, 293, 190);
			else
			loadGraphic(Paths.image('icons/icon-' + char), true, Std.int(width / 2), Std.int(height));
			}

			if(char.endsWith('-pixel') || char.startsWith('senpai') || char.startsWith('spirit'))
				antialiasing = false
			else
				antialiasing = true;

		if (!isAnimated)
			{	
			if (char == 'tricky')	
		    animation.add(char, [1, 0], 0, false, isPlayer);
			else
			animation.add(char, [0, 1], 0, false, isPlayer);
			animation.play(char);	
			}

			if (char == 'moai')
				flipX = true;
			
			initialWidth = width;
			initialHeight = height;
		
		}
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
