package;

import flixel.FlxSprite;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;

class NickNameState extends MusicBeatState {
 
 var typingShit:FlxInputText;

 var extension:Array<String> = ['loginData/', 'madness']; //do literally innecesary innecesario bro
 var UI_songTitle:FlxUIInputText;

 var randomNames:Array<String> = ['AmsMadness099', 'AssmanBruh!', 'jair17', 'DexterXL', 'Kailer', 'SmokePlumes', 'MiGrain', 'CatInHat', 'Bibliokiller', 'Roanokay', 'Pigeoncatcher', 'Skulldugger', 'Belizard', 'Pelfox', 'RingRaid', 'Crucifery', 'Gerbilator'];
//  var easyShit:Map<String, Map<String, String>>;
 var arrow:FlxSprite;
 var box:FlxSprite;
 var bg:FlxSprite;
 var xShit:Float;
 var yShit:Float;

 var given:FlxSprite;
 var lamp:FlxSprite;

 var grunt:FlxSprite;

 var swagKeyPressed:String;

 var nickText:FlxText;
 var MAYUSKEY:Int;
 override public function create() {

   var white = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xffff0000);
//    add(white);
   bg = new FlxSprite(10, 0);
   bg.loadGraphic(Paths.image(extension[0] + 'bg', extension[1]));
   add(bg);

   FlxG.mouse.visible = true;

   arrow = new FlxSprite(1070, 0);
   arrow.loadGraphic(Paths.image(extension[0] + 'arrow', extension[1]));
   arrow.updateHitbox();
   arrow.screenCenter(Y);
   add(arrow);

   grunt = new FlxSprite(0, 120);
   grunt.frames = Paths.getSparrowAtlas(extension[0] + 'gruntSprite', extension[1]);
   grunt.animation.addByPrefix('idle', 'idle0', 24);
   grunt.animation.addByPrefix('idle alt', 'idle copia', 24);
   grunt.animation.play('idle');
   grunt.screenCenter(X);
   grunt.x -= 30;
   add(grunt);

   lamp = new FlxSprite(0, FlxG.height + 15);
   lamp.loadGraphic(Paths.image(extension[0] + 'lampLamp', extension[1]));
   lamp.screenCenter(X);
   add(lamp);

   box = new FlxSprite(0, 540);
   box.loadGraphic(Paths.image(extension[0] + 'box', extension[1]));
   box.screenCenter(X);
   add(box);

   given = new FlxSprite(box.x + 680, box.y -3);
   given.frames = Paths.getSparrowAtlas(extension[0] + 'givenAsset', extension[1]);
   given.animation.addByPrefix('idle', 'dadoObject', 24);
   given.animation.play('idle'); 
   given.updateHitbox();
   add(given);
   addInputBox();
 }    
function addInputBox():Void {
   
   UI_songTitle = new FlxUIInputText(10, box.y - 2, 500, '', 230, FlxColor.BLACK, FlxColor.TRANSPARENT); // stolen for charting vro
   UI_songTitle.setFormat(Paths.font("Agency FB Font.ttf"), 90, FlxColor.WHITE);
   UI_songTitle.screenCenter(X);
   // UI_songTitle.UPPER_CASE = MAYUSKEY;
   // UI_songTitle.LOWER_CASE = MAYUSKEY;
   UI_songTitle.text = FlxG.save.data.yourNickName;
   UI_songTitle.maxLength = 15;
   add(UI_songTitle);
   // var writingNotesText = new FlxUIText(20,100, 0, "");
  // writingNotesText.setFormat(Paths.font("Agency FB Font.ttf"), 20, FlxColor.WHITE);
   xShit = UI_songTitle.x - 2;
   yShit = UI_songTitle.y + 90;

   UI_songTitle.text = FlxG.save.data.NickName;
   
  typingShit = UI_songTitle;
}

override public function update(elapsed:Float) {
super.update(elapsed);
  
//    if(FlxG.keys.justPressed.ANY){
//     FlxG.save.data.nickName = FlxG.save.data.nickName + FlxG.keys.getIsDown()[0].ID.toString().toLowerCase();
//     // keysPressed = keysPressed.substr(0, keysPressed.length - 1); 
//     nickText = new FlxText(box.x - 30, box.y + 20, 0, FlxG.save.data.nickName, 90);
//     nickText.setFormat(Paths.font("Agency FB Font.ttf"), 80, FlxColor.WHITE);
//     add(nickText);
//     if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(given))
//         {
//             FlxG.save.data.nickNameUP = randomNames[FlxG.random.int(0, 17)];
//         }
//     trace(FlxG.save.data.nickName);
//    }
if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(given))
   {
      FlxG.save.data.yourNickNames = '' + randomNames[FlxG.random.int(0, 17)];
   }

   if (FlxG.mouse.justPressedMiddle)
    FlxG.save.data.yourNickName = '';

    if(FlxG.keys.justPressed.ENTER && FlxG.save.data.yourNickName != ''){
     FlxG.switchState(new MainMenuState());
	  FlxG.save.data.NickName = UI_songTitle.text;
	 } 

    if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(arrow) && FlxG.save.data.yourNickName != '')
    {
      FlxG.switchState(new MainMenuState());
      FlxG.save.data.NickName = UI_songTitle.text;
    }
   trace(MAYUSKEY);
   (FlxG.keys.justPressed.CAPSLOCK ? MAYUSKEY = 1 : MAYUSKEY = 2);
 }
 override function beatHit() {
    super.beatHit();

    given.animation.play('idle');
    grunt.animation.play('idle');

 }
}
