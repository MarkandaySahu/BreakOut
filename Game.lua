local love = require"love"

function Game(speed)
    return{
        score = 0,
        --ball
        angle = math.rad(math.random(280,330)),
        ball_speed = speed or 600,
        ball_x = (love.graphics.getWidth()/2-8),
        ball_y = (love.graphics.getHeight()/2+80),
        --paddle
        paddle_x = love.graphics.getWidth()/2-100,
        paddle_y = love.graphics.getHeight()-60,
        paddle_speed = 800,
        --bricks
        Bricks = {},
        row = math.random(3,6),
        columns = 17,
        insert_bricks = function (self)
            for i = 1, self.row do
                for j = 1, self.columns do
                    local brick = {
                        x = 100 * j,
                        y = 30 * i,
                    }
                    table.insert(self.Bricks,brick)
                end
            end
        end,
        ------------------------------------------------------------------------------------------------
        draw =function (self)
            --draw the paddle
            love.graphics.rectangle("fill",self.paddle_x,self.paddle_y,200,20)
            --draw the ball
            love.graphics.setColor(150/255,246/255,70/255)
            love.graphics.circle("fill",self.ball_x,self.ball_y,8)
            --draw the bricks
            love.graphics.setColor(150/255,100/255,70/255)
            for _, brick in pairs(self.Bricks) do
                love.graphics.rectangle("fill",brick.x,brick.y,90,20)
            end
            love.graphics.setColor(1,1,1)
        end
    }
end
return Game