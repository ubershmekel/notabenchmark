----------------------------------------------------------------
-- Copyright (c) 2010-2011 Zipline Games, Inc. 
-- All Rights Reserved. 
-- http://getmoai.com
----------------------------------------------------------------

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

--demo(3)
--demo(4)
--demo(5)

gameOver = false

mainThread = MOAICoroutine.new ()
mainThread:run (
    function ()
        local frames = 0
        local n = 1
        local times = {}
        local start = os.clock()
        demo(1)
        while not gameOver do
            coroutine.yield ()
            frames = frames + 1
            
            if frames % 90 == 0 then
                -- 90 frames should take 3 seconds of simulation,
                -- 10 fps is when things suck
                local duration = os.clock() - start
                --table.insert(times, duration)
                print(n, duration)
                if duration > 9 then
                    break
                end
                n = n * 2
                layer:clear()
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

        local font = MOAIFont.new ()
        font:loadFromTTF ( "wizard.ttf", "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.?! ", 12, 163 )

        --for i,v in ipairs(times) do
        --    print(2 ^ i, v)
        --end
            
        local textbox = MOAITextBox.new ()
        textbox:setFont ( font )
        --textbox:setTextSize ( font:getScale ())
        textbox:setRect ( -160, -80, 160, 80 )
        textbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY )
        textbox:setYFlip ( true )
        textbox:setString ( "You are dead!" )
        layer:insertProp ( textbox )
        textbox:spool ()
        os.exit()
   end
)


