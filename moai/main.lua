width, height = 320, 480
spriteRadius = 64

MOAISim.openWindow ( "test", width, height )

viewport = MOAIViewport.new ()
viewport:setSize ( width, height )
viewport:setScale ( width, height )

gfxQuad = MOAIGfxQuad2D.new ()
gfxQuad:setTexture ( "bench128.png" )
gfxQuad:setRect ( -spriteRadius, -spriteRadius, spriteRadius, spriteRadius )
gfxQuad:setUVRect ( 0, 1, 1, 0 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

function demo(n)
    props = {}
    for i=1,n do
        prop = MOAIProp2D.new ()
        prop:setDeck ( gfxQuad )
        prop:setLoc ( math.random(-128, 128), math.random(-128, 128) )
        layer:insertProp ( prop )
        --prop:moveRot ( 360, 1.5 )
        props[i] = prop
    end
end

iterationFrames = 90

mainThread = MOAICoroutine.new ()
mainThread:run (
    function ()
        local frames = 0
        local n = 1
        local times = {}
        local start = os.clock()
        demo(1)
        while true do
            coroutine.yield ()
            frames = frames + 1
            
            if frames % iterationFrames == 0 then
                -- 90 frames should take 3 seconds of simulation,
                -- 10 fps is when things suck
                local duration = os.clock() - start
                local fps = iterationFrames / duration
                --table.insert(times, duration)
                print(n,  fps .. " fps")
                n = n * 2
                layer:clear()
                if fps < 10 then
                    break
                end
                start = os.clock()
                demo(n)
            else
                for k, prop in pairs(props) do
                    prop:addLoc ( math.random(-1, 1), math.random(-1, 1) )
                end
            end
            if MOAIInputMgr.device.mouseLeft:down () then
                --os.exit()
                --gameOver = true
                break
            end
        end
    end
)


