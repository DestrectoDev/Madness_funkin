import flixel.*;
import flixel.text.FlxText;
import Song.SwagSong;
import flixel.addons.ui.*;
class StageEditor extends MusicBeatState
{
    var curStage:String = 'stage';
   var SONG:SwagSong;

    var back:FlxSprite;
    var center:FlxSprite;
    var front:FlxSprite;

    var backTxt:FlxText;
    var centerTxt:FlxText;
    var frontTxt:FlxText;
    var scaleShit:Float = 1;
    var scaleCenter:Float = 1;
    var scaleBack:Float = 1;
    var UI_box:FlxUITabMenu;
    var stages:Array<String> = CoolUtil.coolTextFile(Paths.txt('stageList'));
	var defaultCamZoom:Float = 1.05;
	public var camHUD:FlxCamera;

    var player2Scale:Float = 1;
    var player1Scale:Float = 1;
    var curBf:Array<String> = CoolUtil.coolTextFile(Paths.txt('characterList'));
    var curChar:Array<String> = CoolUtil.coolTextFile(Paths.txt('characterList'));

    var bf:Boyfriend;
    var daBFanim:String = 'bf'; 
    var char:Character;
    var gf:Character;

  override public function create()  
    {
        FlxG.mouse.visible = true;
        camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD);

        back = new FlxSprite(30, 50, Paths.image('stages/Sky', 'madness'));
        back.antialiasing = true;
        back.screenCenter();
        back.updateFramePixels();
        add(back);

        center = new FlxSprite(1200, 200, Paths.image('stages/Ground', 'madness'));
        center.antialiasing = true;
        center.updateFramePixels();
        add(center);

        front = new FlxSprite(30, 50, Paths.image('stages/Tree', 'madness'));
        front.antialiasing = true;
        front.updateFramePixels();
        add(front);

        bf = new Boyfriend(770, 450, daBFanim);
        bf.updateHitbox();
        // bf.curCharacter = SONG.player1;
        add(bf);

        char = new Character(-50, 0, 'dad');
        char.updateHitbox();
        add(char);

		FlxG.camera.zoom = defaultCamZoom;

        backTxt = new FlxText(10, 20, 0, '', 15);
        backTxt.cameras = [camHUD];
        add(backTxt);

        centerTxt = new FlxText(10, 50, 0, '', 15);
        centerTxt.cameras = [camHUD];
        add(centerTxt);

        frontTxt = new FlxText(10, 80, 0, '', 15);
        frontTxt.cameras = [camHUD];
        add(frontTxt);
        editorUI();
       
    }

    var character:String;

    var camZoom:FlxUINumericStepper;
    function editorUI() {
    
        var tabs = [
            {name: "Stage", label: 'Stage'},
            {name: "Character", label: 'Character'}
        ];
        
        UI_box = new FlxUITabMenu(null, tabs, true);
    
        UI_box.resize(400, 400);
        UI_box.x = FlxG.width / 2;
        UI_box.y = 20;
        UI_box.cameras = [camHUD];
        add(UI_box);
    
        var stageDropDown = new FlxUIDropDownMenu(140, 200, FlxUIDropDownMenu.makeStrIdLabelArray(stages, true), function(stage:String)
            {
                curStage = stages[Std.parseInt(stage)];
            });
        stageDropDown.cameras = [camHUD];
        stageDropDown.selectedLabel = curStage;
        
        var stageLabel = new FlxText(140,180,64,'Stage');
        stageLabel.cameras = [camHUD];
    
        camZoom = new FlxUINumericStepper(10, 65, 0.1, 0.7, 0, 5, 1);
        camZoom.value = defaultCamZoom;
        camZoom.name = 'camZooming';
        camZoom.cameras = [camHUD];
    
    
        var camZoomLabel = new FlxText(74,65,'camZoom');
        camZoomLabel.cameras = [camHUD];
       
        player1DropDown = new FlxUIDropDownMenu(10, 100, FlxUIDropDownMenu.makeStrIdLabelArray(curBf, true), function(character:String)
            {
                this.character = character;
                daBFanim = curBf[Std.parseInt(character)];
            });
        player1DropDown.selectedLabel = daBFanim;
        
        var player1Label = new FlxText(10,80,64,'Player 1');

        var player2DropDown = new FlxUIDropDownMenu(140, 100, FlxUIDropDownMenu.makeStrIdLabelArray(curChar, true), function(character:String)
            {
                char.curCharacter = curChar[Std.parseInt(character)];
            });
            player2DropDown.selectedLabel = char.curCharacter;
    
        var player2Label = new FlxText(140,80,64,'Player 2');
    
        var tabAss = new FlxUI(null, UI_box);
        tabAss.name = 'Character';
        tabAss.add(player1DropDown);
        tabAss.add(player1Label);
        tabAss.add(player2DropDown);
        tabAss.add(player2Label);
    
        var tab_group_stageLabel = new FlxUI(null, UI_box);
        tab_group_stageLabel.name = "Stage";
    
        tab_group_stageLabel.add(camZoom);
        tab_group_stageLabel.add(stageDropDown);
        tab_group_stageLabel.add(stageLabel);
        tab_group_stageLabel.add(camZoomLabel);
    
        UI_box.addGroup(tab_group_stageLabel);
        UI_box.addGroup(tabAss);
    
    
      }
  var player1DropDown:FlxUIDropDownMenu;
  override public function update(elapsed)
    {
      super.update(elapsed);
        //   bf.curCharacter = SONG.player1;
        front.scale.set(scaleShit, scaleShit);
        center.scale.set(scaleCenter, scaleCenter);
        back.scale.set(scaleBack, scaleBack);

        bf.scale.set(player1Scale, player1Scale);
        char.scale.set(player2Scale, player2Scale);
  
        backTxt.text = 'back: [' + back.x + ', ' + back.y + ']';
        centerTxt.text = 'center: [' + center.x + ', ' + center.y + ']';
        frontTxt.text = 'front: [' + front.x + ', ' + front.y + ']' + '\n [' + player1Scale + ', ' +  player2Scale + ']';

        if (FlxG.mouse.overlaps(bf))
            {if (FlxG.keys.pressed.LEFT)
                {
                  bf.x -= 1;  
                }
            if (FlxG.keys.pressed.RIGHT)
                {
                    bf.x += 1;  
                }
            if (FlxG.keys.pressed.UP)
                {
                    bf.y -= 1;  
                }
            if (FlxG.keys.pressed.DOWN)
                {
                    bf.y += 1;  
                }
                if (FlxG.keys.pressed.CONTROL)
                    {
                      if (FlxG.keys.justPressed.O)  
                        player1Scale += 0.10;
                      if (FlxG.keys.justPressed.MINUS)
                        player1Scale -= 0.10;
                    }}
        if (FlxG.mouse.overlaps(char))
            {if (FlxG.keys.pressed.LEFT)
                {
                  char.x -= 1;  
                }
            if (FlxG.keys.pressed.RIGHT)
                {
                    char.x += 1;  
                }
            if (FlxG.keys.pressed.UP)
                {
                    char.y -= 1;  
                }
            if (FlxG.keys.pressed.DOWN)
                {
                    char.y += 1;  
                }
                if (FlxG.keys.pressed.CONTROL)
                    {
                      if (FlxG.keys.justPressed.O)  
                        player2Scale += 0.10;
                      if (FlxG.keys.justPressed.MINUS)
                        player2Scale -= 0.10;
                    }
                }
  
        if (FlxG.mouse.overlaps(back))
          {
           if (FlxG.keys.pressed.LEFT)
              {
                back.x -= 1;  
              }
          if (FlxG.keys.pressed.RIGHT)
              {
                  back.x += 1;  
              }
          if (FlxG.keys.pressed.UP)
              {
                  back.y -= 1;  
              }
          if (FlxG.keys.pressed.DOWN)
              {
                  back.y += 1;  
              }
              if (FlxG.keys.pressed.CONTROL)
                  {
                    if (FlxG.keys.justPressed.O)  
                      scaleBack += 0.10;
                    if (FlxG.keys.justPressed.MINUS)
                      scaleBack -= 0.10;
                  }
          }
        if (FlxG.mouse.overlaps(center))
          {
              if (FlxG.keys.pressed.LEFT)
                  {
                      center.x -= 1;  
                  }
              if (FlxG.keys.pressed.RIGHT)
                  {
                      center.x += 1;  
                  }
              if (FlxG.keys.pressed.UP)
                  {
                      center.y -= 1;  
                  }
              if (FlxG.keys.pressed.DOWN)
                  {
                      center.y += 1;  
                  }
              if (FlxG.keys.pressed.CONTROL)
                  {
                    if (FlxG.keys.justPressed.O)  
                      scaleCenter += 0.10;
                    if (FlxG.keys.justPressed.MINUS)
                      scaleCenter -= 0.10;
                  }
          }
  
        if (FlxG.mouse.overlaps(front))
          {
              if (FlxG.keys.pressed.LEFT)
                  {
                      front.x -= 1;  
                  }
              if (FlxG.keys.pressed.RIGHT)
                  {
                      front.x += 1;  
                  }
              if (FlxG.keys.pressed.UP)
                  {
                      front.y -= 1;  
                  }
              if (FlxG.keys.pressed.DOWN)
                  {
                      front.y += 1;  
                  } 
                  if (FlxG.keys.pressed.CONTROL)
                      {
                        if (FlxG.keys.justPressed.O)  
                          scaleShit += 0.10;
                        if (FlxG.keys.justPressed.MINUS)
                          scaleShit -= 0.10;
                      }
          }

          if (controls.BACK)
            FlxG.switchState(new MainMenuState());

         defaultCamZoom = camZoom.value;

    }

  function stageData(curStage:String)
    {
        this.curStage = curStage;
    }
  

}