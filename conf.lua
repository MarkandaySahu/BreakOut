local love = require"love"
function love.conf(app)
    app.window.width = 1920
    app.window.height = 1020
    app.window.title = "BreakOut"
    app.window.icon = "icon.png"
end