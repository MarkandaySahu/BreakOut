---@diagnostic disable: lowercase-global
local love = require"love"
local game = require"Game"

function love.mousepressed(x,y,but)
    if but == 1 then
        if state == "ended" then
            if restart == true then
                g = game()
                g:insert_bricks()
            end
        end
    end
end
function love.load()
    math.randomseed(os.time())
    g = game()
    g:insert_bricks()
    background = love.graphics.newImage('background.png')
end
-------------------------------------------------------------------------------------------------
function love.update(dt)
    if g.ball_y - 8 < love.graphics.getHeight() then--update the game
        state = "play"
        if #g.Bricks < 1 then
            local s = g.score
            local speed = g.ball_speed + 200
            g = game(speed)
            g:insert_bricks()
            g.score = g.score + s
        end
        --update the paddle.
        if love.keyboard.isDown("a") then
            if g.paddle_x >= 0 then
                g.paddle_x = g.paddle_x - g.paddle_speed * dt
            end
        elseif love.keyboard.isDown("d") then
            if (g.paddle_x + 200) <= love.graphics.getWidth() then
                g.paddle_x = g.paddle_x + g.paddle_speed * dt
            end
        end
        --update the ball.
        if g.ball_y - 8 < 0 then
            g.angle = math.rad(360)-g.angle
        elseif g.ball_x + 8 > love.graphics.getWidth() then
            g.angle = math.rad(540)-g.angle
        elseif g.ball_x - 8 < 0 then
            g.angle = math.rad(540)-g.angle
        elseif g.ball_y + 8 > g.paddle_y and g.ball_y + 8 < g.paddle_y + 20 and g.ball_x > g.paddle_x and g.ball_x < g.paddle_x + 200 then
            g.angle = math.rad(360)-g.angle
        end
        for _, brick in pairs(g.Bricks) do
            if g.ball_y - 8 <= brick.y + 20 and g.ball_x - 8 >= brick.x and g.ball_x + 8 <= brick.x + 90 then
                g.angle = math.rad(360)-g.angle
                table.remove(g.Bricks,_)
                g.score = g.score + 10
            end
            if g.ball_y - 8 >= brick.y and g.ball_y + 8 <= brick.y + 20 and g.ball_x - 8 <= brick.x + 90 and g.ball_x - 8 >= brick.x then
                g.angle = math.rad(540)-g.angle
                table.remove(g.Bricks,_)
                g.score = g.score + 10
            end
            if g.ball_y - 8 >= brick.y and g.ball_y + 8 <= brick.y + 20 and g.ball_x + 8 >= brick.x and g.ball_x + 8 <= brick.x + 90 then
                g.angle = math.rad(540)-g.angle
                table.remove(g.Bricks,_)
                g.score = g.score + 10
            end
        end
        g.ball_x = g.ball_x + g.ball_speed * dt*math.cos(g.angle)
        g.ball_y = g.ball_y + g.ball_speed * dt*math.sin(g.angle)
    else
        state = "ended"
    end
    if state == "ended" then
        local mouse_x,mouse_y = love.mouse.getPosition()
        if (mouse_x >= love.graphics.getWidth()/2-120) and (mouse_x <= love.graphics.getWidth()/2+120) then
            if (mouse_y >= love.graphics.getHeight()/2-30) and (mouse_y <= love.graphics.getHeight()/2+30) then
                _G.restart = true
            else
                _G.restart = false
            end
        else
            _G.restart = false
        end
    end
end
-------------------------------------------------------------------------------------------------
function love.draw()
    love.graphics.draw(background,0,0,0,6.4,8)
    g:draw()
    if state == "play" then
        love.graphics.printf("SCORE: "..g.score,0,love.graphics.getHeight()-20,love.graphics.getWidth(),"center")
    end
    if state == "ended" then
        love.graphics.rectangle( "fill", love.graphics.getWidth()/2-120, love.graphics.getHeight()/2-30, 240, 60 )
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.printf(
        "RESTART",
        0,
        love.graphics.getHeight()/2 - 15,
        love.graphics.getWidth(),
        "center")
        love.graphics.setFont(love.graphics.newFont(56))
        love.graphics.setColor(210/255,240/255,93/255)
        love.graphics.printf(
        "GAME OVER",
        0,
        love.graphics.getHeight()/2 - 150,
        love.graphics.getWidth(),
        "center")
        love.graphics.setFont(love.graphics.newFont(16))
        love.graphics.setColor(1,1,1)
        love.graphics.printf(
        "SCORE:"..g.score,
        0,
        love.graphics.getHeight()/2 - 90,
        love.graphics.getWidth(),
        "center")
    end
end