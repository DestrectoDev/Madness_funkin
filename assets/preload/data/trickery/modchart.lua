local angleShit = 1;
local angleVar = 10;

function start(song) -- do nothing
    makeLuaSprite('icon-tricky', 'pene');
    pene.x = 30;
end

 function update(elapsed)
--     if difficulty == 2 and curStep > 400 then
--         local currentBeat = (songPos / 1000)*(bpm/60)
-- 		for i=0,7 do
-- 			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
-- 			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
-- 		end
--     end
 end

function beatHit(beat) -- do nothing
    
    if curBeat % 2 == 0 then
        angleShit = angleVar
    else
        angleShit = -angleVar
    end

    getProperty('iconP1');
    iconP1.angle = -angleShit
     iconP2.angle = angleShit

     angleIconTween(0, stepCrochet*0.005, 'circOut')
     xIconTween(-angleShit, crochet*0.005, 'linear');
     angleIconp2Tween(0, stepCrochet*0.005, 'circOut')
     xIconp2Tween(angleShit, crochet*0.005, 'linear');
end

function stepHit(step) -- do nothing

end

function playerTwoTurn()
    tweenCameraZoom(1.3,(crochet * 4) / 1000)
end

function playerOneTurn()
    tweenCameraZoom(1,(crochet * 4) / 1000)
end