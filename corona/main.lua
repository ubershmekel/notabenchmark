-- Seed randomizer
local seed = os.time();
math.randomseed( seed )

-- Background
local halfW = display.stageWidth / 2
local halfH = display.stageHeight / 2

local playRadius = 128

local file1 = "bench128.png"

local wiggleAnimation = {
    container = display.getCurrentStage(),
}

function demo(n)
    group = display.newGroup()
    for i=1,n do
        local image = display.newImage( file1 )
        group:insert( image, true )
        image:translate( halfW + math.random( -playRadius, playRadius ), halfH + math.random( -playRadius, playRadius ) )
    end
end

frame = 0
iterationFrames = 90
n = 1
function wiggleAnimation:enterFrame( event )
    frame = frame + 1
    if frame % iterationFrames == 0 then
        local duration = os.clock() - start
        local fps = iterationFrames / duration
        print(n, fps .. ' fps')
        n = n * 2
        group:removeSelf()
        if fps < 10 then
            Runtime:removeEventListener( "enterFrame", self )
        end
        demo(n)
        start = os.clock()
    else
        for i=1, group.numChildren do
            group[i]:translate( math.random( -1, 1 ), math.random( -1, 1 ) )
        end
    end
end

start = os.clock()
demo(1)
Runtime:addEventListener( "enterFrame", wiggleAnimation );

